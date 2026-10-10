cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtm-align
label: mtm-align
doc: "An algorithm for multiple protein structure alignment (MSTA)\n\nTool homepage: http://yanglab.nankai.edu.cn/mTM-align/help/"
inputs:
  - id: input_list
    type: File
    doc: "File listing the file names of the structures to be aligned, one per line. Each input structure must be a single-chain structure."
    inputBinding:
      prefix: -i
  - id: structures
    type: File[]
    doc: Structure files named in the input list (staged in the working directory)
  - id: output_filename
    type:
      - 'null'
      - string
    doc: "The name of the file to save the superimposed structures (default: result.pdb)"
    inputBinding:
      prefix: -o
  - id: output_directory
    type: string
    default: mTM_result
    doc: "The output directory to save the results (default: ./mTM_result)"
    inputBinding:
      prefix: -outdir
outputs:
  - id: results
    type: Directory
    doc: Output directory with the superimposed structures and the alignment results
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.structures)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtm-align:20220104--h9948957_3
