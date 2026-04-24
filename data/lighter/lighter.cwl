cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./lighter
label: lighter
doc: "OPTIONS:\n\nTool homepage: https://github.com/mourisl/Lighter"
inputs:
  - id: allow_trimming
    type:
      - 'null'
      - boolean
    doc: allow trimming
    inputBinding:
      position: 101
      prefix: -trim
  - id: alpha
    type: float
    doc: 'kmer_length genome_size alpha: (see README for information on setting alpha)'
    inputBinding:
      position: 101
      prefix: -k
  - id: discard_unfixable
    type:
      - 'null'
      - boolean
    doc: discard unfixable reads. Will LOSE paired-end matching when discarding
    inputBinding:
      position: 101
      prefix: -discard
  - id: genome_size_k
    type: string
    doc: 'kmer_length genome_size alpha: (see README for information on setting alpha)'
    inputBinding:
      position: 101
      prefix: -k
  - id: genome_size_kmer
    type: string
    doc: 'kmer_length genom_size: in this case, the genome size should be relative
      accurate.'
    inputBinding:
      position: 101
      prefix: -K
  - id: ignore_quality_score
    type:
      - 'null'
      - boolean
    doc: ignore the quality socre
    inputBinding:
      position: 101
      prefix: -noQual
  - id: kmer_length
    type: int
    doc: 'kmer_length genome_size alpha: (see README for information on setting alpha)'
    inputBinding:
      position: 101
      prefix: -k
  - id: kmer_length_kmer
    type: int
    doc: 'kmer_length genom_size: in this case, the genome size should be relative
      accurate.'
    inputBinding:
      position: 101
      prefix: -K
  - id: load_trusted_kmers_file
    type:
      - 'null'
      - File
    doc: directly get solid kmers from specified file
    inputBinding:
      position: 101
      prefix: -loadTrustedKmers
  - id: max_corrections_window
    type:
      - 'null'
      - int
    doc: the maximum number of corrections within a 20bp window
    inputBinding:
      position: 101
      prefix: -maxcor
  - id: new_quality_score
    type:
      - 'null'
      - string
    doc: set the quality for the bases corrected to the specified score
    inputBinding:
      position: 101
      prefix: -newQual
  - id: num_of_threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output_file_directory
    inputBinding:
      position: 101
      prefix: -od
  - id: save_trusted_kmers_file
    type:
      - 'null'
      - File
    doc: save the trusted kmers to specified file then stop
    inputBinding:
      position: 101
      prefix: -saveTrustedKmers
  - id: seq_files
    type:
      type: array
      items: File
    doc: "path to the sequence file. Can use multiple -r to specifiy multiple sequence
      files\nThe file can be fasta and fastq, and can be gzip'ed with extension *.gz.\n\
      When the input file is *.gz, the corresponding output file will also be gzip'ed."
    inputBinding:
      position: 101
      prefix: -r
  - id: zlib_compress_level
    type:
      - 'null'
      - int
    doc: set the compression level(0-9) of gzip
    inputBinding:
      position: 101
      prefix: -zlib
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lighter:1.1.3--h077b44d_2
stdout: lighter.out
