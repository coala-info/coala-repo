cwlVersion: v1.2
class: CommandLineTool
baseCommand: KatGC
label: merquryfk_KatGC
doc: "Plots KatGC results\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs:
  - id: source_file
    type: File
    doc: Source file (optionally with .ktab extension)
    inputBinding:
      position: 1
  - id: draw_contour_map
    type:
      - 'null'
      - boolean
    doc: draw a contour map
    inputBinding:
      position: 102
      prefix: -l
  - id: draw_heat_map
    type:
      - 'null'
      - boolean
    doc: draw a heat map
    inputBinding:
      position: 102
      prefix: -f
  - id: draw_heat_map_with_contour_overlay
    type:
      - 'null'
      - boolean
    doc: draw a heat map with contour overlay
    inputBinding:
      position: 102
      prefix: -s
  - id: height
    type:
      - 'null'
      - float
    doc: height in inches of plots
    inputBinding:
      position: 102
      prefix: -h
  - id: max_x_absolute
    type:
      - 'null'
      - int
    doc: max x as an int value in absolute terms
    inputBinding:
      position: 102
      prefix: -X
  - id: max_x_multiple
    type:
      - 'null'
      - float
    doc: max x as a real-valued multiple of x* with max count 'peak' away from 
      the origin
    inputBinding:
      position: 102
      prefix: -x
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: output .pdf (default is .png)
    inputBinding:
      position: 102
      prefix: -pdf
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: -T
  - id: width
    type:
      - 'null'
      - float
    doc: width in inches of plots
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
