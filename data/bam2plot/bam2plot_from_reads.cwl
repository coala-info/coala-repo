cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2plot
label: bam2plot_from_reads
doc: "Align your reads and plot the coverage!\n\nTool homepage: https://github.com/willros/bam2plot"
inputs:
  - id: sub_command
    type: string
    inputBinding:
      position: 1
  - id: no_guci
    type:
      - 'null'
      - boolean
    doc: Plot GC content?
    inputBinding:
      position: 102
      prefix: --no-guci
  - id: plot_gc
    type:
      - 'null'
      - boolean
    doc: Plot GC content?
    inputBinding:
      position: 102
      prefix: --guci
  - id: plot_type
    type:
      - 'null'
      - string
    doc: How to save the plots
    default: png
    inputBinding:
      position: 102
      prefix: --plot_type
  - id: read_1
    type: File
    doc: Fastq file 1 (Required)
    inputBinding:
      position: 102
      prefix: --read_1
  - id: read_2
    type:
      - 'null'
      - File
    doc: Fastq file 2 (Optional)
    inputBinding:
      position: 102
      prefix: --read_2
  - id: reference
    type: File
    doc: Reference fasta
    inputBinding:
      position: 102
      prefix: --reference
  - id: rolling_window
    type:
      - 'null'
      - int
    doc: Rolling window size
    inputBinding:
      position: 102
      prefix: --rolling_window
outputs:
  - id: out_folder
    type: Directory
    doc: Where to save the plots.
    outputBinding:
      glob: $(inputs.out_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2plot:0.4.0--pyhdfd78af_0
