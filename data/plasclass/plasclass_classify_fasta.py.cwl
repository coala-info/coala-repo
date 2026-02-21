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
outputs:
  - id: outfile
    type: File
    doc: output file name
    outputBinding:
      glob: $(inputs.outfile)
  - id: probs
    type:
      - 'null'
      - File
    doc: output file for probabilities
    outputBinding:
      glob: $(inputs.probs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasclass:0.1.1--pyhdfd78af_0
