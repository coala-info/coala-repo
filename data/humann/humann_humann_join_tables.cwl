cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_join_tables
label: humann_humann_join_tables
doc: "The provided text is a system error message (FATAL: no space left on device)
  and does not contain help documentation for the tool. No arguments could be extracted.\n
  \nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
stdout: humann_humann_join_tables.out
