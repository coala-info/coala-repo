# pycistopic CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pycistopic_qc | Failed | image problem: polars version too new for pycisTopic, crashes with column CB not found (synthetic data: scATAC fragments built around real yeast TSS) |
| pycistopic_topic_modeling_lda | Failed | image problem: python module lda is missing in the image |
| pycistopic_topic_modeling_mallet | Failed | image problem: python module lda is missing and no mallet binary in the image |
| pycistopic_tss_gene_annotation_list | PASS |  |
| pycistopic_tss_get_ncbi_acc | PASS |  |
| pycistopic_tss_get_ncbi_chrom_sizes_and_alias_mapping | Failed | image problem: polars too new, DataFrame.write_csv() rejects has_header |
| pycistopic_tss_get_tss | PASS |  |
| pycistopic_tss_get_ucsc_chrom_sizes_and_alias_mapping | Failed | image problem: polars too new, DataFrame.write_csv() rejects has_header |

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


## pycistopic_topic_modeling_lda

### Tool Description
Run LDA topic modeling with the lda package.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycisTopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic topic_modeling lda [-h] -i INPUT -o OUTPUT -t TOPICS
                                     [TOPICS ...] -p PARALLEL [-n ITERATIONS]
                                     [-a ALPHA] [-A {True,False}] [-e ETA]
                                     [-E {True,False}] [-k {True,False}]
                                     [-s SEED] [-T TEMP_DIR]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        cisTopic object pickle input filename.
  -o OUTPUT, --output OUTPUT
                        Topic model list pickle output filename.
  -t TOPICS [TOPICS ...], --topics TOPICS [TOPICS ...]
                        Number(s) of topics to create during topic modeling.
  -p PARALLEL, --parallel PARALLEL
                        Number of topic models to run in parallel.
  -n ITERATIONS, --iterations ITERATIONS
                        Number of iterations. Default: 500.
  -a ALPHA, --alpha ALPHA
                        Alpha value. Default: 50.
  -A {True,False}, --alpha_by_topic {True,False}
                        Whether the alpha value should by divided by the
                        number of topics. Default: True.
  -e ETA, --eta ETA     Eta value. Default: 0.1.
  -E {True,False}, --eta_by_topic {True,False}
                        Whether the eta value should by divided by the number
                        of topics. Default: False.
  -k {True,False}, --keep {True,False}
                        Whether intermediate topic models should be kept.
                        Useful to enable if running with a lot of topic
                        numbers, to not lose finished topic model runs.
                        Default: False.
  -s SEED, --seed SEED  Seed for ensuring reproducibility. Default: 555.
  -T TEMP_DIR, --temp_dir TEMP_DIR
                        TMP directory to use instead of the default ("/tmp").
```

## pycistopic_topic_modeling_mallet

### Tool Description
Run LDA topic modeling with Mallet.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycisTopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic topic_modeling mallet [-h] -i INPUT -o OUTPUT -t TOPICS
                                        [TOPICS ...] -p PARALLEL
                                        [-n ITERATIONS] [-a ALPHA]
                                        [-A {True,False}] [-e ETA]
                                        [-E {True,False}] [-k {True,False}]
                                        [-s SEED] [-T TEMP_DIR]
                                        [-m MEMORY_IN_GB] [-r REUSE_CORPUS]
                                        [-b MALLET_PATH]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        cisTopic object pickle input filename.
  -o OUTPUT, --output OUTPUT
                        Topic model list pickle output filename.
  -t TOPICS [TOPICS ...], --topics TOPICS [TOPICS ...]
                        Number(s) of topics to create during topic modeling.
  -p PARALLEL, --parallel PARALLEL
                        Number of threads Mallet is allowed to use.
  -n ITERATIONS, --iterations ITERATIONS
                        Number of iterations. Default: 500.
  -a ALPHA, --alpha ALPHA
                        Alpha value. Default: 50.
  -A {True,False}, --alpha_by_topic {True,False}
                        Whether the alpha value should by divided by the
                        number of topics. Default: True.
  -e ETA, --eta ETA     Eta value. Default: 0.1.
  -E {True,False}, --eta_by_topic {True,False}
                        Whether the eta value should by divided by the number
                        of topics. Default: False.
  -k {True,False}, --keep {True,False}
                        Whether intermediate topic models should be kept.
                        Useful to enable if running with a lot of topic
                        numbers, to not lose finished topic model runs.
                        Default: False.
  -s SEED, --seed SEED  Seed for ensuring reproducibility. Default: 555.
  -T TEMP_DIR, --temp_dir TEMP_DIR
                        TMP directory to use instead of the default ("/tmp").
  -m MEMORY_IN_GB, --memory MEMORY_IN_GB
                        Amount of memory (in GB) Mallet is allowed to use.
                        Default: "100"
  -r REUSE_CORPUS, --reuse_corpus REUSE_CORPUS
                        Whether to reuse the corpus from Mallet. Default:
                        False.
  -b MALLET_PATH, --mallet_path MALLET_PATH
                        Path to Mallet binary (e.g. "/xxx/Mallet/bin/mallet").
                        Default: "mallet".
```

## pycistopic_tss_gene_annotation_list

### Tool Description
Get list of all Ensembl BioMart gene annotation names.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycisTopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic tss gene_annotation_list [-h] [-f FILTER] [-s BIOMART_HOST]
                                           [--no-cache]

options:
  -h, --help            show this help message and exit
  -f FILTER, --filter FILTER
                        Only keep list of Ensembl BioMart gene annotation
                        names that contain specified string.

Ensembl BioMart:
  Ensembl BioMart server settings.

  -s BIOMART_HOST, --server BIOMART_HOST
                        BioMart host URL to use. Default:
                        "http://www.ensembl.org". Archived Ensembl BioMart
                        URLs: https://www.ensembl.org/info/website/archives/in
                        dex.html (List of currently available archives).
  --no-cache            Disable caching of requests to Ensembl BioMart server.
```

## pycistopic_tss_get_ncbi_acc

### Tool Description
Get NCBI assembly accession numbers and assembly names for a certain species.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycisTopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic tss get_ncbi_acc [-h] -s SPECIES

options:
  -h, --help            show this help message and exit
  -s SPECIES, --species SPECIES
                        Species name (latin name) for which to look for NCBI
                        assembly accession numbers. e.g.: "homo sapiens".
```

## pycistopic_tss_get_ncbi_chrom_sizes_and_alias_mapping

### Tool Description
Get chromosome sizes and alias mapping from NCBI sequence reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycisTopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic tss get_ncbi_chrom_sizes_and_alias_mapping
       [-h] [--ncbi NCBI_ACCESSION_ID]
       [--chrom-sizes-alias CHROM_SIZES_AND_ALIAS_TSV_FILENAME]

options:
  -h, --help            show this help message and exit
  --ncbi NCBI_ACCESSION_ID
                        NCBI genome accession ID for which to retrieve NCBI
                        sequence reports, which will be used to build
                        chromosome sizes and alias mappings, which can be used
                        to map Ensembl chromosome names (from TSS annotation)
                        to UCSC, RefSeq or GenBank chromosome names. Run
                        `pycistopic tss get_ncbi_acc` to get all possible NCBI
                        genome accession IDs for a species. e.g.:
                        "GCF_000001405.40", "GCF_000001215.4",
                        "GCF_000001215.4", ...
  --chrom-sizes-alias CHROM_SIZES_AND_ALIAS_TSV_FILENAME
                        Write chromosome sizes and alias TSV file with
                        chromosome sizes and alias mapping, which can be used
                        to map Ensembl chromosome names (from TSS annotation)
                        to UCSC, RefSeq or GenBank chromosome names.
```

## pycistopic_tss_get_tss

### Tool Description
Get TSS gene annotation from Ensembl BioMart.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycisTopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic tss get_tss [-h] -o TSS_ANNOTATION_BED_FILENAME -n
                              BIOMART_NAME [-t TRANSCRIPT_TYPE]
                              [-s BIOMART_HOST] [--no-cache]
                              [--to-chrom-source TO_CHROM_SOURCE_NAME]
                              [--chrom-sizes-alias CHROM_SIZES_AND_ALIAS_TSV_FILENAME]
                              [--ncbi NCBI_ACCESSION_ID | --ucsc UCSC_ASSEMBLY]

options:
  -h, --help            show this help message and exit
  -o TSS_ANNOTATION_BED_FILENAME, --output TSS_ANNOTATION_BED_FILENAME
                        BED output file with selected Ensembl BioMart TSS
                        annotation and with optionally remapped chromosome
                        names from Ensembl chromosome names to UCSC, RefSeq or
                        GenBank chromosome names.

Ensembl BioMart:
  Ensembl BioMart server settings.

  -n BIOMART_NAME, --name BIOMART_NAME
                        Ensembl BioMart gene annotation name of the dataset.
                        Run `pycistopic tss gene_annotation_list` to get a
                        list of available gene annotation names. e.g.:
                        "hsapiens_gene_ensembl", "mmusculus_gene_ensembl",
                        "dmelanogaster_gene_ensembl", ...
  -t TRANSCRIPT_TYPE, --transcript TRANSCRIPT_TYPE
                        Only keep comma separated list of specified transcript
                        types (e.g.: "protein_coding,pseudogene") or all (""
                        or "all": useful to see all possible transcript
                        types). Default: "protein_coding".
  -s BIOMART_HOST, --server BIOMART_HOST
                        BioMart host URL to use. Default:
                        "http://www.ensembl.org". Archived Ensembl BioMart
                        URLs: https://www.ensembl.org/info/website/archives/in
                        dex.html (List of currently available archives).
  --no-cache            Disable caching of requests to Ensembl BioMart server.

Remap chromosomes:
  Remap Ensembl chromosome names in TSS file to UCSC, RefSeq or GenBank
  chromosome names.

  --to-chrom-source TO_CHROM_SOURCE_NAME
                        Chromosome source name to which the Ensembl chromosome
                        names should be mapped to: "ucsc", "refseq" or
                        "genbank".
  --chrom-sizes-alias CHROM_SIZES_AND_ALIAS_TSV_FILENAME
                        Read/write chromosome sizes and alias TSV file with
                        chromosome sizes andalias mappings, which can be used
                        to map Ensembl chromosome names (from TSS annotation)
                        to UCSC, RefSeq or GenBank chromosome names. Read from
                        chromosome sizes and alias TSV file if "--ncbi" and "
                        --ucsc" are not specified and write to chromosome
                        sizes and alias TSV file one of them is.
  --ncbi NCBI_ACCESSION_ID
                        NCBI genome accession ID for which to retrieve NCBI
                        sequence reports, which will be used to build
                        chromosome sizes and alias mapping, which can be used
                        to map Ensembl chromosome names (from TSS annotation)
                        to UCSC, RefSeq or GenBank chromosome names. Run
                        `pycistopic tss get_ncbi_acc` to get all possible NCBI
                        genome accession IDs for a species. e.g.:
                        "GCF_000001405.40", "GCF_000001215.4",
                        "GCF_000001215.4", ...
  --ucsc UCSC_ASSEMBLY  UCSC genome accession ID for which to retrieve
                        chromosome sizes and alias mapping, which can be used
                        to map Ensembl chromosome names (from TSS annotation)
                        to UCSC, RefSeq or GenBank chromosome names. e.g.:
                        "hg38", "mm10", "dm6", ...
```

## pycistopic_tss_get_ucsc_chrom_sizes_and_alias_mapping

### Tool Description
Get chromosome sizes and alias mapping from UCSC.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/pycisTopic
- **Package**: https://anaconda.org/channels/bioconda/packages/pycistopic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pycistopic tss get_ucsc_chrom_sizes_and_alias_mapping
       [-h] [--ucsc UCSC_ASSEMBLY]
       [--chrom-sizes-alias CHROM_SIZES_AND_ALIAS_TSV_FILENAME]

options:
  -h, --help            show this help message and exit
  --ucsc UCSC_ASSEMBLY  UCSC genome accession ID for which to retrieve
                        chromosome sizes and alias mapping, which can be used
                        to map Ensembl chromosome names (from TSS annotation)
                        to UCSC, RefSeq or GenBank chromosome names. e.g.:
                        "hg38", "mm10", "dm6", ...
  --chrom-sizes-alias CHROM_SIZES_AND_ALIAS_TSV_FILENAME
                        Write chromosome sizes and alias TSV file with
                        chromosome sizes and alias mapping, which can be used
                        to map Ensembl chromosome names (from TSS annotation)
                        to UCSC, RefSeq or GenBank chromosome names.
```

## Metadata
- **Skill**: not generated
