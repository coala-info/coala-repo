cwlVersion: v1.2
class: CommandLineTool
baseCommand: sphinx-argparse
label: sphinx-argparse
doc: "The provided text does not contain help information or usage instructions for
  sphinx-argparse; it is a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/alex-rudakov/sphinx-argparse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sphinx-argparse:0.1.15--py36_0
stdout: sphinx-argparse.out
