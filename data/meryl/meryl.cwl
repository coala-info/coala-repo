cwlVersion: v1.2
class: CommandLineTool
baseCommand: meryl
label: meryl
doc: "A tool for counting and manipulating k-mer sets (Note: The provided text contains
  environment logs and a fatal error rather than CLI help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/marbl/meryl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2
stdout: meryl.out
