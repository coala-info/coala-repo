cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqpuri_trimFilter
label: fastqpuri_trimFilter
doc: "A tool for trimming and filtering FASTQ files. (Note: The provided text contains
  container runtime error messages and does not include the actual help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r43h9d449c0_8
stdout: fastqpuri_trimFilter.out
