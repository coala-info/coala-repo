cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_treeshrink.py
label: treeshrink
doc: "TreeShrink is a tool for detecting outlier long branches in phylogenetic trees.
  Note: The provided text appears to be a system error log regarding a container build
  failure ('no space left on device') rather than the tool's help text, so no arguments
  could be extracted from the input.\n\nTool homepage: https://github.com/uym2/TreeShrink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treeshrink:1.3.9--pyhdfd78af_1
stdout: treeshrink.out
