# mirdeep2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mirdeep2_mapper.pl | PASS | fixed baseCommand to mapper.pl and real -s/-t flags, staged bowtie index; tutorial reads gave the same collapsed reads as the tutorial file and 481 genome mappings |
| mirdeep2_miRDeep2.pl | PASS | new CWL; tutorial C. elegans data gave top known score 61008 as in the tutorial and one novel miRNA |
| mirdeep2_quantifier.pl | PASS | fixed baseCommand to quantifier.pl and wrapped all options, collected outputs; tutorial data gave counts for 7 cel miRNAs (cel-miR-37 118131) |

## mirdeep2_miRDeep2.pl

### Tool Description
Run the miRDeep2 pipeline: identify known and novel miRNAs from deep sequencing reads mapped to a genome

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://github.com/rajewsky-lab/mirdeep2
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS

### Original Help Text
```text


#####################################
#                                   #
# miRDeep2.0.1.3                   #
#                                   #
# last change: 08/11/2019           #
#                                   #
#####################################

miRDeep2 started at 18:5:46


#Starting miRDeep2
/usr/local/bin/miRDeep2.pl -h

miRDeep2 started at 18:5:46


#Starting miRDeep2


miRDeep2.pl reads genome mappings miRNAs_ref/none miRNAs_other/none precursors/none [options] 2>report.log

This script enacts the miRDeep2 pipeline. The input files are:

reads         deep sequences in fasta format. The identifier should contain a prefix, a running
              number and a '_x' to indicate the number of reads that have this sequence.
              There should be no redundancy in the sequences.
genome        genome contigs in fasta format. The identifiers should be unique.
mappings      file_reads mapped against file_genome. The mappings should be in arf format.
              For details on the format see the documentation.
miRNAs_ref    miRBase miRNA sequences in fasta format. These should be the known mature
              sequences for the species being analyzed.
miRNAs_other  miRBase miRNA sequences in fasta format. These should be the pooled known
              mature sequences for 1-5 species closely related to the species being
              analyzed.

precursors    miRBase miRNA precursor sequences in fasta format. These should be the known precursor
              sequences for the species being analyzed.

Please note that [Options] can only be given AFTER the input files have been supplied.

The output files produced are:

result.html   a html table giving an overview of novel and known miRNAs detected in the
              data. The table is hyperlinked to pdfs showing the signature and structure of
              each hairpin.
result.csv    spread-sheet format of results.html
survey.csv    spread-sheet of prediction accuracy for all score-cutoffs between -10 and 10.
output.mrd    text output of the reported hairpins.

Options:

-a int        minimum read stack height that triggers analysis. Using this option disables
              automatic estimation of the optimal value and all detected precursors are analyzed

-g int        maximum number of precursors to analyze when automatic excision gearing is used.
              default=50.000, if set to -1 all precursors will be analyzed

-b int        minimum score cut-off for predicted novel miRNAs to be displayed in the overview
              table. This score cut-off is by default 0.

-c            disable randfold analysis

-d            disable pdf generation

-t species    species being analyzed - this is used to link to the appropriate UCSC browser entry

-u            output list of UCSC browser species that are supported and exit

-v            remove directory with temporary files

-o            do not sort aligned reads in pdf files by sample, only used if multiple samples were used as input (see Readme for mor information)

-s file       File with known miRBase star sequences

-z tag        Additional tag appended to current time stamp

-P            use this switch if mature_ref_miRNAs contain miRBase v18 identifiers (5p and 3p) instead of previous ids from v17

Example of use:

miRDeep2.pl reads.fa genome.fa reads_vs_genome.arf mautre_ref_miRNAs.fa mature_other_miRNAs.fa  hairpin_ref_miRNAs -t Mouse 2>report.log
```

## Metadata
- **Skill**: generated

## mirdeep2_mapper.pl

### Tool Description
Processes reads and/or maps them to the genome index.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1404980811: no space left on device
```

## mirdeep2_quantifier.pl

### Tool Description
The module maps the deep sequencing reads to predefined miRNA precursors and determines the counts for the respective mature miRNAs, star and loop sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
- **Homepage**: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep
- **Package**: https://anaconda.org/channels/bioconda/packages/mirdeep2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3878772788: no space left on device
```

