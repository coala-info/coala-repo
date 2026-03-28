# phyluce CWL Generation Report

## phyluce_phyluce_assembly_assemblo_spades

### Tool Description
Assemble raw reads using SPAdes

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Total Downloads**: 36.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/faircloth-lab/phyluce
- **Stars**: N/A
### Original Help Text
```text
usage: phyluce_assembly_assemblo_spades [-h] --output OUTPUT [--cores CORES]
                                        [--subfolder SUBFOLDER]
                                        [--verbosity {INFO,WARN,CRITICAL}]
                                        [--log-path LOG_PATH] [--do-not-clean]
                                        (--config CONFIG | --dir DIR)

Assemble raw reads using SPAdes

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT       The directory in which to store the assembly data
  --cores CORES         The number of compute cores/threads to run with SPAdes
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use
  --log-path LOG_PATH   The path to a directory to hold logs.
  --do-not-clean        Do not cleanup intermediate SPAdes files
  --config CONFIG       A configuration file containing reads to assemble
  --dir DIR             A directory of reads to assemble
```


## phyluce_phyluce_assembly_get_match_counts

### Tool Description
Given an SQL database of UCE loci and a taxon-set file, output those taxa and those loci in complete and incomplete data matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_get_match_counts [-h] --locus-db LOCUS_DB
                                         --taxon-list-config TAXON_LIST_CONFIG
                                         --taxon-group TAXON_GROUP --output
                                         OUTPUT [--incomplete-matrix]
                                         [--verbosity {INFO,WARN,CRITICAL}]
                                         [--log-path LOG_PATH] [--optimize]
                                         [--random] [--samples SAMPLES]
                                         [--sample-size SAMPLE_SIZE]
                                         [--extend-locus-db EXTEND_LOCUS_DB]
                                         [--silent] [--keep-counts]

Given an SQL database of UCE loci and a taxon-set file, output those taxa and
those loci in complete and incomplete data matrices.

optional arguments:
  -h, --help            show this help message and exit
  --locus-db LOCUS_DB   The SQL database file holding probe matches to
                        targeted loci (usually "lastz/probe.matches.sqlite".)
  --taxon-list-config TAXON_LIST_CONFIG
                        The config file containing lists of the taxa you want
                        to include in matrices.
  --taxon-group TAXON_GROUP
                        The [group] in the config file whose specific data
                        matrix you want to create.
  --output OUTPUT       The path to the output file you want to create.
  --incomplete-matrix   Generate an incomplete matrix of data.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --optimize            Return optimum groups of probes by enumeration
                        (default) or sampling.
  --random              Optimize by sampling.
  --samples SAMPLES     The number of samples to take.
  --sample-size SAMPLE_SIZE
                        The group size of samples.
  --extend-locus-db EXTEND_LOCUS_DB
                        An SQLlite database file holding probe matches to
                        other targeted loci
  --silent              Don't print probe names.
  --keep-counts
```


## phyluce_phyluce_assembly_get_fastas_from_match_counts

### Tool Description
Given an input SQL database of UCE locus matches, a config file containing the loci in your data matrix, and the contigs you have assembled, extract the fastas for each locus for each taxon in the assembled contigs, and rename those to the appropriate UCE loci, outputting the results as a single monolithic FASTA file containing all records. Can also incorporate data from genome-enabled taxa or other studies using the --extend-db and --extend- contigs parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_assembly_get_fastas_from_match_counts [-h] --contigs CONTIGS
                                                     --locus-db LOCUS_DB
                                                     --match-count-output
                                                     MATCH_COUNT_OUTPUT
                                                     [--incomplete-matrix INCOMPLETE_MATRIX]
                                                     --output OUTPUT
                                                     [--verbosity {INFO,WARN,CRITICAL}]
                                                     [--log-path LOG_PATH]
                                                     [--extend-locus-db EXTEND_LOCUS_DB]
                                                     [--extend-locus-contigs EXTEND_LOCUS_CONTIGS]

Given an input SQL database of UCE locus matches, a config file containing the
loci in your data matrix, and the contigs you have assembled, extract the
fastas for each locus for each taxon in the assembled contigs, and rename
those to the appropriate UCE loci, outputting the results as a single
monolithic FASTA file containing all records. Can also incorporate data from
genome-enabled taxa or other studies using the --extend-db and --extend-
contigs parameters.

optional arguments:
  -h, --help            show this help message and exit
  --contigs CONTIGS     The directory containing the assembled contigs in
                        which you searched for UCE loci. (default: None)
  --locus-db LOCUS_DB   The SQL database file holding probe matches to
                        targeted loci (usually "lastz/probe.matches.sqlite").
                        (default: None)
  --match-count-output MATCH_COUNT_OUTPUT
                        The output file containing taxa and loci in
                        complete/incomplete matrices generated by
                        get_match_counts.py. (default: None)
  --incomplete-matrix INCOMPLETE_MATRIX
                        The path to the outfile for incomplete-matrix records.
                        Required when processing an incomplete data matrix.
                        (default: False)
  --output OUTPUT       The path to the output FASTA file you want to create.
                        (default: None)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --extend-locus-db EXTEND_LOCUS_DB
                        An SQLlite database file holding probe matches to
                        other targeted loci. (default: None)
  --extend-locus-contigs EXTEND_LOCUS_CONTIGS
                        A directory holding the assembled contigs (from
                        genomes or another study) referenced by --extend-
                        locus-db. (default: None)
```


## phyluce_phyluce_align_seqcap_align

### Tool Description
Align and possibly trim records in a monolithic UCE FASTA file with MAFFT or MUSCLE

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_seqcap_align [-h] --fasta FASTA --output OUTPUT --taxa
                                  TAXA [--aligner {muscle,mafft}]
                                  [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                  [--verbosity {INFO,WARN,CRITICAL}]
                                  [--log-path LOG_PATH] [--incomplete-matrix]
                                  [--no-trim] [--window WINDOW]
                                  [--proportion PROPORTION]
                                  [--threshold THRESHOLD]
                                  [--max-divergence MAX_DIVERGENCE]
                                  [--min-length MIN_LENGTH] [--ambiguous]
                                  [--cores CORES]

Align and possibly trim records in a monolithic UCE FASTA file with MAFFT or
MUSCLE

optional arguments:
  -h, --help            show this help message and exit
  --fasta FASTA         The file containing FASTA reads associated with
                        targted loci from get_fastas_from_match_counts.py
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --taxa TAXA           Number of taxa expected in each alignment. (default:
                        None)
  --aligner {muscle,mafft}
                        The alignment engine to use. (default: mafft)
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format. (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --incomplete-matrix   Allow alignments that do not contain all --taxa.
                        (default: False)
  --no-trim             Align, but DO NOT trim alignments. (default: False)
  --window WINDOW       Sliding window size for trimming. (default: 20)
  --proportion PROPORTION
                        The proportion of taxa required to have sequence at
                        alignment ends. (default: 0.65)
  --threshold THRESHOLD
                        The proportion of residues required across the window
                        in proportion of taxa. (default: 0.65)
  --max-divergence MAX_DIVERGENCE
                        The max proportion of sequence divergence allowed
                        between any row of the alignment and the alignment
                        consensus. (default: 0.2)
  --min-length MIN_LENGTH
                        The minimum length of alignments to keep. (default:
                        100)
  --ambiguous           Allow reads in alignments containing N-bases.
                        (default: False)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```


## phyluce_phyluce_align_get_only_loci_with_min_taxa

### Tool Description
Screen a directory of alignments, only returning those containing >= --percent of taxa

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_only_loci_with_min_taxa [-h] --alignments ALIGNMENTS
                                                 --taxa TAXA --output OUTPUT
                                                 [--percent PERCENT]
                                                 [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                 [--verbosity {INFO,WARN,CRITICAL}]
                                                 [--log-path LOG_PATH]
                                                 [--cores CORES]

Screen a directory of alignments, only returning those containing >= --percent
of taxa

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to screen.
                        (default: None)
  --taxa TAXA           The total number of taxa in all alignments. (default:
                        None)
  --output OUTPUT       The output dir in which to store copies of the
                        alignments (default: None)
  --percent PERCENT     The percent of taxa to require (default: 0.75)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format. (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```


## phyluce_phyluce_align_get_trimmed_alignments_from_untrimmed

### Tool Description
Use the PHYLUCE trimming algorithm to trim existing alignments in parallel

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_trimmed_alignments_from_untrimmed [-h] --alignments
                                                           ALIGNMENTS --output
                                                           OUTPUT
                                                           [--input-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                           [--output-format {fasta,nexus,phylip,clustal,emboss,stockholm}]
                                                           [--verbosity {INFO,WARN,CRITICAL}]
                                                           [--log-path LOG_PATH]
                                                           [--window WINDOW]
                                                           [--proportion PROPORTION]
                                                           [--threshold THRESHOLD]
                                                           [--max_divergence MAX_DIVERGENCE]
                                                           [--min-length MIN_LENGTH]
                                                           [--cores CORES]

Use the PHYLUCE trimming algorithm to trim existing alignments in parallel

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be trimmed.
                        (default: None)
  --output OUTPUT       The directory in which to store the resulting
                        alignments. (default: None)
  --input-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The input alignment format. (default: fasta)
  --output-format {fasta,nexus,phylip,clustal,emboss,stockholm}
                        The output alignment format. (default: nexus)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --window WINDOW       Sliding window size for trimming. (default: 20)
  --proportion PROPORTION
                        The proportion of taxa required to have sequence at
                        alignment ends. (default: 0.65)
  --threshold THRESHOLD
                        The proportion of residues required across the window
                        in proportion of taxa. (default: 0.65)
  --max_divergence MAX_DIVERGENCE
                        The max proportion of sequence divergence allowed
                        between any row of the alignment and the alignment
                        consensus. (default: 0.2)
  --min-length MIN_LENGTH
                        The minimum length of alignments to keep. (default:
                        100)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
```


## phyluce_phyluce_align_get_align_summary_data

### Tool Description
Compute summary statistics for alignments in parallel

### Metadata
- **Docker Image**: quay.io/biocontainers/phyluce:1.6.8--py_0
- **Homepage**: https://github.com/faircloth-lab/phyluce
- **Package**: https://anaconda.org/channels/bioconda/packages/phyluce/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phyluce_align_get_align_summary_data [-h] --alignments ALIGNMENTS
                                            [--input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}]
                                            [--show-taxon-counts]
                                            [--verbosity {INFO,WARN,CRITICAL}]
                                            [--log-path LOG_PATH]
                                            [--cores CORES]
                                            [--output-stats OUTPUT]

Compute summary statistics for alignments in parallel

optional arguments:
  -h, --help            show this help message and exit
  --alignments ALIGNMENTS
                        The directory containing alignments to be summarized.
                        (default: None)
  --input-format {fasta,nexus,phylip,phylip-relaxed,clustal,emboss,stockholm}
                        The input alignment format. (default: nexus)
  --show-taxon-counts   Show the count of loci with X taxa. (default: False)
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use. (default: INFO)
  --log-path LOG_PATH   The path to a directory to hold logs. (default: None)
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
                        (default: 1)
  --output-stats OUTPUT
                        Output a CSV-formatted file of stats, by locus
                        (default: None)
```


## Metadata
- **Skill**: generated
