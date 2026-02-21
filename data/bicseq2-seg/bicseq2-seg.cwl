cwlVersion: v1.2
class: CommandLineTool
baseCommand: BIC-seq2-seg.pl
label: bicseq2-seg
doc: "BIC-seq2 segmentation tool for detecting copy number variations from high-throughput
  sequencing data.\n\nTool homepage: http://compbio.med.harvard.edu/BIC-seq/"
inputs:
  - id: config_file
    type: File
    doc: Configuration file containing the bin count data
    inputBinding:
      position: 1
  - id: fig
    type:
      - 'null'
      - boolean
    doc: Plot the results
    inputBinding:
      position: 102
      prefix: --fig
  - id: lambda
    type:
      - 'null'
      - float
    doc: The penalty used in the BIC-seq2 algorithm
    default: 2.0
    inputBinding:
      position: 102
      prefix: --lambda
  - id: swin
    type:
      - 'null'
      - int
    doc: The smooth window size
    inputBinding:
      position: 102
      prefix: --swin
  - id: title
    type:
      - 'null'
      - string
    doc: The title of the plot
    inputBinding:
      position: 102
      prefix: --title
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for intermediate files
    inputBinding:
      position: 102
      prefix: --tmp
  - id: win
    type:
      - 'null'
      - int
    doc: The window size
    inputBinding:
      position: 102
      prefix: --win
outputs:
  - id: output_file
    type: File
    doc: Output file for the segmentation results
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bicseq2-seg:0.7.2--hec16e2b_3
