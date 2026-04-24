cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyGenomeTracks
label: pyGenomeTracks
doc: "Plots genomic tracks on specified region(s). Citations : Ramirez et al. High-resolution
  TADs reveal DNA sequences underlying genome organization in flies. Nature Communications
  (2018) doi:10.1038/s41467-017-02525-w Lopez-Delisle et al. pyGenomeTracks: reproducible
  plots for multivariate genomic datasets. Bioinformatics (2020) doi:10.1093/bioinformatics/btaa692\n\
  \nTool homepage: //github.com/maxplanck-ie/pyGenomeTracks"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Instead of a region, a file containing the regions to plot, in BED 
      format, can be given. If this is the case, multiple files will be created.
      It will use the value of --outFileName as a template and put the 
      coordinates between the file name and the extension.
    inputBinding:
      position: 101
      prefix: --BED
  - id: decreasing_x_axis
    type:
      - 'null'
      - boolean
    doc: By default, the x-axis is increasing. Use this option if you want to 
      see all tracks with a decreasing x-axis.
    inputBinding:
      position: 101
      prefix: --decreasingXAxis
  - id: dpi
    type:
      - 'null'
      - int
    doc: Resolution for the image in case the ouput is a raster graphics image 
      (e.g png, jpg) (default is 72)
    inputBinding:
      position: 101
      prefix: --dpi
  - id: font_size
    type:
      - 'null'
      - string
    doc: Font size for the labels of the plot (default is 0.3 * figure width)
    inputBinding:
      position: 101
      prefix: --fontSize
  - id: height
    type:
      - 'null'
      - int
    doc: Figure height in centimeters. If not given, the figure height is 
      computed based on the heights of the tracks. If given, the track height 
      are proportionally scaled to match the desired figure height.
    inputBinding:
      position: 101
      prefix: --height
  - id: plot_width
    type:
      - 'null'
      - int
    doc: width in centimeters of the plotting (central) part
    inputBinding:
      position: 101
      prefix: --plotWidth
  - id: region
    type:
      - 'null'
      - string
    doc: Region to plot, the format is chr:start-end
    inputBinding:
      position: 101
      prefix: --region
  - id: title
    type:
      - 'null'
      - string
    doc: Plot title
    inputBinding:
      position: 101
      prefix: --title
  - id: out_file_name
    type: string
    doc: File name to save the image, file prefix in case multiple images are
      stored (--outFileName / -out).
    inputBinding:
      position: 101
      prefix: --outFileName
  - id: track_label_fraction
    type:
      - 'null'
      - float
    doc: By default the space dedicated to the track labels is 0.05 of the plot 
      width. This fraction can be changed with this parameter if needed.
    inputBinding:
      position: 101
      prefix: --trackLabelFraction
  - id: track_label_h_align
    type:
      - 'null'
      - string
    doc: By default, the horizontal alignment of the track labels is left. This 
      alignemnt can be changed to right or center.
    inputBinding:
      position: 101
      prefix: --trackLabelHAlign
  - id: tracks
    type: File
    doc: File containing the instructions to plot the tracks. The tracks.ini 
      file can be genarated using the `make_tracks_file` program.
    inputBinding:
      position: 101
      prefix: --tracks
  - id: width
    type:
      - 'null'
      - int
    doc: figure width in centimeters (default is 40)
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output_plot
    type: File
    doc: Image written to out_file_name (single file; use a workflow step for
      multiple BED regions if needed).
    outputBinding:
      glob: $(inputs.out_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygenometracks:3.9--pyhdfd78af_0
