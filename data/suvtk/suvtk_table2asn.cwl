cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suvtk
  - table2asn
label: suvtk_table2asn
doc: "This command generates a .sqn file that you can send to gb-sub@ncbi.nlm.nih.gov\n\
  \nTool homepage: https://github.com/LanderDC/suvtk"
inputs:
  - id: comments_file
    type: File
    doc: Structured comment file (.cmt) with MIUVIG information
    inputBinding:
      position: 101
      prefix: --comments
  - id: features_file
    type: File
    doc: Feature table file (.tbl)
    inputBinding:
      position: 101
      prefix: --features
  - id: input_file
    type: File
    doc: Input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: src_file
    type: File
    doc: File with Source modifiers (.src)
    inputBinding:
      position: 101
      prefix: --src-file
  - id: template_file
    type: File
    doc: Template file with author information (.sbt). See 
      https://submit.ncbi.nlm.nih.gov/genbank/template/submission/
    inputBinding:
      position: 101
      prefix: --template
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
stdout: suvtk_table2asn.out
