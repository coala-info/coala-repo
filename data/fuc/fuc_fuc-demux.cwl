cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fuc-demux
label: fuc_fuc-demux
doc: "Parse the Reports directory from bcl2fastq.\n\nThis command will parse, and
  extract various statistics from, HTML files in\nthe Reports directory created by
  the bcl2fastq or bcl2fastq2 prograrm. After\ncreating an output directory, the command
  will write the following files:\n  - flowcell-summary.csv\n  - lane-summary.csv\n\
  \  - top-unknown-barcodes.csv\n  - reports.pdf\n\nUse --sheet to sort samples in
  the lane-summary.csv file in the same order\nas your SampleSheet.csv file. You can
  also provide a modified version of your\nSampleSheet.csv file to subset samples
  for the lane-summary.csv and\nreports.pdf files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: reports
    type: Directory
    doc: Input Reports directory.
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory (will be created).
    inputBinding:
      position: 2
  - id: sheet
    type:
      - 'null'
      - File
    doc: "SampleSheet.csv file. Used for sorting and/or subsetting\n             \
      \   samples."
    inputBinding:
      position: 103
      prefix: --sheet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-demux.out
