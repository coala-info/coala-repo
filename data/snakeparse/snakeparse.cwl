cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakeparse
label: snakeparse
doc: "A tool for parsing Snakemake files (Note: The provided text appears to be a
  container build log rather than help text; no arguments could be extracted).\n\n
  Tool homepage: https://github.com/nh13/snakeparse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakeparse:0.1.0--py36_1
stdout: snakeparse.out
