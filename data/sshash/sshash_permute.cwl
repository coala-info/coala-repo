cwlVersion: v1.2
class: CommandLineTool
baseCommand: sshash permute
label: sshash_permute
doc: "Permute the order of sequences in a FASTA file.\n\nTool homepage: https://github.com/jermp/sshash"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 1
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for permutation. If not specified, a random seed is used.
    inputBinding:
      position: 102
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Defaults to 1.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file. If not specified, output to stdout.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
