cwlVersion: v1.2
class: CommandLineTool
baseCommand: BuildImgtVquestAnnot.pl
label: trust4_BuildImgtVquestAnnot
doc: "Download the IMGT V-QUEST reference directory for one species and write the gene reference in the TRUST4 --ref format (standard output). Needs internet access.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: bcrtcr_fasta
    type: File
    doc: "receptor gene coordinate fasta (for example hg38_bcrtcr.fa)"
    inputBinding:
      position: 1
  - id: cgene_list
    type: File
    doc: "list of C gene names (for example Cgene.list)"
    inputBinding:
      position: 2
  - id: species
    type: string
    doc: "species name, for example Homo_sapiens"
    inputBinding:
      position: 3
outputs:
  - id: imgt_reference
    type: stdout
    doc: "IMGT V-QUEST gene reference fasta (standard output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: imgt_vquest_reference.fa
