cwlVersion: v1.2
class: CommandLineTool
baseCommand: lav2maf
label: multiz_lav2maf
doc: "lav2maf: convert blastz (LAV) output to a MAF file. Usage: lav2maf blastz.output seq-file1 seq-file2. The MAF goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: blastz_output
    type: File
    doc: Blastz output file (LAV)
    inputBinding:
      position: 1
  - id: seq_file1
    type: File
    doc: First sequence file
    inputBinding:
      position: 2
  - id: seq_file2
    type: File
    doc: Second sequence file
    inputBinding:
      position: 3
outputs:
  - id: maf
    type: stdout
    doc: MAF alignment (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: lav2maf.maf
