cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy runall
label: iobrpy_runall
doc: "Run iobrpy in different modes.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform a dry run without executing commands
    inputBinding:
      position: 101
      prefix: --dry_run
  - id: fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 101
      prefix: --fastq
  - id: mode
    type: string
    doc: Mode to run in (salmon or star)
    inputBinding:
      position: 101
      prefix: --mode
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume a previous run
    inputBinding:
      position: 101
      prefix: --resume
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
stdout: iobrpy_runall.out
