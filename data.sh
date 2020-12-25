#!/bin/sh

# Usage: 
# ./backup.sh (backup|restore) [backup_storage_dir] [backup_dir]
#    back_storage_dir: default to $backup_storage/${PWD##*/},
#                      if $backup_storage not specified, default to ./data
#          backup_dir: default to latest backup dir: YYYY-mm-dd_HH-MM-SS,
#                      in case of restore, if no such YYYY-mm-dd_HH-MM-SS dir exists,
#                      will try to find backup data in $backup_storage_dir

prefix="${PWD##*/}_"
if docker ps | grep $prefix
then
  echo "Containers are RUNNING! Please run 'docker-compose stop' to stop them before backup or restore."
  exit 1
else
  echo "NOT Running!"
fi

backup="cd /data && find . -type d -maxdepth 1 -mindepth 1 -exec tar zcvf /backup/{}.tar.gz {} \\;"
restore="cd /backup && ls *.tar.gz | xargs -I filename tar zxvf filename -C /data"

backup_storage=${2:-"$PWD/data"}

case $1 in
  backup)
    op="$backup"
    backup_dir="$backup_storage/$(date +%Y-%m-%d_%H-%M-%S)"
    mkdir -p $backup_dir
    ;;
  restore)
    op="$restore"
    backup_dir=${3:-$(ls $backup_storage | grep -E "20[0-9]{2}-(0|1)[0-9]-[0-3][0-9]_[0-2][0-9]-[0-6][0-9]-[0-6][0-9]" | tail -n 1)}
    backup_dir="$backup_storage/$backup_dir"
    ;;
  *)
    echo "usage: data.sh (backup|restore) [backup_storage_dir] [backup_dir] \n\
    back_storage_dir: default to \$backup_storage/\${PWD##*/}, \n\
                      if \$backup_storage not specified, default to ./data \n\
          backup_dir: default to latest backup dir: YYYY-mm-dd_HH-MM-SS, \n\
                      in case of restore, if no such YYYY-mm-dd_HH-MM-SS dir exists, \n\
                      will try to find backup data in \$backup_storage_dir"
    ;;
esac

volumes="-v $backup_dir:/backup"
for i in $(docker volume ls -q | grep $prefix | sed 's#'"$prefix"'##g')
  do volumes="$volumes -v $prefix$i:/data/$i "
done

echo $volumes
echo $op

echo "operation=[$1], backup_storage=[$backup_storage], backup_dir=[$backup_dir], arg4=[$4]"
docker run --rm $volumes alpine sh -c "$op"

