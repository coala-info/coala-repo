cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqpuri_trimFilterPE
label: fastqpuri_trimFilterPE
doc: "A tool for trimming and filtering paired-end FASTQ files. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list usage or arguments.)\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r43h9d449c0_8
stdout: fastqpuri_trimFilterPE.out
