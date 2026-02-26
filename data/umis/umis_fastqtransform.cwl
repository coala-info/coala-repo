cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - fastqtransform
label: umis_fastqtransform
doc: "Transform input reads to the tagcounts compatible read layout using regular
  expressions as defined in a transform file. Outputs new format to stdout.\n\nTool
  homepage: https://github.com/vals/umis"
inputs:
  - id: transform
    type: string
    doc: Transform file defining regular expressions
    inputBinding:
      position: 1
  - id: fastq1
    type: File
    doc: First input FASTQ file
    inputBinding:
      position: 2
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Second input FASTQ file (optional)
    inputBinding:
      position: 3
  - id: fastq3
    type:
      - 'null'
      - File
    doc: Third input FASTQ file (optional)
    inputBinding:
      position: 4
  - id: fastq4
    type:
      - 'null'
      - File
    doc: Fourth input FASTQ file (optional)
    inputBinding:
      position: 5
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 106
      prefix: --cores
  - id: demuxed_cb
    type:
      - 'null'
      - string
    doc: Demultiplexed barcode
    inputBinding:
      position: 106
      prefix: --demuxed_cb
  - id: keep_fastq_tags
    type:
      - 'null'
      - boolean
    doc: Keep FASTQ tags
    inputBinding:
      position: 106
      prefix: --keep_fastq_tags
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of read to keep.
    inputBinding:
      position: 106
      prefix: --min_length
  - id: separate_cb
    type:
      - 'null'
      - boolean
    doc: Keep dual index barcodes separate.
    inputBinding:
      position: 106
      prefix: --separate_cb
outputs:
  - id: fastq1out
    type:
      - 'null'
      - File
    doc: Output file for FASTQ1
    outputBinding:
      glob: $(inputs.fastq1out)
  - id: fastq2out
    type:
      - 'null'
      - File
    doc: Output file for FASTQ2
    outputBinding:
      glob: $(inputs.fastq2out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
