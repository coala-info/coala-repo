cwlVersion: v1.2
class: CommandLineTool
baseCommand: scshiba.py
label: shiba_scshiba.py
doc: "scShiba v0.8.1 - Pipeline for identification of differential RNA splicing in
  single-cell RNA-seq data\n\nTool homepage: https://github.com/Sika-Zheng-Lab/Shiba"
inputs:
  - id: config
    type: File
    doc: Config file in yaml format
    inputBinding:
      position: 1
  - id: process
    type:
      - 'null'
      - int
    doc: Number of processors to use
    default: 1
    inputBinding:
      position: 102
      prefix: --process
  - id: start_step
    type:
      - 'null'
      - int
    doc: 'Start the pipeline from the specified step (default: 0, run all steps)'
    default: 0
    inputBinding:
      position: 102
      prefix: --start-step
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba:0.8.1--py312hdfd78af_1
stdout: shiba_scshiba.py.out
