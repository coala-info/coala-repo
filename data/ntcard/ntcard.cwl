cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntCard
label: ntcard
doc: "Estimates k-mer coverage histogram in FILE(S).\n\nTool homepage: https://github.com/bcgsc/ntCard"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file(s) in fastq, fasta, sam, bam format. Compressed formats gz, 
      bz, zip, xz are also acceptable. A list of files containing file names in 
      each row can be passed with @ prefix.
    inputBinding:
      position: 1
  - id: gap_length
    type:
      - 'null'
      - int
    doc: the length of gap in the gap seed [0]. g mod 2 must equal k mod 2 
      unless g == 0. -g does not support multiple k currently.
    default: 0
    inputBinding:
      position: 102
      prefix: --gap
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: the length of kmer
    inputBinding:
      position: 102
      prefix: --kmer
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: the maximum coverage of kmer in output [1000]
    default: 1000
    inputBinding:
      position: 102
      prefix: --cov
  - id: output_file
    type:
      - 'null'
      - string
    doc: the name for output file name (used when output should be a single 
      file)
    inputBinding:
      position: 102
      prefix: --output
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: the prefix for output file name(s)
    inputBinding:
      position: 102
      prefix: --pref
  - id: threads
    type:
      - 'null'
      - int
    doc: use N parallel threads [1] (N>=2 should be used when input files are 
      >=2)
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntcard:1.2.2--pl5321h077b44d_7
stdout: ntcard.out
