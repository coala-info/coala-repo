cwlVersion: v1.2
class: CommandLineTool
baseCommand: telescoper
label: telescoper
doc: "A tool for telomere assembly and analysis (Note: The provided text contains
  system logs and error messages rather than help documentation; no arguments could
  be extracted).\n\nTool homepage: https://github.com/Stellarium/stellarium"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/telescoper:v1.0.0_cv3
stdout: telescoper.out
