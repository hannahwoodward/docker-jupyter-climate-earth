FROM woodwardsh/jupyter-climate:latest

ENV CONFIG_NAME "climate-earth"

RUN mamba install --yes \
    cdsapi \
    esgf-pyclient \
    regionmask && \
    mamba clean --all --yes && \
    fix-permissions /home/${NB_USER}
