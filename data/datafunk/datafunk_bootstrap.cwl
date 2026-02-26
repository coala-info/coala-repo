cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk bootstrap
label: datafunk_bootstrap
doc: "bootstrap an alignment\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Alignment in fasta format to bootstrap
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstraps to generate
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    default: bootstrap_
    inputBinding:
      position: 101
      prefix: --output-prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
stdout: datafunk_bootstrap.out
