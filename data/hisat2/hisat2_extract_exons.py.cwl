cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_extract_exons.py
label: hisat2_extract_exons.py
doc: Extract exons from a GTF file
inputs:
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: input GTF file (use "-" for stdin)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
stdout: hisat2_extract_exons.py.out
s:url: https://daehwankimlab.github.io/hisat2
$namespaces:
  s: https://schema.org/
