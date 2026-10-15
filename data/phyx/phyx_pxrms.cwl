cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxrms]
label: phyx_pxrms
doc: |-
  Remove sequences by label.
  This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
  Results are written in fasta format.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input sequence file"
    inputBinding:
      prefix: -s
  - id: names
    type: ['null', string]
    doc: "names sep by commas (NO SPACES!)"
    inputBinding:
      prefix: -n
  - id: names_file
    type: ['null', File]
    doc: "names in a file (each on a line)"
    inputBinding:
      prefix: -f
  - id: regex
    type: ['null', string]
    doc: "match tip labels by a regular expression"
    inputBinding:
      prefix: -r
  - id: comp
    type: ['null', boolean]
    doc: "take the complement (i.e. remove any taxa not in list)"
    inputBinding:
      prefix: -c
  - id: out_file_path
    type: string
    doc: "output sequence file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "remaining sequences (fasta)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
