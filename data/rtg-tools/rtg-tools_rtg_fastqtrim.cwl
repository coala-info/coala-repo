cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - fastqtrim
label: rtg-tools_rtg_fastqtrim
doc: 'Trim reads in FASTQ files. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'input FASTQ file, Use ''-'' to read from standard input'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output filename. Use ''-'' to write to standard output'
    inputBinding:
      position: 101
      prefix: --output
  - id: quality_format
    type:
      - 'null'
      - string
    doc: 'quality data encoding method used in FASTQ input files (Illumina 1.8+ uses sanger). Allowed values are [sanger, solexa, illumina] (Default is sanger)'
    inputBinding:
      position: 101
      prefix: --quality-format
  - id: discard_empty_reads
    type:
      - 'null'
      - boolean
    doc: 'if set, discard reads that have zero length after trimming. Should not be used with paired-end data'
    inputBinding:
      position: 101
      prefix: --discard-empty-reads
  - id: end_quality_threshold
    type:
      - 'null'
      - int
    doc: 'trim read ends to maximise base quality above the given threshold (Default is 0)'
    inputBinding:
      position: 101
      prefix: --end-quality-threshold
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: 'if a read ends up shorter than this threshold it will be trimmed to zero length (Default is 0)'
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: start_quality_threshold
    type:
      - 'null'
      - int
    doc: 'trim read starts to maximise base quality above the given threshold (Default is 0)'
    inputBinding:
      position: 101
      prefix: --start-quality-threshold
  - id: trim_end_bases
    type:
      - 'null'
      - int
    doc: 'always trim the specified number of bases from read end (Default is 0)'
    inputBinding:
      position: 101
      prefix: --trim-end-bases
  - id: trim_start_bases
    type:
      - 'null'
      - int
    doc: 'always trim the specified number of bases from read start (Default is 0)'
    inputBinding:
      position: 101
      prefix: --trim-start-bases
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: 'if set, output in reverse complement'
    inputBinding:
      position: 101
      prefix: --reverse-complement
  - id: seed
    type:
      - 'null'
      - int
    doc: 'seed used during subsampling'
    inputBinding:
      position: 101
      prefix: --seed
  - id: subsample
    type:
      - 'null'
      - float
    doc: 'if set, subsample the input to retain this fraction of reads'
    inputBinding:
      position: 101
      prefix: --subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (Default is the number of available cores)'
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: trimmed
    type:
      type: array
      items: File
    doc: Trimmed FASTQ file
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_fastqtrim.out
