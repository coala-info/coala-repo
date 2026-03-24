FROM ogc-ospd/algae-usecase/base:1.1.0
LABEL version="1.0.0"

CMD ["gdalwarp", "--help"]
