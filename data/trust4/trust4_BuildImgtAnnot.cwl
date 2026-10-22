cwlVersion: v1.2
class: CommandLineTool
baseCommand: BuildImgtAnnot.pl
label: trust4_BuildImgtAnnot
doc: "Download the IMGT reference sequences and write the V/D/J/C gene reference for one species in the TRUST4 --ref format (standard output). Needs internet access.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: species
    type: string
    doc: "species name, for example Homo_sapiens"
    inputBinding:
      position: 1
outputs:
  - id: imgt_reference
    type: stdout
    doc: "IMGT gene reference fasta (standard output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: imgt_reference.fa
