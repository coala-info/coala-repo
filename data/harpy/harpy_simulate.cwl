cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - simulate
label: harpy_simulate
doc: "Simulate genomic variants. The variant simulator (simuG) can only simulate one
  type of variant at a time, so you may need to run it a few times if you want multiple
  variant types.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute: cnv (Introduce copy number variants), inversion
      (Introduce inversions), snpindel (Introduce snps and/or indels), translocation
      (Introduce translocations), or linkedreads (Create linked reads).'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the specified subcommand.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_simulate.out
