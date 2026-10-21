cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sabre
  - se
label: sabre_se
doc: "Single-end barcode de-multiplexing of FASTQ files.\n\nTool homepage: https://github.com/najoshi/sabre/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fastq_file
    type: File
    doc: Input fastq file (required)
    inputBinding:
      position: 1
      prefix: -f
  - id: barcode_file
    type: File
    doc: File with barcode and output file name per line (required)
    inputBinding:
      position: 2
      prefix: -b
  - id: unknown_output
    type: string
    doc: Output file that contains records with no barcodes found. (required)
    inputBinding:
      position: 3
      prefix: -u
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: Optional argument that is the maximum number of mismatches allowed in a
      barcode. Default 0.
    inputBinding:
      position: 4
      prefix: -m
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output matching info
    inputBinding:
      position: 5
      prefix: --quiet
  - id: output_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of the output files listed in the barcode file (used to collect the
      de-multiplexed reads)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: unknown_reads
    type: File
    doc: Records with no barcode found
    outputBinding:
      glob: $(inputs.unknown_output)
  - id: demultiplexed
    type:
      type: array
      items: File
    doc: De-multiplexed read files named in the barcode file
    outputBinding:
      glob: '$(inputs.output_names ? inputs.output_names : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sabre:1.000--h577a1d6_6
stdout: sabre_se.out
