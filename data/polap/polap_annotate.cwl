cwlVersion: v1.2
class: CommandLineTool
baseCommand: polap
label: polap_annotate
doc: "Plant organelle DNA long-read assembly pipeline.\n\nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: inum
    type:
      - 'null'
      - int
    doc: Number of iterations for assembly
    inputBinding:
      position: 101
      prefix: --inum
  - id: jnum
    type:
      - 'null'
      - int
    doc: Number of jobs for assembly
    inputBinding:
      position: 101
      prefix: --jnum
  - id: long_reads
    type:
      - 'null'
      - File
    doc: Long-read file
    inputBinding:
      position: 101
      prefix: --long-reads
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: short_read1
    type:
      - 'null'
      - File
    doc: First short-read file
    inputBinding:
      position: 101
      prefix: --short-read1
  - id: short_read2
    type:
      - 'null'
      - File
    doc: Second short-read file
    inputBinding:
      position: 101
      prefix: --short-read2
  - id: single_min
    type:
      - 'null'
      - int
    doc: Minimum length for single reads
    inputBinding:
      position: 101
      prefix: --single-min
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_annotate.out
