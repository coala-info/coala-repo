# unassigner CWL Generation Report

## unassigner

### Tool Description
Assigns sequences to their closest type strain, or flags them as unassigned.

### Metadata
- **Docker Image**: quay.io/biocontainers/unassigner:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/PennChopMicrobiomeProgram/unassigner
- **Package**: https://anaconda.org/channels/bioconda/packages/unassigner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unassigner/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PennChopMicrobiomeProgram/unassigner
- **Stars**: N/A
### Original Help Text
```text
usage: unassigner [-h] [--output_dir OUTPUT_DIR]
                  [--type_strain_fasta TYPE_STRAIN_FASTA] [--db_dir DB_DIR]
                  [--threshold THRESHOLD]
                  [--ref_mismatch_positions REF_MISMATCH_POSITIONS]
                  [--num_cpus NUM_CPUS] [--soft_threshold] [--verbose]
                  [--version]
                  query_fasta

positional arguments:
  query_fasta           Query sequences FASTA file

options:
  -h, --help            show this help message and exit
  --output_dir OUTPUT_DIR
                        Output directory (default: basename of query sequences
                        FASTA file, plus '_unassigned').
  --type_strain_fasta TYPE_STRAIN_FASTA
                        DEPRECATED. FASTA file containing sequences of type
                        strains. If not provided, the default database is
                        used. Note that this WILL NOT DOWNLOAD a new db.
  --db_dir DB_DIR       Directory containing the reference database. If not
                        provided, the default database is used.
  --threshold THRESHOLD
                        Sequence identity threshold for ruling out species-
                        level compatibility. Default value is 0.975 for the
                        standard algorithm and 0.991 for the soft threshold
                        algorithm.
  --ref_mismatch_positions REF_MISMATCH_POSITIONS
                        File of mismatch positions in reference database. The
                        file may be compressed in gzip format.
  --num_cpus NUM_CPUS   Number of CPUs to use during sequence aligment
                        (default: use all the CPUs)
  --soft_threshold      Use soft threshold algorithm.
  --verbose             Activate verbose mode.
  --version             show program's version number and exit
```

