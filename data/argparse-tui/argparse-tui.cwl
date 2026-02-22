cwlVersion: v1.2
class: CommandLineTool
baseCommand: argparse-tui
label: argparse-tui
doc: "A tool to convert OCI blobs to SIF format (Note: The provided text appears to
  be an error log rather than help text, so no arguments could be extracted).\n\n\
  Tool homepage: https://github.com/fresh2dev/argparse-tui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argparse-tui:0.3.1--pyhdfd78af_0
stdout: argparse-tui.out
