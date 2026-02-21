# aniclustermap CWL Generation Report

## aniclustermap

### Tool Description
FAIL to generate CWL: aniclustermap not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/aniclustermap:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/ANIclustermap/
- **Package**: https://anaconda.org/channels/bioconda/packages/aniclustermap/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/aniclustermap/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-05-02
- **GitHub**: https://github.com/moshi4/ANIclustermap
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: aniclustermap not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: aniclustermap not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## aniclustermap_ANIclustermap

### Tool Description
Draw ANI(Average Nucleotide Identity) clustermap

### Metadata
- **Docker Image**: quay.io/biocontainers/aniclustermap:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/ANIclustermap/
- **Package**: https://anaconda.org/channels/bioconda/packages/aniclustermap/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: ANIclustermap [OPTIONS]                                                                                                                                                               
                                                                                                                                                                                              
 Draw ANI(Average Nucleotide Identity) clustermap                                                                                                                                             
                                                                                                                                                                                              
                                                                                                                                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *  --indir             -i        Input genome fasta directory (*.fa|*.fna[.gz]|*.fasta) [required]                                                                                         │
│ *  --outdir            -o        Output directory [required]                                                                                                                               │
│    --mode                        ANI calculation tool (fastani|skani) [default: fastani]                                                                                                   │
│    --thread_num        -t        Thread number parameter [default: 39]                                                                                                                     │
│    --overwrite                   Overwrite previous ANI calculation result                                                                                                                 │
│    --fig_width                   Figure width [default: 10]                                                                                                                                │
│    --fig_height                  Figure height [default: 10]                                                                                                                               │
│    --dendrogram_ratio            Dendrogram ratio to figsize [default: 0.15]                                                                                                               │
│    --cmap_colors                 cmap interpolation colors parameter [default: lime,yellow,red]                                                                                            │
│    --cmap_gamma                  cmap gamma parameter [default: 1.0]                                                                                                                       │
│    --cmap_ranges                 Range values (e.g. 80,90,95,100) for discrete cmap                                                                                                        │
│    --cbar_pos                    Colorbar position [default: 0.02, 0.85, 0.04, 0.15]                                                                                                       │
│    --annotation                  Show ANI value annotation                                                                                                                                 │
│    --annotation_fmt              Annotation value format [default: .3g]                                                                                                                    │
│    --quiet                       No print log on screen                                                                                                                                    │
│    --version           -v        Print version information                                                                                                                                 │
│    --help              -h        Show this message and exit.                                                                                                                               │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

