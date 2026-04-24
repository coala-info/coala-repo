cwlVersion: v1.2
class: CommandLineTool
baseCommand: easypqp_reduce
label: easypqp_reduce
doc: "Reduce PQP files for OpenSWATH linear and non-linear alignment\n\nTool homepage:
  https://github.com/grosenberger/easypqp"
inputs:
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins to fill along gradient.
    inputBinding:
      position: 101
      prefix: --bins
  - id: in
    type: File
    doc: Input PQP file.
    inputBinding:
      position: 101
      prefix: --in
  - id: peptides
    type:
      - 'null'
      - int
    doc: Number of peptides to sample.
    inputBinding:
      position: 101
      prefix: --peptides
outputs:
  - id: out
    type: File
    doc: Output PQP file.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
