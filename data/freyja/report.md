# freyja CWL Generation Report

## freyja_aggregate

### Tool Description
Aggregates all demix data in RESULTS directory

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Total Downloads**: 57.2K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/andersen-lab/Freyja
- **Stars**: N/A
### Original Help Text
```text
Usage: freyja aggregate [OPTIONS] RESULTS

  Aggregates all demix data in RESULTS directory

Options:
  --ext TEXT     file extension option, e.g. X.ext  [default: ""]
  --output PATH  name for aggregated results  [default: aggregated_result.tsv]
  --help         Show this message and exit.
```


## freyja_ampliconstat

### Tool Description
Calculate amplicon statistics from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/freyja", line 10, in <module>
    sys.exit(cli())
             ^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1485, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1406, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1873, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1269, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 824, in invoke
    return callback(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/freyja/_cli.py", line 1170, in ampliconstat
    processed_primers = process_bed_file(primer)
                        ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/freyja/utils.py", line 1350, in process_bed_file
    primer_df = pd.read_csv(
                ^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/pandas/io/parsers/readers.py", line 873, in read_csv
    return _read(filepath_or_buffer, kwds)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/pandas/io/parsers/readers.py", line 300, in _read
    parser = TextFileReader(filepath_or_buffer, **kwds)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/pandas/io/parsers/readers.py", line 1645, in __init__
    self._engine = self._make_engine(f, self.engine)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/pandas/io/parsers/readers.py", line 1904, in _make_engine
    self.handles = get_handle(
                   ^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/pandas/io/common.py", line 772, in get_handle
    ioargs = _get_filepath_or_buffer(
             ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/pandas/io/common.py", line 492, in _get_filepath_or_buffer
    raise ValueError(msg)
ValueError: Invalid file path or buffer object type: <class 'NoneType'>
```


## freyja_barcode-build

### Tool Description
Builds a barcode reference from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/freyja", line 10, in <module>
    sys.exit(cli())
             ^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1485, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1406, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1873, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1269, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 824, in invoke
    return callback(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/freyja/_cli.py", line 423, in barcode_build
    if os.path.exists(locDir) and not redo:
       ^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen genericpath>", line 19, in exists
TypeError: stat: path should be string, bytes, os.PathLike or integer, not NoneType
```


## freyja_boot

### Tool Description
Perform bootstrapping method for freyja using VARIANTS and DEPTHS

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja boot [OPTIONS] VARIANTS DEPTHS

  Perform bootstrapping method for freyja using VARIANTS and DEPTHS

Options:
  --nb INTEGER                    number of times bootstrapping is performed
                                  [default: 100]
  --nt INTEGER                    max number of cpus to use  [default: 1]
  --eps FLOAT                     minimum abundance to include  [default:
                                  0.001]
  --barcodes TEXT                 custom barcode file  [default: ""]
  --meta TEXT                     custom lineage to variant metadata file
                                  [default: ""]
  --output_base PATH              Output file basename  [default: test]
  --boxplot TEXT                  file format of boxplot output (e.g. pdf or
                                  png)  [default: ""]
  --confirmedonly                 exclude unconfirmed lineages
  --rawboots                      return raw bootstraps
  --lineageyml TEXT               lineage hierarchy file in yaml format
                                  [default: ""]
  --depthcutoff INTEGER           exclude sites with coverage depth below this
                                  value andgroup identical barcodes  [default:
                                  0]
  --relaxedmrca                   for use with depth cutoff,clusters are
                                  assigned robust mrca to handle outliers
  --relaxedthresh FLOAT           associated threshold for robust mrca
                                  function  [default: 0.9]
  --bootseed INTEGER              set seed for bootstrap generation  [default:
                                  0]
  --solver TEXT                   solver used for estimating lineage
                                  prevalence  [default: CLARABEL]
  --pathogen [SARS-CoV-2|MPX|H5Nx|H5Nx-cattle|H1N1|FLU-B-VIC|H3N2|MEASLESgenome|RSVa|RSVb|DENV1|DENV2|DENV3|DENV4|MTB]
                                  Pathogen of interest.Not used if using
                                  --barcodes option.  [default: SARS-CoV-2]
  --autoadapt                     use error profile to set adapt
  --freqcol TEXT                  Frequency column name in the vcf file
                                  [default: AF]
  --help                          Show this message and exit.
```


## freyja_covariants

### Tool Description
Calls physically linked mutations in BAM_FILE using coVar (https://github.com/andersen-lab/covar)

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja covariants [OPTIONS] INPUT_BAM

  Calls physically linked mutations in BAM_FILE using coVar
  (https://github.com/andersen-lab/covar)

Options:
  --reference PATH       [default: data/NC_045512_Hu-1.fasta]
  --annot PATH           path to gff file corresponding to reference genome
                         [default: data/NC_045512_Hu-1.gff]
  --start_site INTEGER   minimum genomic coordinate to consider  [default: 0]
  --end_site TEXT        maximum genomic coordinateto consider (defaults to
                         full genome)
  --output TEXT          [default: covariants.tsv]
  --min_quality INTEGER  minimum quality for a base to be considered
                         [default: 20]
  --min_depth INTEGER    minimum count for a set of mutations to be saved
                         [default: 10]
  --threads INTEGER      number of threads to use  [default: 1]
  --help                 Show this message and exit.
```


## freyja_dash

### Tool Description
Generate an interactive dashboard from Freyja results.

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja dash [OPTIONS] AGG_RESULTS METADATA TITLE INTRO

Options:
  --thresh FLOAT                  minimum lineage abundance  [default: 0.01]
  --headerColor TEXT              color of header  [default: #2fdcf5]
  --bodyColor TEXT                color of body  [default: #ffffff]
  --scale_by_viral_load           scale by viral load
  --nboots INTEGER                Number of Bootstrap iterations  [default:
                                  1000]
  --serial_interval FLOAT         Serial Interval  [default: 5.5]
  --config TEXT                   control the colors and grouping of lineages
                                  in the plot
  --mincov FLOAT                  min genome coverage included  [default:
                                  60.0]
  --output TEXT                   Output html file  [default:
                                  mydashboard.html]
  --days INTEGER                  specify number of days for growth
                                  calculation  [default: 56]
  --grthresh FLOAT                minimum prevalence to calculate relative
                                  growth rate for  [default: 0.001]
  --lineageyml TEXT               custom lineage hierarchy file  [default: ""]
  --keep_plot_files               keep the intermediate html for the core plot
  --pathogen [SARS-CoV-2|MPX|H5Nx|H5Nx-cattle|H1N1|FLU-B-VIC|H3N2|MEASLESgenome|RSVa|RSVb|DENV1|DENV2|DENV3|DENV4|MTB]
                                  Pathogen of interest.Not used if using
                                  --lineageyml option.  [default: SARS-CoV-2]
  --help                          Show this message and exit.
```


## freyja_demix

### Tool Description
Generate relative lineage abundances from VARIANTS and DEPTHS

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja demix [OPTIONS] VARIANTS DEPTHS

  Generate relative lineage abundances from VARIANTS and DEPTHS

Options:
  --version                       get barcode version, returns filename for
                                  custom barcodes. Requires --pathogen option
                                  to get version info
  --eps FLOAT                     minimum abundance to include for each
                                  lineage  [default: 0.001]
  --barcodes TEXT                 Path to custom barcode file  [default: ""]
  --meta TEXT                     custom lineage to variant metadata file
                                  [default: ""]
  --output PATH                   Output file  [default: demixing_result.tsv]
  --covcut INTEGER                calculate percent of sites with n or greater
                                  reads  [default: 10]
  --confirmedonly                 exclude unconfirmed lineages
  --depthcutoff INTEGER           exclude sites with coverage depth below this
                                  value and group identical barcodes
                                  [default: 0]
  --lineageyml TEXT               lineage hierarchy file in a yaml format
                                  [default: ""]
  --adapt FLOAT                   adaptive lasso penalty parameter  [default:
                                  0.0]
  --a_eps FLOAT                   adaptive lasso parameter, hard threshold
                                  [default: 1e-08]
  --region_of_interest TEXT       JSON file containing region(s) of interest
                                  for which to compute additional coverage
                                  estimates  [default: ""]
  --relaxedmrca                   for use with depth cutoff, clusters are
                                  assigned robust mrca to handle outliers
  --relaxedthresh FLOAT           associated threshold for robust mrca
                                  function  [default: 0.9]
  --solver TEXT                   solver used for estimating lineage
                                  prevalence  [default: CLARABEL]
  --max-solver-threads INTEGER    maximum number of threads for multithreaded
                                  demix solvers (0 to choose automatically)
                                  [default: 1]
  --verbose-solver                enable solver verbosity
  --pathogen [SARS-CoV-2|MPX|H5Nx|H5Nx-cattle|H1N1|FLU-B-VIC|H3N2|MEASLESgenome|RSVa|RSVb|DENV1|DENV2|DENV3|DENV4|MTB]
                                  Pathogen of interest. Not used if using
                                  --barcodes option.  [default: SARS-CoV-2]
  --autoadapt                     use error profile to set adapt
  --freqcol TEXT                  Frequency column name in the vcf file
                                  [default: AF]
  --help                          Show this message and exit.
```


## freyja_extract

### Tool Description
Extracts reads from INPUT_BAM containing one or more QUERY_MUTATIONS

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja extract [OPTIONS] QUERY_MUTATIONS INPUT_BAM

  Extracts reads from INPUT_BAM containing one or more QUERY_MUTATIONS

Options:
  --output TEXT  path to save extracted reads  [default: extracted.bam]
  --same_read    include to specify that query reads must all occur on the
                 same read
  --help         Show this message and exit.
```


## freyja_filter

### Tool Description
Excludes reads from INPUT_BAM containing one or more QUERY_MUTATIONS between MIN_SITE and MAX_SITE (genomic coordinates)

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja filter [OPTIONS] QUERY_MUTATIONS INPUT_BAM [MIN_SITE] [MAX_SITE]

  Excludes reads from INPUT_BAM containing one or more QUERY_MUTATIONS between
  MIN_SITE and MAX_SITE (genomic coordinates)

Options:
  --output TEXT  path to save filtered reads  [default: filtered.bam]
  --help         Show this message and exit.
```


## freyja_get-lineage-def

### Tool Description
Get the mutations defining a LINEAGE of interest from provided barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja get-lineage-def [OPTIONS] LINEAGE

  Get the mutations defining a LINEAGE of interest from provided barcodes

Options:
  --barcodes TEXT  Path to custom barcode file  [default:
                   data/usher_barcodes.feather]
  --annot TEXT     Path to annotation file in gff3 format. If included, shows
                   amino acid mutations.
  --ref TEXT       Reference file in fasta format. Required to display amino
                   acid mutations
  --output TEXT    Output file to save lineage definition. Defaults to stdout.
  --help           Show this message and exit.
```


## freyja_plot

### Tool Description
Create plot from AGG_RESULTS

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja plot [OPTIONS] AGG_RESULTS

  Create plot from AGG_RESULTS

Options:
  --lineages                      modify lineage breakdown
  --times TEXT                    provide sample collection information,check
                                  data/times_metadata.csv for additional
                                  information  [default: ""]
  --interval TEXT                 define whether the intervals are calculated
                                  daily D or monthly M use with --windowsize
                                  [default: MS]
  --config TEXT                   allows users to control the colors and
                                  grouping of lineages in the plot
  --mincov FLOAT                  min genome coverage included  [default:
                                  60.0]
  --output TEXT                   specify output file name  [default:
                                  mix_plot.pdf]
  --windowsize INTEGER            width of the rolling average windowfor
                                  interval calculation  [default: 14]
  --lineageyml TEXT               Custom lineage hierarchy file  [default: ""]
  --thresh FLOAT                  pass a minimum lineage abundance  [default:
                                  0.01]
  --writegrouped TEXT             path to write grouped lineage data
                                  [default: ""]
  --pathogen [SARS-CoV-2|MPX|H5Nx|H5Nx-cattle|H1N1|FLU-B-VIC|H3N2|MEASLESgenome|RSVa|RSVb|DENV1|DENV2|DENV3|DENV4|MTB]
                                  Pathogen of interest.Not used if using
                                  --lineageyml option.  [default: SARS-CoV-2]
  --help                          Show this message and exit.
```


## freyja_plot-covariants

### Tool Description
Plot COVARIANTS output as a heatmap

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja plot-covariants [OPTIONS] COVARIANTS

  Plot COVARIANTS output as a heatmap

Options:
  --output TEXT            [default: covariants_plot.pdf]
  --num_clusters INTEGER   number of clusters to plot (sorted by frequency)
                           [default: 10]
  --min_mutations INTEGER  minimum number of mutations in a cluster to be
                           plotted  [default: 2]
  --nt_muts                if included, include nucleotide mutations in
                           x-labels
  --help                   Show this message and exit.
```


## freyja_relgrowthrate

### Tool Description
Calculates relative growth rates for each lineage using AGG_RESULTS and METADATA

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja relgrowthrate [OPTIONS] AGG_RESULTS METADATA

  Calculates relative growth rates for each lineage using AGG_RESULTS and
  METADATA

Options:
  --thresh FLOAT                  min lineage abundance in plot  [default:
                                  0.01]
  --scale_by_viral_load           scale by viral load
  --nboots INTEGER                Number of Bootstrap iterations  [default:
                                  1000]
  --serial_interval FLOAT         Serial Interval  [default: 5.5]
  --config TEXT                   control the colors and grouping of lineages
                                  in the plot
  --mincov FLOAT                  min genome coverage included  [default:
                                  60.0]
  --output TEXT                   Output html file  [default:
                                  rel_growth_rates.csv]
  --days INTEGER                  number of days for growth calculation
                                  [default: 56]
  --grthresh FLOAT                minimum prevalence to calculate relative
                                  growth rate for  [default: 0.001]
  --lineageyml TEXT               lineage hierarchy file  [default: ""]
  --pathogen [SARS-CoV-2|MPX|H5Nx|H5Nx-cattle|H1N1|FLU-B-VIC|H3N2|MEASLESgenome|RSVa|RSVb|DENV1|DENV2|DENV3|DENV4|MTB]
                                  Pathogen of interest.Not used if using
                                  --lineageyml option.  [default: SARS-CoV-2]
  --help                          Show this message and exit.
```


## freyja_update

### Tool Description
Update to the most recent barcodes and curated lineage data

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja update [OPTIONS]

  Update to the most recent barcodes and curated lineage data

Options:
  --outdir TEXT                   Output directory to save updated files.if
                                  this option is used, the barcodes are
                                  onlydownloaded to the directory specified.
                                  [default: ""]
  --noncl                         only include lineages that are confirmed by
                                  cov-lineages  [default: True]
  --buildlocal                    Perform barcode building locally(only
                                  available for SARS-CoV-2)
  --pathogen [SARS-CoV-2|MPX|H5Nx|H5Nx-cattle|H1N1|FLU-B-VIC|H3N2|MEASLESgenome|RSVa|RSVb|DENV1|DENV2|DENV3|DENV4|MTB]
                                  Pathogen to provide update for  [default:
                                  SARS-CoV-2]
  --help                          Show this message and exit.
```


## freyja_variants

### Tool Description
Perform variant calling using samtools and iVar on a BAMFILE

### Metadata
- **Docker Image**: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Freyja
- **Package**: https://anaconda.org/channels/bioconda/packages/freyja/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: freyja variants [OPTIONS] BAMFILE

  Perform variant calling using samtools and iVar on a BAMFILE

Options:
  --ref PATH         Reference file in fasta format  [default:
                     data/NC_045512_Hu-1.fasta]
  --variants PATH    Variant calling output file
  --depths PATH      Sequencing depth output file
  --refname TEXT     Ref name (for bams with multiple sequences)  [default:
                     ""]
  --minq INTEGER     Minimum base quality score  [default: 20]
  --annot TEXT       provide an annotation file in gff3 format  [default: ""]
  --varthresh FLOAT  Variant frequency threshold  [default: 0.0]
  --help             Show this message and exit.
```


## Metadata
- **Skill**: generated
