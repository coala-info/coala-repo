cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2plot
label: bam2plot_guci
doc: "Plot GC content of your reference fasta!\n\nTool homepage: https://github.com/willros/bam2plot"
inputs:
  - id: sub_command
    type: string
    inputBinding:
      position: 1
  - id: plot_type
    type:
      - 'null'
      - string
    doc: How to save the plots
    inputBinding:
      position: 102
      prefix: --plot_type
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Reference fasta
    inputBinding:
      position: 102
      prefix: --reference
  - id: window
    type: int
    doc: Rolling window size
    inputBinding:
      position: 102
      prefix: --window
  - id: out_folder_path
    type: Directory
    doc: Output or path parameter `out_folder_path`
    inputBinding:
      position: 103
      prefix: --out-folder
outputs:
  - id: out_folder
    type: Directory
    doc: Where to save the plots.
    outputBinding:
      glob: $(inputs.out_folder_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2plot:0.4.0--pyhdfd78af_0
