cwlVersion: v1.2
class: CommandLineTool
baseCommand: ariba
label: ariba
doc: "Antibiotic Resistance Identification by Assembly\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
stdout: ariba.out
