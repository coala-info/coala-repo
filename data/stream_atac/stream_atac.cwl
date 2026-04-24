cwlVersion: v1.2
class: CommandLineTool
baseCommand: stream_atac
label: stream_atac
doc: "STREAM single cell ATAC-seq preprocessing steps\n\nTool homepage: https://github.com/pinellolab/STREAM_atac"
inputs:
  - id: feature
    type:
      - 'null'
      - string
    doc: Features used to have the analysis. Choose from {{'kmer', 'motif'}}
    inputBinding:
      position: 101
      prefix: --feature
  - id: file_count
    type: File
    doc: scATAC-seq counts file name
    inputBinding:
      position: 101
      prefix: --file_count
  - id: file_format
    type:
      - 'null'
      - string
    doc: "File format of file_count. Currently supported file formats: 'tsv','txt','csv','mtx'."
    inputBinding:
      position: 101
      prefix: --file_format
  - id: file_region
    type: File
    doc: scATAC-seq regions file name in .bed or .bed.gz format
    inputBinding:
      position: 101
      prefix: --file_region
  - id: file_sample
    type: File
    doc: scATAC-seq samples file name
    inputBinding:
      position: 101
      prefix: --file_sample
  - id: genome
    type:
      - 'null'
      - string
    doc: Reference genome. Choose from {{'mm9', 'mm10', 'hg38', 'hg19'}}
    inputBinding:
      position: 101
      prefix: --genome
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer length for scATAC-seq analysis
    inputBinding:
      position: 101
      prefix: -k
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: The number of parallel jobs to run.
    inputBinding:
      position: 101
      prefix: --n_jobs
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: peak_width
    type:
      - 'null'
      - int
    doc: Specify the width of peak when resizing them. Only valid when 
      resize_peak is True.
    inputBinding:
      position: 101
      prefix: --peak_width
  - id: resize_peak
    type:
      - 'null'
      - boolean
    doc: Resize peaks when peaks have different widths.
    inputBinding:
      position: 101
      prefix: --resize_peak
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stream_atac:0.3.5--py_5
stdout: stream_atac.out
