FROM continuumio/miniconda3

ARG SCIHUB_UN
ARG SCIHUB_PW

ENV SCIHUB_UN=$SCIHUB_UN
ENV SCIHUB_PW=$SCIHUB_PW

ADD ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV PATH /opt/conda/envs/tb16/bin:$PATH
RUN echo "source activate tb16" > /etc/profile