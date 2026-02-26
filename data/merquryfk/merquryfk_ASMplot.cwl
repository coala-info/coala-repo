cwlVersion: v1.2
class: CommandLineTool
baseCommand: ASMpLot
label: merquryfk_ASMplot
doc: "Plots assembly statistics\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs:
  - id: reads
    type:
      - 'null'
      - File
    doc: Reads file (optionally with .ktab suffix)
    inputBinding:
      position: 1
  - id: asm1
    type:
      - 'null'
      - File
    doc: First assembly (dna)
    inputBinding:
      position: 2
  - id: asm2
    type:
      - 'null'
      - File
    doc: Second assembly (dna)
    inputBinding:
      position: 3
  - id: output_asmi
    type:
      - 'null'
      - File
    doc: Output file (optionally with .asmi suffix)
    inputBinding:
      position: 4
  - id: draw_fill_plot
    type:
      - 'null'
      - boolean
    doc: draw fill plot
    inputBinding:
      position: 105
      prefix: -f
  - id: draw_line_plot
    type:
      - 'null'
      - boolean
    doc: draw line plot
    inputBinding:
      position: 105
      prefix: -l
  - id: draw_stack_plot
    type:
      - 'null'
      - boolean
    doc: draw stack plot
    inputBinding:
      position: 105
      prefix: -s
  - id: height
    type:
      - 'null'
      - float
    doc: height in inches of plots
    default: 4.5
    inputBinding:
      position: 105
      prefix: -h
  - id: keep_plotting_data
    type:
      - 'null'
      - boolean
    doc: keep plotting data as <out>.asmi for a later go
    inputBinding:
      position: 105
      prefix: -k
  - id: max_x_absolute
    type:
      - 'null'
      - int
    doc: max x as an int value in absolute terms
    inputBinding:
      position: 105
      prefix: -X
  - id: max_x_multiple
    type:
      - 'null'
      - float
    doc: max x as a real-valued multiple of x* with max count 'peak' away from 
      the origin
    default: 2.1
    inputBinding:
      position: 105
      prefix: -x
  - id: max_y_absolute
    type:
      - 'null'
      - int
    doc: max y as an int value in absolute terms
    inputBinding:
      position: 105
      prefix: -Y
  - id: max_y_multiple
    type:
      - 'null'
      - float
    doc: max y as a real-valued multiple of max count 'peak' away from the 
      origin
    default: 1.1
    inputBinding:
      position: 105
      prefix: -y
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: output .pdf (default is .png)
    inputBinding:
      position: 105
      prefix: -pdf
  - id: plot_unique_kmers
    type:
      - 'null'
      - boolean
    doc: plot counts of k-mers unique to one or both assemblies
    inputBinding:
      position: 105
      prefix: -z
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Place all temporary files in directory -P.
    default: $TMPDIR
    inputBinding:
      position: 105
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 4
    inputBinding:
      position: 105
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output to stderr
    inputBinding:
      position: 105
      prefix: -v
  - id: width
    type:
      - 'null'
      - float
    doc: width in inches of plots
    default: 6.0
    inputBinding:
      position: 105
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_ASMplot.out
