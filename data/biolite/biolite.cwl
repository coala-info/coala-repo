cwlVersion: v1.2
class: CommandLineTool
baseCommand: biolite
label: biolite
doc: "A tool for lightweight bioinformatics processing (Note: The provided text contains
  system error messages regarding disk space and container image conversion rather
  than tool help documentation).\n\nTool homepage: https://bitbucket.org/caseywdunn/biolite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biolite:1.2.0--py27_0
stdout: biolite.out
