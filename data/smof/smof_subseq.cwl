cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_subseq
label: smof_subseq
doc: "Extract subsequences from FASTA files, optionally with reverse complement, GFF
  input, or coloring.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Append the subsequence interval to the defline
    inputBinding:
      position: 102
      prefix: --annotate
  - id: color
    type:
      - 'null'
      - string
    doc: Color subsequence (do not extract)
    inputBinding:
      position: 102
      prefix: --color
  - id: force_color
    type:
      - 'null'
      - boolean
    doc: Print in color even to non-tty (DANGEROUS)
    inputBinding:
      position: 102
      prefix: --force-color
  - id: gff_file
    type:
      - 'null'
      - File
    doc: Get bounds from this gff3 file
    inputBinding:
      position: 102
      prefix: --gff
  - id: keep_no_matches
    type:
      - 'null'
      - boolean
    doc: With --gff, keep sequences with no matches
    inputBinding:
      position: 102
      prefix: --keep
  - id: start
    type:
      - 'null'
      - int
    doc: Start position (indexed from 1)
    inputBinding:
      position: 102
      prefix: --bounds
  - id: stop
    type:
      - 'null'
      - int
    doc: Stop position (indexed from 1)
    inputBinding:
      position: 102
      prefix: --bounds
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_subseq.out
