cwlVersion: v1.2
class: CommandLineTool
baseCommand: GTFupdate
label: ribocode_GTFupdate
doc: "This script is designed for preparing the appropriate GTF file from custom GTF\n\
  file (or those not from ENSEMBL/GENCODE database)\n\nTool homepage: https://github.com/xryanglab/RiboCode"
inputs:
  - id: gtf_file
    type: File
    doc: GTF file to update
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocode:1.2.15--pyhdc42f0e_1
stdout: ribocode_GTFupdate.out
