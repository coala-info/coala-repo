cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa-assembly
label: jaffa_jaffa-assembly
doc: "JAFFA is a tool for detecting gene fusions from RNA-Seq data.\n\nTool homepage:
  https://github.com/Oshlack/JAFFA"
inputs:
  - id: hg38_genCode22_fa
    type: File
    doc: Path to the hg38_genCode22.fa file
    inputBinding:
      position: 1
  - id: hg38_genCode22_tab
    type: File
    doc: Path to the hg38_genCode22.tab file
    inputBinding:
      position: 2
  - id: known_fusions_txt
    type: File
    doc: Path to the known_fusions.txt file
    inputBinding:
      position: 3
  - id: hg38_fa
    type: File
    doc: Path to the hg38.fa file
    inputBinding:
      position: 4
  - id: masked_hg38_1_bt2
    type: File
    doc: Path to the Masked_hg38.1.bt2 file
    inputBinding:
      position: 5
  - id: hg38_genCode22_1_bt2
    type: File
    doc: Path to the hg38_genCode22.1.bt2 file
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa_jaffa-assembly.out
