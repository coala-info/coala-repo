cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - mask
label: yame_mask
doc: "Masking tool for CG files\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cg_file
    type: File
    doc: Input CG file
    inputBinding:
      position: 1
  - id: mask_cx_file
    type: File
    doc: Mask CX file
    inputBinding:
      position: 2
  - id: contextualize
    type:
      - 'null'
      - boolean
    doc: contextualize to format 6 using '1's in mask. if format 3 is used as 
      mask, then use M+U>0 (coverage).
    inputBinding:
      position: 103
      prefix: -c
  - id: reverse_mask
    type:
      - 'null'
      - boolean
    doc: reverse the mask (default is to mask '1's, if -v will mask '0's).
    inputBinding:
      position: 103
      prefix: -v
  - id: output_cx_file_path
    type: string
    doc: Output or path parameter `output_cx_file_path`
    inputBinding:
      position: 104
      prefix: --output-cx-file
outputs:
  - id: output_cx_file
    type:
      - 'null'
      - File
    doc: output cx file name. if missing, output to stdout without index.
    outputBinding:
      glob: $(inputs.output_cx_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
