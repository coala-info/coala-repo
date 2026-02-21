cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree_doctor
label: phast_tree_doctor
doc: "A tool for manipulating and analyzing phylogenetic trees (part of the PHAST
  package). Note: The provided text contains container environment logs and a fatal
  error rather than the tool's help documentation, so no arguments could be extracted.\n
  \nTool homepage: http://compgen.cshl.edu/phast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.6--h93e12ee_0
stdout: phast_tree_doctor.out
