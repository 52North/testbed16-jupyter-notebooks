FROM continuumio/miniconda3:4.8.2

ADD ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV PATH /opt/conda/envs/tb16/bin:$PATH
RUN echo "source activate tb16" > /etc/profile

ENV SCIHUB_UN=$SCIHUB_UN
ENV SCIHUB_PW=$SCIHUB_PW

ADD nb1.ipynb /nb1.ipynb