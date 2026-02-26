# mhcflurry CWL Generation Report

## mhcflurry_mhcflurry-downloads

### Tool Description
Download MHCflurry released datasets and trained models.

### Metadata
- **Docker Image**: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
- **Homepage**: https://github.com/hammerlab/mhcflurry
- **Package**: https://anaconda.org/channels/bioconda/packages/mhcflurry/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mhcflurry/overview
- **Total Downloads**: 38.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hammerlab/mhcflurry
- **Stars**: N/A
### Original Help Text
```text
usage: mhcflurry-downloads [-h] [--quiet] [--verbose]
                           {fetch,info,path,url} ...

Download MHCflurry released datasets and trained models.

Examples

Fetch the default downloads:
    $ mhcflurry-downloads fetch

Fetch a specific download:
    $ mhcflurry-downloads fetch models_class1_pan

Get the path to a download:
    $ mhcflurry-downloads path models_class1_pan

Get the URL of a download:
    $ mhcflurry-downloads url models_class1_pan

Summarize available and fetched downloads:
    $ mhcflurry-downloads info

positional arguments:
  {fetch,info,path,url}

optional arguments:
  -h, --help            show this help message and exit
  --quiet               Output less
  --verbose, -v         Output more
```


## mhcflurry_mhcflurry-predict

### Tool Description
Run MHCflurry predictor on specified peptides.

### Metadata
- **Docker Image**: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
- **Homepage**: https://github.com/hammerlab/mhcflurry
- **Package**: https://anaconda.org/channels/bioconda/packages/mhcflurry/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhcflurry-predict [-h] [--list-supported-alleles]
                         [--list-supported-peptide-lengths] [--version]
                         [--alleles ALLELE [ALLELE ...]]
                         [--peptides PEPTIDE [PEPTIDE ...]]
                         [--allele-column NAME] [--peptide-column NAME]
                         [--n-flank-column NAME] [--c-flank-column NAME]
                         [--no-throw] [--out OUTPUT.csv]
                         [--prediction-column-prefix NAME]
                         [--output-delimiter CHAR] [--no-affinity-percentile]
                         [--always-include-best-allele] [--models DIR]
                         [--affinity-only] [--no-flanking]
                         [INPUT.csv]

Run MHCflurry predictor on specified peptides.

By default, the presentation predictor is used, and predictions for
MHC I binding affinity, antigen processing, and the composite presentation score
are returned. If you just want binding affinity predictions, pass
--affinity-only.

Examples:

Write a CSV file containing the contents of INPUT.csv plus additional columns
giving MHCflurry predictions:

$ mhcflurry-predict INPUT.csv --out RESULT.csv

The input CSV file is expected to contain columns "allele", "peptide", and,
optionally, "n_flank", and "c_flank".

If `--out` is not specified, results are written to stdout.

You can also run on alleles and peptides specified on the commandline, in
which case predictions are written for *all combinations* of alleles and
peptides:

$ mhcflurry-predict --alleles HLA-A0201 H-2Kb --peptides SIINFEKL DENDREKLLL

Instead of individual alleles (in a CSV or on the command line), you can also
give a comma separated list of alleles giving a sample genotype. In this case,
the tightest binding affinity across the alleles for the sample will be
returned. For example:

$ mhcflurry-predict --peptides SIINFEKL DENDREKLLL     --alleles         HLA-A*02:01,HLA-A*03:01,HLA-B*57:01,HLA-B*45:01,HLA-C*02:01,HLA-C*07:02         HLA-A*01:01,HLA-A*02:06,HLA-B*44:02,HLA-B*07:02,HLA-C*01:01,HLA-C*03:01

will give the tightest predicted affinities across alleles for each of the two
genotypes specified for each peptide.

Help:
  -h, --help            Show this help message and exit
  --list-supported-alleles
                        Prints the list of supported alleles and exits
  --list-supported-peptide-lengths
                        Prints the list of supported peptide lengths and exits
  --version             show program's version number and exit

Input (required):
  INPUT.csv             Input CSV
  --alleles ALLELE [ALLELE ...]
                        Alleles to predict (exclusive with passing an input
                        CSV)
  --peptides PEPTIDE [PEPTIDE ...]
                        Peptides to predict (exclusive with passing an input
                        CSV)

Input options:
  --allele-column NAME  Input column name for alleles. Default: 'allele'
  --peptide-column NAME
                        Input column name for peptides. Default: 'peptide'
  --n-flank-column NAME
                        Column giving N-terminal flanking sequence. Default:
                        'n_flank'
  --c-flank-column NAME
                        Column giving C-terminal flanking sequence. Default:
                        'c_flank'
  --no-throw            Return NaNs for unsupported alleles or peptides
                        instead of raising

Output options:
  --out OUTPUT.csv      Output CSV
  --prediction-column-prefix NAME
                        Prefix for output column names. Default: 'mhcflurry_'
  --output-delimiter CHAR
                        Delimiter character for results. Default: ','
  --no-affinity-percentile
                        Do not include affinity percentile rank
  --always-include-best-allele
                        Always include the best_allele column even when it is
                        identical to the allele column (i.e. all queries are
                        monoallelic).

Model options:
  --models DIR          Directory containing models. Either a binding affinity
                        predictor or a presentation predictor can be used.
                        Default: /root/.local/share/mhcflurry/4/2.2.0/models_c
                        lass1_presentation/models
  --affinity-only       Affinity prediction only (no antigen processing or
                        presentation)
  --no-flanking         Do not use flanking sequence information even when
                        available
```


## mhcflurry_mhcflurry-predict-scan

### Tool Description
Scan protein sequences using the MHCflurry presentation predictor.

### Metadata
- **Docker Image**: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
- **Homepage**: https://github.com/hammerlab/mhcflurry
- **Package**: https://anaconda.org/channels/bioconda/packages/mhcflurry/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhcflurry-predict-scan [-h] [--list-supported-alleles]
                              [--list-supported-peptide-lengths] [--version]
                              [--input-format {guess,csv,fasta}]
                              [--alleles ALLELE [ALLELE ...]]
                              [--sequences SEQ [SEQ ...]]
                              [--sequence-id-column NAME]
                              [--sequence-column NAME] [--no-throw]
                              [--peptide-lengths L] [--results-all]
                              [--threshold-presentation-score THRESHOLD_PRESENTATION_SCORE]
                              [--threshold-processing-score THRESHOLD_PROCESSING_SCORE]
                              [--threshold-affinity THRESHOLD_AFFINITY]
                              [--threshold-affinity-percentile THRESHOLD_AFFINITY_PERCENTILE]
                              [--out OUTPUT.csv] [--output-delimiter CHAR]
                              [--no-affinity-percentile] [--models DIR]
                              [--no-flanking]
                              [INPUT]

Scan protein sequences using the MHCflurry presentation predictor.

By default, sub-sequences (peptides) with affinity percentile ranks less than
2.0 are returned. You can also specify --results-all to return predictions for
all peptides, or adjust the filter threshold(s) using the --threshold-* options.

Examples:

Scan a set of sequences in a FASTA file for binders to any alleles in a MHC I
genotype:

$ mhcflurry-predict-scan     test/data/example.fasta     --alleles HLA-A*02:01,HLA-A*03:01,HLA-B*57:01,HLA-B*45:01,HLA-C*02:01,HLA-C*07:02

Instead of a FASTA, you can also pass a CSV that has "sequence_id" and "sequence"
columns.

You can also specify multiple MHC I genotypes to scan as space-separated
arguments to the --alleles option:

$ mhcflurry-predict-scan     test/data/example.fasta     --alleles         HLA-A*02:01,HLA-A*03:01,HLA-B*57:01,HLA-B*45:01,HLA-C*02:02,HLA-C*07:02         HLA-A*01:01,HLA-A*02:06,HLA-B*44:02,HLA-B*07:02,HLA-C*01:02,HLA-C*03:01

If `--out` is not specified, results are written to standard out.

You can also specify sequences on the commandline:

mhcflurry-predict-scan     --sequences MGYINVFAFPFTIYSLLLCRMNSRNYIAQVDVVNFNLT     --alleles HLA-A*02:01,HLA-A*03:01,HLA-B*57:01,HLA-B*45:01,HLA-C*02:02,HLA-C*07:02

Help:
  -h, --help            Show this help message and exit
  --list-supported-alleles
                        Print the list of supported alleles and exit
  --list-supported-peptide-lengths
                        Print the list of supported peptide lengths and exit
  --version             show program's version number and exit

Input options:
  INPUT                 Input CSV or FASTA
  --input-format {guess,csv,fasta}
                        Format of input file. By default, it is guessed from
                        the file extension.
  --alleles ALLELE [ALLELE ...]
                        Alleles to predict
  --sequences SEQ [SEQ ...]
                        Sequences to predict (exclusive with passing an input
                        file)
  --sequence-id-column NAME
                        Input CSV column name for sequence IDs. Default:
                        'sequence_id'
  --sequence-column NAME
                        Input CSV column name for sequences. Default:
                        'sequence'
  --no-throw            Return NaNs for unsupported alleles or peptides
                        instead of raising

Result options:
  --peptide-lengths L   Peptide lengths to consider. Pass as START-END (e.g.
                        8-11) or a comma-separated list (8,9,10,11). When
                        using START-END, the range is INCLUSIVE on both ends.
                        Default: 8-11.
  --results-all         Return results for all peptides regardless of
                        affinity, etc.
  --threshold-presentation-score THRESHOLD_PRESENTATION_SCORE
                        Threshold if filtering by presentation score. Default:
                        > 0.7
  --threshold-processing-score THRESHOLD_PROCESSING_SCORE
                        Threshold if filtering by processing score. Default: >
                        0.5
  --threshold-affinity THRESHOLD_AFFINITY
                        Threshold if filtering by affinity. Default: < 500
  --threshold-affinity-percentile THRESHOLD_AFFINITY_PERCENTILE
                        Threshold if filtering by affinity percentile.
                        Default: < 2.0

Output options:
  --out OUTPUT.csv      Output CSV
  --output-delimiter CHAR
                        Delimiter character for results. Default: ','
  --no-affinity-percentile
                        Do not include affinity percentile rank

Model options:
  --models DIR          Directory containing presentation models.Default: /roo
                        t/.local/share/mhcflurry/4/2.2.0/models_class1_present
                        ation/models
  --no-flanking         Do not use flanking sequence information in
                        predictions
```

