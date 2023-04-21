# Jupyter & Earth Climate Docker Image

[Docker](https://www.docker.com/) image to load [Jupyter](https://docs.jupyter.org/en/latest/) and [Conda](https://docs.conda.io/en/latest/), with a few [additional packages installed](Dockerfile) useful for climatological data analysis.

Additional Earth-specific packages have been installed for downloading from the [Climate Data Store](https://cds.climate.copernicus.eu/cdsapp#!/search?type=dataset) (`cdsapi`), `esgf-pyclient` for opendap authentication (e.g. for accessing [CORDEX data](https://esgf-index1.ceda.ac.uk/search/cordex-ceda/)), and `regionmask` for [CMIP6/IPCC and other region masks](https://github.com/regionmask/regionmask). For general geospatial/climate data analysis, see [hannahwoodward/docker-jupyter-climate](https://github.com/hannahwoodward/docker-jupyter-climate)


## Useful links

* [Jupyter Docker stacks github](https://github.com/jupyter/docker-stacks)
* [Jupyter Docker stacks docs](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
* [Docker build help](https://docs.docker.com/engine/reference/commandline/build/)
* [Docker run help](https://docs.docker.com/engine/reference/commandline/run/)


## Installation & Use

* [Install Docker desktop](https://www.docker.com/get-started)
* Ensure Docker desktop is running
* Navigate to your project directory (i.e. with Jupyter notebook files)
* Download published image:

```
docker pull woodwardsh/jupyter-climate-earth:latest
```

* Run published image, mounting local working directory to container directory `/home/jovyan`:

```
docker run -it --rm -p 8888:8888 -v ${PWD}:/home/jovyan -w /home/jovyan woodwardsh/jupyter-climate-earth:latest

# Options:
# -it           interactive && TTY (starts shell inside container)
# --rm          delete container on exit
# --volume|-v   mount local directory inside container
# -w PATH       sets working directory inside container
```


## Exporting the Conda environment

* Start the container
* Open a new terminal inside JupyterLab
* Run `sh ~/generate-config.sh` to generate config `climate-earth.yml` into your working directory
* Download `climate-earth.yml` from the JupyterLab UI, or copy straight from the directory if mounted


## Building & running image from scratch

* Clone repo & navigate inside:

```
git clone git@github.com:hannahwoodward/docker-jupyter-climate-earth.git && cd docker-jupyter-climate-earth
```

* Build image from Dockerfile (takes ~15 minutes):

```
docker build -t jupyter-climate-earth .

# -t = name/tag the image, format `name:tag`
```

* Navigate to your project directory (i.e. with Jupyter notebook files)
* Run locally built image, mounting local working directory to container directory `/home/jovyan`:

```
docker run -it --rm -p 8888:8888 -v ${PWD}:/home/jovyan -w /home/jovyan jupyter-climate-earth

# Options:
# -it           interactive && TTY (starts shell inside container)
# --rm          delete container on exit
# --volume|-v   mount local directory inside container
# -w PATH       sets working directory inside container
```


## Publishing image

```
docker login && docker tag jupyter-climate woodwardsh/jupyter-climate-earth && docker push woodwardsh/jupyter-climate-earth
```


## Troubleshooting

* Exit code 137 - need to increase Docker memory e.g. to 4GB
* No space left on device - `docker system prune`
