cwlVersion: v1.2
class: CommandLineTool
baseCommand: ' fuc ngs-quant'
label: fuc_ngs-quant
doc: "Pipeline for running RNAseq quantification from FASTQ files with Kallisto.\n\
  \nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: manifest
    type: File
    doc: Sample manifest CSV file.
    inputBinding:
      position: 1
  - id: index
    type: File
    doc: Kallisto index file.
    inputBinding:
      position: 2
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 3
  - id: qsub
    type: string
    doc: SGE resoruce to request for qsub.
    inputBinding:
      position: 4
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: Number of bootstrap samples
    default: 50
    inputBinding:
      position: 105
      prefix: --bootstrap
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 105
      prefix: --force
  - id: job
    type:
      - 'null'
      - string
    doc: Job submission ID for SGE.
    inputBinding:
      position: 105
      prefix: --job
  - id: posix
    type:
      - 'null'
      - boolean
    doc: Set the environment variable HDF5_USE_FILE_LOCKING=FALSE before running
      Kallisto. This is required for shared Posix Filesystems (e.g. NFS, 
      Lustre).
    inputBinding:
      position: 105
      prefix: --posix
  - id: stranded
    type:
      - 'null'
      - string
    doc: Strand specific reads
    default: none
    inputBinding:
      position: 105
      prefix: --stranded
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 105
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_ngs-quant.out
