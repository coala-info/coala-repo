cwlVersion: v1.2
class: CommandLineTool
baseCommand: platon
label: platon
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool 'platon'.\n\nTool
  homepage: https://github.com/oschwengers/platon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/platon:1.7--pyhdfd78af_0
stdout: platon.out
