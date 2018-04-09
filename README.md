My site stack
=============

**IMPORTANT**
for drone agent to work, set `COMPOSE_CONVERT_WINDOWS_PATHS=1` or you cannot mount `/var/docker.sock:/var/docker.sock`

Build my local all-in-one develop, blogging site.

Services
-------
- Git service, gogs may try gitea later
- Db service, postgre, serves gogs and other project that requires database
- www service: nginx reverse proxy for backend sites, projects and static bolg site
- Jenkins for auto test and deploy
- node for deploy of node projects
- python for deploy of python projects

Sitemap
-------------
- Redirect / to /blog
- /blog:
- /gogs:
- /gitea:
- /drone
- /jenkins:
- /demo: project demos

Specifaction
-------------
- run test in jenkins/drone when git repo pushed
- deploy if test pass
- generate test result tag in repo's README

Tasks
----
- [ ] install and integrate services
    - [x] www
    - [x] gogs
    - [x] jenkins
    - [x] gitea
    - [ ] python
    - [ ] node
    - [ ] drone
- [ ] testings
    - [x] auto execute jenkins test job when repo pushed to gogs
    - [ ] auto execute jenkins test job when repo pushed to gitea
    - [ ] auto deploy when jenkins test pass 
    - [x] auto execute drone test job when repo pushed to gogs
    - [ ] auto execute drone test job when repo pushed to gitea
    - [ ] auto deploy when drone test pass 
- [ ] documentation
    - [ ] Setup my owe develop sites
