cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sshash
  - permute
label: sshash_permute
doc: "Permute a weighted collection of unitigs so that the number of runs in the
  weights is minimized, and write the permuted collection to a file.\n\nTool homepage:
  https://github.com/jermp/sshash"
inputs:
  - id: input_filename
    type: File
    doc: "REQUIRED: FASTA file (.fa/fasta extension), gzip-compressed or not, without
      duplicate nor invalid k-mers, with one DNA sequence per line and with the k-mers'
      weights (for example a de Bruijn graph from BCALM)."
    inputBinding:
      position: 101
      prefix: -i
  - id: k
    type: int
    doc: 'REQUIRED: K-mer length (must be <= 31).'
    inputBinding:
      position: 101
      prefix: -k
  - id: tmp_dirname
    type:
      - 'null'
      - string
    doc: Temporary directory used for merging in external memory. Default is 
      directory '.'.
    inputBinding:
      position: 101
      prefix: -d
  - id: output_filename
    type: string
    doc: Output file where the permuted collection will be written.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: permuted
    type:
      - 'null'
      - File
    doc: Permuted collection
    outputBinding:
      glob: $(inputs.output_filename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
stdout: sshash_permute.out
