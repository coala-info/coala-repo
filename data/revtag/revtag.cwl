cwlVersion: v1.2
class: CommandLineTool
baseCommand: revtag
label: revtag
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/clintval/revtag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revtag:1.0.0--h3ab6199_0
stdout: revtag.out
