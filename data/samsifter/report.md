# samsifter CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| samsifter | Not completed | graphical program (needs a display), cannot run in a container test |
| samsifter_compile_stats | PASS | synthetic data: two copies of a count_taxon_reads table; the compiled table has one column per step. |
| samsifter_count_taxon_reads | PASS | synthetic data: MALT-style SAM made from 10 real reads; counts per taxon are 1280=7 and 562=3. |
| samsifter_filter_read_conservation | PASS | synthetic data: reads hitting two taxa are kept with --max_taxa 1 and the others discarded; the tool's -i option crashes, so the SAM is read from stdin. |
| samsifter_filter_read_list | PASS | synthetic data: MALT-style SAM made from 10 real reads; keeping two listed reads gives exactly those two. |
| samsifter_filter_ref_coverage | PASS | synthetic data: MALT-style SAM made from 10 real reads; read counts and mean coverage in the statistics file are correct; the tool's -i option crashes, so the SAM is read from stdin. |
| samsifter_filter_ref_identity | PASS | synthetic data: MALT-style SAM made from 10 real reads; reference filtering by percent identity works; the tool's -i option crashes, so the SAM is read from stdin. |
| samsifter_filter_ref_list | PASS | synthetic data: MALT-style SAM made from 10 real reads; keeping accession NC_000002.1 gives its 3 reads. |
| samsifter_filter_ref_pmds | PASS | synthetic data: MALT-style SAM with planted PMD scores; the filter keeps exactly the references over the threshold; the tool's -i option crashes, so the SAM is read from stdin. |
| samsifter_filter_taxon_list | PASS | synthetic data: MALT-style SAM made from 10 real reads; keeping taxon 1280 gives its 7 reads. |
| samsifter_filter_taxon_pmds | PASS | synthetic data: MALT-style SAM with planted PMD scores; the filter keeps exactly the taxon over the threshold; the tool's -i option crashes, so the SAM is read from stdin. |
| samsifter_pmdtools_mod | Not completed | Ran on 10 real reads and printed PMD scores, but no reference values exist to check them. |
| samsifter_summarize_stats | PASS | synthetic data: two copies of a compiled table; the summary has one column per sample file. |

## samsifter

### Tool Description
SamSifter helps you create filter workflows for next-generation sequencing data (graphical program)

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python3.5/site-packages/matplotlib/font_manager.py:279: UserWarning: Matplotlib is building the font cache using fc-list. This may take a moment.
  warnings.warn('Matplotlib is building the font cache using fc-list. This may take a moment.')
/usr/local/lib/python3.5/site-packages/matplotlib/font_manager.py:279: UserWarning: Matplotlib is building the font cache using fc-list. This may take a moment.
  warnings.warn('Matplotlib is building the font cache using fc-list. This may take a moment.')
usage: samsifter [-h] [-v] [-d]
samsifter: error: argument -h/--help: ignored explicit argument 'elp'
```


## samsifter_compile_stats

### Tool Description
compile statistics from temporary files

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compile_stats [-h] [-v] [-d] [-r] [-p PREFIX]

compile statistics from temporary files

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         print additional information to STDERR
  -d, --debug           print debug messages to STDERR
  -r, --remove          remove temporary statistics files after use
  -p PREFIX, --prefix PREFIX
                        prefix of temporary statistics files
```

## samsifter_count_taxon_reads

### Tool Description
Counts reads per taxon ID and stores them in a separate statistics file.

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: count_taxon_reads [-h] [-i INPUT] [-p PREFIX] [-v] [-d]

Counts reads per taxon ID and stores them in a separate statistics file.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  -p PREFIX, --prefix PREFIX
                        prefix of temporary statistics files
  -v, --verbose         print additional information to STDERR
  -d, --debug           print debug messages to STDERR
```

## samsifter_filter_read_conservation

### Tool Description
Filters reads assigned to multiple taxa with similar identity. Excludes reads

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_read_conservation [-h] [-i INPUT] [--discard DISCARD] [-v] [-d]
                                [-m] [--as_dev AS_DEV] [--max_taxa MAX_TAXA]

Filters reads assigned to multiple taxa with similar identity. Excludes reads
mapping to different accessions/taxa with similar alignment scores.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  --discard DISCARD     keep or discard entries passing the filter criteria?
  -v, --verbose         print additional information to stderr
  -d, --debug           print debug messages to stderr
  -m, --modify          modify header by adding PG record
  --as_dev AS_DEV       permitted deviation from max alignment score [5]
  --max_taxa MAX_TAXA   maximum number of taxa [10]
```

## samsifter_filter_read_list

### Tool Description
Filtering reads by a list of QNAMES (read identifiers) given in a tab-

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_read_list [-h] [-i INPUT] -l LIST [--discard DISCARD] [-v] [-d]

Filtering reads by a list of QNAMES (read identifiers) given in a tab-
separated CSV file.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  -l LIST, --list LIST  tab-separated CSV file with accession numbers in first
                        column
  --discard DISCARD     keep or discard entries passing the filter criteria?
  -v, --verbose         print additional information to STDERR
  -d, --debug           print debug messages to STDERR
```

## samsifter_filter_ref_coverage

### Tool Description
Filters reference accessions exceeding a Gini Index threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_ref_coverage [-h] [-i INPUT] [--discard DISCARD] [-v] [-d] [-m]
                           [-r] [-c] [-p] [-l LCI_ARG] [-s STATS_FILE]
                           [--min_cov MIN_COV | --max_cov MAX_COV | --min_lci MIN_LCI | --max_lci MAX_LCI | --min_gini MIN_GINI | --max_gini MAX_GINI]

Filters reference accessions exceeding a Gini Index threshold.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  --discard DISCARD     keep or discard entries passing the filter criteria?
  -v, --verbose         print additional information to stderr
  -d, --debug           print debug messages to stderr
  -m, --modify          modify header by adding PG record
  -r, --read_lengths    analyze read length distributions
  -c, --covered         covered bases only, ignore uncovered bases
  -p, --plot            plot distribution(s)
  -l LCI_ARG, --lci_arg LCI_ARG
                        fraction of mean coverage to use for LCI integration
  -s STATS_FILE, --stats_file STATS_FILE
                        override filename for tab-separated statistics
  --min_cov MIN_COV     minimum average coverage
  --max_cov MAX_COV     maximum average coverage
  --min_lci MIN_LCI     minimum LCI
  --max_lci MAX_LCI     maximum LCI
  --min_gini MIN_GINI   minimum Gini coefficient
  --max_gini MAX_GINI   maximum Gini coefficient
```

## samsifter_filter_ref_identity

### Tool Description
Filters reference accessions with too few/many reads of high/low percent

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_ref_identity [-h] [-i INPUT] [--min_reads MIN_READS]
                           [--max_reads MAX_READS]
                           [--min_identity MIN_IDENTITY]
                           [--max_identity MAX_IDENTITY] [--no_deamination]
                           [--no_indels] [--no_unknown] [--discard DISCARD]
                           [-v] [-d] [-m]

Filters reference accessions with too few/many reads of high/low percent
identity in MALT'ed SAM files

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  --discard DISCARD     keep or discard entries passing the filter criteria?
  -v, --verbose         print additional information to stderr
  -d, --debug           print debug messages to stderr
  -m, --modify          modify header by adding PG record

filtering thresholds:
  modify cutoffs for percent identity filtering

  --min_reads MIN_READS
                        minimum percentage of reads with insufficient identity
                        [50.0]
  --max_reads MAX_READS
                        maximum percentage of reads with insufficient identity
                        [100.0]
  --min_identity MIN_IDENTITY
                        minimum percent identity [90.0]
  --max_identity MAX_IDENTITY
                        maximum percent identity [100.0]

percent identity:
  Options to modify calculation of percent identity. Setting all three
  options will calculate values similar to PMDtools, while the default
  settings calculate values similar to MALT.

  --no_deamination      do not treat possibly deaminated T>C and A>G pairs as
                        mismatches in calculation of percent identity
  --no_indels           do not treat insertions and deletions in alignment as
                        mismatches in calculation of percent identity
  --no_unknown          do not treat Ns in alignment as mismatch in
                        calculation of percent identity
```

## samsifter_filter_ref_list

### Tool Description
Filtering references by a list of accession numbers given in a tab-separated

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_ref_list [-h] [-i INPUT] -l LIST [--discard DISCARD] [-v] [-d]

Filtering references by a list of accession numbers given in a tab-separated
CSV file

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  -l LIST, --list LIST  tab-separated CSV file with accession numbers in first
                        column
  --discard DISCARD     keep or discard entries passing the filter criteria?
  -v, --verbose         print additional information to STDERR
  -d, --debug           print debug messages to STDERR
```

## samsifter_filter_ref_pmds

### Tool Description
Filter taxa with high attribution of ancient reads in a MALT'ed and PMD'ed SAM

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_ref_pmds [-h] [-i INPUT] [--discard DISCARD] [-v] [-d] [-m] -p
                       PMDS (-rp READS_PERC | -rt READS_TOTAL)

Filter taxa with high attribution of ancient reads in a MALT'ed and PMD'ed SAM
file

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  --discard DISCARD     keep or discard entries passing the filter criteria?
  -v, --verbose         print additional information to stderr
  -d, --debug           print debug messages to stderr
  -m, --modify          modify header by adding PG record
  -p PMDS, --pmds PMDS  post-mortem degradation score (PMDS) threshold
  -rp READS_PERC, --reads_perc READS_PERC
                        attributed read threshold (percent)
  -rt READS_TOTAL, --reads_total READS_TOTAL
                        attributed read threshold (total)
```

## samsifter_filter_taxon_list

### Tool Description
filtering references by a list of NCBI taxon IDs given in a tab-separated CSV

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_taxon_list [-h] [-i INPUT] -l LIST [--discard DISCARD]

filtering references by a list of NCBI taxon IDs given in a tab-separated CSV
file

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  -l LIST, --list LIST  tab-separated CSV file with accession numbers in first
                        column
  --discard DISCARD     keep or discard entries passing the filter criteria?
```

## samsifter_filter_taxon_pmds

### Tool Description
Filter taxa with high attribution of ancient reads in a MALT'ed and PMD'ed SAM

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_taxon_pmds [-h] [-i INPUT] [--discard DISCARD] [-v] [-d] [-m] -p
                         PMDS (-rp READS_PERC | -rt READS_TOTAL)

Filter taxa with high attribution of ancient reads in a MALT'ed and PMD'ed SAM
file

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify SAM file to be analysed (default: STDIN)
  --discard DISCARD     keep or discard entries passing the filter criteria?
  -v, --verbose         print additional information to stderr
  -d, --debug           print debug messages to stderr
  -m, --modify          modify header by adding PG record
  -p PMDS, --pmds PMDS  post-mortem degradation score (PMDS) threshold
  -rp READS_PERC, --reads_perc READS_PERC
                        attributed read threshold (percent)
  -rt READS_TOTAL, --reads_total READS_TOTAL
                        attributed read threshold (total)
```

## samsifter_pmdtools_mod

### Tool Description
Estimate post-mortem degradation (PMD) scores of reads in SAM files with MD tags

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: python pmdtools_mod <SAM formatted data with MD field present from stdin> [options]

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --PMDSprim            PMDSprim
  --PMDSprimthreshold PMDSPRIMTHRESHOLD
                        PMDSprimthreshold
  --first               outputs the deamination rate at the first position
                        only, but with a standard error
  --range RANGE         output deamination patterns for this many positions
                        from the sequence terminus (default=30)
  --noclips             no clips
  --noindels            no indels
  --onlyclips           only clips
  --onlydeletions       only deletions
  --onlyinsertions      only insertions
  --nodeletions         no deletions
  --noinsertions        no insertions
  --notreverse          no reverse complement alignments
  -a, --adjustbaseq     apply PMD-aware adjustment of base quality scores
                        specific to C>T and G>A mismatches to the reference
  --adjustbaseq_all     apply PMD-aware adjustment of base quality scores
                        regardless of observed bases
  --samtoolspath SAMTOOLSPATH
                        full path to samtools
  --basecomposition     basecomposition
  -r REFSEQ, --refseq REFSEQ
                        refseq
  --estimate            two-terminus estimate of contamination
  --estimatebase ESTIMATEBASE
                        position of base used fortwo-terminus estimate of
                        contamination
  -b BASIC, --basic BASIC
                        only output reads with a C>T mismatch this many
                        basepairs from the 5' end

PMD parameters:
  influence the geometric distribution used for PMD score calculation by
  changing these parameters

  --PMDpparam PMDPPARAM
                        parameter p in geometric probability distribution of
                        PMD
  --PMDconstant PMDCONSTANT
                        constant C in geometric probability distribution of
                        PMD
  --polymorphism_ancient POLYMORPHISM_ANCIENT
                        True biological polymorphism between the ancient
                        individual and the reference sequence
  --polymorphism_contamination POLYMORPHISM_CONTAMINATION
                        True biological polymorphism between the contaminants
                        and the reference sequence

filters:
  restrict analysis to a subset of reads by setting these thresholds

  --dry                 print SAM input without any filters
  -n MAXREADS, --number MAXREADS
                        stop after these many reads have been processed
  -c CHROMOSOME, --chromosome CHROMOSOME
                        only process data from this chromosome
  --perc_identity PERC_IDENTITY
                        only output sequences with percent identity above this
                        threshold
  -m MAPQ, --requiremapq MAPQ
                        only process sequences with mapping quality at least
                        this great
  --readlength READLENGTH
                        only process sequences with this read length
  --maxlength MAXLENGTH
                        only process sequences with max this read length
  --minlength MINLENGTH
                        only process sequences with min this read length
  --maxGC MAXGC         only process sequences with max this GC content of the
                        aligning reference sequence
  --minGC MINGC         only process sequences with min this GC content of the
                        aligning reference sequence
  -q BASEQ, --requirebaseq BASEQ
                        only process bases with base quality at least this
                        great
  -t THRESHOLD, --threshold THRESHOLD
                        only output sequences with PMD score above this
                        threshold
  --upperthreshold UPPERTHRESHOLD
                        only output sequences with PMD score below this
                        threshold

CpG context:
  options controlling the handling of deamination in CpG contexts

  --CpG, --UDGplus      only use Cs and Gs in CpG context
  --noCpG               dont use Cs and Gs in CpG context
  --UDGhalf             only use Cs and Gs in CpG context, the first and last
                        base are used regardless of dinucleotide context
  --UDGminus            use all bases (placeholder)

output:
  control type and detail of output

  --verbose             verbose
  --header              output the SAM header
  --writesamfield       add 'DS:Z:<PMDS>' field to SAM output, will overwrite
                        if already present
  --stats               output summarizing statistics to stderr
  --debug               show additional information for debugging
  -p, --printDS         print PMD scores
  --printalignments     print human readable alignments
  --platypus            output big list of base frequencies for platypus
  -d, --deamination     output base frequencies in the read at positions where
                        there are C or G in the reference

percent identity:
  options to modify calculation of percent identity

  --include_deamination
                        treat possibly deaminated T>C and A>G pairs as
                        mismatches in calculation of percent identity
  --include_indels      treat insertions and deletions as mismatches in
                        calculation of percent identity
  --include_unknown     treat Ns in either read or reference as mismatch in
                        calculation of percent identity
```

## samsifter_summarize_stats

### Tool Description
compile statistics from temporary files

### Metadata
- **Docker Image**: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
- **Homepage**: https://github.com/BioInf-Wuerzburg/SamSifter
- **Package**: https://anaconda.org/channels/bioconda/packages/samsifter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: summarize_stats [-h] [-v] [-d] [-p PREFIX]

compile statistics from temporary files

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         print additional information to STDERR
  -d, --debug           print debug messages to STDERR
  -p PREFIX, --prefix PREFIX
                        prefix of temporary statistics files
```

## Metadata
- **Skill**: generated
