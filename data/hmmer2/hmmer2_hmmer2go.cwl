cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmer2go
label: hmmer2_hmmer2go
doc: "A tool for HMMER2 analysis (Note: The provided help text contains only system
  error messages regarding container execution and does not list specific command-line
  arguments).\n\nTool homepage: https://github.com/sestaton/HMMER2GO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hmmer2:v2.3.2-13-deb_cv1
stdout: hmmer2_hmmer2go.out
