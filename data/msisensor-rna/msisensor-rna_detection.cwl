cwlVersion: v1.2
class: CommandLineTool
baseCommand: msisensor-rna detection
label: msisensor-rna_detection
doc: "Microsatellite instability detection.\n\nTool homepage: https://github.com/xjtu-omics/msisensor-rna"
inputs:
  - id: input
    type: File
    doc: The path of input file.
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type: File
    doc: The path of the microsatellite regions.
    inputBinding:
      position: 101
      prefix: --model
  - id: run_directly
    type:
      - 'null'
      - boolean
    doc: Run the program directly without any Confirm.
    inputBinding:
      position: 101
      prefix: --run_directly
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: The path of output file prefix.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
