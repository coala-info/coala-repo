cwlVersion: v1.2
class: CommandLineTool
baseCommand: catmt
label: consel_catmt
doc: "Join mt files along the sites (to combine genes) and write <output_base>.mt, optionally prescreening the items by the Kishino-Hasegawa test.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: mt_files
    type: File[]
    doc: "input mt files with the same items"
    inputBinding:
      position: 2
  - id: output_base
    type: string
    doc: "base name of the output mt file, without extension"
    default: "catmt_out"
    inputBinding:
      position: 3
  - id: kht
    type:
      - 'null'
      - double
    doc: "prescreen the items by the KH test at this level; ids of the kept items go to <output_base>.vt"
    inputBinding:
      position: 1
      prefix: --kht
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: mt
    type: File
    doc: "joined mt file"
    outputBinding:
      glob: $(inputs.output_base).mt
  - id: vt
    type:
      - 'null'
      - File
    doc: "ids of the items kept by the KH prescreening (with --kht)"
    outputBinding:
      glob: $(inputs.output_base).vt
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_catmt.log
