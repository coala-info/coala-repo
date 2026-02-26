cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_to_perfect_reads
label: fastaq_to_perfect_reads
doc: "Makes perfect paired end fastq reads from a sequence file, with insert sizes
  sampled from a normal distribution. Read orientation is innies. Output is an interleaved
  FASTQ file.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: mean_insert_size
    type: float
    doc: Mean insert size of read pairs
    inputBinding:
      position: 2
  - id: insert_std_deviation
    type: float
    doc: Standard devation of insert size
    inputBinding:
      position: 3
  - id: mean_coverage
    type: float
    doc: Mean coverage of the reads
    inputBinding:
      position: 4
  - id: read_length
    type: int
    doc: Length of each read
    inputBinding:
      position: 5
  - id: no_n
    type:
      - 'null'
      - boolean
    doc: Don't allow any N or n characters in the reads
    inputBinding:
      position: 106
      prefix: --no_n
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator. Default is to use python's default
    default: python's default
    inputBinding:
      position: 106
      prefix: --seed
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
  - id: fragments_filename
    type:
      - 'null'
      - File
    doc: Write FASTA sequences of fragments (i.e. read pairs plus sequences in 
      between them) to the given filename
    outputBinding:
      glob: $(inputs.fragments_filename)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
