cwlVersion: v1.2
class: CommandLineTool
baseCommand: umis demultiplex_cells
label: umis_demultiplex_cells
doc: "Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each cell.\n\
  \nTool homepage: https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: FASTQ file
    inputBinding:
      position: 1
  - id: cb_cutoff
    type:
      - 'null'
      - int
    doc: Cell barcode cutoff
    inputBinding:
      position: 102
      prefix: --cb_cutoff
  - id: cb_histogram
    type:
      - 'null'
      - File
    doc: Cell barcode histogram file
    inputBinding:
      position: 102
      prefix: --cb_histogram
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --out_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: readnumber
    type:
      - 'null'
      - string
    doc: Read number
    inputBinding:
      position: 102
      prefix: --readnumber
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_demultiplex_cells.out
