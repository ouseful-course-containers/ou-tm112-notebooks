FROM jupyter/base-notebook

RUN pip install folium

RUN pip install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension  --sys-prefix

RUN pip install descartes scipy shapely

COPY  ./install/Localization-master.zip ./Localization.zip
RUN pip install Localization.zip
RUN rm Localization.zip

COPY --chown=jovyan:users ./notebooks/*.ipynb /home/$NB_USER/work/


ENV DOCKERBUILD 1
COPY --chown=jovyan:users jupyter_custom_files/ jupyter_custom_files/
RUN jupyter_custom_files/jupyter_styling.sh

RUN rm -rf jupyter_custom_files