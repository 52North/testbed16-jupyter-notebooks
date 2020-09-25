FROM continuumio/miniconda3

ADD ./environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ENV PATH /opt/conda/envs/geopandas/bin:$PATH
RUN echo "source activate geopandas" > /etc/profile

ADD ./tile-resolution.ipynb /nb.ipynb

ENV INPUT_FILENAME '/aoi.geojson'
ENV OUTPUT_OUTPUT_FILENAME '/output_urls.json'
ENV INPUT_ZOOM_LEVEL '10'
ENV INPUT_TILE_BASE_URL 'https://eratosthenes.pvretano.com/cubewerx/cubeserv/default/ogcapi/mysql_tb16/collections/waterbody_2_50k/map/Water Body 2 Style/tiles/smerc_512/%s/%s/%s.png'
ENV OUTPUT_DOWNLOAD_FOLDER '/training'

CMD env && papermill /nb.ipynb /out.ipynb -p filename $INPUT_FILENAME -p outputFilename $OUTPUT_OUTPUT_FILENAME -p zoomLevel $INPUT_ZOOM_LEVEL -p tileBaseUrl "$INPUT_TILE_BASE_URL" -p downloadFolder $OUTPUT_DOWNLOAD_FOLDER
