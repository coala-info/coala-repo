cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gbsx
  - --Demultiplexer
label: gbsx_Demultiplexer
doc: "GBSX demultiplex v3: demultiplexes fastq or fastq.gz files from sequencing with inline barcodes, as used in GBS and RAD protocols.\n\nTool homepage: https://github.com/GenomicsCoreLeuven/GBSX"
inputs:
  - id: fastq1
    type: File
    doc: "The fastq or fastq.gz file to demultiplex"
    inputBinding:
      position: 101
      prefix: -f1
  - id: info_file
    type: File
    doc: "Tab-delimited info file without headings: sample, barcode sequence, enzyme name, second enzyme (optional), second barcode (optional), mismatches for the barcode (optional)"
    inputBinding:
      position: 101
      prefix: -i
  - id: fastq2
    type:
      - 'null'
      - File
    doc: "Second fastq or fastq.gz file (only with paired-end sequencing)"
    inputBinding:
      position: 101
      prefix: -f2
  - id: out_dir
    type:
      - 'null'
      - string
    doc: "Name of the output directory (standard: the directory of the call)"
    inputBinding:
      position: 101
      prefix: -o
  - id: long_file_names
    type:
      - 'null'
      - boolean
    doc: "Use long file names: sample name_barcode_enzyme instead of the sample name (standard false)"
    inputBinding:
      position: 101
      prefix: -lf
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: rad
    type:
      - 'null'
      - boolean
    doc: "True for RAD data, false for GBS data (standard false)"
    inputBinding:
      position: 101
      prefix: -rad
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "The input and output are gzipped (.gz) (standard false)"
    inputBinding:
      position: 101
      prefix: -gzip
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (standard 1)"
    inputBinding:
      position: 101
      prefix: -t
  - id: mismatches_barcode
    type:
      - 'null'
      - int
    doc: "Allowed mismatches in the barcodes"
    inputBinding:
      position: 101
      prefix: -mb
  - id: mismatches_enzyme
    type:
      - 'null'
      - int
    doc: "Allowed mismatches in the enzymes"
    inputBinding:
      position: 101
      prefix: -me
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: "Minimum allowed length for the sequences (standard 0); rejected sequences are in the undetermined file"
    inputBinding:
      position: 101
      prefix: -minsl
  - id: keep_n
    type:
      - 'null'
      - boolean
    doc: "Keep sequences where N occurs as a nucleotide (standard true)"
    inputBinding:
      position: 101
      prefix: -n
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: common_adaptor
    type:
      - 'null'
      - string
    doc: "Common adaptor used in the sequencing (standard AGATCGGAAGAGCG, minimum length 10)"
    inputBinding:
      position: 101
      prefix: -ca
  - id: start_distance
    type:
      - 'null'
      - int
    doc: "Possible distance of the start: from the read start to the first base of the barcode or enzyme (standard 0, maximum 20)"
    inputBinding:
      position: 101
      prefix: -s
  - id: keep_cut_site
    type:
      - 'null'
      - boolean
    doc: "Keep the enzyme cut-site remains (standard true)"
    inputBinding:
      position: 101
      prefix: -kc
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: enzymes_add
    type:
      - 'null'
      - File
    doc: "Add enzymes from this file (no header; enzyme name, tab, cut sites separated by commas); keeps the standard enzymes. Do not use with enzymes_replace"
    inputBinding:
      position: 101
      prefix: -ea
  - id: enzymes_replace
    type:
      - 'null'
      - File
    doc: "Replace the standard enzymes with the enzymes in this file (no header; enzyme name, tab, cut sites separated by commas). Do not use with enzymes_add"
    inputBinding:
      position: 101
      prefix: -er
  - id: self_correcting_barcodes
    type:
      - 'null'
      - boolean
    doc: "Use self-correcting barcodes created by the BarcodeGenerator (standard false)"
    inputBinding:
      position: 101
      prefix: -scb
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: mismatch_algorithm
    type:
      - 'null'
      - string
    doc: "Algorithm to find mismatches and indels: hammings (standard), knuth, indelmis, misindel"
    inputBinding:
      position: 101
      prefix: -malg
  - id: quality_encoding
    type:
      - 'null'
      - string
    doc: "Quality score encoding of the fastq file: Illumina1.8 (standard), Illumina1.5, Illumina1.3, Sanger, Solid"
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory with the demultiplexed fastq files and statistics
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbsx:1.3--0
stdout: gbsx_Demultiplexer.out
