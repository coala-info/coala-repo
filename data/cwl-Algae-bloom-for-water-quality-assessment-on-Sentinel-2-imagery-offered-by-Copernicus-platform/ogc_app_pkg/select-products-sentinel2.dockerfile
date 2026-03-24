FROM ogc-ospd/algae-usecase/base:1.1.0
LABEL version="1.1"

COPY src/select_products_sentinel2.py /opt/select_products_sentinel2.py
ENTRYPOINT ["python", "/opt/select_products_sentinel2.py"]
