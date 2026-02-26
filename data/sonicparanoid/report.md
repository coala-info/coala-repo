# sonicparanoid CWL Generation Report

## sonicparanoid

### Tool Description
SonicParanoid 2.0.9

### Metadata
- **Docker Image**: quay.io/biocontainers/sonicparanoid:2.0.9--py312hc9302aa_0
- **Homepage**: http://iwasakilab.bs.s.u-tokyo.ac.jp/sonicparanoid/
- **Package**: https://anaconda.org/channels/bioconda/packages/sonicparanoid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sonicparanoid/overview
- **Total Downloads**: 43.9K
- **Last updated**: 2025-09-15
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: sonicparanoid -i <INPUT_DIRECTORY> -o <OUTPUT_DIRECTORY>[options]

SonicParanoid 2.0.9

options:
  -h, --help            show this help message and exit
  -i INPUT_DIRECTORY, --input-directory INPUT_DIRECTORY
                        Directory containing the proteomes (in FASTA format)
                        of the species to be analyzed.
  -o OUTPUT_DIRECTORY, --output-directory OUTPUT_DIRECTORY
                        The directory in which the results will be stored.
  -p PROJECT_ID, --project-id PROJECT_ID
                        Name for the project reflecting the name of run. If
                        not specified it will be automatically generated using
                        the current date and time.
  -sh SHARED_DIRECTORY, --shared-directory SHARED_DIRECTORY
                        Directory in which the alignment files are stored. If
                        not specified it is created inside the main output
                        directory.
  -t THREADS, --threads THREADS
                        Maximum number of CPUs to be used. Default=4
  -at, --force-all-threads
                        Force using all the requested threads.
  -sm, --skip-multi-species
                        Skip the creation of multi-species ortholog groups.
  -d, --debug           Show debug lines. WARNING: extremely verbose
  -nc, --no-compress    Skip the compression of processed alignment files.
  -cl COMPRESSION_LEV, --compression-lev COMPRESSION_LEV
                        Gzip compression level. Integer values between 1 and
                        9, with 9 and 1 being the highest lowest compression
                        levels, respectively. Default=5
  -m {fast,default,sensitive}, --mode {fast,default,sensitive}
                        SonicParanoid execution mode. The default mode is
                        suitable for most studies. Use sensitive if the input
                        proteomes are not closely related.
  -dmnd {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}, --diamond {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}
                        Use Diamond with a custom sensitivity. This will
                        bypass the -m (--mode) option.
  -mmseqs MMSEQS, --mmseqs MMSEQS
                        Use MMseqs2 with a custom sensitivity (between 1.0 and
                        7.5). This will bypass the -m (--mode) option.
  -blast, --blast       Use Blastp for all-vs-all alignments. This will bypass
                        the -m (--mode) option.
  -ml MAX_LEN_DIFF, --max-len-diff MAX_LEN_DIFF
                        Maximum allowed length-difference-ratio between main
                        orthologs and canditate inparalogs. Example: 0.5 means
                        one of the two sequences could be two times longer
                        than the other 0 means no length difference allowed; 1
                        means any length difference allowed. Default=0.75
  -db SEQS_DBS, --seqs-dbs SEQS_DBS
                        The directory in which the database files created by
                        the selectedlocal alignment tool will be stored.
                        DEFAULT: automatically created inside the main output
                        directory.
  -idxdb, --index-db    Index the MMSeqs2/Diamond databases. IMPORTANT: This
                        will use more storage but will be slighly faster
                        (5~10%) when processing many big proteomes with
                        MMseqs2. The results might also be sligthy different.
  -op, --output-pairs   Output a text file with all the pairwise orthologous
                        relationships.
  -ka, --keep-raw-alignments
                        Do not delete raw MMseqs2 alignment files. NOTE: this
                        will triple the space required for storing the
                        results.
  -bs MIN_BITSCORE, --min-bitscore MIN_BITSCORE
                        Consider only alignments with bitscores above min-
                        bitscore.Increasing this value can be a good idea when
                        comparing very closely related species.Increasing this
                        value will reduce the number of paralogs (and
                        orthologs) generate.WARNING: use only if you are sure
                        of what you are doing. INFO: higher min-bitscore
                        values reduce the execution time for all-vs-all.
                        Default=40
  -ca, --complete-aln   Perform complete alignments (slower), rathen than
                        essential ones.
  -go, --graph-only     Perform only graph-based orthology (skip architectures
                        analysis).
  --min-arch-merging-cov MIN_ARCH_MERGING_COV
                        When merging graph- and arch-based orhtologs consider
                        only new-orthologs with a protein coverage greater or
                        equal than this value. Default=0.75
  -I INFLATION, --inflation INFLATION
                        Affects the granularity of ortholog groups. This value
                        should be between 1.2 (very coarse) and 5 (fine
                        grained clustering). Default=1.5
  -ot, --overwrite-tables
                        This will force the re-computation of the ortholog
                        tables. Only missing alignment files will be re-
                        computed.
  -ow, --overwrite      Overwrite previous runs and execute it again. This can
                        be useful to update a subset of the computed tables.
  -rs, --remove-old-species
                        (EXPERIMENTAL) Remove alignments and pairwise ortholog
                        tables related to species used in a previous run. This
                        option should be used when updating a run in which
                        some input proteomes were modified or removed.
  -un, --update-input-names
                        (EXPERIMENTAL) Remove alignments and pairwise ortholog
                        tables for an input proteome used in a previous which
                        file name conflicts with a newly added species. This
                        option should be used when updating a run in which
                        some input proteomes or their file names were
                        modified.
```

