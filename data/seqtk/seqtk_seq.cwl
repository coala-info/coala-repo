cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - seq
label: seqtk_seq
doc: "Common transformation of FASTA/FASTQ sequences, including masking, partitioning,
  and format conversion.\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: drop_ambiguous
    type:
      - 'null'
      - boolean
    doc: drop sequences containing ambiguous bases
    inputBinding:
      position: 102
      prefix: -N
  - id: drop_comments
    type:
      - 'null'
      - boolean
    doc: drop comments at the header lines
    inputBinding:
      position: 102
      prefix: -C
  - id: force_fasta
    type:
      - 'null'
      - boolean
    doc: force FASTA output (discard quality)
    inputBinding:
      position: 102
      prefix: -A
  - id: line_length
    type:
      - 'null'
      - int
    doc: number of residues per line
    inputBinding:
      position: 102
      prefix: -l
  - id: mask_char
    type:
      - 'null'
      - string
    doc: masked bases converted to CHAR
    inputBinding:
      position: 102
      prefix: -n
  - id: mask_complement
    type:
      - 'null'
      - boolean
    doc: mask complement region (effective with -M)
    inputBinding:
      position: 102
      prefix: -c
  - id: mask_high_qual
    type:
      - 'null'
      - int
    doc: mask bases with quality higher than INT
    inputBinding:
      position: 102
      prefix: -X
  - id: mask_low_qual
    type:
      - 'null'
      - int
    doc: mask bases with quality lower than INT
    inputBinding:
      position: 102
      prefix: -q
  - id: mask_regions
    type:
      - 'null'
      - File
    doc: mask regions in BED or name list FILE
    inputBinding:
      position: 102
      prefix: -M
  - id: min_len
    type:
      - 'null'
      - int
    doc: drop sequences with length shorter than INT
    inputBinding:
      position: 102
      prefix: -L
  - id: output_first_read
    type:
      - 'null'
      - boolean
    doc: output the 2n-1 reads only
    inputBinding:
      position: 102
      prefix: '-1'
  - id: output_second_read
    type:
      - 'null'
      - boolean
    doc: output the 2n reads only
    inputBinding:
      position: 102
      prefix: '-2'
  - id: quality_shift
    type:
      - 'null'
      - int
    doc: 'quality shift: ASCII-INT'
    inputBinding:
      position: 102
      prefix: -Q
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: reverse complement
    inputBinding:
      position: 102
      prefix: -r
  - id: sample_fraction
    type:
      - 'null'
      - float
    doc: sample fraction
    inputBinding:
      position: 102
      prefix: -f
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 102
      prefix: -s
  - id: shift_quality_v
    type:
      - 'null'
      - boolean
    doc: shift quality by '(-Q) - 33'
    inputBinding:
      position: 102
      prefix: -V
  - id: strip_spaces
    type:
      - 'null'
      - boolean
    doc: strip of white spaces in sequences
    inputBinding:
      position: 102
      prefix: -S
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: convert all bases to upper case
    inputBinding:
      position: 102
      prefix: -U
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_seq.out
