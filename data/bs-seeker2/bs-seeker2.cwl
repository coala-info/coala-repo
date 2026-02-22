cwlVersion: v1.2
class: CommandLineTool
baseCommand: bs-seeker2
label: bs-seeker2
doc: "No description available in the provided text. The input appears to be an error
  log rather than help text.\n\nTool homepage: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bs-seeker2:2.1.7--0
stdout: bs-seeker2.out
