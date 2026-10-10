cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf_checkThread
label: multiz_maf_checkThread
doc: "maf_checkThread: check the threading condition of an alignment for its first sequence. Usage: maf_checkThread maf-file. The error count goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: maf_file
    type: File
    doc: MAF file to check
    inputBinding:
      position: 1
outputs:
  - id: report
    type: stdout
    doc: Threading report (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: maf_checkThread.txt
