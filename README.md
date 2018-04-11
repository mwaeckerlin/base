Minimum Base Docker Image
=========================

Use this image as base for all your docker container.

Built from Alpine Linux with nicer prompt, defined start script and
health check.


Rules for Descendents
---------------------

In your image, you must have a file `start.sh` which is executed at
startup and `health.sh`. This image enforces this convention.

In your image or optionally also container, define environment
variable `CONTAINERNAME` to specify the name of your image or container.

At the end of your dockerfile, call `/cleanup.sh` to remove unneded caches:

    RUN /cleanup.sh


Shared Volumes
--------------

If you need access to the same external volume path from two containers, add your user to the group specified in environment variable `SHARED_GROUP_NAME` and give access rights and ownership of the sared ressource to this group, e.g., if your user is in variable `USER`, add to `Dockerfile`:

    RUN addgroup $SHARED_GROUP_NAME $USER
    VOLUME /var/common

And add to `start.sh`:

    chgrp $SHARED_GROUP_NAME /var/common
    chmod g+rwx /var/common
