cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit convert
label: transit_convert
doc: "Convert between different data formats. Please use one of the known methods
  (or see documentation to add a new one).\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: method
    type: string
    doc: The conversion method to use (e.g., gff_to_prot_table)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit_convert.out
