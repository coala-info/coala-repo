# biofluff CWL Generation Report

## biofluff

### Tool Description
FAIL to generate CWL: biofluff not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/biofluff:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/simonvh/fluff
- **Package**: https://anaconda.org/channels/bioconda/packages/biofluff/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/biofluff/overview
- **Total Downloads**: 57.7K
- **Last updated**: 2025-08-10
- **GitHub**: https://github.com/simonvh/fluff
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: biofluff not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: biofluff not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## biofluff_fluff

### Tool Description
A tool for NGS data visualization (Note: The provided text is a Python traceback/error log and does not contain help documentation or argument definitions).

### Metadata
- **Docker Image**: quay.io/biocontainers/biofluff:3.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/simonvh/fluff
- **Package**: https://anaconda.org/channels/bioconda/packages/biofluff/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
mkdir -p failed for path /projects/rpci/songliu/qhu/.cache/matplotlib: [Errno 30] Read-only file system: '/projects/rpci/songliu/qhu/.cache'
Matplotlib created a temporary cache directory at /tmp/matplotlib-z0mysgvj because there was an issue with the default path (/projects/rpci/songliu/qhu/.cache/matplotlib); it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
Traceback (most recent call last):
  File "/usr/local/bin/fluff", line 6, in <module>
    from fluff.parse import main
  File "/usr/local/lib/python3.12/site-packages/fluff/parse.py", line 4, in <module>
    from fluff.commands.heatmap import heatmap
  File "/usr/local/lib/python3.12/site-packages/fluff/commands/heatmap.py", line 17, in <module>
    from fluff.plot import heatmap_plot
  File "/usr/local/lib/python3.12/site-packages/fluff/plot.py", line 22, in <module>
    GENE_ARROW = ArrowStyle._Curve(beginarrow=False, endarrow=True, head_length=.4, head_width=.4)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: ArrowStyle._Curve.__init__() got an unexpected keyword argument 'beginarrow'
```

