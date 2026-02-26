# pycistopic CWL Generation Report

## pycistopic_qc

### Tool Description
QC for scATAC-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycistopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Total Downloads**: 65
- **Last updated**: 2025-12-17
- **GitHub**: https://github.com/aertslab/pycistopic
- **Stars**: N/A
### Original Help Text
```text
usage: pycistopic qc [-h] -f FRAGMENTS_TSV_FILENAME -r REGIONS_BED_FILENAME -t
                     TSS_ANNOTATION_BED_FILENAME -o OUTPUT_PREFIX
                     [--threads THREADS] [--tss_flank_window TSS_FLANK_WINDOW]
                     [--tss_smoothing_rolling_window TSS_SMOOTHING_ROLLING_WINDOW]
                     [--tss_minimum_signal_window TSS_MINIMUM_SIGNAL_WINDOW]
                     [--tss_window TSS_WINDOW] [--tss_min_norm TSS_MIN_NORM]
                     [--use-pyranges]
                     [--min_fragments_per_cb MIN_FRAGMENTS_PER_CB]
                     [--dont-collapse_duplicates]

options:
  -h, --help            show this help message and exit
  -f FRAGMENTS_TSV_FILENAME, --fragments FRAGMENTS_TSV_FILENAME
                        Fragments TSV filename which contains scATAC
                        fragments.
  -r REGIONS_BED_FILENAME, --regions REGIONS_BED_FILENAME
                        Consensus peaks / SCREEN regions BED file. Used to
                        calculate amount of fragments in peaks.
  -t TSS_ANNOTATION_BED_FILENAME, --tss TSS_ANNOTATION_BED_FILENAME
                        TSS annotation BED file. Used to calculate distance of
                        fragments to TSS positions.
  -o OUTPUT_PREFIX, --output OUTPUT_PREFIX
                        Output prefix to use for QC statistics parquet output
                        files.
  --threads THREADS     Number of threads to use when calculating kernel-
                        density estimate (KDE) to get probability density
                        function (PDF) values for log10 unique fragments in
                        peaks vs TSS enrichment, fractions of fragments in
                        peaks and duplication ratio. Default: 8.
  --min_fragments_per_cb MIN_FRAGMENTS_PER_CB
                        Minimum number of fragments needed per cell barcode to
                        keep the fragments for those cell barcodes. Default:
                        10.
  --dont-collapse_duplicates
                        Don't collapse duplicate fragments (same chromosomal
                        positions and linked to the same cell barcode).
                        Default: collapse duplicates.

TSS profile:
  TSS profile statistics calculation settings.

  --tss_flank_window TSS_FLANK_WINDOW
                        Flanking window around the TSS. Used for intersecting
                        fragments with TSS positions and keeping cut
                        sites.Default: 2000 (+/- 2000 bp).
  --tss_smoothing_rolling_window TSS_SMOOTHING_ROLLING_WINDOW
                        Rolling window used to smooth the cut sites signal.
                        Default: 10.
  --tss_minimum_signal_window TSS_MINIMUM_SIGNAL_WINDOW
                        Average signal in the tails of the flanking window
                        around the TSS ([-flank_window, -flank_window +
                        minimum_signal_window + 1], [flank_window -
                        minimum_signal_window + 1, flank_window]) is used to
                        normalize the TSS enrichment. Default: 100 (average
                        signal in [-2000, -1901], [1901, 2000] around TSS, if
                        flank_window=2000).
  --tss_window TSS_WINDOW
                        Window around the TSS used to count fragments in the
                        TSS when calculating the TSS enrichment per cell
                        barcode. Default: 50 (+/- 50 bp).
  --tss_min_norm TSS_MIN_NORM
                        Minimum normalization score. If the average minimum
                        signal value is below this value, this number is used
                        to normalize the TSS signal. This approach penalizes
                        cells with fewer reads. Default: 0.2
  --use-pyranges        Use pyranges instead of genomic ranges implementation
                        for calculating intersections.
```


## pycistopic_topic_modeling

### Tool Description
Topic modeling for pycisTopic

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycistopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.10/site-packages/pycisTopic/__init__.py:3: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import DistributionNotFound, get_distribution
usage: pycistopic topic_modeling [-h] {lda,mallet} ...
pycistopic topic_modeling: error: the following arguments are required: topic_modeling
```


## pycistopic_tss

### Tool Description
TSS: List of TSS subcommands.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycistopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic tss [-h]
                      {get_tss,gene_annotation_list,get_ncbi_acc,get_ncbi_chrom_sizes_and_alias_mapping,get_ucsc_chrom_sizes_and_alias_mapping}
                      ...

options:
  -h, --help            show this help message and exit

TSS:
  {get_tss,gene_annotation_list,get_ncbi_acc,get_ncbi_chrom_sizes_and_alias_mapping,get_ucsc_chrom_sizes_and_alias_mapping}
                        List of TSS subcommands.
    get_tss             Get TSS gene annotation from Ensembl BioMart.
    gene_annotation_list
                        Get list of all Ensembl BioMart gene annotation names.
    get_ncbi_acc        Get NCBI assembly accession numbers and assembly names
                        for a certain species.
    get_ncbi_chrom_sizes_and_alias_mapping
                        Get chromosome sizes and alias mapping from NCBI
                        sequence reports.
    get_ucsc_chrom_sizes_and_alias_mapping
                        Get chromosome sizes and alias mapping from UCSC.
```

