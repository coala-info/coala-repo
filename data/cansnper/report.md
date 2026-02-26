# cansnper CWL Generation Report

## cansnper_CanSNPer

### Tool Description
A toolkit for SNP-typing using NGS data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cansnper:1.0.10--py_1
- **Homepage**: https://github.com/adrlar/CanSNPer/
- **Package**: https://anaconda.org/channels/bioconda/packages/cansnper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cansnper/overview
- **Total Downloads**: 9.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/adrlar/CanSNPer
- **Stars**: N/A
### Original Help Text
```text
usage: CanSNPer [-h] [-r REFERENCE] [-i QUERY] [-b DB_PATH]
                [--import_tree_file IMPORT_TREE_FILE]
                [--import_snp_file IMPORT_SNP_FILE]
                [--import_seq_file IMPORT_SEQ_FILE]
                [--strain_name STRAIN_NAME]
                [--allow_differences ALLOW_DIFFERENCES] [-t] [-d]
                [-m PROGRESSIVEMAUVE] [-l] [-v] [-s] [-n NUM_THREADS]
                [-delete_organism] [-initialise_organism] [-f TMP_PATH] [-q]
                [--galaxy]

CanSNPer: A toolkit for SNP-typing using NGS data. Copyright (C) 2016 Adrian
Lärkeryd. This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
details. If you are stuck in a prompt and do not know what to do, type 'exit'
to exit.

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        the name of the organism
  -i QUERY, --query QUERY
                        fasta sequence file name that is to be analysed
  -b DB_PATH, --db_path DB_PATH
                        path to CanSNPerDB.db
  --import_tree_file IMPORT_TREE_FILE
                        imports a tree structure into the database
  --import_snp_file IMPORT_SNP_FILE
                        imports a list of SNPs into the database
  --import_seq_file IMPORT_SEQ_FILE
                        loads a sequence file into the database
  --strain_name STRAIN_NAME
                        the name of the strain
  --allow_differences ALLOW_DIFFERENCES
                        allow a number of SNPs to be wrong, i.e.continue
                        moving down the tree even if none of the SNPs of the
                        lower level are present [0]
  -t, --tab_sep         print the results in a simple tab separated format
  -d, --draw_tree       draw a pdf version of the tree, marking SNPs of the
                        query sequence
  -m PROGRESSIVEMAUVE, --progressiveMauve PROGRESSIVEMAUVE
                        path to progressiveMauve binary file
  -l, --list_snps       lists the SNPs of the given sequence
  -v, --verbose         prints some more information about the goings-ons of
                        the program while running
  -s, --save_align      saves the alignment file
  -n NUM_THREADS, --num_threads NUM_THREADS
                        maximum number of threads CanSNPer is allowed to use,
                        the default [0] is no limit, CanSNPer will start one
                        process per reference genome while aligning
  -delete_organism      deletes all information in the database concerning an
                        organism
  -initialise_organism  initialise a new table for an organism
  -f TMP_PATH, --tmp_path TMP_PATH
                        where temporary files are stored
  -q, --dev             dev mode
  --galaxy              argument used if Galaxy is running CanSNPer, do NOT
                        use.
```

