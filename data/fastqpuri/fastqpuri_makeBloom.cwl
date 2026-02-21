cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqpuri_makeBloom
label: fastqpuri_makeBloom
doc: "A tool for creating Bloom filters as part of the FastqPuri suite. (Note: The
  provided help text contains container runtime error messages and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r43h9d449c0_8
stdout: fastqpuri_makeBloom.out
