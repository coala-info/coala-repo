cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_extract_exons.py
label: hisat2_hisat2_extract_exons.py
doc: "Extracts exons from a GTF file for use with HISAT2 index building.\n\nTool homepage:
  http://daehwankimlab.github.io/hisat2"
inputs:
  - id: gtf_file
    type: File
    doc: Input gene annotation file in GTF format
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
stdout: hisat2_hisat2_extract_exons.py.out
