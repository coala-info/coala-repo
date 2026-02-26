# rnachipintegrator CWL Generation Report

## rnachipintegrator_RnaChipIntegrator

### Tool Description
Analyse GENES (any set of genes or genomic features) against PEAKS (a set of regions) and report nearest genes to each peak (and vice versa)

### Metadata
- **Docker Image**: quay.io/biocontainers/rnachipintegrator:3.0.0--pyh7cba7a3_0
- **Homepage**: https://github.com/fls-bioinformatics-core/RnaChipIntegrator
- **Package**: https://anaconda.org/channels/bioconda/packages/rnachipintegrator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnachipintegrator/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fls-bioinformatics-core/RnaChipIntegrator
- **Stars**: N/A
### Original Help Text
```text
usage: RnaChipIntegrator [options] [GENES PEAKS]

Analyse GENES (any set of genes or genomic features) against PEAKS (a set of
regions) and report nearest genes to each peak (and vice versa)

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

Analysis options:
  --cutoff MAX_DISTANCE
                        Maximum distance allowed between peaks and genes
                        before being omitted from the analyses (default
                        1000000bp; set to zero for no cutoff, use --cutoffs
                        instead to specify multiple distances)
  --edge {tss,tes,both}
                        Gene edges to consider when calculating distances
                        between genes and peaks, either: 'tss' (default: only
                        use gene TSS), 'tes' (only use gene TES), or 'both'
                        (use whichever of TSS or TES gives shortest distance)
  --only-DE             Only use genes flagged as differentially expressed in
                        analyses (input gene data must include DE flags)

Reporting options:
  --number MAX_CLOSEST  Filter results after applying --cutoff[s] to report
                        only the nearest MAX_CLOSEST number of pairs for each
                        gene/peak from the analyses (default is to report all
                        results)
  --promoter_region PROMOTER_REGION
                        Define promoter region with respect to gene TSS in the
                        form UPSTREAM,DOWNSTREAM (default -1000 to 100bp of
                        TSS)

Output options:
  --name NAME           Set basename for output files
  --compact             Output all hits for each peak or gene on a single line
                        (cannot be used with --summary)
  --summary             Output 'summary' for each analysis, consisting of only
                        the top hit for each peak or gene (cannot be used with
                        --compact)
  --pad                 Where less than MAX_CLOSEST hits are found, pad output
                        with blanks to ensure that MAX_CLOSEST hits are still
                        reported (nb --pad is implied for --compact)
  --xlsx                Output XLSX spreadsheet with results

Batch options:
  --cutoffs CUTOFFS     Comma-separated list of one or more maximum distances
                        allowed between peaks and genes (bp). An analysis will
                        be performed for each GENES-PEAKS pair at each cutoff
                        distance (default 1000000bp; set to zero for no cutoff
                        NB cannot be used in conjunction with the --cutoff
                        option)
  --genes GENES_FILE [GENES_FILE ...]
                        Specify multiple genes files (if used then peaks
                        file(s) must be specified using --peaks option)
  --peaks PEAKS_FILE [PEAKS_FILE ...]
                        Specify multiple peaks files (if used then genes
                        file(s) must be specified using --genes option)
  -n NPROCS, --nprocessors NPROCS
                        Number of processors/cores to run the program using
                        (default: 1)
  --split-outputs       In batch mode write results of each analysis to
                        separate file (default is to write all results to
                        single file)

Advanced options:
  --analyses {all,gene_centric,peak_centric}
                        Select which analyses to run: can be one of 'all'
                        (default, runs all available analyses), 'peak_centric'
                        or 'gene_centric'
  --feature FEATURE_TYPE
                        Rename 'gene' to FEATURE_TYPE in output (e.g.
                        'transcript' etc)
  --peak_cols PEAK_COLS
                        List of 3 column indices (e.g. '1,4,5') indicating
                        columns to use for chromosome, start and end from the
                        input peak file (if not first three columns)
  --peak_id PEAK_ID     Column to use as an ID for each peak from the input
                        peak file (first column is column 1). If specified
                        then IDs will be transferred to the output files when
                        peaks are reported
```

