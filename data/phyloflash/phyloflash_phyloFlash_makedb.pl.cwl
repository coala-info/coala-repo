cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloFlash_makedb.pl
label: phyloflash_phyloFlash_makedb.pl
doc: "Builds the phyloFlash reference database (SILVA SSU Ref NR99 and Univec) by downloading the files or from local copies.\n\nTool homepage: https://hrgv.github.io/phyloFlash/"
inputs:
  - id: remote
    type:
      - 'null'
      - boolean
    doc: "Download databases via FTP"
    inputBinding:
      position: 1
      prefix: "--remote"
  - id: silva_file
    type:
      - 'null'
      - File
    doc: "Path to local copy of the SILVA database file (SILVA_[Release]_SSURef_NR99_tax_silva_trunc.fasta.gz). Ignored if --remote is used."
    inputBinding:
      position: 1
      prefix: "--silva_file"
  - id: univec_file
    type:
      - 'null'
      - File
    doc: "Path to local copy of the Univec database file. Ignored if --remote is used."
    inputBinding:
      position: 1
      prefix: "--univec_file"
  - id: emirge
    type:
      - 'null'
      - boolean
    doc: "Index database with Bowtie v1 for Emirge. Requires bowtie-build to be in path. Default: Yes (turn off with --noemirge)"
    inputBinding:
      position: 1
      prefix: "--emirge"
  - id: noemirge
    type:
      - 'null'
      - boolean
    doc: "Do not index the database for Emirge"
    inputBinding:
      position: 1
      prefix: "--noemirge"
  - id: sortmerna
    type:
      - 'null'
      - boolean
    doc: "Index database for Sortmerna. Requires indexdb_rna to be in path. Default: No (--nosortmerna)."
    inputBinding:
      position: 1
      prefix: "--sortmerna"
  - id: keep
    type:
      - 'null'
      - boolean
    doc: "Do not delete intermediary files"
    inputBinding:
      position: 1
      prefix: "--keep"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite files if already present. Default: No (\"--nooverwrite\")"
    inputBinding:
      position: 1
      prefix: "--overwrite"
  - id: ref_minlength
    type:
      - 'null'
      - int
    doc: "Minimum length of database sequences to keep after trimming of vectors and contaminant sequences. Default: 800"
    inputBinding:
      position: 1
      prefix: "--ref_minlength"
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of processors to use. Default: All available"
    inputBinding:
      position: 1
      prefix: "--CPUs"
  - id: mem
    type:
      - 'null'
      - int
    doc: "Memory limit (in Gb) for indexing tools. At least 10 is recommended. Default: 10"
    inputBinding:
      position: 1
      prefix: "--mem"
  - id: log
    type:
      - 'null'
      - string
    doc: "Write phyloFlash_makedb.pl log to a file. Default: None"
    inputBinding:
      position: 1
      prefix: "--log"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: database_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Database files written to the working directory"
    outputBinding:
      glob: "*"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
stdout: phyloflash_phyloFlash_makedb.pl.out
