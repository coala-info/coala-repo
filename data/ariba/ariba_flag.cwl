cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - flag
label: ariba_flag
doc: "Translate the meaning of a flag output by ARIBA, found in the report tsv file\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: flag
    type: int
    doc: "Flag to be translated (an integer)"
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Meaning of each flag bit
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
stdout: ariba_flag.out
