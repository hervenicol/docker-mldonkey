Mldonkey as a "from scratch" container
====

For security purposes, this container contains as few components as possible.

Building this container is made through these steps:

- creating a build image, from a full-featured Debian image with compilation tools and libs
- running this image, resulting in a static mlnet binary, and a few remaining dependencies
- creating the runtime image with the output files of the build one


To run mlnet:

 docker run -P -ti --rm -v $PWD/workdir:/.mldonkey hervenicol/mldonkey:0.1 /mlnet.static

Setup:

- run once
- quit
- edit config files
- run again

