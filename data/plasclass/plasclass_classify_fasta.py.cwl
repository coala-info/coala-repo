cwlVersion: v1.2
class: CommandLineTool
baseCommand: classify_fasta.py
label: plasclass_classify_fasta.py
doc: "Classify fasta sequences as plasmid or chromosomal.\n\nTool homepage: https://github.com/Shamir-Lab/PlasClass"
inputs:
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use (default 8)
    inputBinding:
      position: 101
      prefix: --num_processes
  - id: fasta
    type: File
    doc: fasta file with sequences to be classified
    inputBinding:
      position: 101
      prefix: --fasta
  - id: outfile_path
    type: string
    doc: output file prefix (the classification table is written to this file)
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type: File
    doc: classification table with one row per sequence and its plasmid probability
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasclass:0.1.1--pyhdfd78af_0
