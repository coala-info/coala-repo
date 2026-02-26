# ratt CWL Generation Report

## ratt

### Tool Description
A tool for transferring annotations between biological sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/ratt:1.1.0--hdfd78af_0
- **Homepage**: http://ratt.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/ratt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ratt/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-05-24
- **GitHub**: https://github.com/ThomasDOtto/ratt
- **Stars**: N/A
### Original Help Text
```text
A required option was not passed.
Please use RATT with the following options:
  ratt {-p|--prefix} <Resultname> {-t|--type} <Transfer type> [{-r|--refseq} <reference (multi) Fasta>] <Directory with embl-files> <Query-fasta sequence>


  Directory name with
  embl-annotation files             - This directory contains all the embl files that should be transfered to the query.
  Query.fasta                       - A multifasta file to, which the annotation will be mapped.


  -p, --prefix ResultName           - The prefix you wish to give to each result file.
  -t, --type Transfer type          - Following parameters can be used (see below for the different used sets)
       (i)   Assembly:                  Transfer between different assemblies.
       (ii)  Assembly.Repetitive:       As before, but the genome is extremely repetitive.
                                        This should be run, only if the parameter Assembly
                                        doesn't return good results (misses too many annotation tags).
       (iii) Strain:                    Transfer between strains. Similarity is between 95-99%.
       (iv)  Strain.Repetitive:         As before, but the genome is extremely repetitive.
                                        This should be run, only if the parameter Strain doesn't
                                        return good results (misses too many annotation tags).
       (v)   Species:                   Transfer between species. Similarity is between 50-94%.
       (vi)  Species.Repetitive:        As before, but the genome is extremely repetitive.
                                        This should be run, only if the parameter Species
                                        doesn't return good results (misses too many annotation tags).
       (vii) Multiple:                  When many annotated strains are used as a reference, and you
                                        assume the newly sequenced genome has many insertions
                                        compared to the strains in the query (reference?). This parameter will
                                        use the best regions of each reference strain to transfer tags.
       (viii)Free:                      The user sets all parameters individually.

  -r, --refseq reference fasta      - Name of multi-fasta. VERY I M P O R T A N T The name of each
                                      sequence in the fasta description,
                                      MUST be the same name as its corresponding embl file. So if
                                      your embl file is call Tuberculosis.embl, in your reference.fasta file,
                                      the description has to be:
                                         >Tuberculosis
                                         ATTGCGTACG
                                         ...
```


## Metadata
- **Skill**: generated
