cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapless.py
  - split
label: gapless_split
doc: "Splits scaffolds into contigs.\n\nTool homepage: https://github.com/schmeing/gapless"
inputs:
  - id: assembly
    type: File
    doc: "Assembly in FASTA format ({assembly}.fa)"
    inputBinding:
      position: 2
  - id: min_n
    type:
      - 'null'
      - int
    doc: "Minimum number of N's to split at that position (1)"
    inputBinding:
      position: 1
      prefix: --minN
  - id: output
    type:
      - 'null'
      - string
    doc: "File to which the split sequences should be written to ({assembly}_split.fa)"
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: split_assembly
    type: File
    doc: Assembly split into contigs
    outputBinding:
      glob: '${ return inputs.output ? inputs.output : inputs.assembly.nameroot + "_split.fa"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
