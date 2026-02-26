# metacerberus CWL Generation Report

## metacerberus_metacerberus.py

### Tool Description
MetaCerberus: a pipeline for the prediction of viral sequences in metagenomes and single genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/metacerberus:1.4.0--pyhdfd78af_1
- **Homepage**: https://github.com/raw-lab/metacerberus
- **Package**: https://anaconda.org/channels/bioconda/packages/metacerberus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metacerberus/overview
- **Total Downloads**: 14.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/raw-lab/metacerberus
- **Stars**: N/A
### Original Help Text
```text
usage: metacerberus.py [--setup] [--update] [--list-db]
                       [--download [DOWNLOAD ...]] [--uninstall] [-c CONFIG]
                       [--prodigal PRODIGAL [PRODIGAL ...]]
                       [--fraggenescan FRAGGENESCAN [FRAGGENESCAN ...]]
                       [--super SUPER [SUPER ...]]
                       [--prodigalgv PRODIGALGV [PRODIGALGV ...]]
                       [--phanotate PHANOTATE [PHANOTATE ...]]
                       [--protein PROTEIN [PROTEIN ...]]
                       [--hmmer-tsv HMMER_TSV [HMMER_TSV ...]] [--class CLASS]
                       [--illumina | --nanopore | --pacbio]
                       [--dir-out DIR_OUT] [--replace] [--keep]
                       [--hmm HMM [HMM ...]] [--db-path DB_PATH]
                       [--address ADDRESS] [--port PORT] [--meta]
                       [--scaffolds] [--minscore MINSCORE] [--evalue EVALUE]
                       [--remove-n-repeats] [--skip-decon] [--skip-pca]
                       [--cpus CPUS] [--chunker CHUNKER] [--grouped]
                       [--version] [-h] [--adapters ADAPTERS]
                       [--qc_seq QC_SEQ]

Setup arguments:
  --setup               Setup additional dependencies [False]
  --update              Update downloaded databases [False]
  --list-db             List available and downloaded databases [False]
  --download [DOWNLOAD ...]
                        Downloads selected HMMs. Use the option --list-db for
                        a list of available databases, default is to download
                        all available databases
  --uninstall           Remove downloaded databases and FragGeneScan+ [False]

Input files
At least one sequence is required.
    accepted formats: [.fastq, .fq, .fasta, .fa, .fna, .ffn, .faa]
Example:
> metacerberus.py --prodigal file1.fasta
> metacerberus.py --config file.config
*Note: If a sequence is given in [.fastq, .fq] format, one of --nanopore, --illumina, or --pacbio is required.:
  -c CONFIG, --config CONFIG
                        Path to config file, command line takes priority
  --prodigal PRODIGAL [PRODIGAL ...]
                        Prokaryote nucleotide sequence (includes microbes,
                        bacteriophage)
  --fraggenescan FRAGGENESCAN [FRAGGENESCAN ...]
                        Eukaryote nucleotide sequence (includes other viruses,
                        works all around for everything)
  --super SUPER [SUPER ...]
                        Run sequence in both --prodigal and --fraggenescan
                        modes
  --prodigalgv PRODIGALGV [PRODIGALGV ...]
                        Giant virus nucleotide sequence
  --phanotate PHANOTATE [PHANOTATE ...]
                        Phage sequence (EXPERIMENTAL)
  --protein PROTEIN [PROTEIN ...], --amino PROTEIN [PROTEIN ...]
                        Protein Amino Acid sequence
  --hmmer-tsv HMMER_TSV [HMMER_TSV ...]
                        Annotations tsv file from HMMER (experimental)
  --class CLASS         path to a tsv file which has class information for the
                        samples. If this file is included scripts will be
                        included to run Pathview in R
  --illumina            Specifies that the given FASTQ files are from Illumina
  --nanopore            Specifies that the given FASTQ files are from Nanopore
  --pacbio              Specifies that the given FASTQ files are from PacBio

Output options:
  --dir-out DIR_OUT, --dir_out DIR_OUT
                        path to output directory, defaults to "results-
                        metacerberus" in current directory. [./results-
                        metacerberus]
  --replace             Flag to replace existing files. [False]
  --keep                Flag to keep temporary files. [False]

Database options:
  --hmm HMM [HMM ...]   A list of databases for HMMER. 'ALL' uses all
                        downloaded databases. Use the option --list-db for a
                        list of available databases [KOFam_all]
  --db-path DB_PATH     Path to folder of databases [Default: under the
                        library path of MetaCerberus]

MPP options:
  --address ADDRESS     Address for MPP. local=no networking, host=make this
                        machine a host, ip-address=connect to remote host
                        [local]
  --port PORT           The port to listen/connect to [24515]

optional arguments:
  --meta                Metagenomic nucleotide sequences (for prodigal)
                        [False]
  --scaffolds           Sequences are treated as scaffolds [False]
  --minscore MINSCORE   Score cutoff for parsing HMMER results [60]
  --evalue EVALUE       E-value cutoff for parsing HMMER results [1e-09]
  --remove-n-repeats    Remove N repeats, splitting contigs [False]
  --skip-decon          Skip decontamination step [False]
  --skip-pca            Skip PCA [False]
  --cpus CPUS           Number of CPUs to use per task. System will try to
                        detect available CPUs if not specified [Auto Detect]
  --chunker CHUNKER     Split files into smaller chunks, in Megabytes
                        [Disabled by default]
  --grouped             Group multiple fasta files into a single file before
                        processing. When used with chunker can improve speed
  --version, -v         show the version number and exit
  -h, --help            show this help message and exit

  --adapters ADAPTERS   FASTA File containing adapter sequences for trimming
  --qc_seq QC_SEQ       FASTA File containing control sequences for
                        decontamination

Args that start with '--' can also be set in a config file (specified via -c).
Config file syntax allows: key=value, flag=true, stuff=[a,b,c] (for details,
see syntax at https://goo.gl/R74nmi). In general, command-line values override
config file values which override defaults.
```

