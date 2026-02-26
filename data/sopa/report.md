# sopa CWL Generation Report

## sopa_convert

### Tool Description
Read any technology data as a SpatialData object and save it as a `.zarr` directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-12-20
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: sopa convert [OPTIONS] DATA_PATH                                        
                                                                                
 Read any technology data as a SpatialData object and save it as a `.zarr`      
 directory.                                                                     
                                                                                
 Either `--technology` or `--config-path` has to be provided.                   
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    data_path      TEXT  Path to one data sample (most of the time, this    │
│                           corresponds to a directory with images files and   │
│                           eventually a transcript file)                      │
│                           [required]                                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --technology                       TEXT  Name of the technology used to      │
│                                          collected the data                  │
│                                          (`xenium`/`merfish`/`cosmx`/`pheno… │
│ --sdata-path                       TEXT  Optional path to write the          │
│                                          SpatialData object. If not          │
│                                          provided, will write to the         │
│                                          `{data_path}.zarr` directory        │
│ --config-path                      TEXT  Path to the snakemake config. This  │
│                                          can be useful in order not to       │
│                                          provide the `--technology` and the  │
│                                          `--kwargs` arguments                │
│ --overwrite      --no-overwrite          Whether to overwrite the existing   │
│                                          SpatialData object if already       │
│                                          existing                            │
│                                          [default: no-overwrite]             │
│ --kwargs                           TEXT  Dictionary provided to the reader   │
│                                          function as kwargs                  │
│                                          [default: {}]                       │
│ --help                                   Show this message and exit.         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_aggregate

### Tool Description
Create an `anndata` table containing the transcript count and/or the channel intensities per cell

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sopa aggregate [OPTIONS] SDATA_PATH                                     
                                                                                
 Create an `anndata` table containing the transcript count and/or the channel   
 intensities per cell                                                           
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    sdata_path      TEXT  Path to the SpatialData `.zarr` directory         │
│                            [required]                                        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --aggregate-genes       --no-aggregate-gen…             Whether to aggregate │
│                                                         the genes (counts)   │
│                                                         inside each cell     │
│ --aggregate-channels    --no-aggregate-cha…             Whether to aggregate │
│                                                         the channels         │
│                                                         (intensity) inside   │
│                                                         each cell            │
│                                                         [default:            │
│                                                         no-aggregate-channe… │
│ --expand-radius-rat…                           FLOAT    Cells polygons will  │
│                                                         be expanded by       │
│                                                         `expand_radius_ratio │
│                                                         * mean_radius` for   │
│                                                         channels averaging   │
│                                                         **only**. This help  │
│                                                         better aggregate     │
│                                                         boundary stainings   │
│ --min-transcripts                              INTEGER  Cells with less      │
│                                                         transcript than this │
│                                                         integer will be      │
│                                                         filtered             │
│                                                         [default: 0]         │
│ --min-intensity-rat…                           FLOAT    Cells whose mean     │
│                                                         channel intensity is │
│                                                         less than            │
│                                                         `min_intensity_ratio │
│                                                         * quantile_90` will  │
│                                                         be filtered          │
│                                                         [default: 0]         │
│ --image-key                                    TEXT     Optional image key   │
│                                                         of the SpatialData   │
│                                                         object. By default,  │
│                                                         considers the only   │
│                                                         one image. It can be │
│                                                         useful if another    │
│                                                         image is added later │
│                                                         on                   │
│ --gene-column                                  TEXT     Optional column of   │
│                                                         the transcript       │
│                                                         dataframe to be used │
│                                                         as gene names.       │
│                                                         Inferred by default. │
│ --method-name                                  TEXT     If segmentation was  │
│                                                         performed with a     │
│                                                         generic method, this │
│                                                         is the name of the   │
│                                                         method used.         │
│ --help                                                  Show this message    │
│                                                         and exit.            │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_scanpy-preprocess

### Tool Description
Optional scanpy table preprocessing (log1p, UMAP, leiden clustering) after aggregation/annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sopa scanpy-preprocess [OPTIONS] SDATA_PATH                             
                                                                                
 Optional scanpy table preprocessing (log1p, UMAP, leiden clustering) after     
 aggregation/annotation.                                                        
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    sdata_path      TEXT  Path to the SpatialData `.zarr` directory         │
│                            [required]                                        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --table-key                            TEXT   Key of the table in the        │
│                                               `SpatialData` object to be     │
│                                               preprocessed                   │
│                                               [default: table]               │
│ --resolution                           FLOAT  Resolution parameter for the   │
│                                               leiden clustering              │
│                                               [default: 1.0]                 │
│ --check-counts    --no-check-counts           Whether to check that adata.X  │
│                                               contains counts                │
│                                               [default: check-counts]        │
│ --hvg             --no-hvg                    Whether to compute highly      │
│                                               variable genes before          │
│                                               computing the UMAP and         │
│                                               clustering                     │
│                                               [default: no-hvg]              │
│ --help                                        Show this message and exit.    │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_report

### Tool Description
Create a HTML report of the pipeline run and some quality controls

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sopa report [OPTIONS] SDATA_PATH PATH                                   
                                                                                
 Create a HTML report of the pipeline run and some quality controls             
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    sdata_path      TEXT  Path to the SpatialData `.zarr` directory         │
│                            [required]                                        │
│ *    path            TEXT  Path to the HTML report [required]                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --table-key        TEXT  Key of the table in the `SpatialData` object to be  │
│                          used for the report                                 │
│                          [default: table]                                    │
│ --help                   Show this message and exit.                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_annotate

### Tool Description
Annotate spatial data

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/dask/dataframe/__init__.py:31: FutureWarning: The legacy Dask DataFrame implementation is deprecated and will be removed in a future version. Set the configuration option `dataframe.query-planning` to `True` or None to enable the new Dask Dataframe implementation and silence this warning.
  warnings.warn(
/usr/local/lib/python3.12/site-packages/xarray_schema/__init__.py:1: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import DistributionNotFound, get_distribution
Usage: sopa annotate [OPTIONS] COMMAND [ARGS]...
Try 'sopa annotate --help' for help.
╭─ Error ──────────────────────────────────────────────────────────────────────╮
│ No such option: -h                                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_explorer

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: sopa explorer [OPTIONS] COMMAND [ARGS]...                               
                                                                                
 Convertion to the Xenium Explorer's inputs, and image alignment                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ write         Convert a spatialdata object to Xenium Explorer's inputs       │
│ update-obs    Update the cell categories for the Xenium Explorer's (i.e.     │
│               what's in `adata.obs`). This is useful when you perform        │
│               analysis and update your `AnnData` object                      │
│ add-aligned   After alignment on the Xenium Explorer, add an image to the    │
│               SpatialData object                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_segmentation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: sopa segmentation [OPTIONS] COMMAND [ARGS]...                           
                                                                                
 Perform cell segmentation on patches. NB: for `baysor`, use directly the       
 `baysor` command line.                                                         
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ cellpose           Perform cellpose segmentation. This can be done on all    │
│                    patches directly, or on one individual patch.             │
│ stardist           Perform Stardist segmentation. This can be done on all    │
│                    patches directly, or on one individual patch.             │
│ generic-staining   Perform generic staining-based segmentation. This can be  │
│                    done on all patches directly, or on one individual patch. │
│ comseg             Perform ComSeg segmentation. This can be done on all      │
│                    patches directly, or on one individual patch.             │
│ baysor             Perform Baysor segmentation. This can be done on all      │
│                    patches directly, or on one individual patch.             │
│ proseg             Perform Proseg segmentation. This needs to be done on a   │
│                    single patch as proseg is fast enough and doesn't require │
│                    parallelization.                                          │
│ tissue             Perform tissue segmentation. This can be done only on     │
│                    objects with H&E staining.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_resolve

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: sopa resolve [OPTIONS] COMMAND [ARGS]...                                
                                                                                
 Resolve the segmentation conflicts over patches overlaps                       
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ cellpose   Resolve patches conflicts after cellpose segmentation             │
│ stardist   Resolve patches conflicts after stardist segmentation             │
│ generic    Resolve patches conflicts after generic segmentation              │
│ baysor     Resolve patches conflicts after baysor segmentation.              │
│ comseg     Resolve patches conflicts after comseg segmentation.              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sopa_patchify

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
- **Homepage**: https://gustaveroussy.github.io/sopa
- **Package**: https://anaconda.org/channels/bioconda/packages/sopa/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: sopa patchify [OPTIONS] COMMAND [ARGS]...                               
                                                                                
 Create patches with overlaps. Afterwards, segmentation will be run on each     
 patch                                                                          
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ image         Prepare patches for staining-based segmentation (including     │
│               Cellpose)                                                      │
│ transcripts   Prepare patches for transcript-based segmentation (e.g., for   │
│               Proseg or Baysor)                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```

