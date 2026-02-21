cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_quality_converter
label: fastx-toolkit_fastq_quality_converter
doc: "The provided text contains a system error message (out of disk space during
  container image extraction) rather than the tool's help text. Based on the tool
  name hint, this tool is part of the FASTX-Toolkit and is used to convert FASTQ quality
  scores (e.g., between Phred+33 and Phred+64) or compress output.\n\nTool homepage:
  https://github.com/agordon/fastx_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
stdout: fastx-toolkit_fastq_quality_converter.out
