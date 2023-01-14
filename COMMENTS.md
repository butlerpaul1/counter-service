## CI Yaml - .gitlab-ci.yml

The CI Pipeline has two stages. A build stage which tests and builds the application and a publish stage to build the docker image and push it to your docker hub.

I kept the test and build steps in the same build stage as since they both only require an image with go lang installed I can use the same image which reduces the time taken to run a build. A separate stage then to publish the image as it requires docker to be installed, this stage will only run if the previous stage was successful, this ensures that only working images are published.

I use three variables in the yaml file, GO_TIMEOUT is a timeout value that is used when testing the app, I've kept this to 20 seconds, similar to what the Makefile uses. The next two TAG_LATEST & TAG_COMMIT are used when pushing the docker image. These use a secret variable which is set through Gitlab UI. CI_REGISTRY_IMAGE is the URL of the container registry tied to the specific project.

The build stage uses an image that is built off the latest go lang image available, this image will have all the dependencies we require to build our app. I use the same logic that is in the Makefile to maintain consistency. First I set the ALL_PACKAGES variable to the result of the go list command so that it includes all the packages and modules. Using this variable I then call the go test command to test the application using the timeout variable set earlier in the pipeline, lastly I build the app outputting the binaries to the /bin/counter-service directory. At the end of this stage I upload the deployment script as an artifact that can be downloaded to deploy the application. A future improvement could be to add variable tokens within the script, and add a step to substitute the image variable in deploy.sh with $CI_REGISTRY_IMAGE.

If the build stage is successful the publish stage is executed, this stage is build off a docker image. First I login to the docker hub repo associated with this project. All variables are stored as secrets within the project UI, I call the dockerfile with two tags, tag:latest to indicate that this image is the latest release, and a second tag using the commit, this enables developers to trace the history of a docker image to a specific commit id. Once the image is built both are pushed to the docker hub repo.

A deployment stage could be added to this pipeline in the future, to call the deployment agent installed on the server, download the artifact from the build stage and execute this script on the server which will download our image and spin it up by passing the required arguments.

## Docker File - dockerfile

I kept the environment variable logic from the Makefile to maintain consistency between what a developer would use locally and what the dockerfile uses. The dockerfile accepts a http_argumnet which is then assigned to the PORT environment variable.

- First we use the official Go image that will have the tools we require to compile and run our Go application.
- The working directory is set next, I copy and download the required go modules to this directory.
- Next the source code is copied, a wild card is used to copy all .go files.
- Next I build the app and output the binaries to the /bin/counter-service. Again keeping the same logic as the Makefile.
- Last we tell the docker to execute our binaries when the image is used.

## Deployment script - deploy.sh

The deployment script can be downloaded from the artifacts stage of the build pipeline. The script takes two arguments.

- Image: this the docker image to download
- Port: the port we want the container to be available over.

The script can be called like so `./deploy.sh -i butlerpaul1/counter-service -p 80` which will pull the latest image from our docker hub and map port 80 on our local machine to 8080 on the container.
