cwlVersion: v1.2
class: CommandLineTool
baseCommand: KatComp
label: merquryfk_KatComp
doc: "Compare k-mer counts between two sources and generate plots.\n\nTool homepage:
  https://github.com/thegenemyers/MERQURY.FK"
inputs:
  - id: source1
    type: File
    doc: First k-mer count file (.ktab)
    inputBinding:
      position: 1
  - id: source2
    type: File
    doc: Second k-mer count file (.ktab)
    inputBinding:
      position: 2
  - id: out
    type: string
    doc: Output file name (extension determined by -pdf flag)
    inputBinding:
      position: 3
  - id: draw_fill_plot
    type:
      - 'null'
      - boolean
    doc: draw fill plot
    inputBinding:
      position: 104
      prefix: -f
  - id: draw_line_plot
    type:
      - 'null'
      - boolean
    doc: draw line plot
    inputBinding:
      position: 104
      prefix: -l
  - id: draw_stack_plot
    type:
      - 'null'
      - boolean
    doc: draw stack plot
    inputBinding:
      position: 104
      prefix: -s
  - id: height
    type:
      - 'null'
      - float
    doc: height in inches of plots
    default: 4.5
    inputBinding:
      position: 104
      prefix: -h
  - id: max_x_absolute
    type:
      - 'null'
      - int
    doc: max x as an int value in absolute terms
    inputBinding:
      position: 104
      prefix: -X
  - id: max_x_multiple
    type:
      - 'null'
      - float
    doc: max x as a real-valued multiple of x* with max count 'peak' away from 
      the origin
    default: x2.1
    inputBinding:
      position: 104
      prefix: -x
  - id: max_y_absolute
    type:
      - 'null'
      - int
    doc: max y as an int value in absolute terms
    inputBinding:
      position: 104
      prefix: -Y
  - id: max_y_multiple
    type:
      - 'null'
      - float
    doc: max y as a real-valued multiple of y* with max count 'peak' away from 
      the origin
    default: y2.1
    inputBinding:
      position: 104
      prefix: -y
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: output .pdf (default is .png)
    inputBinding:
      position: 104
      prefix: -pdf
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 4
    inputBinding:
      position: 104
      prefix: -T
  - id: width
    type:
      - 'null'
      - float
    doc: width in inches of plots
    default: 6.0
    inputBinding:
      position: 104
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_KatComp.out
