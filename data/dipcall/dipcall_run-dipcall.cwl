cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-dipcall
label: dipcall_run-dipcall
doc: "A variant calling pipeline for diploid genomes (Note: The provided help text
  contains only system error messages and no argument definitions).\n\nTool homepage:
  https://github.com/lh3/dipcall"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipcall:0.3--hdfd78af_0
stdout: dipcall_run-dipcall.out
