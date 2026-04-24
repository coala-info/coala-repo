cwlVersion: v1.2
class: CommandLineTool
baseCommand: sshash_build
label: sshash_build
doc: "Build a shash index from a FASTA file.\n\nTool homepage: https://github.com/jermp/sshash"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mers to use.
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length to consider.
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum sequence length to consider.
    inputBinding:
      position: 102
      prefix: --min-len
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_shash
    type:
      - 'null'
      - File
    doc: Output shash file.
    outputBinding:
      glob: $(inputs.output_shash)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
