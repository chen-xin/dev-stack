#!/bin/sh

op = $1

case $1 in
  backup|b|-b|--backup)
    op="backup"
    ;;
  restore|r|-r|--restore)
    op="restore"
    ;;
  *)
    echo "usage: ./data.sh (backup|restore [...volumes]"
    ;;
esac

shift 

for i in $(docker volume ls -q | grep devstack | sed 's#'"$prefix"'##g')
  do
    if [[
    volumes+=" -v $prefix$i:/data/$i "
done

echo "$@"
echo "$#"

