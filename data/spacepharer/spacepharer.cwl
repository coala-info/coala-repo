cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacepharer
label: spacepharer
doc: "The provided text does not contain help information for spacepharer; it is a
  log of a failed container build/fetch process. No arguments or tool descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/soedinglab/spacepharer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacepharer:5.c2e680a--hd6d6fdc_7
stdout: spacepharer.out
