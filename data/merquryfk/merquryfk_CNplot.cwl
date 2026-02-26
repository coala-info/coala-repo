cwlVersion: v1.2
class: CommandLineTool
baseCommand: CNpLot
label: merquryfk_CNplot
doc: "Plots k-mer counts for sequence data.\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs:
  - id: reads
    type: File
    doc: Input k-mer counts file for reads (optional .ktab suffix)
    inputBinding:
      position: 1
  - id: asm
    type: string
    doc: Assembly file (expected to be dna)
    inputBinding:
      position: 2
  - id: draw_fill
    type:
      - 'null'
      - boolean
    doc: draw fill plot
    inputBinding:
      position: 103
      prefix: -f
  - id: draw_line
    type:
      - 'null'
      - boolean
    doc: draw line plot
    inputBinding:
      position: 103
      prefix: -l
  - id: draw_stack
    type:
      - 'null'
      - boolean
    doc: draw stack plot
    inputBinding:
      position: 103
      prefix: -s
  - id: height
    type:
      - 'null'
      - float
    doc: height in inches of plots
    default: 4.5
    inputBinding:
      position: 103
      prefix: -h
  - id: keep_plotting_data
    type:
      - 'null'
      - boolean
    doc: keep plotting data as <out>.cni for a later go
    inputBinding:
      position: 103
      prefix: -k
  - id: max_x_absolute
    type:
      - 'null'
      - int
    doc: max x as an int value in absolute terms
    inputBinding:
      position: 103
      prefix: -X
  - id: max_x_multiple
    type:
      - 'null'
      - float
    doc: max x as a real-valued multiple of x* with max count 'peak' away from 
      the origin
    default: 2.1
    inputBinding:
      position: 103
      prefix: -x
  - id: max_y_absolute
    type:
      - 'null'
      - int
    doc: max y as an int value in absolute terms
    inputBinding:
      position: 103
      prefix: -Y
  - id: max_y_multiple
    type:
      - 'null'
      - float
    doc: max y as a real-valued multiple of max count 'peak' away from the 
      origin
    default: 1.1
    inputBinding:
      position: 103
      prefix: -y
  - id: output_pdf
    type:
      - 'null'
      - boolean
    doc: output .pdf (default is .png)
    inputBinding:
      position: 103
      prefix: -pdf
  - id: plot_unique_counts
    type:
      - 'null'
      - boolean
    doc: plot counts of k-mers unique to assembly
    inputBinding:
      position: 103
      prefix: -z
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Place all temporary files in directory -P.
    default: $TMPDIR
    inputBinding:
      position: 103
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 4
    inputBinding:
      position: 103
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output to stderr
    inputBinding:
      position: 103
      prefix: -v
  - id: width
    type:
      - 'null'
      - float
    doc: width in inches of plots
    default: 6.0
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file prefix (optional .cni suffix)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
