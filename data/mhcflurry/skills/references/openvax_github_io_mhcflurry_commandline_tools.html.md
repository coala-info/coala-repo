[MHCflurry](index.html)

2.0.0

* [Introduction and setup](intro.html)
* [Command-line tutorial](commandline_tutorial.html)
* [Python library tutorial](python_tutorial.html)
* Command-line reference
  + [mhcflurry-predict](#mhcflurry-predict)
  + [mhcflurry-predict-scan](#mhcflurry-predict-scan)
  + [mhcflurry-downloads](#mhcflurry-downloads)
    - [mhcflurry-downloads fetch](#mhcflurry-downloads-fetch)
    - [mhcflurry-downloads info](#mhcflurry-downloads-info)
    - [mhcflurry-downloads path](#mhcflurry-downloads-path)
    - [mhcflurry-downloads url](#mhcflurry-downloads-url)
  + [mhcflurry-class1-train-allele-specific-models](#mhcflurry-class1-train-allele-specific-models)
  + [mhcflurry-class1-select-allele-specific-models](#mhcflurry-class1-select-allele-specific-models)
  + [mhcflurry-class1-train-pan-allele-models](#mhcflurry-class1-train-pan-allele-models)
  + [mhcflurry-class1-select-pan-allele-models](#mhcflurry-class1-select-pan-allele-models)
  + [mhcflurry-class1-train-processing-models](#mhcflurry-class1-train-processing-models)
  + [mhcflurry-class1-select-processing-models](#mhcflurry-class1-select-processing-models)
  + [mhcflurry-class1-train-presentation-models](#mhcflurry-class1-train-presentation-models)
* [API Documentation](api.html)

[MHCflurry](index.html)

* »
* Command-line reference
* [View page source](_sources/commandline_tools.rst.txt)

---

# Command-line reference[¶](#command-line-reference "Permalink to this headline")

See also the [tutorial](commandline_tutorial.html#commandline-tutorial).

## mhcflurry-predict[¶](#mhcflurry-predict "Permalink to this headline")

Run MHCflurry predictor on specified peptides.

By default, the presentation predictor is used, and predictions for
MHC I binding affinity, antigen processing, and the composite presentation score
are returned. If you just want binding affinity predictions, pass
–affinity-only.

Examples:

Write a CSV file containing the contents of INPUT.csv plus additional columns
giving MHCflurry predictions:

$ mhcflurry-predict INPUT.csv –out RESULT.csv

The input CSV file is expected to contain columns “allele”, “peptide”, and,
optionally, “n\_flank”, and “c\_flank”.

If `--out` is not specified, results are written to stdout.

You can also run on alleles and peptides specified on the commandline, in
which case predictions are written for *all combinations* of alleles and
peptides:

$ mhcflurry-predict –alleles HLA-A0201 H-2Kb –peptides SIINFEKL DENDREKLLL

Instead of individual alleles (in a CSV or on the command line), you can also
give a comma separated list of alleles giving a sample genotype. In this case,
the tightest binding affinity across the alleles for the sample will be
returned. For example:

$ mhcflurry-predict –peptides SIINFEKL DENDREKLLL –alleles HLA-A\*02:01,HLA-A\*03:01,HLA-B\*57:01,HLA-B\*45:01,HLA-C\*02:01,HLA-C\*07:02 HLA-A\*01:01,HLA-A\*02:06,HLA-B\*44:02,HLA-B\*07:02,HLA-C\*01:01,HLA-C\*03:01

will give the tightest predicted affinities across alleles for each of the two
genotypes specified for each peptide.

```
usage: mhcflurry-predict [-h] [--list-supported-alleles] [--list-supported-peptide-lengths] [--version] [--alleles ALLELE [ALLELE ...]]
                         [--peptides PEPTIDE [PEPTIDE ...]] [--allele-column NAME] [--peptide-column NAME] [--n-flank-column NAME] [--c-flank-column NAME]
                         [--no-throw] [--out OUTPUT.csv] [--prediction-column-prefix NAME] [--output-delimiter CHAR] [--no-affinity-percentile]
                         [--always-include-best-allele] [--models DIR] [--affinity-only] [--no-flanking]
                         [INPUT.csv]
```

`input``.csv`[¶](#cmdoption-mhcflurry-predict-arg-input "Permalink to this definition")
:   Input CSV

`-h``,` `--help`[¶](#cmdoption-mhcflurry-predict-h "Permalink to this definition")
:   Show this help message and exit

`--list-supported-alleles`[¶](#cmdoption-mhcflurry-predict-list-supported-alleles "Permalink to this definition")
:   Prints the list of supported alleles and exits

`--list-supported-peptide-lengths`[¶](#cmdoption-mhcflurry-predict-list-supported-peptide-lengths "Permalink to this definition")
:   Prints the list of supported peptide lengths and exits

`--version`[¶](#cmdoption-mhcflurry-predict-version "Permalink to this definition")
:   show program’s version number and exit

`--alleles` `<allele>`[¶](#cmdoption-mhcflurry-predict-alleles "Permalink to this definition")
:   Alleles to predict (exclusive with passing an input CSV)

`--peptides` `<peptide>`[¶](#cmdoption-mhcflurry-predict-peptides "Permalink to this definition")
:   Peptides to predict (exclusive with passing an input CSV)

`--allele-column` `<name>`[¶](#cmdoption-mhcflurry-predict-allele-column "Permalink to this definition")
:   Input column name for alleles. Default: ‘allele’

`--peptide-column` `<name>`[¶](#cmdoption-mhcflurry-predict-peptide-column "Permalink to this definition")
:   Input column name for peptides. Default: ‘peptide’

`--n-flank-column` `<name>`[¶](#cmdoption-mhcflurry-predict-n-flank-column "Permalink to this definition")
:   Column giving N-terminal flanking sequence. Default: ‘n\_flank’

`--c-flank-column` `<name>`[¶](#cmdoption-mhcflurry-predict-c-flank-column "Permalink to this definition")
:   Column giving C-terminal flanking sequence. Default: ‘c\_flank’

`--no-throw`[¶](#cmdoption-mhcflurry-predict-no-throw "Permalink to this definition")
:   Return NaNs for unsupported alleles or peptides instead of raising

`--out` `<output.csv>`[¶](#cmdoption-mhcflurry-predict-out "Permalink to this definition")
:   Output CSV

`--prediction-column-prefix` `<name>`[¶](#cmdoption-mhcflurry-predict-prediction-column-prefix "Permalink to this definition")
:   Prefix for output column names. Default: ‘[mhcflurry\_](#id11)’

`--output-delimiter` `<char>`[¶](#cmdoption-mhcflurry-predict-output-delimiter "Permalink to this definition")
:   Delimiter character for results. Default: ‘,’

`--no-affinity-percentile`[¶](#cmdoption-mhcflurry-predict-no-affinity-percentile "Permalink to this definition")
:   Do not include affinity percentile rank

`--always-include-best-allele`[¶](#cmdoption-mhcflurry-predict-always-include-best-allele "Permalink to this definition")
:   Always include the best\_allele column even when it is identical to the allele column (i.e. all queries are monoallelic).

`--models` `<dir>`[¶](#cmdoption-mhcflurry-predict-models "Permalink to this definition")
:   Directory containing models. Either a binding affinity predictor or a presentation predictor can be used. Default: /Users/tim/Library/Application Support/mhcflurry/4/2.0.0/models\_class1\_presentation/models

`--affinity-only`[¶](#cmdoption-mhcflurry-predict-affinity-only "Permalink to this definition")
:   Affinity prediction only (no antigen processing or presentation)

`--no-flanking`[¶](#cmdoption-mhcflurry-predict-no-flanking "Permalink to this definition")
:   Do not use flanking sequence information even when available

## mhcflurry-predict-scan[¶](#mhcflurry-predict-scan "Permalink to this headline")

Scan protein sequences using the MHCflurry presentation predictor.

By default, sub-sequences (peptides) with affinity percentile ranks less than
2.0 are returned. You can also specify –results-all to return predictions for
all peptides, or –results-best to return the top peptide for each sequence.

Examples:

Scan a set of sequences in a FASTA file for binders to any alleles in a MHC I
genotype:

$ mhcflurry-predict-scan test/data/example.fasta –alleles HLA-A\*02:01,HLA-A\*03:01,HLA-B\*57:01,HLA-B\*45:01,HLA-C\*02:01,HLA-C\*07:02

Instead of a FASTA, you can also pass a CSV that has “sequence\_id” and “sequence”
columns.

You can also specify multiple MHC I genotypes to scan as space-separated
arguments to the –alleles option:

$ mhcflurry-predict-scan test/data/example.fasta –alleles HLA-A\*02:01,HLA-A\*03:01,HLA-B\*57:01,HLA-B\*45:01,HLA-C\*02:02,HLA-C\*07:02 HLA-A\*01:01,HLA-A\*02:06,HLA-B\*44:02,HLA-B\*07:02,HLA-C\*01:02,HLA-C\*03:01

If `--out` is not specified, results are written to standard out.

You can also specify sequences on the commandline:

mhcflurry-predict-scan –sequences MGYINVFAFPFTIYSLLLCRMNSRNYIAQVDVVNFNLT –alleles HLA-A\*02:01,HLA-A\*03:01,HLA-B\*57:01,HLA-B\*45:01,HLA-C\*02:02,HLA-C\*07:02

```
usage: mhcflurry-predict-scan [-h] [--list-supported-alleles] [--list-supported-peptide-lengths] [--version] [--input-format {guess,csv,fasta}]
                              [--alleles ALLELE [ALLELE ...]] [--sequences SEQ [SEQ ...]] [--sequence-id-column NAME] [--sequence-column NAME] [--no-throw]
                              [--peptide-lengths L] [--results-all] [--results-best {presentation_score,processing_score,affinity,affinity_percentile}]
                              [--results-filtered {presentation_score,processing_score,affinity,affinity_percentile}]
                              [--threshold-presentation-score THRESHOLD_PRESENTATION_SCORE] [--threshold-processing-score THRESHOLD_PROCESSING_SCORE]
                              [--threshold-affinity THRESHOLD_AFFINITY] [--threshold-affinity-percentile THRESHOLD_AFFINITY_PERCENTILE] [--out OUTPUT.csv]
                              [--output-delimiter CHAR] [--no-affinity-percentile] [--models DIR] [--no-flanking]
                              [INPUT]
```

`input`[¶](#cmdoption-mhcflurry-predict-scan-arg-input "Permalink to this definition")
:   Input CSV or FASTA

`-h``,` `--help`[¶](#cmdoption-mhcflurry-predict-scan-h "Permalink to this definition")
:   Show this help message and exit

`--list-supported-alleles`[¶](#cmdoption-mhcflurry-predict-scan-list-supported-alleles "Permalink to this definition")
:   Print the list of supported alleles and exits

`--list-supported-peptide-lengths`[¶](#cmdoption-mhcflurry-predict-scan-list-supported-peptide-lengths "Permalink to this definition")
:   Print the list of supported peptide lengths and exits

`--version`[¶](#cmdoption-mhcflurry-predict-scan-version "Permalink to this definition")
:   show program’s version number and exit

`--input-format` `{guess,csv,fasta}`[¶](#cmdoption-mhcflurry-predict-scan-input-format "Permalink to this definition")
:   Format of input file. By default, it is guessed from the file extension.

`--alleles` `<allele>`[¶](#cmdoption-mhcflurry-predict-scan-alleles "Permalink to this definition")
:   Alleles to predict

`--sequences` `<seq>`[¶](#cmdoption-mhcflurry-predict-scan-sequences "Permalink to this definition")
:   Sequences to predict (exclusive with passing an input file)

`--sequence-id-column` `<name>`[¶](#cmdoption-mhcflurry-predict-scan-sequence-id-column "Permalink to this definition")
:   Input CSV column name for sequence IDs. Default: ‘sequence\_id’

`--sequence-column` `<name>`[¶](#cmdoption-mhcflurry-predict-scan-sequence-column "Permalink to this definition")
:   Input CSV column name for sequences. Default: ‘sequence’

`--no-throw`[¶](#cmdoption-mhcflurry-predict-scan-no-throw "Permalink to this definition")
:   Return NaNs for unsupported alleles or peptides instead of raising

`--peptide-lengths` `<l>`[¶](#cmdoption-mhcflurry-predict-scan-peptide-lengths "Permalink to this definition")
:   Peptide lengths to consider. Pass as START-END (e.g. 8-11) or a comma-separated list (8,9,10,11). When using START-END, the range is INCLUSIVE on both ends. Default: 8-11.

`--results-all`[¶](#cmdoption-mhcflurry-predict-scan-results-all "Permalink to this definition")
:   Return results for all peptides regardless of affinity, etc.

`--results-best` `{presentation_score,processing_score,affinity,affinity_percentile}`[¶](#cmdoption-mhcflurry-predict-scan-results-best "Permalink to this definition")
:   Take the top result for each sequence according to the specified predicted quantity

`--results-filtered` `{presentation_score,processing_score,affinity,affinity_percentile}`[¶](#cmdoption-mhcflurry-predict-scan-results-filtered "Permalink to this definition")
:   Filter results by the specified quantity.

`--threshold-presentation-score` `<threshold_presentation_score>`[¶](#cmdoption-mhcflurry-predict-scan-threshold-presentation-score "Permalink to this definition")
:   Threshold if filtering by presentation score. Default: 0.7

`--threshold-processing-score` `<threshold_processing_score>`[¶](#cmdoption-mhcflurry-predict-scan-threshold-processing-score "Permalink to this definition")
:   Threshold if filtering by processing score. Default: 0.5

`--threshold-affinity` `<threshold_affinity>`[¶](#cmdoption-mhcflurry-predict-scan-threshold-affinity "Permalink to this definition")
:   Threshold if filtering by affinity. Default: 500

`--threshold-affinity-percentile` `<threshold_affinity_percentile>`[¶](#cmdoption-mhcflurry-predict-scan-threshold-affinity-percentile "Permalink to this definition")
:   Threshold if filtering by affinity percentile. Default: 2.0

`--out` `<output.csv>`[¶](#cmdoption-mhcflurry-predict-scan-out "Permalink to this definition")
:   Output CSV

`--output-delimiter` `<char>`[¶](#cmdoption-mhcflurry-predict-scan-output-delimiter "Permalink to this definition")
:   Delimiter character for results. Default: ‘,’

`--no-affinity-percentile`[¶](#cmdoption-mhcflurry-predict-scan-no-affinity-percentile "Permalink to this definition")
:   Do not include affinity percentile rank

`--models` `<dir>`[¶](#cmdoption-mhcflurry-predict-scan-models "Permalink to this definition")
:   Directory containing presentation models.Default: /Users/tim/Library/Application Support/mhcflurry/4/2.0.0/models\_class1\_presentation/models

`--no-flanking`[¶](#cmdoption-mhcflurry-predict-scan-no-flanking "Permalink to this definition")
:   Do not use flanking sequence information in predictions

## mhcflurry-downloads[¶](#mhcflurry-downloads "Permalink to this headline")

Download MHCflurry released datasets and trained models.

Examples

Fetch the default downloads:
:   $ mhcflurry-downloads fetch

Fetch a specific download:
:   $ mhcflurry-downloads fetch models\_class1\_pan

Get the path to a download:
:   $ mhcflurry-downloads path models\_class1\_pan

Get the URL of a download:
:   $ mhcflurry-downloads url models\_class1\_pan

Summarize available and fetched downloads:
:   $ mhcflurry-downloads info

```
usage: mhcflurry-downloads [-h] [--quiet] [--verbose] {fetch,info,path,url} ...
```

`-h``,` `--help`[¶](#cmdoption-mhcflurry-downloads-h "Permalink to this definition")
:   show this help message and exit

`--quiet`[¶](#cmdoption-mhcflurry-downloads-quiet "Permalink to this definition")
:   Output less

`--verbose``,` `-v`[¶](#cmdoption-mhcflurry-downloads-verbose "Permalink to this definition")
:   Output more

### mhcflurry-downloads fetch[¶](#mhcflurry-downloads-fetch "Permalink to this headline")

```
usage: mhcflurry-downloads fetch [-h] [--keep] [--release RELEASE] [--already-downloaded-dir DIR] [DOWNLOAD [DOWNLOAD ...]]
```

`download`[¶](#cmdoption-mhcflurry-downloads-fetch-arg-download "Permalink