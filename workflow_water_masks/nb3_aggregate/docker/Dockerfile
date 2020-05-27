FROM continuumio/miniconda3

ADD ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV PATH /opt/conda/envs/tb16/bin:$PATH
RUN echo "source activate tb16" > /etc/profile