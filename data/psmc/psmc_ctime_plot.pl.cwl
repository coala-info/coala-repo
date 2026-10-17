cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ctime_plot.pl
label: psmc_ctime_plot.pl
doc: "Plot coalescent times along the genome\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: input_ctime
    type: File
    doc: "Coalescent time file (.ctime) from dec2ctime.pl"
    inputBinding:
      position: 100
  - id: d
    type:
      - 'null'
      - string
    doc: "Working directory (default: ctime_plot)"
    inputBinding:
      position: 1
      prefix: "-d"
  - id: l
    type:
      - 'null'
      - float
    doc: "Length of the figure (default: 10.0)"
    inputBinding:
      position: 2
      prefix: "-l"
  - id: h
    type:
      - 'null'
      - float
    doc: "Height of the figure (default: 0.5)"
    inputBinding:
      position: 3
      prefix: "-h"
  - id: Y
    type:
      - 'null'
      - float
    doc: "Max Y-axis, 0 for auto (default: 0)"
    inputBinding:
      position: 4
      prefix: "-Y"
  - id: r
    type:
      - 'null'
      - File
    doc: "Recombination map (.rho)"
    inputBinding:
      position: 5
      prefix: "-r"
  - id: L
    type:
      - 'null'
      - boolean
    doc: "Option -L of ctime_plot.pl"
    inputBinding:
      position: 6
      prefix: "-L"
outputs:
  - id: plot_dir
    type:
      - 'null'
      - Directory
    doc: "Working directory with the plot files"
    outputBinding:
      glob: ctime_plot
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
