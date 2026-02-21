cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgt
label: tgt
doc: "The provided text does not contain help information or usage instructions for
  the tool 'tgt'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/hbuschme/TextGridTools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgt:1.4.3--pyh7e72e81_3
stdout: tgt.out
