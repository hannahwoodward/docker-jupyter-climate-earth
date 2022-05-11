# --- Load Miniconda docker image ---
FROM continuumio/miniconda3

# --- Set server env variables for conda ---
SHELL ["/bin/bash", "-c"]

# --- Copy over conda config ---
COPY environment.yml environment.yml

# --- Add conda forge and update conda [v4.11.0] ---
RUN conda config --add channels conda-forge && conda config --set channel_priority strict
RUN conda update conda -y --quiet && conda clean --all -y --quiet

# --- Load geog0121 environment into conda ---
RUN conda env create -f environment.yml --quiet
RUN source activate climate

# --- Install nbextensions (collapsible headings) ---
RUN pip install --quiet --no-cache-dir jupyter_contrib_nbextensions && jupyter contrib nbextension install && jupyter nbextension enable collapsible_headings/main

# --- Script to run when starting the Docker image ---
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "climate", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
