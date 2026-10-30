cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_histogram
doc: "Histogram of the values of one or several tracks (extraction histogram); the bin widths are adapted to the data.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: histogram
  - position: 2
    valueFrom: $(inputs.output_name)
inputs:
  - id: bins
    type: int
    doc: Number of bins of the histogram.
    inputBinding:
      position: 3
  - id: input_files
    type: File[]
    doc: Tracks whose value distributions are put in the histogram (one column per track).
    inputBinding:
      position: 4
  - id: output_name
    type: string
    doc: Output text file (use '-' for standard output).
    default: histogram.txt
outputs:
  - id: output_file
    type: File
    doc: Text file; each line has the middle value of a bin and one count per track.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
