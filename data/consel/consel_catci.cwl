cwlVersion: v1.2
class: CommandLineTool
baseCommand: catci
label: consel_catci
doc: "Print the confidence intervals (au and np) of the test statistics stored in ci files made by consel.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: ci_files
    type: File[]
    doc: "ci files made by consel"
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "also print the standard errors and ei values"
    inputBinding:
      position: 1
      prefix: -v
  - id: no_au
    type:
      - 'null'
      - boolean
    doc: "suppress the intervals of the au test"
    inputBinding:
      position: 1
      prefix: --no_au
  - id: no_np
    type:
      - 'null'
      - boolean
    doc: "suppress the intervals of np"
    inputBinding:
      position: 1
      prefix: --no_np
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:

  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_catci.log
