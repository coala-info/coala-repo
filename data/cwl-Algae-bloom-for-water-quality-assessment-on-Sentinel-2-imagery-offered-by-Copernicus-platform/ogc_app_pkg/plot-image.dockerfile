FROM ogc-ospd/algae-usecase/base:1.1.0
LABEL version="1.0.0"

COPY src/plot_image.py /opt/plot_image.py
ENTRYPOINT ["python", "/opt/plot_image.py"]
