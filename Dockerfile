FROM jupyter/base-notebook

RUN pip install folium

RUN pip install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension  --sys-prefix

RUN pip install descartes scipy shapely pandas



COPY  ./install/Localization-master.zip ./Localization.zip
RUN pip install Localization.zip
RUN rm Localization.zip




COPY ./notebooks/*.ipynb /home/$NB_USER/work/
COPY ./notebooks/*.py /home/$NB_USER/work/
COPY ./notebooks/images/* /home/$NB_USER/work/images/

#COPY --chown=jovyan:users ./docs /home/$NB_USER/docs

ENV DOCKERBUILD 1
COPY jupyter_custom_files/ jupyter_custom_files/

RUN jupyter_custom_files/jupyter_styling.sh



USER root
RUN rm -rf jupyter_custom_files
RUN chown -R jovyan:users /home/$NB_USER/work/
USER $NB_UID