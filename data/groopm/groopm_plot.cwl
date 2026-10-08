cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - plot
label: groopm_plot
doc: "Plotting tool for groopm\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: database
    type: File
    doc: GroopM database file to open (created by groopm parse)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: bids
    type:
      - 'null'
      - type: array
        items: string
    doc: bin ids to plot (None for all)
    inputBinding:
      position: 102
      prefix: --bids
  - id: cm
    type:
      - 'null'
      - string
    doc: set colormap [HSV, Accent, Blues, Spectral, Grayscale, Discrete, 
      DiscretePaired]
    inputBinding:
      position: 102
      prefix: --cm
  - id: folder
    type:
      - 'null'
      - string
    doc: save plots in folder
    inputBinding:
      position: 102
      prefix: --folder
  - id: points
    type:
      - 'null'
      - boolean
    doc: ignore contig lengths when plotting
    inputBinding:
      position: 102
      prefix: --points
  - id: tag
    type:
      - 'null'
      - string
    doc: tag to add to output filename
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: folder_dir
    type:
      - 'null'
      - Directory
    doc: Folder with the plots (when folder is set)
    outputBinding:
      glob: $(inputs.folder)
  - id: plot_files
    type:
      type: array
      items: File
    doc: Plot images written to the working directory
    outputBinding:
      glob:
        - '*.png'
        - '*.jpg'
        - '*.jpeg'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database.basename)
        entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_plot.out
