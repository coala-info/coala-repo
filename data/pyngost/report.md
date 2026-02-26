# pyngost CWL Generation Report

## pyngost_pyngoST.py

### Tool Description
fast, simultaneous and accurate multiple sequence typing of Neisseria gonorrhoeae genome collections

### Metadata
- **Docker Image**: quay.io/biocontainers/pyngost:1.1.3--pyh7e72e81_0
- **Homepage**: https://github.com/leosanbu/pyngoST
- **Package**: https://anaconda.org/channels/bioconda/packages/pyngost/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyngost/overview
- **Total Downloads**: 239
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/leosanbu/pyngoST
- **Stars**: N/A
### Original Help Text
```text
usage: pyngoST [options]

pyngoST: fast, simultaneous and accurate multiple sequence typing of Neisseria gonorrhoeae genome collections

Citation:
    Sanchez-Buso L, Sanchez-Serrano A, Golparian D and Unemo M.
    pyngoST: fast, simultaneous and accurate multiple sequence typing of Neisseria gonorrhoeae genome collections.
    Publication: https://doi.org/10.1099/mgen.0.001189
    GitHub: https://github.com/leosanbu/pyngoST

options:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        Input files (fasta or tab/csv)
  -r READ_FILE, --read_file READ_FILE
                        File containing the paths to the input files
  -s SCHEMES, --schemes SCHEMES
                        Typing schemes to query separated by commas (options: NG-STAR, MLST, NG-MAST) (default=NG-STAR)
  -g, --genogroups      Calculate NG-MAST genogroups from NG-MAST types (default=False)
  -c, --ngstarccs       Include NG-STAR CCs in output table (default=False)
  -m, --mosaic_pena     Report if the penA allele sequence is a mosaic or semimosaic (default=False)
  -b, --blast_new_alleles
                        Use blastn to find the closest alleles to new ones (default=False)
  -a, --alleles_out     Print fasta files with new alleles (optional, default=False)
  -q OUT_PATH, --out_path OUT_PATH
                        Path used to save output files (default: current directory)
  -o OUT_FILENAME, --out_filename OUT_FILENAME
                        Name of file to print the results table to (optional, default=screen output)
  -y ONLY_ASSIGNCCS, --only_assignccs ONLY_ASSIGNCCS
                        Only assign CCs from a table with NG-STAR STs. Indicate as value the number of the column that contains the STs (optional, default=None)
  -z, --only_assignsts  Only assign STs from a table with NG-STAR, MLST and/or NG-MAST profiles (optional, default=None)
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of processes to use for computation (optional, default=1)
  -p PATH, --path PATH  Path to database containing MLST/NG-STAR alleles and profiles. If not available, use -d to create an updated database
  -d, --download_db     Download updated allele and profile files and create database
  -n DB_NAME, --db_name DB_NAME
                        Name of the folder that will contain the database in case a download is requested with -d (default=allelesDB in working directory)
  -u, --update          Only recreate the database pickle file
  -cc NGSTARCCSFILE, --ngstarccsfile NGSTARCCSFILE
                        File with the NG-STAR clonal complexes (NG-STAR CCs) database (csv) to integrate to NG-STAR profiles
```

