cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexbar
label: flexbar
doc: "The program Flexbar preprocesses high-throughput sequencing data efficiently.
  It demultiplexes barcoded runs and removes adapter sequences.\n\nTool homepage:
  https://github.com/seqan/flexbar"
inputs:
  - id: adapter_error_rate
    type:
      - 'null'
      - float
    doc: Error rate threshold for mismatches and gaps.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --adapter-error-rate
  - id: adapter_min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap for removal without pair overlap.
    default: 3
    inputBinding:
      position: 101
      prefix: --adapter-min-overlap
  - id: adapter_pair_overlap
    type:
      - 'null'
      - string
    doc: Overlap detection of paired reads. One of ON, SHORT, and ONLY.
    inputBinding:
      position: 101
      prefix: --adapter-pair-overlap
  - id: adapter_preset
    type:
      - 'null'
      - string
    doc: One of TruSeq, SmallRNA, Methyl, Ribo, Nextera, and NexteraMP.
    inputBinding:
      position: 101
      prefix: --adapter-preset
  - id: adapter_trim_end
    type:
      - 'null'
      - string
    doc: Type of removal, see section trim-end modes.
    default: RIGHT
    inputBinding:
      position: 101
      prefix: --adapter-trim-end
  - id: adapters
    type:
      - 'null'
      - File
    doc: Fasta file with adapters for removal that may contain N.
    inputBinding:
      position: 101
      prefix: --adapters
  - id: adapters2
    type:
      - 'null'
      - File
    doc: File with extra adapters for second read set in paired mode.
    inputBinding:
      position: 101
      prefix: --adapters2
  - id: align_log
    type:
      - 'null'
      - string
    doc: Print chosen read alignments. One of ALL, MOD, and TAB.
    inputBinding:
      position: 101
      prefix: --align-log
  - id: barcode_error_rate
    type:
      - 'null'
      - float
    doc: Error rate threshold for mismatches and gaps.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --barcode-error-rate
  - id: barcode_min_overlap
    type:
      - 'null'
      - int
    doc: 'Minimum overlap of barcode and read. Default: barcode length.'
    inputBinding:
      position: 101
      prefix: --barcode-min-overlap
  - id: barcode_reads
    type:
      - 'null'
      - File
    doc: Fasta/q file containing separate barcode reads for detection.
    inputBinding:
      position: 101
      prefix: --barcode-reads
  - id: barcode_trim_end
    type:
      - 'null'
      - string
    doc: Type of detection, see section trim-end modes.
    default: LTAIL
    inputBinding:
      position: 101
      prefix: --barcode-trim-end
  - id: barcodes
    type:
      - 'null'
      - File
    doc: Fasta file with barcodes for demultiplexing, may contain N.
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Prefer non-quality format fasta for output.
    inputBinding:
      position: 101
      prefix: --fasta-output
  - id: htrim_error_rate
    type:
      - 'null'
      - float
    doc: Error rate threshold for mismatches.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --htrim-error-rate
  - id: htrim_min_length
    type:
      - 'null'
      - int
    doc: Minimum length of homopolymers at read ends.
    default: 3
    inputBinding:
      position: 101
      prefix: --htrim-min-length
  - id: htrim_right
    type:
      - 'null'
      - string
    doc: Trim certain homopolymers on right read end after removal.
    inputBinding:
      position: 101
      prefix: --htrim-right
  - id: max_uncalled
    type:
      - 'null'
      - int
    doc: Allowed uncalled bases N for each read.
    default: 0
    inputBinding:
      position: 101
      prefix: --max-uncalled
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length to remain after removal.
    default: 18
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: pre_trim_left
    type:
      - 'null'
      - int
    doc: Trim given number of bases on 5' read end before detection.
    inputBinding:
      position: 101
      prefix: --pre-trim-left
  - id: pre_trim_right
    type:
      - 'null'
      - int
    doc: Trim specified number of bases on 3' end prior to detection.
    inputBinding:
      position: 101
      prefix: --pre-trim-right
  - id: qtrim
    type:
      - 'null'
      - string
    doc: Quality-based trimming mode. One of TAIL, WIN, and BWA.
    inputBinding:
      position: 101
      prefix: --qtrim
  - id: qtrim_format
    type:
      - 'null'
      - string
    doc: Quality format. One of sanger, solexa, i1.3, i1.5, and i1.8.
    inputBinding:
      position: 101
      prefix: --qtrim-format
  - id: qtrim_threshold
    type:
      - 'null'
      - int
    doc: Minimum quality as threshold for trimming.
    default: 20
    inputBinding:
      position: 101
      prefix: --qtrim-threshold
  - id: reads
    type: File
    doc: Fasta/q file or stdin (-) with reads that may contain barcodes.
    inputBinding:
      position: 101
      prefix: --reads
  - id: reads2
    type:
      - 'null'
      - File
    doc: Second input file of paired reads, gz and bz2 files supported.
    inputBinding:
      position: 101
      prefix: --reads2
  - id: removal_tags
    type:
      - 'null'
      - boolean
    doc: Tag reads that are subject to adapter or barcode removal.
    inputBinding:
      position: 101
      prefix: --removal-tags
  - id: stdout_log
    type:
      - 'null'
      - boolean
    doc: Write statistics to stdout instead of target log file.
    inputBinding:
      position: 101
      prefix: --stdout-log
  - id: stdout_reads
    type:
      - 'null'
      - boolean
    doc: Write reads to stdout, tagged and interleaved if needed.
    inputBinding:
      position: 101
      prefix: --stdout-reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to employ.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: zip_output
    type:
      - 'null'
      - string
    doc: Direct compression of output files. One of GZ and BZ2.
    inputBinding:
      position: 101
      prefix: --zip-output
outputs:
  - id: target
    type:
      - 'null'
      - File
    doc: Prefix for output file names or paths.
    outputBinding:
      glob: $(inputs.target)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexbar:3.5.0--hdfd68b8_12
