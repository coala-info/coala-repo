cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacerberus.py
label: metacerberus_metacerberus.py
doc: "MetaCerberus: a pipeline for the prediction of viral sequences in metagenomes
  and single genomes.\n\nTool homepage: https://github.com/raw-lab/metacerberus"
inputs:
  - id: adapters
    type:
      - 'null'
      - File
    doc: FASTA File containing adapter sequences for trimming
    inputBinding:
      position: 101
      prefix: --adapters
  - id: address
    type:
      - 'null'
      - string
    doc: Address for MPP. local=no networking, host=make this machine a host, 
      ip-address=connect to remote host
    inputBinding:
      position: 101
      prefix: --address
  - id: amino
    type:
      - 'null'
      - type: array
        items: string
    doc: Protein Amino Acid sequence
    inputBinding:
      position: 101
      prefix: --amino
  - id: chunker
    type:
      - 'null'
      - int
    doc: Split files into smaller chunks, in Megabytes [Disabled by default]
    inputBinding:
      position: 101
      prefix: --chunker
  - id: class
    type:
      - 'null'
      - File
    doc: path to a tsv file which has class information for the samples. If this
      file is included scripts will be included to run Pathview in R
    inputBinding:
      position: 101
      prefix: --class
  - id: config
    type:
      - 'null'
      - File
    doc: Path to config file, command line takes priority
    inputBinding:
      position: 101
      prefix: --config
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use per task. System will try to detect available 
      CPUs if not specified
    inputBinding:
      position: 101
      prefix: --cpus
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: 'Path to folder of databases [Default: under the library path of MetaCerberus]'
    inputBinding:
      position: 101
      prefix: --db-path
  - id: dir_out
    type:
      - 'null'
      - Directory
    doc: path to output directory, defaults to "results-metacerberus" in current
      directory.
    inputBinding:
      position: 101
      prefix: --dir-out
  - id: dir_out
    type:
      - 'null'
      - Directory
    doc: path to output directory, defaults to "results-metacerberus" in current
      directory.
    inputBinding:
      position: 101
      prefix: --dir_out
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: Downloads selected HMMs. Use the option --list-db for a list of 
      available databases, default is to download all available databases
    inputBinding:
      position: 101
      prefix: --download
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value cutoff for parsing HMMER results
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fraggenescan
    type:
      - 'null'
      - type: array
        items: string
    doc: Eukaryote nucleotide sequence (includes other viruses, works all around
      for everything)
    inputBinding:
      position: 101
      prefix: --fraggenescan
  - id: grouped
    type:
      - 'null'
      - boolean
    doc: Group multiple fasta files into a single file before processing. When 
      used with chunker can improve speed
    inputBinding:
      position: 101
      prefix: --grouped
  - id: hmm
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of databases for HMMER. 'ALL' uses all downloaded databases. Use
      the option --list-db for a list of available databases
    inputBinding:
      position: 101
      prefix: --hmm
  - id: hmmer_tsv
    type:
      - 'null'
      - type: array
        items: string
    doc: Annotations tsv file from HMMER (experimental)
    inputBinding:
      position: 101
      prefix: --hmmer-tsv
  - id: illumina
    type:
      - 'null'
      - boolean
    doc: Specifies that the given FASTQ files are from Illumina
    inputBinding:
      position: 101
      prefix: --illumina
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Flag to keep temporary files.
    inputBinding:
      position: 101
      prefix: --keep
  - id: list_db
    type:
      - 'null'
      - boolean
    doc: List available and downloaded databases
    inputBinding:
      position: 101
      prefix: --list-db
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Metagenomic nucleotide sequences (for prodigal)
    inputBinding:
      position: 101
      prefix: --meta
  - id: minscore
    type:
      - 'null'
      - int
    doc: Score cutoff for parsing HMMER results
    inputBinding:
      position: 101
      prefix: --minscore
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Specifies that the given FASTQ files are from Nanopore
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: Specifies that the given FASTQ files are from PacBio
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: phanotate
    type:
      - 'null'
      - type: array
        items: string
    doc: Phage sequence (EXPERIMENTAL)
    inputBinding:
      position: 101
      prefix: --phanotate
  - id: port
    type:
      - 'null'
      - int
    doc: The port to listen/connect to
    inputBinding:
      position: 101
      prefix: --port
  - id: prodigal
    type:
      - 'null'
      - type: array
        items: string
    doc: Prokaryote nucleotide sequence (includes microbes, bacteriophage)
    inputBinding:
      position: 101
      prefix: --prodigal
  - id: prodigalgv
    type:
      - 'null'
      - type: array
        items: string
    doc: Giant virus nucleotide sequence
    inputBinding:
      position: 101
      prefix: --prodigalgv
  - id: protein
    type:
      - 'null'
      - type: array
        items: string
    doc: Protein Amino Acid sequence
    inputBinding:
      position: 101
      prefix: --protein
  - id: qc_seq
    type:
      - 'null'
      - File
    doc: FASTA File containing control sequences for decontamination
    inputBinding:
      position: 101
      prefix: --qc_seq
  - id: remove_n_repeats
    type:
      - 'null'
      - boolean
    doc: Remove N repeats, splitting contigs
    inputBinding:
      position: 101
      prefix: --remove-n-repeats
  - id: replace
    type:
      - 'null'
      - boolean
    doc: Flag to replace existing files.
    inputBinding:
      position: 101
      prefix: --replace
  - id: scaffolds
    type:
      - 'null'
      - boolean
    doc: Sequences are treated as scaffolds
    inputBinding:
      position: 101
      prefix: --scaffolds
  - id: setup
    type:
      - 'null'
      - boolean
    doc: Setup additional dependencies
    inputBinding:
      position: 101
      prefix: --setup
  - id: skip_decon
    type:
      - 'null'
      - boolean
    doc: Skip decontamination step
    inputBinding:
      position: 101
      prefix: --skip-decon
  - id: skip_pca
    type:
      - 'null'
      - boolean
    doc: Skip PCA
    inputBinding:
      position: 101
      prefix: --skip-pca
  - id: super
    type:
      - 'null'
      - type: array
        items: string
    doc: Run sequence in both --prodigal and --fraggenescan modes
    inputBinding:
      position: 101
      prefix: --super
  - id: uninstall
    type:
      - 'null'
      - boolean
    doc: Remove downloaded databases and FragGeneScan+
    inputBinding:
      position: 101
      prefix: --uninstall
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update downloaded databases
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacerberus:1.4.0--pyhdfd78af_1
stdout: metacerberus_metacerberus.py.out
