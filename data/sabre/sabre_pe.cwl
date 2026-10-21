cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sabre
  - pe
label: sabre_pe
doc: "Paired-end barcode de-multiplexing of FASTQ files.\n\nTool homepage: https://github.com/najoshi/sabre/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: pe_file1
    type: File
    doc: Input paired-end fastq file 1 (required, must have same number of records
      as pe2)
    inputBinding:
      position: 1
      prefix: -f
  - id: pe_file2
    type: File
    doc: Input paired-end fastq file 2 (required, must have same number of records
      as pe1)
    inputBinding:
      position: 2
      prefix: -r
  - id: barcode_file
    type: File
    doc: File with barcode and two output file names per line (required)
    inputBinding:
      position: 3
      prefix: -b
  - id: unknown_output1
    type: string
    doc: Output paired-end file 1 that contains records with no barcodes found.
      (required)
    inputBinding:
      position: 4
      prefix: -u
  - id: unknown_output2
    type: string
    doc: Output paired-end file 2 that contains records with no barcodes found.
      (required)
    inputBinding:
      position: 5
      prefix: -w
  - id: both_barcodes
    type:
      - 'null'
      - boolean
    doc: Optional flag that indicates that both fastq files have barcodes.
    inputBinding:
      position: 6
      prefix: -c
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: Optional argument that is the maximum number of mismatches allowed in a
      barcode. Default 0.
    inputBinding:
      position: 7
      prefix: -m
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print barcode matching info
    inputBinding:
      position: 8
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
  - id: unknown_reads1
    type: File
    doc: Records of file 1 with no barcode found
    outputBinding:
      glob: $(inputs.unknown_output1)
  - id: unknown_reads2
    type: File
    doc: Records of file 2 with no barcode found
    outputBinding:
      glob: $(inputs.unknown_output2)
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
stdout: sabre_pe.out
