cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suvtk
  - gbk2tbl
label: suvtk_gbk2tbl
doc: "This script converts a GenBank file (.gbk or .gb) into a Sequin feature table
  (.tbl), which is an input file of table2asn used for creating an ASN.1 file (.sqn).\n\
  \nTool homepage: https://github.com/LanderDC/suvtk"
inputs:
  - id: input_file
    type: File
    doc: Input genbank file
    inputBinding:
      position: 101
      prefix: --input
  - id: mincontigsize
    type:
      - 'null'
      - int
    doc: The minimum contig length
    inputBinding:
      position: 101
      prefix: --mincontigsize
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix of output filenames
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
stdout: suvtk_gbk2tbl.out
