cwlVersion: v1.2
class: CommandLineTool
baseCommand: athena_meta
label: athena_meta
doc: "Athena is a de novo assembler designed for meta-genomics data. (Note: The provided
  text contains system error logs regarding container execution and does not include
  usage instructions or argument definitions.)\n\nTool homepage: https://github.com/abishara/athena_meta/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/athena_meta:1.3--py27_0
stdout: athena_meta.out
