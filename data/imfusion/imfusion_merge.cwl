cwlVersion: v1.2
class: CommandLineTool
baseCommand: imfusion-merge
label: imfusion_merge
doc: "Merge insertions (and expression) of multiple IM-Fusion samples into single files.\n\nTool homepage: https://github.com/NKI-CCB/imfusion"
inputs:
  - id: sample_dirs
    type:
      type: array
      items: Directory
    doc: Path to sample directories (output of imfusion-insertions, with 
      insertions.txt and optionally expression.txt).
    inputBinding:
      position: 1
      prefix: --sample_dirs
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Alternative sample names to use for samples in merged dataset.
    inputBinding:
      position: 102
      prefix: --names
  - id: output_expression
    type:
      - 'null'
      - string
    doc: Output path for merged expression file. Needs expression.txt in 
      every sample directory.
    inputBinding:
      position: 102
      prefix: --output_expression
  - id: output_path
    type: string
    doc: Output path for merged insertion file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Merged insertion file.
    outputBinding:
      glob: $(inputs.output_path)
  - id: merged_expression
    type:
      - 'null'
      - File
    doc: Merged expression file.
    outputBinding:
      glob: $(inputs.output_expression)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
