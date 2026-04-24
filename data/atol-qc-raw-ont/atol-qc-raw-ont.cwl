cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-qc-raw-ont
label: atol-qc-raw-ont
doc: "Performs QC on raw Oxford Nanopore reads.\n\nTool homepage: https://github.com/TomHarrop/atol-qc-raw-ont"
inputs:
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run
    inputBinding:
      position: 101
      prefix: -n
  - id: fastqfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Reads in fastq.gz. Multiple files are accepted.
    inputBinding:
      position: 101
      prefix: --fastqfiles
  - id: logs
    type:
      - 'null'
      - Directory
    doc: 'Log output directory. Default: logs are discarded.'
    inputBinding:
      position: 101
      prefix: --logs
  - id: mem_gb
    type:
      - 'null'
      - int
    doc: "Intended maximum RAM in GB. NOTE: some steps (e.g. filtlong) don't allow
      memory usage to be specified by the user."
    inputBinding:
      position: 101
      prefix: --mem
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length read to output. Default is 1, i.e. keep all reads.
    inputBinding:
      position: 101
      prefix: --min-length
  - id: stats
    type: File
    doc: Stats output (json)
    inputBinding:
      position: 101
      prefix: --stats
  - id: tarfile
    type:
      - 'null'
      - File
    doc: Reads in a single tarfile. Will be searched for filenames ending in 
      fastq.gz.
    inputBinding:
      position: 101
      prefix: --tarfile
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Combined output in fastq.gz
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-qc-raw-ont:0.1.12--pyhdfd78af_0
