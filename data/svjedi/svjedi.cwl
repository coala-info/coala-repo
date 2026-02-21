cwlVersion: v1.2
class: CommandLineTool
baseCommand: svjedi
label: svjedi
doc: "Structural Variant Joint Estimation of DIstributions (Note: The provided text
  contains container execution logs rather than help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/llecompte/SVJedi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svjedi:1.1.6--hdfd78af_1
stdout: svjedi.out
