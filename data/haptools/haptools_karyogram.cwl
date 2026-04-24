cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haptools
  - karyogram
label: haptools_karyogram
doc: "Visualize a karyogram of local ancestry tracks\n\nTool homepage: https://github.com/cast-genomics/haptools"
inputs:
  - id: bp_file
    type: File
    doc: Path to .bp file with breakpoints
    inputBinding:
      position: 101
      prefix: --bp
  - id: centromeres_file
    type:
      - 'null'
      - File
    doc: Optional file with telomere/centromere cM positions
    inputBinding:
      position: 101
      prefix: --centromeres
  - id: colors
    type:
      - 'null'
      - string
    doc: Optional color dictionary. Input can be from the matplotlib list of 
      colors or in hexcode. Format is e.g. 'YRI:blue,CEU:green'
    inputBinding:
      position: 101
      prefix: --colors
  - id: plot_title
    type:
      - 'null'
      - string
    doc: Optional plot title
    inputBinding:
      position: 101
      prefix: --title
  - id: sample_id
    type: string
    doc: Sample ID to plot
    inputBinding:
      position: 101
      prefix: --sample
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The level of verbosity desired
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_file
    type: File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
