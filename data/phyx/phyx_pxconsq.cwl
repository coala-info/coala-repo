cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxconsq]
label: phyx_pxconsq
doc: |-
  Compute a consensus sequence from an alignment.
  This will take fasta, phylip, and nexus formats from a file or STDIN.
  Results are written in fasta format.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input alignment file (fasta, phylip or nexus)"
    inputBinding:
      prefix: -s
  - id: out_file_path
    type: string
    doc: "output sequence file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "consensus sequence (fasta)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
