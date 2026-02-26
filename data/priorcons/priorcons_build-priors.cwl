cwlVersion: v1.2
class: CommandLineTool
baseCommand: priorcons
label: priorcons_build-priors
doc: "Build empirical priors from alignment\n\nTool homepage: https://github.com/GERMAN00VP/priorcons"
inputs:
  - id: input
    type: File
    doc: Input alignment FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: overlap
    type:
      - 'null'
      - int
    doc: Window overlap
    default: 50
    inputBinding:
      position: 101
      prefix: --overlap
  - id: ref
    type: string
    doc: Reference sequence ID
    inputBinding:
      position: 101
      prefix: --ref
  - id: win
    type:
      - 'null'
      - int
    doc: Window size
    default: 100
    inputBinding:
      position: 101
      prefix: --win
outputs:
  - id: output
    type: File
    doc: Output file (.parquet)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/priorcons:0.1.0--pyhdfd78af_0
