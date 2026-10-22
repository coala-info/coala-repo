# suppa CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| suppa_clusterEvents | PASS |  |
| suppa_diffSplice | PASS |  |
| suppa_generateEvents | PASS |  |
| suppa_joinFiles | PASS |  |
| suppa_psiPerEvent | PASS |  |
| suppa_psiPerIsoform | PASS |  |

## suppa_generateEvents

### Tool Description
SUPPA generateEvents

### Metadata
- **Docker Image**: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
- **Homepage**: https://github.com/comprna/SUPPA
- **Package**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SUPPA generateEvents [-h] -i INPUT_FILE -o OUTPUT_FILE
                            [-e {SE,SS,MX,RI,FL} [{SE,SS,MX,RI,FL} ...]]
                            [-b {S,V}] [-t THRESHOLD] [-p] [-l EXON_LENGTH]
                            [-m MODE] -f {ioe,ioi}

options:
  -h, --help            show this help message and exit
  -i, --input-file INPUT_FILE
                        specify input file
  -o, --output-file OUTPUT_FILE
                        specify output path and name without extension
  -e, --event-type {SE,SS,MX,RI,FL} [{SE,SS,MX,RI,FL} ...]
                        list of events to analyze. (space separated) Options:
                        SE -- Skipping Exon SS -- Alternative Splice Site
                        (5'/3') MX -- Mutually Exclusive Exon RI -- Retained
                        Intron FL -- Alternative First/Last Exon
  -b, --boundary {S,V}  Boundary type.Options: S -- Strict (Default) V --
                        Variable
  -t, --threshold THRESHOLD
                        Variability treshold. In case of strict boundaries
                        this argument is ignored(Default: 10nt).
  -p, --pool-genes      pool together overlapping genes.
  -l, --exon-length EXON_LENGTH
                        length of the exons for its visualization. (Default:
                        100nt)
  -m, --mode MODE       to choose from DEBUG, INFO, WARNING, ERROR and
                        CRITICAL
  -f, --format {ioe,ioi}
                        Format of the annotation file. Required.
```

## suppa_psiPerEvent

### Tool Description
SUPPA psiPerEvent

### Metadata
- **Docker Image**: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
- **Homepage**: https://github.com/comprna/SUPPA
- **Package**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SUPPA psiPerEvent [-h] -i IOE_FILE -e EXPRESSION_FILE -o OUTPUT_FILE
                         [-f TOTAL_FILTER] [-s] [-m MODE]

options:
  -h, --help            show this help message and exit
  -i, --ioe-file IOE_FILE
                        Input file with the event-transcripts equivalence
                        (.ioe format).
  -e, --expression-file EXPRESSION_FILE
                        Input transcript expression file.
  -o, --output-file OUTPUT_FILE
                        Output psi file.
  -f, --total-filter TOTAL_FILTER
                        Minimum total expression of the transcripts involved
                        in the event.
  -s, --save_tpm_events
                        Boolean. If True, save the TPM of the events in an
                        external file (Default: False).
  -m, --mode MODE       to choose from DEBUG, INFO, WARNING, ERROR and
                        CRITICAL
```

## suppa_psiPerIsoform

### Tool Description
SUPPA psiPerIsoform

### Metadata
- **Docker Image**: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
- **Homepage**: https://github.com/comprna/SUPPA
- **Package**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SUPPA psiPerIsoform [-h] -g GTF_FILE -e EXPRESSION_FILE -o OUTPUT_FILE
                           [-m MODE]

options:
  -h, --help            show this help message and exit
  -g, --gtf-file GTF_FILE
                        Input gtf file
  -e, --expression-file EXPRESSION_FILE
                        Input expression file
  -o, --output-file OUTPUT_FILE
                        Path and name of the ouput file
  -m, --mode MODE       to choose from DEBUG, INFO, WARNING, ERROR and
                        CRITICAL
```

## suppa_diffSplice

### Tool Description
SUPPA diffSplice

### Metadata
- **Docker Image**: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
- **Homepage**: https://github.com/comprna/SUPPA
- **Package**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SUPPA diffSplice [-h] -m {empirical,classical} [-p CONDS [CONDS ...]]
                        [-e TPMS [TPMS ...]] [-i IOX] [-a AREA]
                        [-l LOWER_BOUND] [-pa] [-gc] [-al ALPHA] [-s] [-c]
                        [-me] [-th TPM_TH] [-nan NAN_TH] [-o OUTPUT]
                        [-mo MODE]

options:
  -h, --help            show this help message and exit
  -m, --method {empirical,classical}
                        Method to test significance. Required.
  -p, --psi CONDS [CONDS ...]
                        Path of the PSI files. PSI files and the transcript
                        expression (TPM) files must have the same order.The
                        conditions files and the tpm files must have the same
                        order.
  -e, --tpm TPMS [TPMS ...]
                        Path of the transcript expression (TPM) files.
                        Conditions files and the transcript expression (TPM)
                        files must have the same order.The conditions files
                        and the tpm files must have the same order.
  -i, --input IOX       Input file with the event-transcripts equivalence
                        (.ioe or .ioi format)
  -a, --area AREA       Number indicating the number of points in the local
                        area distribution. (default: 1000)
  -l, --lower-bound LOWER_BOUND
                        Lower-bound for the absolute delta PSI value to test
                        for significance. (Default: 0).
  -pa, --paired         Boolean. Indicates if replicates in conditions are
                        paired. (Default: False).
  -gc, --gene-correction
                        Boolean. If True, SUPPA correct the p-values by gene.
                        (Default: False).
  -al, --alpha ALPHA    Family-wise error rate to use for the multiple test
                        correction. (Default: 0.05).
  -s, --save_tpm_events
                        Boolean. If True, the average log TPM of the events
                        will be saved in an external file (Default: False).
  -c, --combination     Boolean. If True, SUPPA perform the analysis between
                        all the possible combinations of conditions (Default:
                        False).
  -me, --median         Boolean. If True, SUPPA use the median to calculate
                        the Delta PSI. (Default: False).
  -th, --tpm-threshold TPM_TH
                        Minimum transcript average TPM value within-replicates
                        and between-conditions to be included in the analysis.
                        (Default: 1.0).
  -nan, --nan-threshold NAN_TH
                        Proportion of allowed samples per condition with nan
                        values for returning a DeltaPSI (Default: 0, no
                        missing values allowed).
  -o, --output OUTPUT   Name of the output files.
  -mo, --mode MODE      to choose from DEBUG, INFO, WARNING, ERROR and
                        CRITICAL
```

## suppa_clusterEvents

### Tool Description
SUPPA clusterEvents

### Metadata
- **Docker Image**: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
- **Homepage**: https://github.com/comprna/SUPPA
- **Package**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SUPPA clusterEvents [-h] [-d DPSI] [-p PSIVEC] [-st SIG_THRESHOLD]
                           [-dt DPSI_THRESHOLD] [-e EPS] [-s SEPARATION]
                           [-n MINPTS] [-m {euclidean,manhattan,cosine}]
                           [-c {OPTICS,DBSCAN}] -g [INDEXES ...] [-o OUTPUT]

options:
  -h, --help            show this help message and exit
  -d, --dpsi DPSI       Input file of delta-PSI values (.dpsi format)
  -p, --psivec PSIVEC   Input file with PSI values (.psivec format)
  -st, --sig-threshold SIG_THRESHOLD
                        P-value cut-off for significant events. (Default:
                        0.05).
  -dt, --dpsi-threshold DPSI_THRESHOLD
                        Lower-bound for the absolute delta PSI value to
                        cluster. (Default: 0.05).
  -e, --eps EPS         Maximum (Euclidean) distance (between 0 and 1) to
                        consider two events as members of the same cluster.
                        (Default: 0.05).
  -s, --separation SEPARATION
                        Minimum separation for considering two points in
                        different clusters. (Default: 0).
  -n, --min-pts MINPTS  Minimum number of events required per cluster.
                        (Default: 20).
  -m, --metric {euclidean,manhattan,cosine}
                        Distance function to be used.Options: euclidean
                        (Default), manhattan, cosine.
  -c, --clustering {OPTICS,DBSCAN}
                        Clustering method to use.Options: OPTICS , DBSCAN
                        (Default).
  -g, --groups [INDEXES ...]
                        Ranges of column numbers specifying the replicates per
                        condition. Column numbers have to be continuous, with
                        no overlapping or missing columns between them. Ex:
                        1-3,4-6
  -o, --output OUTPUT   Name of the output file.
```

## suppa_joinFiles

### Tool Description
SUPPA joinFiles

### Metadata
- **Docker Image**: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
- **Homepage**: https://github.com/comprna/SUPPA
- **Package**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SUPPA joinFiles [-h] [-i INPUT [INPUT ...]] -f {psi,tpm} [-o OUTPUT]

options:
  -h, --help            show this help message and exit
  -i, --input-files INPUT [INPUT ...]
                        Space separated list of the files to be joined. If the
                        absolute path is not indicate the program use the
                        current working directory instead.
  -f, --file-extension {psi,tpm}
                        Extension of the output file. Required.
  -o, --output OUTPUT   Name of the output file.
```

