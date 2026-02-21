cwlVersion: v1.2
class: CommandLineTool
baseCommand: methphaser
label: methphaser_meth_phaser_post_processing
doc: "Post-processing tool for methphaser (Note: The provided text is a system error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/treangenlab/methphaser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
stdout: methphaser_meth_phaser_post_processing.out
