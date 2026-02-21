cwlVersion: v1.2
class: CommandLineTool
baseCommand: stag
label: stag
doc: "The provided text does not contain help information or usage instructions for
  the tool 'stag'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/zellerlab/stag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
stdout: stag.out
