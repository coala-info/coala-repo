cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper recovery_heatmap
label: hybpiper_recovery_heatmap
doc: "Generates a heatmap of recovery based on sequence lengths.\n\nTool homepage:
  https://github.com/mossmatters/HybPiper"
inputs:
  - id: seq_lengths_file
    type: File
    doc: Filename for the seq_lengths file (output of the 'hybpiper stats' 
      command)
    inputBinding:
      position: 1
  - id: figure_height
    type:
      - 'null'
      - int
    doc: Height dimension (in inches) for the output heatmap file. Default is 
      automatically calculated based on the number of samples
    inputBinding:
      position: 102
      prefix: --figure_height
  - id: figure_length
    type:
      - 'null'
      - int
    doc: Length dimension (in inches) for the output heatmap file. Default is 
      automatically calculated based on the number of genes
    inputBinding:
      position: 102
      prefix: --figure_length
  - id: gene_text_size
    type:
      - 'null'
      - int
    doc: Size (in points) for the gene text labels in the output heatmap file. 
      Default is automatically calculated based on the number of genes
    inputBinding:
      position: 102
      prefix: --gene_text_size
  - id: heatmap_dpi
    type:
      - 'null'
      - int
    doc: Dot per inch (DPI) for the output heatmap image. Default is 100
    inputBinding:
      position: 102
      prefix: --heatmap_dpi
  - id: heatmap_filename
    type:
      - 'null'
      - string
    doc: Filename for the output heatmap, saved by default as a *.png file.
    inputBinding:
      position: 102
      prefix: --heatmap_filename
  - id: heatmap_filetype
    type:
      - 'null'
      - string
    doc: File type to save the output heatmap image as. Default is *.png
    inputBinding:
      position: 102
      prefix: --heatmap_filetype
  - id: no_xlabels
    type:
      - 'null'
      - boolean
    doc: If supplied, do not render labels for x-axis (loci) in the saved 
      heatmap figure
    inputBinding:
      position: 102
      prefix: --no_xlabels
  - id: no_ylabels
    type:
      - 'null'
      - boolean
    doc: If supplied, do not render labels for y-axis (samples) in the saved 
      heatmap figure
    inputBinding:
      position: 102
      prefix: --no_ylabels
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: If supplied, run the subcommand using cProfile. Saves a *.csv file of 
      results
    inputBinding:
      position: 102
      prefix: --run_profiler
  - id: sample_text_size
    type:
      - 'null'
      - int
    doc: Size (in points) for the sample text labels in the output heatmap file.
      Default is automatically calculated based on the number of samples
    inputBinding:
      position: 102
      prefix: --sample_text_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_recovery_heatmap.out
