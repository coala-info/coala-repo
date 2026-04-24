cwlVersion: v1.2
class: CommandLineTool
baseCommand: quorum
label: quorum
doc: "Run the quorum error corrector on the given fastq file. If the --paired-files
  switch is given, quorum expect an even number of files on the command line, each
  pair files containing pair end reads. The output will be two files (<prefix>_1.fa
  and <prefix>_2.fa) containing error corrected pair end reads.\n\nTool homepage:
  https://github.com/Consensys/quorum"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: Input fastq file(s)
    inputBinding:
      position: 1
  - id: anchor
    type:
      - 'null'
      - int
    doc: Numer of good kmer in a row for anchor
    inputBinding:
      position: 102
  - id: anchor_count
    type:
      - 'null'
      - int
    doc: Minimum count for an anchor kmer
    inputBinding:
      position: 102
  - id: contaminant
    type:
      - 'null'
      - File
    doc: Contaminant sequences
    inputBinding:
      position: 102
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Display debugging information
    inputBinding:
      position: 102
      prefix: --debug
  - id: error
    type:
      - 'null'
      - int
    doc: Maximum number of errors in a window
    inputBinding:
      position: 102
      prefix: --error
  - id: homo_trim
    type:
      - 'null'
      - boolean
    doc: Trim homo-polymer on 3' end
    inputBinding:
      position: 102
      prefix: --homo-trim
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: Kmer length
    inputBinding:
      position: 102
      prefix: --kmer-len
  - id: mer_database_size
    type:
      - 'null'
      - string
    doc: Mer database size
    inputBinding:
      position: 102
      prefix: --size
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum count for a k-mer to be good
    inputBinding:
      position: 102
  - id: min_q_char
    type:
      - 'null'
      - string
    doc: Minimum quality char. Usually 33 or 64 (autodetect)
    inputBinding:
      position: 102
      prefix: --min-q-char
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum above -q for high quality base
    inputBinding:
      position: 102
      prefix: --min-quality
  - id: no_discard
    type:
      - 'null'
      - boolean
    doc: Do not discard reads, output a single N
    inputBinding:
      position: 102
      prefix: --no-discard
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: paired_files
    type:
      - 'null'
      - boolean
    doc: Preserve mate pairs in two files
    inputBinding:
      position: 102
      prefix: --paired-files
  - id: skip
    type:
      - 'null'
      - int
    doc: Number of bases to skip to find anchor kmer
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_contaminant
    type:
      - 'null'
      - boolean
    doc: Trim sequences with contaminant mers
    inputBinding:
      position: 102
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for trimming
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/quorum:v1.1.1-2-deb_cv1
stdout: quorum.out
