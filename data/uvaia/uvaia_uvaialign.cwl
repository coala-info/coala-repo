cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - uvaia
  - align
label: uvaia_uvaialign
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build/fetch process.\n\nTool homepage: https://github.com/quadram-institute-bioscience/uvaia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvaia:2.0.1--heee599d_3
stdout: uvaia_uvaialign.out
