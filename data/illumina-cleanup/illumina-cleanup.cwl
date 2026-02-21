cwlVersion: v1.2
class: CommandLineTool
baseCommand: illumina-cleanup
label: illumina-cleanup
doc: "A tool for Illumina data cleanup. (Note: The provided text contains container
  runtime error messages and does not include usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/rpetit3/illumina-cleanup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-cleanup:1.0.0--0
stdout: illumina-cleanup.out
