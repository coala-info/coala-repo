cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sinto
  - filterbarcodes
label: sinto_filterbarcodes
doc: "Filter reads based on input list of cell barcodes\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam_file
    type: File
    secondaryFiles:
      - .bai
    doc: Input bam file (must be indexed)
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcode_regex
    type:
      - 'null'
      - string
    doc: Regular expression used to extract cell barcode from read name. If None
      (default), extract cell barcode from read tag. Use "[^:]*" to match all 
      characters up to the first colon.
    inputBinding:
      position: 101
      prefix: --barcode_regex
  - id: barcodetag
    type:
      - 'null'
      - string
    doc: Read tag storing cell barcode information
    inputBinding:
      position: 101
      prefix: --barcodetag
  - id: cells
    type: File
    doc: "File of cell barcodes (tab-delimited: barcode, then comma-separated group names; one output file per group). Can be gzip compressed. The tool needs a file: a comma-separated list gives 'File not found'."
    inputBinding:
      position: 101
      prefix: --cells
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processors
    inputBinding:
      position: 101
      prefix: --nproc
  - id: outdir
    type:
      - 'null'
      - string
    doc: Output file directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output sam format (default bam output)
    inputBinding:
      position: 101
      prefix: --sam
  - id: trim_suffix
    type:
      - 'null'
      - boolean
    doc: Remove trail 2 characters from cell barcode in BAM file
    inputBinding:
      position: 101
      prefix: --trim_suffix
outputs:
  - id: filtered_alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: One alignment file per group in the cells file (written to the working directory when outdir is not set).
    outputBinding:
      glob:
        - '*.bam'
        - '*.sam'
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: Output file directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
