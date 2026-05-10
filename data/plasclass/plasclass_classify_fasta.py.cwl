cwlVersion: v1.2
class: CommandLineTool
baseCommand: classify_fasta.py
label: plasclass_classify_fasta.py
doc: "Classify fasta sequences as plasmid or chromosomal.\n\nTool homepage: https://github.com/Shamir-Lab/PlasClass"
inputs:
  - id: fasta
    type: File
    doc: fasta file with sequences to be classified
    inputBinding:
      position: 101
      prefix: --fasta
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 102
      prefix: --outfile
  - id: probs_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `probs_path`
    inputBinding:
      position: 103
      prefix: --probs
outputs:
  - id: outfile
    type: File
    doc: output file name
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: probs
    type:
      - 'null'
      - File
    doc: output file for probabilities
    outputBinding:
      glob: $(inputs.probs_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasclass:0.1.1--pyhdfd78af_0
