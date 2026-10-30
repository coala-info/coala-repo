cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_perfect_reads
label: pyfastaq_fastaq_to_perfect_reads
doc: "Makes perfect paired end fastq reads from a sequence file, with insert sizes sampled from a normal distribution. Read orientation is innies. Output is an interleaved FASTQ file.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: fragments
    type:
      - 'null'
      - string
    doc: "Write FASTA sequences of fragments (i.e. read pairs plus sequences in between them) to the given filename"
    inputBinding:
      position: 1
      prefix: --fragments
  - id: no_n
    type:
      - 'null'
      - boolean
    doc: "Don't allow any N or n characters in the reads"
    inputBinding:
      position: 2
      prefix: --no_n
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator. Default is to use python's default"
    inputBinding:
      position: 3
      prefix: --seed
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
  - id: mean_insert
    type: int
    doc: "Mean insert size of read pairs"
    inputBinding:
      position: 22
  - id: insert_std
    type: float
    doc: "Standard devation of insert size"
    inputBinding:
      position: 23
  - id: coverage
    type: float
    doc: "Mean coverage of the reads"
    inputBinding:
      position: 24
  - id: readlength
    type: int
    doc: "Length of each read"
    inputBinding:
      position: 25
outputs:
  - id: fragments_output
    type:
      - 'null'
      - File
    doc: "Write FASTA sequences of fragments (i.e. read pairs plus sequences in between them) to the given filename"
    outputBinding:
      glob: $(inputs.fragments)
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
