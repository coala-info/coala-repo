cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - bintest
label: cnvkit_bintest
doc: "Test for single-bin copy number alterations.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: cnarray
    type: File
    doc: "Bin-level log2 ratios (.cnr file), as produced by 'fix'."
    inputBinding:
      position: 1
  - id: segment
    type:
      - 'null'
      - File
    doc: "Segmentation calls (.cns), the output of the 'segment' command)."
    inputBinding:
      position: 101
      prefix: --segment
  - id: alpha
    type:
      - 'null'
      - float
    doc: "Significance threhold. [Default: 0.005]"
    inputBinding:
      position: 101
      prefix: --alpha
  - id: target
    type:
      - 'null'
      - boolean
    doc: "Test target bins only; ignore off-target bins."
    inputBinding:
      position: 101
      prefix: --target
  - id: output
    type: string
    doc: "Output filename."
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output filename."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
