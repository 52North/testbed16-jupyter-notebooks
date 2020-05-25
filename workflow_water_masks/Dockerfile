FROM continuumio/miniconda3

ADD ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV PATH /opt/conda/envs/env_snap/bin:$PATH
RUN echo "source activate env_snap" > /etc/profile