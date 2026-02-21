cwlVersion: v1.2
class: CommandLineTool
baseCommand: indelfixer_sff2fastq
label: indelfixer_sff2fastq
doc: "A tool for converting SFF files to FASTQ format (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/cbg-ethz/InDelFixer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/indelfixer:1.1--0
stdout: indelfixer_sff2fastq.out
