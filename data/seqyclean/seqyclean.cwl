cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqyclean
label: seqyclean
doc: 'Seqyclean: cleans Roche 454 and Illumina reads (adapter, vector, contaminant, quality, poly A/T and duplicate filtering).


  Tool homepage: https://github.com/ibest/seqyclean'
inputs:
  - id: fastq_1
    type:
      - 'null'
      - File
    doc: 'Paired-end mode: first FASTQ file (can be gzip).'
    inputBinding:
      position: 1
      prefix: '-1'
  - id: fastq_2
    type:
      - 'null'
      - File
    doc: 'Paired-end mode: second FASTQ file (can be gzip).'
    inputBinding:
      position: 2
      prefix: '-2'
  - id: single_end
    type:
      - 'null'
      - File
    doc: 'Single-end mode: FASTQ file (can be gzip).'
    inputBinding:
      position: 3
      prefix: -U
  - id: roche454
    type:
      - 'null'
      - File
    doc: 'Roche 454 mode: input SFF file.'
    inputBinding:
      position: 4
      prefix: '-454'
  - id: output_prefix_path
    type: string
    doc: Output prefix.
    inputBinding:
      position: 5
      prefix: -o
  - id: vector_file
    type:
      - 'null'
      - File
    doc: Turns on vector trimming; FASTA file with vector genomes.
    inputBinding:
      position: 6
      prefix: -v
  - id: contaminants_file
    type:
      - 'null'
      - File
    doc: Turns on contaminants screening; FASTA file with contaminant genomes.
    inputBinding:
      position: 7
      prefix: -c
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Common size of k-mer. Default 15.
    inputBinding:
      position: 8
      prefix: -k
  - id: kmer_distance
    type:
      - 'null'
      - int
    doc: Distance between consecutive k-mers. Default 1.
    inputBinding:
      position: 9
      prefix: -d
  - id: contaminant_kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mer used in sampling contaminant genome. Default 15.
    inputBinding:
      position: 10
      prefix: -kc
  - id: qual
    type:
      - 'null'
      - float[]
    doc: 'Turns on quality trimming: max_average_error and max_error_at_ends (defaults 0.01 0.01).'
    inputBinding:
      position: 11
      prefix: -qual
  - id: bracket
    type:
      - 'null'
      - float[]
    doc: Bracket window_size and max_avg_error for quality trimming (defaults 0.794 0.794).
    inputBinding:
      position: 12
      prefix: -bracket
  - id: window
    type:
      - 'null'
      - float[]
    doc: 'Window trimming parameters: window_size max_avg_err pairs. Two windows (50 and 10 bp, 0.794) by default.'
    inputBinding:
      position: 13
      prefix: -window
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing results.
    inputBinding:
      position: 14
      prefix: -ow
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum length of read to accept. Default 50 bp.
    inputBinding:
      position: 15
      prefix: -minlen
  - id: polyat
    type:
      - 'null'
      - boolean
    doc: Turns on poly A/T trimming.
    inputBinding:
      position: 16
      prefix: -polyat
  - id: polyat_params
    type:
      - 'null'
      - int[]
    doc: 'Poly A/T parameters after -polyat: cdna (10), cerr (3), crng (50).'
    inputBinding:
      position: 17
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 18
      prefix: -verbose
  - id: detrep
    type:
      - 'null'
      - boolean
    doc: Generate detailed report for each read.
    inputBinding:
      position: 19
      prefix: -detrep
  - id: dup
    type:
      - 'null'
      - boolean
    doc: Turns on screening duplicated sequences.
    inputBinding:
      position: 20
      prefix: -dup
  - id: dup_startdw
    type:
      - 'null'
      - int
    doc: Starting position of the window within a read for duplicate screening. Default 10.
    inputBinding:
      position: 21
      prefix: -startdw
  - id: dup_sizedw
    type:
      - 'null'
      - int
    doc: Size of the window within a read for duplicate screening. Default 25.
    inputBinding:
      position: 22
      prefix: -sizedw
  - id: dup_maxdup
    type:
      - 'null'
      - int
    doc: Maximum number of duplicated sequences allowed. Default 3.
    inputBinding:
      position: 23
      prefix: -maxdup
  - id: no_adapter_trim
    type:
      - 'null'
      - boolean
    doc: Turns off trimming of adapters.
    inputBinding:
      position: 24
      prefix: -no_adapter_trim
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Roche 454 only: number of threads. Default 4.'
    inputBinding:
      position: 25
      prefix: -t
  - id: fastq_out
    type:
      - 'null'
      - boolean
    doc: 'Roche 454 only: output in FASTQ format.'
    inputBinding:
      position: 26
      prefix: -fastq
  - id: fasta_out
    type:
      - 'null'
      - boolean
    doc: 'Roche 454 only: output in FASTA format.'
    inputBinding:
      position: 27
      prefix: -fasta_out
  - id: barcodes
    type:
      - 'null'
      - File
    doc: 'Roche 454 only: FASTA file with custom barcodes.'
    inputBinding:
      position: 28
      prefix: -m
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: 'Illumina: store non-paired reads in a shuffled file.'
    inputBinding:
      position: 29
      prefix: -shuffle
  - id: i64
    type:
      - 'null'
      - boolean
    doc: 'Illumina: turns on 64-quality base.'
    inputBinding:
      position: 30
      prefix: -i64
  - id: adapters
    type:
      - 'null'
      - File
    doc: 'Illumina: FASTA file with custom adapters.'
    inputBinding:
      position: 31
      prefix: -adp
  - id: adapter_threshold
    type:
      - 'null'
      - float
    doc: 'Illumina paired-end: similarity threshold for adapter trimming by overlap. Default 0.75.'
    inputBinding:
      position: 32
      prefix: -at
  - id: overlap
    type:
      - 'null'
      - int
    doc: 'Illumina: merge overlapping paired-end reads with this minimum overlap length. Default 16.'
    inputBinding:
      position: 33
      prefix: -overlap
  - id: new2old
    type:
      - 'null'
      - boolean
    doc: 'Illumina: fix read IDs of new Illumina headers.'
    inputBinding:
      position: 34
      prefix: -new2old
  - id: gz
    type:
      - 'null'
      - boolean
    doc: Compressed output (GZip format, .gz).
    inputBinding:
      position: 35
      prefix: -gz
  - id: adapter_max_len
    type:
      - 'null'
      - int
    doc: 'Illumina paired-end: maximum adapter length. Default 30 bp.'
    inputBinding:
      position: 36
      prefix: -alen
outputs:
  - id: cleaned_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (cleaned reads, reports and statistics).
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqyclean:1.10.09--h5ca1c30_6
