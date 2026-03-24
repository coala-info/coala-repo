FROM ogc-ospd/algae-usecase/base:1.1.0
LABEL version="1.1.0"

COPY src/download_band_sentinel2_stac_item.py /opt/download_band_sentinel2_stac_item.py
ENTRYPOINT ["python", "/opt/download_band_sentinel2_stac_item.py"]
