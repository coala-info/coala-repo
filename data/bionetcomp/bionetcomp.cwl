cwlVersion: v1.2
class: CommandLineTool
baseCommand: bionetcomp
label: bionetcomp
doc: "A tool for biological network comparison using gene lists and STRING database
  interactions.\n\nTool homepage: https://github.com/lmigueel/bionetcomp/"
inputs:
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR cutoff for enrichment analysis
    inputBinding:
      position: 101
      prefix: --fdr
  - id: in1
    type: File
    doc: File containing a first gene list.
    inputBinding:
      position: 101
      prefix: --in1
  - id: in2
    type: File
    doc: File containing a second gene list.
    inputBinding:
      position: 101
      prefix: --in2
  - id: taxid
    type: string
    doc: 'STRING taxonomy ID. Ex: 9606'
    inputBinding:
      position: 101
      prefix: --taxid
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for STRING interaction score
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_folder
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bionetcomp:1.1--pyhfa5458b_0
