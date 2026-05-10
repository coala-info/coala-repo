cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasclass_train.py
label: plasclass_train.py
doc: "Train the PlasClass classifier using plasmid and chromosome sequences.\n\nTool
  homepage: https://github.com/Shamir-Lab/PlasClass"
inputs:
  - id: chromosome_fasta
    type: File
    doc: Fasta file of chromosome sequences
    inputBinding:
      position: 101
      prefix: -c
  - id: plasmid_fasta
    type: File
    doc: Fasta file of plasmid sequences
    inputBinding:
      position: 101
      prefix: -p
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for the output model files
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasclass:0.1.1--pyhdfd78af_0
