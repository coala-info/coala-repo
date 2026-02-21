cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam
label: sam
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sam'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam:3.5--0
stdout: sam.out
