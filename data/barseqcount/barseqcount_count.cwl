cwlVersion: v1.2
class: CommandLineTool
baseCommand: barseqcount_count
label: barseqcount_count
doc: "Counts barcodes in sequencing data.\n\nTool homepage: https://github.com/damienmarsic/barseqcount"
inputs:
  - id: input_file
    type: File
    doc: Path to the input sequencing data file (e.g., FASTQ).
    inputBinding:
      position: 1
  - id: barcode_file
    type: File
    doc: Path to the file containing the list of barcodes to count.
    inputBinding:
      position: 102
      prefix: --barcode-file
  - id: max_barcode_len
    type:
      - 'null'
      - int
    doc: Maximum length of a barcode to be considered valid.
    inputBinding:
      position: 102
      prefix: --max-barcode-len
  - id: min_barcode_len
    type:
      - 'null'
      - int
    doc: Minimum length of a barcode to be considered valid.
    inputBinding:
      position: 102
      prefix: --min-barcode-len
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to save the output counts and plots.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
stdout: barseqcount_count.out
