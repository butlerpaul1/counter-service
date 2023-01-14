# devops-techtask

## Overview

Hopefully this tech task allows you to strut your stuff as much as you decide to!

This exercise should take you no more than a weekend. If you need any clarification, please don’t hesitate to ask us.

## Task details

This repository contains a simple golang service which serves a single endpoint: `/count`. For each call to this endpoint, the service increments a counter, and returns the number of times the endpoint has been called. We have also included a makefile that allows you to build and test the application.

We'd like to deploy this application using docker in VM. We'd like this process to be automated, using [gitlab ci](https://docs.gitlab.com/ee/ci/). The CI should include the following steps:

1. Test the application. This can be done by running `make test`.
2. Build the application. The application can be built by running `make build`.
3. Build the application docker image and push it to a public repository.

Since we cannot ensure that you have access to a VM, instead of having the deploy be part of the CI step, the deploy logic should be encoded in the file `scripts/deploy.sh`, which you can assume will be run inside the VM to deploy the application, which has to be accessible after deployment from outside the VM. You can assume that the VM:
- already has docker installed
- is publicly available over the internet

In your solution, include a readme detailing your thought process and any design decisions you made.

## Requirements

- Valid gitlab-ci.yml manifest containing `test`, `build` and `build-push-docker`(or equivalent) steps.
- Application must be built into a docker image
- Application can be deployed on a ubuntu VM with docker installed using the `scripts/deploy.sh` script.
- Deployed application must be accessible from outside the VM.

If you have any questions, please do not hesitate to ask!
