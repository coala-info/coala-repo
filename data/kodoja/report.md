# kodoja CWL Generation Report

## kodoja_kodoja_build.py

### Tool Description
Kodoja Build creates a database for use with Kodoja Search.

### Metadata
- **Docker Image**: quay.io/biocontainers/kodoja:0.0.10--0
- **Homepage**: https://github.com/abaizan/kodoja/
- **Package**: https://anaconda.org/channels/bioconda/packages/kodoja/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kodoja/overview
- **Total Downloads**: 31.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/abaizan/kodoja
- **Stars**: N/A
### Original Help Text
```text
usage: kodoja_build.py [-h] [--version] -o OUTPUT_DIR [-t THREADS]
                       [-p HOST_TAXID] [-d DOWNLOAD_PARALLEL] [-n]
                       [-e [EXTRA_FILES [EXTRA_FILES ...]]]
                       [-x [EXTRA_TAXIDS [EXTRA_TAXIDS ...]]] [-v]
                       [-b KRAKEN_TAX] [-k KRAKEN_KMER] [-m KRAKEN_MINIMIZER]
                       [-a DB_TAG]

Kodoja Build creates a database for use with Kodoja Search.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory path, required
  -t THREADS, --threads THREADS
                        Number of threads, default=1
  -p HOST_TAXID, --host_taxid HOST_TAXID
                        Host tax ID
  -d DOWNLOAD_PARALLEL, --download_parallel DOWNLOAD_PARALLEL
                        Parallel genome download, default=4
  -n, --no_download     Genomes have already been downloaded
  -e [EXTRA_FILES [EXTRA_FILES ...]], --extra_files [EXTRA_FILES [EXTRA_FILES ...]]
                        List of extra files added to "extra" dir
  -x [EXTRA_TAXIDS [EXTRA_TAXIDS ...]], --extra_taxids [EXTRA_TAXIDS [EXTRA_TAXIDS ...]]
                        List of taxID of extra files
  -v, --all_viruses     Build databases with all viruses (not plant specific)
  -b KRAKEN_TAX, --kraken_tax KRAKEN_TAX
                        Path to taxonomy directory
  -k KRAKEN_KMER, --kraken_kmer KRAKEN_KMER
                        Kraken kmer size, default=31
  -m KRAKEN_MINIMIZER, --kraken_minimizer KRAKEN_MINIMIZER
                        Kraken minimizer size, default=15
  -a DB_TAG, --db_tag DB_TAG
                        Suffix for databases

See also https://github.com/abaizan/kodoja/wiki/Kodoja-Manual
```


## kodoja_kodoja_search.py

### Tool Description
Kodoja Search is a tool intended to identify viral sequences
in a FASTQ/FASTA sequencing run by matching them against both Kraken and
Kaiju databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/kodoja:0.0.10--0
- **Homepage**: https://github.com/abaizan/kodoja/
- **Package**: https://anaconda.org/channels/bioconda/packages/kodoja/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kodoja_search.py [-h] [--version] -o OUTPUT_DIR -d1 KRAKEN_DB -d2
                        KAIJU_DB -r1 READ1 [-r2 READ2] [-f DATA_FORMAT]
                        [-t THREADS] [-s HOST_SUBSET] [-m TRIM_MINLEN]
                        [-a TRIM_ADAPT] [-q KRAKEN_QUICK] [-p]
                        [-c KAIJU_SCORE] [-l KAIJU_MINLEN] [-i KAIJU_MISMATCH]

Kodoja Search is a tool intended to identify viral sequences
in a FASTQ/FASTA sequencing run by matching them against both Kraken and
Kaiju databases.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory path, required
  -d1 KRAKEN_DB, --kraken_db KRAKEN_DB
                        Kraken database path, required
  -d2 KAIJU_DB, --kaiju_db KAIJU_DB
                        Kaiju database path, required
  -r1 READ1, --read1 READ1
                        Read 1 file path, required
  -r2 READ2, --read2 READ2
                        Read 2 file path
  -f DATA_FORMAT, --data_format DATA_FORMAT
                        Sequence data format (default fastq)
  -t THREADS, --threads THREADS
                        Number of threads (default 1)
  -s HOST_SUBSET, --host_subset HOST_SUBSET
                        Subset sequences with this tax id from results
  -m TRIM_MINLEN, --trim_minlen TRIM_MINLEN
                        Trimmomatic minimum length
  -a TRIM_ADAPT, --trim_adapt TRIM_ADAPT
                        Illumina adapter sequence file
  -q KRAKEN_QUICK, --kraken_quick KRAKEN_QUICK
                        Number of minium hits by Kraken
  -p, --kraken_preload  Kraken preload database
  -c KAIJU_SCORE, --kaiju_score KAIJU_SCORE
                        Kaju alignment score
  -l KAIJU_MINLEN, --kaiju_minlen KAIJU_MINLEN
                        Kaju minimum length
  -i KAIJU_MISMATCH, --kaiju_mismatch KAIJU_MISMATCH
                        Kaju allowed mismatches

The main output of ``kodoja_search.py`` is a file called ``virus_table.txt``
in the specified output directory. This is a plain text tab-separated table,
the columns are as follows:

1. Species name,
2. Species NCBI taxonomy identifier (TaxID),
3. Number of reads assigned by *either* Kraken or Kaiju to this species,
4. Number of Reads assigned by *both* Kraken and Kaiju to this species,
5. Genus name,
6. Number of reads assigned by *either* Kraken or Kaiju to this genus,
7. Number of reads assigned by *both* Kraken and Kaiju to this genus.

The output directory includes additional files, including ``kodoja_VRL.txt``
(a table listing the read identifiers used) which is intended mainly as
input to the ``kodoja_retrieve.py`` script.

See also https://github.com/abaizan/kodoja/wiki/Kodoja-Manual
```


## kodoja_kodoja_retrieve.py

### Tool Description
Kodoja Retrieve is used with the output of Kodoja Search to give subsets of your input sequencing reads matching viruses.

### Metadata
- **Docker Image**: quay.io/biocontainers/kodoja:0.0.10--0
- **Homepage**: https://github.com/abaizan/kodoja/
- **Package**: https://anaconda.org/channels/bioconda/packages/kodoja/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kodoja_retrieve.py [-h] [--version] -o FILE_DIR -r1 READ1 [-r2 READ2]
                          [-f USER_FORMAT] [-t TAXID] [-g] [-s]

Kodoja Retrieve is used with the output of Kodoja Search to
give subsets of your input sequencing reads matching viruses.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o FILE_DIR, --file_dir FILE_DIR
                        Path to directory of kodoja_search results, required
  -r1 READ1, --read1 READ1
                        Read 1 file path, required
  -r2 READ2, --read2 READ2
                        Read 2 file path, default: False
  -f USER_FORMAT, --user_format USER_FORMAT
                        Sequence data format, default: fastq
  -t TAXID, --taxID TAXID
                        Virus tax ID for subsetting, default: All viral
                        sequences
  -g, --genus           Include sequences classified at genus
  -s, --stringent       Only subset sequences identified by both tools

The main output of ``kodoja_search.py`` is a file called ``virus_table.txt``
(a table summarising the potential viruses found), but the specified output
directory will also contain ``kodoja_VRL.txt`` (a table listing the read
identifiers). This second file is used as input to ``kodoja_retrieve.py``
along with the original sequencing read files.

A sub-directory ``subreads/`` will be created in the output directory,
which will include either FASTA or FASTQ files named as follows:

* ``subset_files/virus_all_sequences1.fasta`` FASTA output
* ``subset_files/virus_all_sequences1.fastq`` FASTQ output

And, for paired end datasets,

* ``subset_files/virus_all_sequences2.fasta`` FASTA output
* ``subset_files/virus_all_sequences2.fastq`` FASTQ output

However, if the ``-t 12345`` option is used rather than ``virus_all_...``
the files will be named ``virus_12345_...`` instead.

See also https://github.com/abaizan/kodoja/wiki/Kodoja-Manual
```

