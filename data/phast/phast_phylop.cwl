cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast
label: phast_phylop
doc: "The PHAST package contains the following programs\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: program_name
    type: string
    doc: Name of the PHAST program to get help for
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: phast_phylop.out
