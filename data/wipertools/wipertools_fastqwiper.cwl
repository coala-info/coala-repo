cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wipertools
  - fastqwiper
label: wipertools_fastqwiper
doc: "A tool for cleaning and wiping FASTQ files. (Note: The provided help text contained
  container build error logs rather than CLI usage information.)\n\nTool homepage:
  https://github.com/mazzalab/fastqwiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
stdout: wipertools_fastqwiper.out
