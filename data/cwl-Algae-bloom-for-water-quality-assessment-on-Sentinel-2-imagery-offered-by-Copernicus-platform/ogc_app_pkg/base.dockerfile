FROM mambaorg/micromamba:jammy
LABEL description.short="OGC OSPD Algae Bloom base image"
LABEL description.long="Base image to package the algae bloom use case for the OGC Open Science Persistent Demonstrator."
LABEL maintainer="Francis Charette-Migneault <francis.charette-migneault@crim.ca>"
LABEL vendor="CRIM"
# below version is for managing the Docker Application Package
# this is different than the original source code, which has its own version
LABEL version="1.1.0"
# details from OSF platform
LABEL source.project="https://osf.io/aujkb"
# FIXME: OSF project does not have any attributed DOI!
LABEL source.doi="undefined"
# below are extracted from original notebook details
LABEL source.name="Sentinel-2 Water Quality (Se2WaQ)"
LABEL source.version="1.0"
LABEL source.date="2020-01-31"
LABEL source.author="Nuno Sidónio Andrade Pereira"
LABEL source.modification="Tyna Dolezalova (Python port from original JavaScript code)"
LABEL source.affiliation="Polytechnic Institute of Beja, Portugal"
LABEL source.license="Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)"
LABEL source.references.1="M. Potes et al., “Use of Sentinel 2 – MSI for water quality monitoring at Alqueva reservoir, Portugal,” Proc. Int. Assoc. Hydrol. Sci., vol. 380, pp. 73–79, Dec. 2018."
LABEL source.references.2="K. Toming, T. Kutser, A. Laas, M. Sepp, B. Paavel, and T. Nõges, “First Experiences in Mapping Lake Water Quality Parameters with Sentinel-2 MSI Imagery,” Remote Sens., vol. 8, no. 8, p. 640, Aug. 2016."

COPY ../env-algae-usecase.yml conda-environment.yml

ARG CONDA_ENV=algae-usecase
RUN micromamba create -n ${CONDA_ENV} -y -f conda-environment.yml
ENV PATH /opt/conda/envs/${CONDA_ENV}/bin:$PATH
ENV CONDA_DEFAULT_ENV ${CONDA_ENV}
# avoids an error to resolve proj called through the final dataset (output file) creatiion step
# https://stackoverflow.com/a/78438171/5936364
ENV PROJ_LIB=/opt/conda/envs/algae-usecase/share/proj
