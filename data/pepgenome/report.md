# pepgenome CWL Generation Report

## pepgenome

### Tool Description
A tool for mapping peptide identifications to genomic coordinates using protein sequences and genome annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepgenome:1.1.beta--0
- **Homepage**: https://github.com/bigbio/pgatk/
- **Package**: https://anaconda.org/channels/bioconda/packages/pepgenome/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pepgenome/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bigbio/pgatk
- **Stars**: N/A
### Original Help Text
```text
[14-Feb-2026 10:24:00 - INFO] " *** Error in parsing the input arguments. Please check the arguments ***" (org.bigbio.pgatk.pepgenome.PepGenomeTool:124)
usage: Arguments: -fasta TRANSL -gtf ANNO -in *.tsv[,*.tsv] [-format OUTF]
                  [-merge TRUE/FALSE] [-source SRC] [-mm NUM] [-mmmode
                  TRUE/FALSE] [-species SPECIES] [-chr 0/1]
 -chr <arg>            Export chr prefix Allowed 0, 1  (default: 0)
 -fasta <arg>          Filepath for file containing protein sequences in
                       FASTA format
 -format <arg>         Select the output formats from gtf, gct, bed,
                       ptmbed, all or combinations thereof separated by
                       ',' (default all)
 -genome <arg>         Filepath for file containing genome sequence in
                       FASTA format used to extract chromosome names and
                       order and differenciate between assembly and
                       scaffolds. If not set chromosome and scaffold names
                       and order is extracted from GTF input.
 -gtf <arg>            Filepath for file containing genome annotation in
                       GTF format
 -h                    Print this help & exit
 -in <arg>             Comma(,) separated file paths for files containing
                       peptide identifications (Contents of the file can
                       tab separated format. i.e., File format: four
                       columns: SampleName
                       PeptideSequence
                       PSMs
                       Quant; or mzTab, and mzIdentML)
 -inf <arg>            Format of the input file (mztab, mzid, or tsv).
                       (default tsv)
 -inm <arg>            Compute the kmer algorithm in memory or using
                       database algorithm (default 0, database 1)
 -merge <arg>          Set 'true' to merge mappings from all files from
                       input (default 'false')
 -mm <arg>             Allowed mismatches (0, 1 or 2; default: 0)
 -mmmode <arg>         Mismatch mode (true or false): if true mismatching
                       with two mismatches will only allow 1 mismatch
                       every kmersize (default: 5) positions. (default:
                       false)
 -source <arg>         Please give a source name which will be used in the
                       second column in the output gtf file (default:
                       PoGo)
 -spark_master <arg>   Spark master String. i.e., to run locally use:
                       local[*]
```


## Metadata
- **Skill**: not generated
