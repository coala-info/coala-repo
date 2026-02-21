cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparc
label: sparc
doc: "Sparc is a sparsity-based consensus algorithm for long reads. (Note: The provided
  text is an error log and does not contain usage information or argument descriptions.)\n
  \nTool homepage: https://github.com/unicorn-engine/unicorn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparc:20160205--h077b44d_13
stdout: sparc.out
