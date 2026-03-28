# vpt CWL Generation Report

## vpt_run-segmentation

### Tool Description
Top-level interface for this CLI which invokes the segmentation functionality of the tool. It is intended for users who would like to run the program with minimal additional configuration. Specifically, it executes: prepare-segmentation, run-segmentation-on-tile, and compile-tile-segmentation.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Total Downloads**: 474
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Vizgen/vizgen-postprocessing
- **Stars**: N/A
### Original Help Text
```text
usage: vpt [OPTIONS] run-segmentation [arguments]

Top-level interface for this CLI which invokes the segmentation functionality
of the tool. It is intended for users who would like to run the program with
minimal additional configuration. Specifically, it executes: prepare-
segmentation, run-segmentation-on-tile, and compile-tile-segmentation.

Required arguments:
  --segmentation-algorithm SEGMENTATION_ALGORITHM
                        Path to a json file that fully specifies the
                        segmentation algorithm to use, including algorithm
                        name, any algorithm specific parameters (including
                        path to weights for new model), stains corresponding
                        to each channel in the algorithm.
  --input-images INPUT_IMAGES
                        Input images can be specified in one of three ways: 1.
                        The path to a directory of tiff files, if the files
                        are named by the MERSCOPE convention. Example:
                        /path/to/files/ 2. The path to a directory of tiff
                        files including a python formatting string specifying
                        the file name. The format string must specify values
                        for "stain" and "z". Example:
                        /path/to/files/image_{stain}_z{z}.tif 3. A regular
                        expression matching the tiff files to be used, where
                        the regular expression specifies values for "stain"
                        and "z". Example: /path/to/files/mosaic_(?P<stain>[\w|
                        -]+)_z(?P<z>[0-9]+).tif In all cases, the values for
                        "stain" and "z" must match the stains and z indexes
                        specified in the segmentation algorithm.
  --input-micron-to-mosaic INPUT_MICRON_TO_MOSAIC
                        Path to the micron to mosaic pixel transformation
                        matrix.
  --output-path OUTPUT_PATH
                        Directory where the segmentation specification json
                        file will be saved as segmentation_specification.json
                        and where the final segmentation results will be
                        saved.

Optional arguments:
  --tile-size TILE_SIZE
                        Number of pixels for the width and height of each
                        tile. Each tile is created as a square. Default: 4096.
  --tile-overlap TILE_OVERLAP
                        Overlap between adjacent tiles. Default: 10% of tile
                        size.
  --max-row-group-size MAX_ROW_GROUP_SIZE
                        Maximum number of rows in row groups inside output
                        parquet files. Cannot be less than 1000
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_segmentation

### Tool Description
vpt: error: argument : invalid choice: 'segmentation' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'segmentation' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_for

### Tool Description
vpt: error: argument : invalid choice: 'for' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'for' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_minimal

### Tool Description
vpt: error: argument : invalid choice: 'minimal' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'minimal' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_prepare-segmentation

### Tool Description
Generates a segmentation specification json file to be used for cell segmentation tasks. The segmentation specification json includes specification for the algorithm to run, the paths for all images for each stain for each z index, the micron to mosaic pixel transformation matrix, the number of tiles, and the window coordinates for each tile.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] prepare-segmentation [arguments]

Generates a segmentation specification json file to be used for cell
segmentation tasks. The segmentation specification json includes specification
for the algorithm to run, the paths for all images for each stain for each z
index, the micron to mosaic pixel transformation matrix, the number of tiles,
and the window coordinates for each tile.

Required arguments:
  --segmentation-algorithm SEGMENTATION_ALGORITHM
                        Path to a json file that fully specifies the
                        segmentation algorithm to use, including algorithm
                        name, any algorithm specific parameters (including
                        path to weights for new model), stains corresponding
                        to each channel in the algorithm.
  --input-images INPUT_IMAGES
                        Input images can be specified in one of three ways: 1.
                        The path to a directory of tiff files, if the files
                        are named by the MERSCOPE convention. Example:
                        /path/to/files/ 2. The path to a directory of tiff
                        files including a python formatting string specifying
                        the file name. The format string must specify values
                        for "stain" and "z". Example:
                        /path/to/files/image_{stain}_z{z}.tif 3. A regular
                        expression matching the tiff files to be used, where
                        the regular expression specifies values for "stain"
                        and "z". Example: /path/to/files/mosaic_(?P<stain>[\w|
                        -]+)_z(?P<z>[0-9]+).tif In all cases, the values for
                        "stain" and "z" must match the stains and z indexes
                        specified in the segmentation algorithm.
  --output-path OUTPUT_PATH
                        Path where the segmentation specification json file
                        will be saved.
  --input-micron-to-mosaic INPUT_MICRON_TO_MOSAIC
                        Path to the micron to mosaic pixel transformation
                        matrix.

Optional arguments:
  --tile-size TILE_SIZE
                        Number of pixels for the width and height of each
                        tile. Each tile is created as a square. Default is
                        4096.
  --tile-overlap TILE_OVERLAP
                        Overlap between adjacent tiles. Default is 10% of
                        tile-size.
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_Generates

### Tool Description
vpt: error: argument : invalid choice: 'Generates' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Generates' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_used

### Tool Description
vpt: error: argument : invalid choice: 'used' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'used' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_specification

### Tool Description
vpt: error: argument : invalid choice: 'specification' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'specification' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_algorithm

### Tool Description
vpt: error: argument : invalid choice: 'algorithm' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'algorithm' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_stain

### Tool Description
vpt: error: argument : invalid choice: 'stain' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'stain' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_transformation

### Tool Description
vpt: error: argument : invalid choice: 'transformation' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'transformation' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_window

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'window' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_run-segmentation-on-tile

### Tool Description
Executes the segmentation algorithm on a specific tile of the mosaic images. This functionality is intended both for visualizing a preview of the segmentation (run only one tile), and for distributing jobs using an orchestration tool such as Nextflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] run-segmentation-on-tile [arguments]

Executes the segmentation algorithm on a specific tile of the mosaic images.
This functionality is intended both for visualizing a preview of the
segmentation (run only one tile), and for distributing jobs using an
orchestration tool such as Nextflow.

Required arguments:
  --input-segmentation-parameters INPUT_SEGMENTATION_PARAMETERS
                        Json file generate by --prepare-segmentation that
                        fully specifies the segmentation to run
  --tile-index TILE_INDEX
                        Index of the tile to run the segmentation on

Optional arguments:
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_Executes

### Tool Description
vpt: error: argument : invalid choice: 'Executes' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Executes' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_of

### Tool Description
vpt: error: argument : invalid choice: 'of' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'of' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_both

### Tool Description
vpt: error: argument : invalid choice: 'both' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'both' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_an

### Tool Description
vpt: error: argument : invalid choice: 'an' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'an' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_compile-tile-segmentation

### Tool Description
Combines the per-tile segmentation outputs into a single, internally-consistent parquet file containing all of the segmentation boundaries found in the experiment.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] compile-tile-segmentation [arguments]

Combines the per-tile segmentation outputs into a single, internally-
consistent parquet file containing all of the segmentation boundaries found in
the experiment.

Required arguments:
  --input-segmentation-parameters INPUT_SEGMENTATION_PARAMETERS
                        Json file generated by prepare-segmentation that fully
                        specifies the segmentation to run.

Optional arguments:
  --max-row-group-size MAX_ROW_GROUP_SIZE
                        Maximum number of rows in row groups inside output
                        parquet files. Cannot be less than 1000
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  --help                Show this help message and exit
```


## vpt_Combines

### Tool Description
vpt: error: argument : invalid choice: 'Combines' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Combines' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_all

### Tool Description
vpt: error: argument : invalid choice: 'all' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'all' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_derive-entity-metadata

### Tool Description
Uses the segmentation boundaries to calculate the geometric attributes of each Entity. These attributes include the position, volume, and morphological features.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] derive-entity-metadata [arguments]

Uses the segmentation boundaries to calculate the geometric attributes of each
Entity. These attributes include the position, volume, and morphological
features.

Required arguments:
  --input-boundaries INPUT_BOUNDARIES
                        Path to a micron-space parquet boundary file.
  --output-metadata OUTPUT_METADATA
                        Path to the output csv file where the entity metadata
                        will be stored.

Optional arguments:
  --input-entity-by-gene INPUT_ENTITY_BY_GENE
                        Path to an existing entity by gene csv.
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_Uses

### Tool Description
vpt: error: argument : invalid choice: 'Uses' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Uses' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_geometric

### Tool Description
vpt: error: argument : invalid choice: 'geometric' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'geometric' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_include

### Tool Description
vpt: error: argument : invalid choice: 'include' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'include' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_partition-transcripts

### Tool Description
Uses the segmentation boundaries to determine which Entity, if any, contains each detected transcript. Outputs an Entity by gene matrix, and may optionally output a detected transcript csv with an additional column indicating the containing Entity.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] partition-transcripts [arguments]

Uses the segmentation boundaries to determine which Entity, if any, contains
each detected transcript. Outputs an Entity by gene matrix, and may optionally
output a detected transcript csv with an additional column indicating the
containing Entity.

Required arguments:
  --input-boundaries INPUT_BOUNDARIES
                        Path to a micron-space parquet boundary file.
  --input-transcripts INPUT_TRANSCRIPTS
                        Path to an existing transcripts csv or parquet file.
  --output-entity-by-gene OUTPUT_ENTITY_BY_GENE
                        Path to output the Entity by gene matrix csv file.

Optional arguments:
  --chunk-size CHUNK_SIZE
                        Number of transcript file lines to be loaded in memory
                        at once. Default: 10,000,000
  --output-transcripts OUTPUT_TRANSCRIPTS
                        If a filename is provided, a copy of the detected
                        transcripts file will be written with an additional
                        column with the EntityID of the cell or other Entity
                        that contains each transcript (or -1 if the transcript
                        is not contained by any Entity).
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_Outputs

### Tool Description
vpt: error: argument : invalid choice: 'Outputs' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Outputs' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_output

### Tool Description
vpt: error: argument : invalid choice: 'output' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'output' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_column

### Tool Description
vpt: error: argument : invalid choice: 'column' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'column' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_sum-signals

### Tool Description
Uses the segmentation boundaries to find the intensity of each mosaic image in each Entity. Outputs both the summed intensity of the raw images and the summed intensity of high-pass filtered images (reduces the effect of background fluorescence).

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] sum-signals [arguments]

Uses the segmentation boundaries to find the intensity of each mosaic image in
each Entity. Outputs both the summed intensity of the raw images and the
summed intensity of high-pass filtered images (reduces the effect of
background fluorescence).

Required arguments:
  --input-images INPUT_IMAGES
                        Input images can be specified in one of three ways: 1.
                        The path to a directory of tiff files, if the files
                        are named by the MERSCOPE convention. Example:
                        /path/to/files/ 2. The path to a directory of tiff
                        files including a python formatting string specifying
                        the file name. The format string must specify values
                        for "stain" and "z". Example:
                        /path/to/files/image_{stain}_z{z}.tif 3. A regular
                        expression matching the tiff files to be used, where
                        the regular expression specifies values for "stain"
                        and "z". Example: /path/to/files/mosaic_(?P<stain>[\w|
                        -]+)_z(?P<z>[0-9]+).tif In all cases, the values for
                        "stain" and "z" must match the stains and z indexes
                        specified in the segmentation algorithm.
  --input-boundaries INPUT_BOUNDARIES
                        Path to a micron-space .parquet boundary file.
  --input-micron-to-mosaic INPUT_MICRON_TO_MOSAIC
                        Path to the micron to mosaic pixel transformation
                        matrix.
  --output-csv OUTPUT_CSV
                        Path to the csv file where the sum intensities will be
                        stored.

Optional arguments:
  --overwrite           Set true if you want to use non empty directory and
                        agree that files can be overwritten.
  -h, --help            Show this help message and exit
```


## vpt_summed

### Tool Description
vpt: error: argument : invalid choice: 'summed' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'summed' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_intensity

### Tool Description
vpt: error: argument : invalid choice: 'intensity' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'intensity' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_effect

### Tool Description
vpt: error: argument : invalid choice: 'effect' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'effect' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_update-vzg

### Tool Description
Updates an existing .vzg file with new segmentation boundaries and the
corresponding expression matrix. NOTE: This functionality requires enough disk
space to unpack the existing .vzg file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] update-vzg [arguments]

Updates an existing .vzg file with new segmentation boundaries and the
corresponding expression matrix. NOTE: This functionality requires enough disk
space to unpack the existing .vzg file.

Required arguments:
  --input-vzg INPUT_VZG
                        Path to an existing vzg file.
  --input-boundaries INPUT_BOUNDARIES
                        Path to a micron-space parquet boundary file.
  --input-entity-by-gene INPUT_ENTITY_BY_GENE
                        Path to the Entity by gene csv file.
  --output-vzg OUTPUT_VZG
                        Path where the updated vzg should be saved.

Optional arguments:
  --input-metadata INPUT_METADATA
                        Path to an existing entity metadata file.
  --input-entity-type INPUT_ENTITY_TYPE
                        Entity type name for detections in input boundaries
                        file.
  --temp-path TEMP_PATH
                        Path for temporary folder for unzipping vzg file.
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_boundaries

### Tool Description
vpt: error: argument : invalid choice: 'boundaries' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'boundaries' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_unpack

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'unpack' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_convert-geometry

### Tool Description
Converts entity boundaries produced by a different tool into a vpt compatible parquet file. In the process, each of the input entities is checked for geometric validity, overlap with other geometries, and assigned a globally-unique EntityID to facilitate other processing steps.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] convert-geometry [arguments]

Converts entity boundaries produced by a different tool into a vpt compatible
parquet file. In the process, each of the input entities is checked for
geometric validity, overlap with other geometries, and assigned a globally-
unique EntityID to facilitate other processing steps.

Required arguments:
  --input-boundaries INPUT_BOUNDARIES
                        Regular expression that matches all input segmentation
                        files (geojson or hdf5) that will be processed.
  --output-boundaries OUTPUT_BOUNDARIES
                        The path to the parquet file where segmentation
                        compatible with vpt will be saved.

Optional arguments:
  --convert-to-3D       Pass if segmentation should be converted from 2D to 3D
                        by replication. Only possible for geojson and parquet
                        input formats.
  --input-micron-to-mosaic INPUT_MICRON_TO_MOSAIC
                        Path to the transformation matrix.
  --number-z-planes NUMBER_Z_PLANES
                        The number of z planes that should be produced during
                        the conversion from 2D to 3D. Should be specified only
                        if the "--convert-to-3D" argument is passed
  --spacing-z-planes SPACING_Z_PLANES
                        Step size between z-planes, assuming that z-index 0 is
                        1 “step” above zero. Should be specified only if the "
                        --convert-to-3D" argument is passed
  --output-entity-type OUTPUT_ENTITY_TYPE
                        String with entity type name. For example: cell,
                        nuclei. Default: cell
  --id-mapping-file ID_MAPPING_FILE
                        Path to csv file where map from source segmentation
                        entity id to EntityID in result will be saved.
  --entity-fusion-strategy ENTITY_FUSION_STRATEGY
                        String with entity fusion strategy name. One from
                        list: harmonize, union, larger. Default: harmonize
  --max-row-group-size MAX_ROW_GROUP_SIZE
                        Maximum number of rows in row groups inside output
                        parquet files. Cannot be less than 1000
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_tool

### Tool Description
vpt: error: argument : invalid choice: 'tool' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'tool' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_assigned

### Tool Description
vpt: error: argument : invalid choice: 'assigned' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'assigned' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_other

### Tool Description
vpt: error: argument : invalid choice: 'other' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'other' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_convert-to-ome

### Tool Description
Transforms the large 16-bit mosaic tiff images produced by the MERSCOPE into a OME pyramidal tiff.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] convert-to-ome [arguments]

Transforms the large 16-bit mosaic tiff images produced by the MERSCOPE into a
OME pyramidal tiff.

Required arguments:
  --input-image INPUT_IMAGE
                        Either a path to a directory or a path to a specific
                        file.

Optional arguments:
  --output-image OUTPUT_IMAGE
                        Either a path to a directory or a path to a specific
                        file.
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_produced

### Tool Description
vpt: error: argument : invalid choice: 'produced' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'produced' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_convert-to-rgb-ome

### Tool Description
Converts up to three flat tiff images into a rgb OME-tiff pyramidal images. If a rgb channel input isn’t specified, the channel will be dark (all 0’s).

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] convert-to-rgb-ome [arguments]

Converts up to three flat tiff images into a rgb OME-tiff pyramidal images. If
a rgb channel input isn’t specified, the channel will be dark (all 0’s).

Required arguments:
  --output-image OUTPUT_IMAGE
                        Either a path to a directory or a path to a specific
                        file

Optional arguments:
  --input-image-red INPUT_IMAGE_RED
                        Either a path to a directory or a path to a specific
                        file
  --input-image-green INPUT_IMAGE_GREEN
                        Either a path to a directory or a path to a specific
                        file
  --input-image-blue INPUT_IMAGE_BLUE
                        Either a path to a directory or a path to a specific
                        file
  --overwrite
  -h, --help            Show this help message and exit
```


## vpt_tiff

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'tiff' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_extract-image-patch

### Tool Description
Extracts a patch of specified coordinates and channels from the 16-bit mosaic tiff images produced by the MERSCOPE as an 8-bit RGB PNG file

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] extract-image-patch [arguments]

Extracts a patch of specified coordinates and channels from the 16-bit mosaic
tiff images produced by the MERSCOPE as an 8-bit RGB PNG file

Required arguments:
  --input-images INPUT_IMAGES
                        Input images can be specified in one of three ways: 1.
                        The path to a directory of tiff files, if the files
                        are named by the MERSCOPE convention. Example:
                        /path/to/files/ 2. The path to a directory of tiff
                        files including a python formatting string specifying
                        the file name. The format string must specify values
                        for "stain" and "z". Example:
                        /path/to/files/image_{stain}_z{z}.tif 3. A regular
                        expression matching the tiff files to be used, where
                        the regular expression specifies values for "stain"
                        and "z". Example: /path/to/files/mosaic_(?P<stain>[\w|
                        -]+)_z(?P<z>[0-9]+).tif In all cases, the values for
                        "stain" and "z" must match the stains and z indexes
                        specified in the segmentation algorithm.
  --input-micron-to-mosaic INPUT_MICRON_TO_MOSAIC
                        Path to the micron to mosaic pixel transformation
                        matrix.
  --output-patch OUTPUT_PATCH
                        Path to the patch PNG file, will append .png to the
                        end if not included in file name.
  --center-x CENTER_X   MERSCOPE Vizualizer X coordinate in micron space that
                        will serve as the center of the saved PNG patch
  --center-y CENTER_Y   MERSCOPE Vizualizer Y coordinate in micron space that
                        will serve as the center of the saved PNG patch
  --green-stain-name GREEN_STAIN_NAME
                        The name of the stain that will be used for the green
                        channel of the patch

Optional arguments:
  --size-x SIZE_X       Number of microns for the width of the patch. Default:
                        108.
  --size-y SIZE_Y       Number of microns for the height of the patch.
                        Default: 108.
  --input-z-index INPUT_Z_INDEX
                        The Z plane of the mosaic tiff images to use for the
                        patch. Default: 2.
  --red-stain-name RED_STAIN_NAME
                        The name of the stain that will be used for the red
                        channel of the patch. Default: None.
  --blue-stain-name BLUE_STAIN_NAME
                        The name of the stain that will be used for the blue
                        channel of the patch. Default: None.
  --normalization NORMALIZATION
                        The name of the normalization method that will be used
                        on each channel of the patch. Default: None.
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_Extracts

### Tool Description
vpt: error: argument : invalid choice: 'Extracts' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Extracts' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_from

### Tool Description
vpt: error: argument : invalid choice: 'from' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'from' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_MERSCOPE

### Tool Description
vpt: error: argument : invalid choice: 'MERSCOPE' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'MERSCOPE' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_generate-segmentation-metrics

### Tool Description
Computes a number of segmentation metrics and figures to assess the quality of cell segmentation

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] generate-segmentation-metrics [arguments]

Computes a number of segmentation metrics and figures to assess the quality of
cell segmentation

Required arguments:
  --input-entity-by-gene INPUT_ENTITY_BY_GENE
                        Path to the Entity by gene csv file.
  --input-metadata INPUT_METADATA
                        Path to the output csv file where the entity metadata
                        will be stored.
  --input-transcripts INPUT_TRANSCRIPTS
                        Path to an existing transcripts csv file.
  --input-boundaries INPUT_BOUNDARIES
                        Path to a micron-space parquet boundary file.
  --input-micron-to-mosaic INPUT_MICRON_TO_MOSAIC
                        Path to the micron to mosaic pixel transformation
                        matrix.
  --output-csv OUTPUT_CSV
                        Path to the csv file where segmentation metrics will
                        be stored.

Optional arguments:
  --input-images INPUT_IMAGES
                        Input images can be specified in one of three ways: 1.
                        The path to a directory of tiff files, if the files
                        are named by the MERSCOPE convention. Example:
                        /path/to/files/ 2. The path to a directory of tiff
                        files including a python formatting string specifying
                        the file name. The format string must specify values
                        for "stain" and "z". Example:
                        /path/to/files/image_{stain}_z{z}.tif 3. A regular
                        expression matching the tiff files to be used, where
                        the regular expression specifies values for "stain"
                        and "z". Example: /path/to/files/mosaic_(?P<stain>[\w|
                        -]+)_z(?P<z>[0-9]+).tif In all cases, the values for
                        "stain" and "z" must match the stains and z indexes
                        specified in the segmentation algorithm.
  --experiment-name EXPERIMENT_NAME
                        The name of the experiment to be used as the index in
                        the output csv and segmentation report. Default:
                        Analysis Timestamp.
  --output-report OUTPUT_REPORT
                        Path to the output HTML file, will append .html to the
                        end if not included in file name.
  --output-clustering OUTPUT_CLUSTERING
                        Path where the Cell categories Parquet files with
                        clustering results will be saved.
  --input-z-index INPUT_Z_INDEX
                        The Z plane of the mosaic tiff images to use for the
                        patch. Default: 2.
  --red-stain-name RED_STAIN_NAME
                        The name of the stain that will be used for the red
                        channel in images. Default: None.
  --green-stain-name GREEN_STAIN_NAME
                        The name of the stain that will be used for the red
                        channel in images. Default: PolyT.
  --blue-stain-name BLUE_STAIN_NAME
                        The name of the stain that will be used for the blue
                        channel in images. Default: DAPI.
  --normalization NORMALIZATION
                        The name of the normalization method that will be used
                        on each channel. Default: CLAHE.
  --transcript-count-filter-threshold TRANSCRIPT_COUNT_FILTER_THRESHOLD
                        The cell transcript count threshold used for computing
                        metrics and clustering. Default: 100.
  --volume-filter-threshold VOLUME_FILTER_THRESHOLD
                        The cell volume threshold used for computing metrics
                        and clustering. Default: 200.
  --overwrite           Set flag if you want to use non empty directory and
                        agree that files can be over-written.
  -h, --help            Show this help message and exit
```


## vpt_Computes

### Tool Description
vpt: error: argument : invalid choice: 'Computes' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Computes' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_to

### Tool Description
vpt: error: argument : invalid choice: 'to' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'to' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_Number

### Tool Description
vpt: error: argument : invalid choice: 'Number' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Number' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_locally

### Tool Description
vpt: error: argument : invalid choice: 'locally' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'locally' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_Named

### Tool Description
vpt: error: argument : invalid choice: 'Named' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Named' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_AWS

### Tool Description
vpt: error: argument : invalid choice: 'AWS' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'AWS' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_Path

### Tool Description
vpt: error: argument : invalid choice: 'Path' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Path' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_needed

### Tool Description
vpt: error: argument : invalid choice: 'needed' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'needed' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_gcloud

### Tool Description
vpt: error: argument : invalid choice: 'gcloud' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'gcloud' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_Log

### Tool Description
vpt: error: argument : invalid choice: 'Log' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'Log' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_crit

### Tool Description
vpt: error: argument : invalid choice: 'crit' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'crit' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## vpt_written

### Tool Description
vpt: error: argument : invalid choice: 'written' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Vizgen/vizgen-postprocessing
- **Package**: https://anaconda.org/channels/bioconda/packages/vpt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vpt [OPTIONS] COMMAND [arguments]
vpt: error: argument : invalid choice: 'written' (choose from 'run-segmentation', 'prepare-segmentation', 'run-segmentation-on-tile', 'compile-tile-segmentation', 'derive-entity-metadata', 'partition-transcripts', 'sum-signals', 'update-vzg', 'convert-geometry', 'convert-to-ome', 'convert-to-rgb-ome', 'extract-image-patch', 'generate-segmentation-metrics')
```


## Metadata
- **Skill**: generated
