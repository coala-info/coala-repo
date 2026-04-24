cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nucleoatac
  - vprocess
label: nucleoatac_vprocess
doc: "Processes nucleosome positioning data to generate various outputs and plots
  related to insert sizes and nucleosome footprints.\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs:
  - id: flank_distance
    type:
      - 'null'
      - int
    doc: distance on each side of dyad to include
    inputBinding:
      position: 101
      prefix: --flank
  - id: lower_limit
    type:
      - 'null'
      - int
    doc: lower limit (inclusive) in insert size
    inputBinding:
      position: 101
      prefix: --lower
  - id: output_basename
    type: string
    doc: Output basename for generated files
    inputBinding:
      position: 101
      prefix: --out
  - id: plot_extra
    type:
      - 'null'
      - boolean
    doc: Make some additional plots
    inputBinding:
      position: 101
      prefix: --plot_extra
  - id: sizes_file
    type:
      - 'null'
      - File
    doc: Insert distribution file
    inputBinding:
      position: 101
      prefix: --sizes
  - id: smooth_sd
    type:
      - 'null'
      - float
    doc: SD to use for gaussian smoothing. Use 0 for no smoothing.
    inputBinding:
      position: 101
      prefix: --smooth
  - id: upper_limit
    type:
      - 'null'
      - int
    doc: upper limit (exclusive) in insert size
    inputBinding:
      position: 101
      prefix: --upper
  - id: vmat_file
    type:
      - 'null'
      - File
    doc: Accepts VMat file. Default is Vplot from S. Cer.
    inputBinding:
      position: 101
      prefix: --vplot
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
stdout: nucleoatac_vprocess.out
