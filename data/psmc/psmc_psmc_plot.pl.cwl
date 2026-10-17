cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psmc_plot.pl
label: psmc_psmc_plot.pl
doc: "Plot the PSMC estimate of effective population size history\n\nTool homepage: https://github.com/lh3/psmc"
inputs:
  - id: out_prefix
    type: string
    doc: "Output prefix"
    inputBinding:
      position: 100
  - id: input_psmc
    type: File
    doc: "PSMC result file"
    inputBinding:
      position: 101
  - id: u
    type:
      - 'null'
      - float
    doc: "Absolute mutation rate per nucleotide (default: 2.5e-8)"
    inputBinding:
      position: 50
      prefix: "-u"
  - id: s
    type:
      - 'null'
      - int
    doc: "Skip used in data preparation (default: 100)"
    inputBinding:
      position: 22
      prefix: "-s"
  - id: X
    type:
      - 'null'
      - float
    doc: "Maximum generations, 0 for auto"
    inputBinding:
      position: 31
      prefix: "-X"
  - id: x
    type:
      - 'null'
      - float
    doc: "Minimum generations, 0 for auto (default: 10000)"
    inputBinding:
      position: 29
      prefix: "-x"
  - id: Y
    type:
      - 'null'
      - float
    doc: "Maximum popsize, 0 for auto"
    inputBinding:
      position: 44
      prefix: "-Y"
  - id: m
    type:
      - 'null'
      - int
    doc: "Minimum number of iterations (default: 5)"
    inputBinding:
      position: 38
      prefix: "-m"
  - id: n
    type:
      - 'null'
      - int
    doc: "Take n-th iteration (default: 20)"
    inputBinding:
      position: 44
      prefix: "-n"
  - id: M
    type:
      - 'null'
      - string
    doc: "Titles for multiline mode"
    inputBinding:
      position: 42
      prefix: "-M"
  - id: f
    type:
      - 'null'
      - string
    doc: "Font for title, labels and tics (default: Helvetica,16)"
    inputBinding:
      position: 35
      prefix: "-f"
  - id: g
    type:
      - 'null'
      - int
    doc: "Number of years per generation (default: 25)"
    inputBinding:
      position: 8
      prefix: "-g"
  - id: w
    type:
      - 'null'
      - int
    doc: "Line width (default: 4)"
    inputBinding:
      position: 16
      prefix: "-w"
  - id: P
    type:
      - 'null'
      - string
    doc: "Position of the keys (default: right top)"
    inputBinding:
      position: 4
      prefix: "-P"
  - id: T
    type:
      - 'null'
      - string
    doc: "Figure title"
    inputBinding:
      position: 12
      prefix: "-T"
  - id: N
    type:
      - 'null'
      - float
    doc: "False negative rate (default: 0)"
    inputBinding:
      position: 42
      prefix: "-N"
  - id: no_scaling
    type:
      - 'null'
      - boolean
    doc: "No scaling"
    inputBinding:
      position: 41
      prefix: "-S"
  - id: show_last_bin
    type:
      - 'null'
      - boolean
    doc: "Show the last bin"
    inputBinding:
      position: 29
      prefix: "-L"
  - id: to_pdf
    type:
      - 'null'
      - boolean
    doc: "Convert to PDF (with epstopdf)"
    inputBinding:
      position: 27
      prefix: "-p"
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Do not remove temporary files"
    inputBinding:
      position: 31
      prefix: "-R"
  - id: grid
    type:
      - 'null'
      - boolean
    doc: "Plot grid"
    inputBinding:
      position: 37
      prefix: "-G"
outputs:
  - id: plot_files
    type:
      type: array
      items: File
    doc: "Plot files written next to the output prefix (.eps, .pdf, .par, .txt)"
    outputBinding:
      glob:
        - $(inputs.out_prefix).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
