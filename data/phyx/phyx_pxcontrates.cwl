cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxcontrates]
label: phyx_pxcontrates
doc: |-
  Continuous character rate estimation with Brownian and OU.
  This will take fasta, phylip, and nexus formats from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: char_file
    type: File
    doc: "input character file"
    inputBinding:
      prefix: -c
  - id: tree_file
    type: File
    doc: "input tree file"
    inputBinding:
      prefix: -t
  - id: analysis
    type: ['null', int]
    doc: "analysis type (0=anc[DEFAULT], 1=ratetest)"
    inputBinding:
      prefix: -a
  - id: out_file_path
    type: ['null', string]
    doc: "output sequence file, STOUT otherwise"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: ['null', File]
    doc: "output file (the tool writes its results to standard output, so this file stays empty)"
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: stdout_text
    type: stdout
    doc: "rate and ancestral state estimates (standard output)"
stdout: pxcontrates.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
