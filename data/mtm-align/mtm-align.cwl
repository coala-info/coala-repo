cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtm-align
label: mtm-align
doc: "An algorithm for multiple protein structure alignment (MSTA)\n\nTool homepage:
  http://yanglab.nankai.edu.cn/mTM-align/help/"
inputs:
  - id: input_list
    type: File
    doc: "The input_list is an input file, listing the file names of the structures
      to be aligned.\n                   Each line represents the file name for one
      structure.\n                   Please note that each input structure should
      be a single-chain structure."
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: "The name of the file to save the superimposed structures. The default is
      'result.pdb'\n                   When the number of input structures is >61,
      the superimposed structures will be separated by 'MODEL'\n                 \
      \  Otherwise, the structures are speparated using the chain IDs: A,B,C,..."
    outputBinding:
      glob: $(inputs.output_filename)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The output directory to save the results (the default is 
      './mTM_result')
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtm-align:20220104--h9948957_3
