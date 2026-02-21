cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - axiome
  - utility
label: axiome_utility
doc: "Generates a file mapping template or copies AXIOME sample data into the current
  directory\n\nTool homepage: https://github.com/ujjwalredd/Axiomeer"
inputs:
  - id: action
    type: string
    doc: 'mapping_template: generates a file mapping template in the current directory,
      which can be opened in a spreadsheet program; sample_data: copies AXIOME sample
      data into the current directory'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/axiome:2.0.4--py27_0
stdout: axiome_utility.out
