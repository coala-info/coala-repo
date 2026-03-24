FROM ogc-ospd/algae-usecase/base:1.1.0
LABEL version="1.1.0"

ENTRYPOINT ["gdal_calc.py"]
