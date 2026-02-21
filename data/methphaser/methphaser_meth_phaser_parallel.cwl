cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methphaser
  - meth_phaser_parallel
label: methphaser_meth_phaser_parallel
doc: "A tool for DNA methylation phasing. (Note: The provided help text contains only
  system error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/treangenlab/methphaser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
stdout: methphaser_meth_phaser_parallel.out
