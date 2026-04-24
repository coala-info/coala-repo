cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - barcode-build
label: freyja_barcode-build
doc: "Builds a barcode reference from a FASTA file.\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing sequences to build barcodes from.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing files, even if they are not identical.
    inputBinding:
      position: 102
      prefix: --force
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of barcodes to consider.
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of barcodes to consider.
    inputBinding:
      position: 102
      prefix: --min-len
  - id: output_dir
    type: Directory
    doc: Directory to save the barcode reference files.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: redo
    type:
      - 'null'
      - boolean
    doc: If set, will overwrite existing files in the output directory.
    inputBinding:
      position: 102
      prefix: --redo
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
stdout: freyja_barcode-build.out
