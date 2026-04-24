cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - sample
label: seqtk_sample
doc: "Subsample sequences from FASTA/FASTQ files\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: sample_size
    type: float
    doc: Fraction of sequences (if < 1.0) or number of sequences (if >= 1)
    inputBinding:
      position: 2
  - id: seed
    type:
      - 'null'
      - int
    doc: RNG seed
    inputBinding:
      position: 103
      prefix: -s
  - id: two_pass_mode
    type:
      - 'null'
      - boolean
    doc: '2-pass mode: twice as slow but with much reduced memory'
    inputBinding:
      position: 103
      prefix: '-2'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_sample.out
