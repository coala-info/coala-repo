cwlVersion: v1.2
class: CommandLineTool
baseCommand: cats-rf_compare
label: cats-rf_CATS_rf_compare
doc: "transcriptome assembly comparison script\n\nTool homepage: https://github.com/bodulic/CATS-rf"
inputs:
  - id: cats_rf_dir1
    type:
      type: array
      items: Directory
    doc: Directory containing CATS-rf output for comparison
    inputBinding:
      position: 1
  - id: barplot_colors
    type:
      - 'null'
      - string
    doc: Barplot colors (quoted hexadecimal codes or R color names, specified 
      with x,y,z...)
    inputBinding:
      position: 102
      prefix: -b
  - id: comparison_output_dir
    type:
      - 'null'
      - string
    doc: Comparison output directory name
    inputBinding:
      position: 102
      prefix: -D
  - id: figure_dpi
    type:
      - 'null'
      - int
    doc: Figure DPI
    inputBinding:
      position: 102
      prefix: -d
  - id: figure_extension
    type:
      - 'null'
      - string
    doc: Figure extension
    inputBinding:
      position: 102
      prefix: -x
  - id: histogram_colors
    type:
      - 'null'
      - string
    doc: Histogram colors (quoted hexadecimal codes or R color names, specified 
      with x,y,z...)
    inputBinding:
      position: 102
      prefix: -H
  - id: lineplot_colors
    type:
      - 'null'
      - string
    doc: Lineplot colors (quoted hexadecimal codes or R color names, specified 
      with x,y,z...)
    inputBinding:
      position: 102
      prefix: -l
  - id: max_tail_quantile
    type:
      - 'null'
      - float
    doc: Maximum right-tail distribution quantile for histograms
    inputBinding:
      position: 102
      prefix: -q
  - id: overwrite_output_dir
    type:
      - 'null'
      - boolean
    doc: Overwrite the comparison output directory
    inputBinding:
      position: 102
      prefix: -O
  - id: raincloud_colors
    type:
      - 'null'
      - string
    doc: Raincloud plot colors (quoted hexadecimal codes or R color names, 
      specified with x,y,z...)
    inputBinding:
      position: 102
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rf:1.0.4--hdfd78af_0
stdout: cats-rf_CATS_rf_compare.out
