FROM continuumio/miniconda3:4.8.2

ADD ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV PATH /opt/conda/envs/env_snap/bin:$PATH
RUN echo "source activate env_snap" > /etc/profile

ENV SCIHUB_UN=$SCIHUB_UN
ENV SCIHUB_PW=$SCIHUB_PW

ADD nb2.ipynb /nb2.ipynb