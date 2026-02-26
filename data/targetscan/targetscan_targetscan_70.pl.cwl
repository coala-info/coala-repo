cwlVersion: v1.2
class: CommandLineTool
baseCommand: targetscan_targetscan_70.pl
label: targetscan_targetscan_70.pl
doc: "Search for predicted miRNA targets using the modified TargetScanS algorithm.\n\
  \nTool homepage: https://www.targetscan.org/vert_80/"
inputs:
  - id: miRNA_file
    type: File
    doc: miRNA families by species
    inputBinding:
      position: 1
  - id: UTR_file
    type: File
    doc: Aligned UTRs
    inputBinding:
      position: 2
outputs:
  - id: predicted_targets_output_file
    type: File
    doc: Lists sites using alignment coordinates (MSA and UTR)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/targetscan:7.0--pl5321hdfd78af_0
