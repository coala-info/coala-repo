cwlVersion: v1.2
class: CommandLineTool
baseCommand: est-sfs
label: est-sfs
doc: "Estimate site frequency spectrum\n\nTool homepage: https://sourceforge.net/projects/est-usfs/"
inputs:
  - id: config_file_name
    type: File
    doc: Configuration file name
    inputBinding:
      position: 1
  - id: input_file_name
    type: File
    doc: Input file name
    inputBinding:
      position: 2
  - id: seedfile_name
    type: File
    doc: Seed file name
    inputBinding:
      position: 3
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Optional verbose output flag
    inputBinding:
      position: 4
outputs:
  - id: output_file_sfs
    type: File
    doc: Output SFS file name
    outputBinding:
      glob: '*.out'
  - id: output_file_p_anc
    type: File
    doc: Output P(anc) file name
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/est-sfs:2.04--h985cbd6_1
