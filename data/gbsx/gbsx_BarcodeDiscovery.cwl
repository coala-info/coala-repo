cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gbsx
  - --BarcodeDiscovery
label: gbsx_BarcodeDiscovery
doc: "GBSX Barcode Discovery v1.0: searches a fastq file for possible barcodes and barcode-enzyme combinations.\n\nTool homepage: https://github.com/GenomicsCoreLeuven/GBSX"
inputs:
  - id: fastq1
    type: File
    doc: "The input fastq or fastq.gz file"
    inputBinding:
      position: 101
      prefix: -f1
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of the barcode (standard 6)"
    inputBinding:
      position: 101
      prefix: -min
  - id: max_length
    type:
      - 'null'
      - int
    doc: "Maximum length of the barcode (standard 16)"
    inputBinding:
      position: 101
      prefix: -max
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "Use gzip files as input and output (standard false)"
    inputBinding:
      position: 101
      prefix: -gzip
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: out_dir
    type:
      - 'null'
      - string
    doc: "The output directory (standard: the directory of execution)"
    inputBinding:
      position: 101
      prefix: -o
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
    doc: "Replace the standard enzymes with the enzymes in this file. Do not use with enzymes_add"
    inputBinding:
      position: 101
      prefix: -er
  - id: barcode_min_occurrence
    type:
      - 'null'
      - int
    doc: "Minimum occurrence of a barcode before it is shown in the results (standard 200)"
    inputBinding:
      position: 101
      prefix: -barmin
  - id: barcode_max_shown
    type:
      - 'null'
      - int
    doc: "Maximum number of barcodes shown in the output; a higher number uses more memory but gives a slightly better result (standard 100)"
    inputBinding:
      position: 101
      prefix: -barmax
  - id: barcode_mismatch_percent
    type:
      - 'null'
      - int
    doc: "Percentage of mismatches that may occur between barcodes, an integer between 1 and 10 (standard 10)"
    inputBinding:
      position: 101
      prefix: -barmis
  - id: find_enzymes
    type:
      - 'null'
      - boolean
    doc: "Find possible enzyme combinations (standard true)"
    inputBinding:
      position: 101
      prefix: -fe
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory with the barcode counts and the possible barcodes
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbsx:1.3--0
stdout: gbsx_BarcodeDiscovery.out
