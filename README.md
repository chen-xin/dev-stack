My site stack
=============

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

tasks
----
- [ ] install services
    - [x] www
    - [x] gogs
    - [x] jenkins
    - [x] gitea
    - [ ] python
    - [ ] node
    - [ ] drone
- [ ] integretate services
