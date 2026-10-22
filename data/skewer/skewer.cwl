cwlVersion: v1.2
class: CommandLineTool
baseCommand: skewer
label: skewer
doc: "Skewer is a fast and accurate adapter trimmer for single-end and paired-end
  NGS reads.\n\nTool homepage: https://github.com/relipmoc/skewer"
inputs:
  - id: reads
    type: File
    doc: Input reads in FASTQ format (forward reads for paired-end)
    inputBinding:
      position: 100
  - id: paired_reads
    type: ['null', File]
    doc: Second FASTQ file (paired-end reads)
    inputBinding:
      position: 101
  - id: adapter
    type: ['null', string]
    doc: Adapter sequence or file (-x)
    inputBinding:
      position: 1
      prefix: -x
  - id: adapter_pair
    type: ['null', string]
    doc: Adapter sequence or file for paired-end reads (-y)
    inputBinding:
      position: 1
      prefix: -y
  - id: matrix
    type: ['null', File]
    doc: File indicating valid adapter pairing (all-ones matrix)
    inputBinding:
      position: 1
      prefix: --matrix
  - id: junction_adapter
    type: ['null', string]
    doc: Junction adapter sequence or file for Nextera Mate Pair reads
    inputBinding:
      position: 1
      prefix: -j
  - id: mode
    type: ['null', string]
    doc: "Trimming mode; single-end: head, tail, any; paired-end: pe, mp, ap"
    inputBinding:
      position: 1
      prefix: --mode
  - id: barcode
    type: ['null', boolean]
    doc: Demultiplex reads according to adapters/primers
    inputBinding:
      position: 1
      prefix: --barcode
  - id: max_error_rate
    type: ['null', float]
    doc: Maximum allowed error rate [0, 0.5]
    inputBinding:
      position: 1
      prefix: -r
  - id: max_indel_error_rate
    type: ['null', float]
    doc: Maximum allowed indel error rate [0, r]
    inputBinding:
      position: 1
      prefix: -d
  - id: min_overlap
    type: ['null', int]
    doc: Minimum overlap length for adapter detection
    inputBinding:
      position: 1
      prefix: -k
  - id: cut
    type: ['null', string]
    doc: "Hard clip off the 5' leading bases as barcodes in amplicon mode (<int>,<int>)"
    inputBinding:
      position: 1
      prefix: --cut
  - id: cut3
    type: ['null', boolean]
    doc: Hard clip off the 3' tailing bases if the read is longer than the maximum length set by -L
    inputBinding:
      position: 1
      prefix: --cut3
  - id: end_quality
    type: ['null', int]
    doc: Trim 3' end until the specified or higher quality is reached
    inputBinding:
      position: 1
      prefix: --end-quality
  - id: mean_quality
    type: ['null', int]
    doc: The lowest mean quality value allowed before trimming
    inputBinding:
      position: 1
      prefix: --mean-quality
  - id: min_length
    type: ['null', int]
    doc: The minimum read length allowed after trimming
    inputBinding:
      position: 1
      prefix: --min
  - id: max_length
    type: ['null', int]
    doc: The maximum read length allowed after trimming
    inputBinding:
      position: 1
      prefix: --max
  - id: filter_n
    type: ['null', boolean]
    doc: Filter out highly degenerative (many Ns) reads
    inputBinding:
      position: 1
      prefix: -n
  - id: filter_undetermined
    type: ['null', boolean]
    doc: Filter out undetermined mate-pair reads
    inputBinding:
      position: 1
      prefix: -u
  - id: fill_ns
    type: ['null', boolean]
    doc: Replace trimmed bases with Ns
    inputBinding:
      position: 1
      prefix: --fillNs
  - id: format
    type: ['null', string]
    doc: Format of FASTQ quality values (sanger, solexa or auto)
    inputBinding:
      position: 1
      prefix: --format
  - id: output
    type: string
    doc: Base name of the output files
    inputBinding:
      position: 1
      prefix: --output
  - id: to_stdout
    type: ['null', boolean]
    doc: Redirect output to standard output, suppressing -b, -o and -z
    inputBinding:
      position: 1
      prefix: --stdout
  - id: compress
    type: ['null', boolean]
    doc: Compress output in GZIP format
    inputBinding:
      position: 1
      prefix: --compress
  - id: qiime
    type: ['null', boolean]
    doc: Prepare barcodes.fastq and mapping_file.txt for processing with QIIME
    inputBinding:
      position: 1
      prefix: --qiime
  - id: quiet
    type: ['null', boolean]
    doc: No progress update
    inputBinding:
      position: 1
      prefix: --quiet
  - id: masked_output
    type: ['null', boolean]
    doc: Write output files for trimmed reads (trimmed bases converted to lower case)
    inputBinding:
      position: 1
      prefix: --masked-output
  - id: excluded_output
    type: ['null', boolean]
    doc: Write output files for excluded reads
    inputBinding:
      position: 1
      prefix: --excluded-output
  - id: intelligent
    type: ['null', boolean]
    doc: For mate-pair mode, redistribute reads based on junction information
    inputBinding:
      position: 1
      prefix: --intelligent
  - id: threads
    type: ['null', int]
    doc: Number of concurrent threads [1, 32]
    inputBinding:
      position: 1
      prefix: --threads
stdout: skewer_stdout.txt
outputs:
  - id: stdout_text
    type: File
    doc: Standard output (with --stdout this holds the trimmed reads)
    outputBinding:
      glob: skewer_stdout.txt
  - id: trimmed_reads
    type:
      type: array
      items: File
    doc: Trimmed FASTQ files (and any masked, excluded or barcode files)
    outputBinding:
      glob:
        - $(inputs.output)*.fastq
        - $(inputs.output)*.fastq.gz
        - $(inputs.output)*.fq
        - $(inputs.output)*.fq.gz
  - id: log_file
    type: ['null', File]
    doc: Skewer trimming log
    outputBinding:
      glob: $(inputs.output)*.log
  - id: qiime_mapping_file
    type: ['null', File]
    doc: QIIME mapping file (only with --qiime)
    outputBinding:
      glob: mapping_file.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skewer:0.2.2--h2d50403_2
