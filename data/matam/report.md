# matam CWL Generation Report

## matam_index_default_ssu_rrna_db.py

### Tool Description
Index default SSU rRNA DB

### Metadata
- **Docker Image**: quay.io/biocontainers/matam:1.6.2--haf24da9_0
- **Homepage**: https://github.com/bonsai-team/matam
- **Package**: https://anaconda.org/channels/bioconda/packages/matam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/matam/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-08-16
- **GitHub**: https://github.com/bonsai-team/matam
- **Stars**: N/A
### Original Help Text
```text
usage: index_default_ssu_rrna_db.py [-h] [-d DBDIRPATH] [-m MAXMEM]

Index default SSU rRNA DB

options:
  -h, --help            show this help message and exit
  -d, --ref_dir DBDIRPATH
                        Output dir. Default is $MATAM_DIR/db/
  -m, --max_memory MAXMEM
                        Maximum memory to use (in MBi). Default is 10000 MBi
```


## matam_matam_db_preprocessing.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/matam:1.6.2--haf24da9_0
- **Homepage**: https://github.com/bonsai-team/matam
- **Package**: https://anaconda.org/channels/bioconda/packages/matam/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No valid binary found for indexdb_rna
```


## matam_matam_assembly.py

### Tool Description
MATAM assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/matam:1.6.2--haf24da9_0
- **Homepage**: https://github.com/bonsai-team/matam
- **Package**: https://anaconda.org/channels/bioconda/packages/matam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: matam_assembly.py [-h] -i FASTQ [-d DBPATH] [-o OUTDIR] [-v] [--cpu CPU] [--max_memory MAXMEM] [--best INT]
                         [--evalue REAL] [--score_threshold REAL] [--straight_mode] [--coverage_threshold INT]
                         [--min_identity REAL] [--min_overlap_length INT] [-N INT] [-E INT] [--seed INT]
                         [--quorum FLOAT] [-a {SGA}] [--read_correction {no,yes,auto}] [--contigs_binning]
                         [--min_scaffold_length MIN_SCAFFOLD_LENGTH] [--perform_taxonomic_assignment]
                         [--training_model {16srrna,fungallsu,fungalits_warcup,fungalits_unite}]
                         [--rdp_cutoff RDP_CUTOFF] [--keep_tmp] [--debug] [--resume_from STEP] [--filter_only]

MATAM assembly

options:
  -h, --help                                                             show this help message and exit

Main parameters:
  -i, --input_fastq FASTQ                                                Input reads file (fasta or fastq format)
  -d, --ref_db DBPATH                                                    MATAM ref db. Default is
                                                                         $MATAM_DIR/db/SILVA_128_SSURef_NR95
  -o, --out_dir OUTDIR                                                   Output directory.Default will be
                                                                         "matam_assembly"
  -v, --verbose                                                          Increase verbosity

Performance:
  --cpu CPU                                                              Max number of CPU to use. Default is 1 cpu
  --max_memory MAXMEM                                                    Maximum memory to use (in MBi). Default is
                                                                         10000 MBi

Read mapping:
  --best INT                                                             Get up to --best good alignments per read.
                                                                         Default is 10
  --evalue REAL                                                          Max e-value to keep an alignment for. Default
                                                                         is 1e-05

Alignment filtering:
  --score_threshold REAL                                                 Score threshold (real between 0 and 1). Default
                                                                         is 0.9
  --straight_mode                                                        Use straight mode filtering. Default is
                                                                         geometric mode
  --coverage_threshold INT                                               Ref coverage threshold. By default set to 0 to
                                                                         desactivate filtering

Overlap-graph building:
  --min_identity REAL                                                    Minimum identity of an overlap between 2 reads.
                                                                         Default is 1.0
  --min_overlap_length INT                                               Minimum length of an overlap. Default is 50

Graph compaction & Components identification:
  -N, --min_read_node INT                                                Minimum number of read to keep a node. Default
                                                                         is 1
  -E, --min_overlap_edge INT                                             Minimum number of overlap to keep an edge.
                                                                         Default is 1
  --seed INT                                                             Seed to initialize random generator. Default is
                                                                         picking seed from system time

LCA labelling:
  --quorum FLOAT                                                         Quorum for LCA computing. Has to be between
                                                                         0.51 and 1. Default is 0.51

Contigs assembly:
  -a, --assembler {SGA}                                                  Select the assembler to be used. Default is SGA
  --read_correction {no,yes,auto}                                        Set the assembler read correction step. 'auto'
                                                                         means assemble the components with read
                                                                         correction enabled when the components coverage
                                                                         are sufficient (20X) and assemble the other
                                                                         components without read correction. Default is
                                                                         auto

Scaffolding:
  --contigs_binning                                                      Experimental. Perform contigs binning during
                                                                         scaffolding.
  --min_scaffold_length MIN_SCAFFOLD_LENGTH                              Filter out small scaffolds

Taxonomic assignment:
  --perform_taxonomic_assignment                                         Do the taxonomic assignment
  --training_model {16srrna,fungallsu,fungalits_warcup,fungalits_unite}  The training model used for taxonomic
                                                                         assignment. Default is 16srrna
  --rdp_cutoff RDP_CUTOFF                                                Sequences assigned (by RDP) with a confidence
                                                                         score < 0.8 (at genus level) will be tagged as
                                                                         an artificial "unclassified" taxon

Advanced parameters:
  --keep_tmp                                                             Do not remove tmp files
  --debug                                                                Output debug infos
  --resume_from STEP                                                     Try to resume from given step. Steps are:
                                                                         reads_mapping, alignments_filtering,
                                                                         overlap_graph_building, graph_compaction,
                                                                         contigs_assembly, scaffolding,
                                                                         abundance_calculation, taxonomic_assignment
  --filter_only                                                          Perform only the first step of MATAM (i.e Reads
                                                                         mapping against ref db with sortmerna to filter
                                                                         the reads). Relevant options for this step
                                                                         correspond to the "Read mapping" section.
```


## matam_matam_compare_samples.py

### Tool Description
This script let you compare two or more samples coming from MATAM -- v1.5.1 or superior

### Metadata
- **Docker Image**: quay.io/biocontainers/matam:1.6.2--haf24da9_0
- **Homepage**: https://github.com/bonsai-team/matam
- **Package**: https://anaconda.org/channels/bioconda/packages/matam/overview
- **Validation**: PASS

### Original Help Text
```text
usage: matam_compare_samples.py [-h] -s SAMPLES_FILE
                                -t OUPUT_CONTINGENCY_TABLE
                                -c OUPUT_COMPARAISON_TABLE

This script let you compare two or more samples coming from MATAM -- v1.5.1 or
superior

options:
  -h, --help            show this help message and exit
  -s, --samples_file SAMPLES_FILE
                        A tabulated file with one sample by row. The first
                        column contains the sample id (must be unique) The
                        second column contains the fasta path. The abundances
                        must be present into this file. The third, the rdp
                        path. Paths can be absolute or relative to the current
                        working directory.
  -t, --ouput_contingency_table OUPUT_CONTINGENCY_TABLE
                        Output a table with the abundance for each sequence
  -c, --ouput_comparaison_table OUPUT_COMPARAISON_TABLE
                        Output a comparaison table (taxonomy vs samples)
```


## Metadata
- **Skill**: generated
