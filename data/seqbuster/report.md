# seqbuster CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seqbuster_miraligner | PASS | tool test data and bundled miRBase files; canonical let-7a-5p read annotated with no changes |

## seqbuster_miraligner

### Tool Description
miraligner is a tool for microRNA alignment and isomiR identification.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqbuster:3.5--0
- **Homepage**: https://github.com/lpantano/seqbuster
- **Package**: https://anaconda.org/channels/bioconda/packages/seqbuster/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: <main class> [options] 
  Options:
    -add
       nt allowed for addition processes
       Default: 3
    -db
       database
    -debug
       add verbosity
       Default: false
    -format
       format input
       Default: none
    -freq
       add freq information
       Default: true
    -help
       help
       Default: false
    -i
       input
    -minl
       minimum size
       Default: 16
    -o
       output
    -pre
       add reads mapping to precursor
       Default: false
    -s
       three letter code for species
    -sub
       nt allowed for substitution processes
       Default: 1
    -trim
       nt allowed for trimming processes
       Default: 3
    -v
       version
       Default: false


java -jar miraligner.jar -minl 16 -sub mismatches -trim trimming-nts -add addition-nts -s species -i read_seq_file -db miRBase_folder_files -o output_file

example:java -jar miraligner.jar -sub 1 -trim 3 -add 3 -s hsa -i test/test.fa -db DB -o test/out
example: see output at miraligner/test/output.mirna & miraligner/test/output.mirna.opt
```

