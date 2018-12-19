[![Build Status](https://img.shields.io/travis/adorsys/dockerhub-pipeline-images/master.svg?longCache=true&style=flat-square)](https://travis-ci.org/adorsys/dockerhub-pipeline-images)

# adorsys docker pipeline images

Primary used to build and distribute software at adorsys.

# Getting updates

All images are build daily at travis to receive daily OS update. Most of the images are squashed into one to
reduce the image size. 

## Flavors

By default all images based on CentOS except `awscli`. Some images have a `alpine` flavor to get the minimal footprint.

# Images

| Name | Description |
|------|-------------|
| [adorsys/ansible](ansible/README.md) | Run Ansible inside Docker |
| [adorsys/arc42-tools](arc42-tools/README.md) | Generate arc42 documentation for gitlab pages. Also supports plantuml |
| [adorsys/awscli](awscli/README.md) | Provides awscli for terraform |
| [adorsys/ci-build](ci-build/README.md) | Generic build image for Gitlab CI |
| [adorsys/ci-helm](ci-helm/README.md) | Deploy your environment with helm! Multiple versions of helm supported |
| [adorsys/ci-clair](ci-clair/README.md) | Scan your images with clair before release them  |
| [adorsys/nginx](nginx/README.md) | Base image for distribute static files and SPAs. |
| [adorsys/java](java/README.md) | Base image for distribute java jars. |
| [adorsys/node](node/README.md) | Base image for distribute node applications. |


# Contributing

If you want to contribute new images you should done:
* The name of the subdirectory should always the same name as in the image name. For example if you want to create the
  image `adorsys/tool` the directory should be named `tool`. If your images has some flavors use subdirectories like
  `tool/<flavor>/` like `tool/alpine` and use the image tag `adorsys/tool:<flavor>` or `adorsys/tool:<version>-<flavor>`. 
  If you want you use template, take a look at https://github.com/hairyhenderson/gomplate.
* Create a executable `test.sh` and include some commands to test your images.
  if you need more complex test you should take a look to https://github.com/aelsabbahy/goss. Also a `README.md` would 
  be appreciated.
* Include your images in the `.travis.yml`. 
* Run the `gen_compose.sh` before commit your image.
* Be sure you create a new `repository` at https://hub.docker.com/r/adorsys/. The team `service` should have write
  permissions.
