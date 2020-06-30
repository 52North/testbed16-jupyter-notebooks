# 3 Steps to Setup and execute

## Prerequesites
The following things are required for the workflow:
* docker and docker-compose installed
* Scrapbook installed (required from nb1 to nb2 - https://github.com/nteract/scrapbook)
    * `pip install nteract-scrapbook`
    * (subject for improvement)
* cwl-runner installed (see https://github.com/common-workflow-language/cwltool)
* an account for ESAs SciHub (https://scihub.copernicus.eu/dhus/#/home)


## 1. Set SciHub Credentials (To be improved)
Put your credentials for the ESA Scihub into an .env-file like follows

```
SCIHUB_UN=<your username>
SCIHUB_PW=<your password>
```

These will be put into the build of the docker-images. (Note: This will be improved in the future)

## 2. Build Images via docker-compose.
Run the following command:

```
docker-compose build
```

## 3. Configure & Run
Adjust the timerange and area of interest in the `nb_parameters.json` and run the workflow via:

```
./run_workflow.sh
```