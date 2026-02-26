# plantcv CWL Generation Report

## plantcv_plantcv-workflow.py

### Tool Description
Parallel imaging processing with PlantCV.

### Metadata
- **Docker Image**: quay.io/biocontainers/plantcv:3.8.0--py_0
- **Homepage**: https://plantcv.danforthcenter.org
- **Package**: https://anaconda.org/channels/bioconda/packages/plantcv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plantcv/overview
- **Total Downloads**: 38.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/danforthcenter/plantcv
- **Stars**: N/A
### Original Help Text
```text
usage: plantcv-workflow.py [-h] -d DIR [-a ADAPTOR] -p WORKFLOW -j JSON -f
                           META [-i OUTDIR] [-T CPU] [-c] [-D DATES] [-t TYPE]
                           [-l DELIMITER] [-M MATCH] [-C COPROCESS]
                           [-s TIMESTAMPFORMAT] [-w] [-o OTHER_ARGS]

Parallel imaging processing with PlantCV.

optional arguments:
  -h, --help            show this help message and exit
  -d DIR, --dir DIR     Input directory containing images or snapshots.
                        (default: None)
  -a ADAPTOR, --adaptor ADAPTOR
                        Image metadata reader adaptor. PhenoFront metadata is
                        stored in a CSV file and the image file name. For the
                        filename option, all metadata is stored in the image
                        file name. Current adaptors: phenofront, filename
                        (default: phenofront)
  -p WORKFLOW, --workflow WORKFLOW
                        Workflow script file. (default: None)
  -j JSON, --json JSON  Output database file name. (default: None)
  -f META, --meta META  Image filename metadata structure. Comma-separated
                        list of valid metadata terms. Valid metadata fields
                        are: camera, imgtype, zoom, exposure, gain, frame,
                        lifter, timestamp, id, plantbarcode, treatment,
                        cartag, measurementlabel, other (default: None)
  -i OUTDIR, --outdir OUTDIR
                        Output directory for images. Not required by all
                        workflows. (default: .)
  -T CPU, --cpu CPU     Number of CPU processes to use. (default: 1)
  -c, --create          will overwrite an existing databaseWarning: activating
                        this option will delete an existing database!
                        (default: False)
  -D DATES, --dates DATES
                        Date range. Format: YYYY-MM-DD-hh-mm-ss_YYYY-MM-DD-hh-
                        mm-ss. If the second date is excluded then the current
                        date is assumed. (default: None)
  -t TYPE, --type TYPE  Image format type (extension). (default: png)
  -l DELIMITER, --delimiter DELIMITER
                        Image file name metadata delimiter
                        character.Alternatively, a regular expression for
                        parsing filename metadata. (default: _)
  -M MATCH, --match MATCH
                        Restrict analysis to images with metadata matching
                        input criteria. Input a metadata:value comma-separated
                        list. This is an exact match search. E.g.
                        imgtype:VIS,camera:SV,zoom:z500 (default: None)
  -C COPROCESS, --coprocess COPROCESS
                        Coprocess the specified imgtype with the imgtype
                        specified in --match (e.g. coprocess NIR images with
                        VIS). (default: None)
  -s TIMESTAMPFORMAT, --timestampformat TIMESTAMPFORMAT
                        a date format code compatible with strptime C library,
                        e.g. "%Y-%m-%d %H_%M_%S", except "%" symbols must be
                        escaped on Windows with "%" e.g. "%%Y-%%m-%%d
                        %%H_%%M_%%S"default format code is "%Y-%m-%d
                        %H:%M:%S.%f" (default: %Y-%m-%d %H:%M:%S.%f)
  -w, --writeimg        Include analysis images in output. (default: False)
  -o OTHER_ARGS, --other_args OTHER_ARGS
                        Other arguments to pass to the workflow script.
                        (default: None)
```

