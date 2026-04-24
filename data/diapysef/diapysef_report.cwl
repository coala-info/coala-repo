cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diapysef
  - report
label: diapysef_report
doc: "Generate a report for a specfific type of plot\n\nTool homepage: https://github.com/Roestlab/dia-pasef"
inputs:
  - id: in_file
    type: File
    doc: Data tsv file that contains data to be plotting. i.e peptide sequence, 
      charge state, m/z, MS level, retention time, ion mobility, and intensity
    inputBinding:
      position: 101
      prefix: --in
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file to save console messages.
    inputBinding:
      position: 101
      prefix: --log_file
  - id: no_plot_contours
    type:
      - 'null'
      - boolean
    doc: Should contour lines be plotted? Arg for type rt_im_heatmap
    inputBinding:
      position: 101
      prefix: --no-plot_contours
  - id: plot_contours
    type:
      - 'null'
      - boolean
    doc: Should contour lines be plotted? Arg for type rt_im_heatmap
    inputBinding:
      position: 101
      prefix: --plot_contours
  - id: type
    type:
      - 'null'
      - string
    doc: Type of plot to generate.
    inputBinding:
      position: 101
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - int
    doc: Level of verbosity. 0 - just displays info, 1 - display some debug 
      info, 10 displays a lot of debug info.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type: File
    doc: The pdf file name to save the plots to.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
