cwlVersion: v1.2
class: CommandLineTool
baseCommand: sneep
label: sneep
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sneep'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/SchulzLab/SNEEP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sneep:1.1--py311ha48eb5d_3
stdout: sneep.out
