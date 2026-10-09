cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_extract_splice_sites.py
label: hisat2_extract_splice_sites.py
doc: "Extract splice junctions from a GTF file\n\nTool homepage: https://daehwankimlab.github.io/hisat2"
inputs:
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: input GTF file (use "-" for stdin)
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: also print some statistics to stderr
    inputBinding:
      position: 0
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Splice sites (chromosome, start, end, strand)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
stdout: hisat2_extract_splice_sites.py.out
