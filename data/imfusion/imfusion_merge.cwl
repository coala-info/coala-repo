cwlVersion: v1.2
class: CommandLineTool
baseCommand: imfusion-merge
label: imfusion_merge
doc: "Merges multiple samples into a single imfusion object.\n\nTool homepage: https://github.com/iamsh4shank/Imfusion"
inputs:
  - id: sample_dirs
    type:
      type: array
      items: Directory
    doc: Directories containing the samples to merge.
    inputBinding:
      position: 1
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional list of names to assign to each sample. If not provided, 
      sample directory names will be used.
    inputBinding:
      position: 102
      prefix: --names
  - id: output_expression
    type:
      - 'null'
      - string
    doc: Optional expression to define the structure of the output imfusion 
      object. See imfusion documentation for details.
    inputBinding:
      position: 102
      prefix: --output_expression
outputs:
  - id: output
    type: Directory
    doc: Path to the output directory where the merged imfusion object will be 
      saved.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
