# segzoo CWL Generation Report

## segzoo

### Tool Description
Segzoo is a tool that allows to run various genomic analysis on a segmentation obtained by segway. The results of each analysis are made available as well as a summarizing visualization of the results. The tool will download all necessary data into a common directory and run all the analysis, storing the results in an output directory. All this information is then transformed into a set of tables that can be found in this same directory under the "data" folder, that are used to generate a final visualization.

### Metadata
- **Docker Image**: quay.io/biocontainers/segzoo:1.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/hoffmangroup/segzoo
- **Package**: https://anaconda.org/channels/bioconda/packages/segzoo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/segzoo/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hoffmangroup/segzoo
- **Stars**: N/A
### Original Help Text
```text
usage: segzoo [-h] [--version] [--parameters PARAMETERS] [-o OUTDIR]
              [-j CORES] [--species SPECIES] [--build BUILD] [--prefix PREFIX]
              [--download-only] [--mne MNE] [--dendrogram] [--unlock]
              segmentation

Segzoo is a tool that allows to run various genomic analysis on a segmentation
obtained by segway. The results of each analysis are made available as well as
a summarizing visualization of the results. The tool will download all
necessary data into a common directory and run all the analysis, storing the
results in an output directory. All this information is then transformed into
a set of tables that can be found in this same directory under the "data"
folder, that are used to generate a final visualization.

positional arguments:
  segmentation          .bed.gz file, the segmentation/annotation output from
                        Segway

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --parameters PARAMETERS
                        The params.params file used to obtain the gmtk-
                        parameters (default: False)
  -o OUTDIR, --outdir OUTDIR
                        Output directory to store all the results (default:
                        outdir)
  -j CORES              Number of cores to use (default: 1)
  --species SPECIES     Species of the genome used for the segmentation
                        (default: Homo_sapiens)
  --build BUILD         Build of the genome assembly used for the segmentation
                        (default: hg38)
  --prefix PREFIX       Prefix where all the external data is going to be
                        downloaded, followed by /share/ggd/SPECIES/BUILD
                        (default: /usr/local)
  --download-only       Execute only the rules that need internet connection,
                        which store data in a shared directory (default:
                        False)
  --mne MNE             Allows specify an mne file to translate segment labels
                        and track names on the shown on the figure (default:
                        None)
  --dendrogram          If set, perform hierarchical clustering of GMTK
                        parameters table row-wise (default: False)
  --unlock              unlock directory (see snakemake doc) (default: False)
```

