cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - micplot
label: ariba_micplot
doc: "Makes a violin and scatter plot of MIC per variant in the summary file\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: prepareref_dir
    type: Directory
    doc: "Name of output directory when \"ariba prepareref\" was run"
    inputBinding:
      position: 10
  - id: antibiotic
    type: string
    doc: "Antibiotic name. Must exactly match a column from the MIC file"
    inputBinding:
      position: 11
  - id: mic_file
    type: File
    doc: "File containing MIC data for each sample and one or more antibiotics"
    inputBinding:
      position: 12
  - id: summary_file
    type: File
    doc: "File made by running \"ariba summary\""
    inputBinding:
      position: 13
  - id: outprefix
    type: string
    doc: "Prefix of output files"
    default: micplot
    inputBinding:
      position: 14
  - id: out_format
    type:
      - 'null'
      - string
    doc: "Output format of image file. Use anything that matplotlib can save to, eg pdf or png [pdf]"
    inputBinding:
      position: 1
      prefix: --out_format
  - id: main_title
    type:
      - 'null'
      - string
    doc: "Main title of plot. Default is to use the antibiotic name"
    inputBinding:
      position: 1
      prefix: --main_title
  - id: plot_height
    type:
      - 'null'
      - float
    doc: "Height of plot in inches [7]"
    inputBinding:
      position: 1
      prefix: --plot_height
  - id: plot_width
    type:
      - 'null'
      - float
    doc: "Width of plot in inches [7]"
    inputBinding:
      position: 1
      prefix: --plot_width
  - id: use_hets
    type:
      - 'null'
      - string
    doc: "How to deal with HET snps. Choose from yes,no,exclude [yes]"
    inputBinding:
      position: 1
      prefix: --use_hets
  - id: interrupted
    type:
      - 'null'
      - boolean
    doc: "Include interrupted genes (as in the assembled column of the ariba summary files)"
    inputBinding:
      position: 1
      prefix: --interrupted
  - id: min_samples
    type:
      - 'null'
      - int
    doc: "Minimum number of samples in each column required to include in plot [1]"
    inputBinding:
      position: 1
      prefix: --min_samples
  - id: no_combinations
    type:
      - 'null'
      - boolean
    doc: "Do not show combinations of variants. Instead separate out into one box/violin plot per variant."
    inputBinding:
      position: 1
      prefix: --no_combinations
  - id: panel_heights
    type:
      - 'null'
      - string
    doc: "Two integers that determine relative height of top and bottom plots, eg 5,1 [9,2]"
    inputBinding:
      position: 1
      prefix: --panel_heights
  - id: panel_widths
    type:
      - 'null'
      - string
    doc: "Two integers that determine relative width of plots and space used by counts legend, eg 5,1 [5,1]"
    inputBinding:
      position: 1
      prefix: --panel_widths
  - id: count_legend_x
    type:
      - 'null'
      - float
    doc: "Control x position of counts legend when plotting points and --point_size 0 [-2]"
    inputBinding:
      position: 1
      prefix: --count_legend_x
  - id: p_cutoff
    type:
      - 'null'
      - float
    doc: "p-value cutoff for Mann-Whitney tests [0.05]"
    inputBinding:
      position: 1
      prefix: --p_cutoff
  - id: xkcd
    type:
      - 'null'
      - boolean
    doc: "Best used with xkcd font installed"
    inputBinding:
      position: 1
      prefix: --xkcd
  - id: colourmap
    type:
      - 'null'
      - string
    doc: "Colours to use. See http://matplotlib.org/users/colormaps.html [Accent]"
    inputBinding:
      position: 1
      prefix: --colourmap
  - id: number_of_colours
    type:
      - 'null'
      - int
    doc: "Number of colours in plot. 0:same number as columns in the plot. 1:all black. >1: take the first N colours from the colourmap [0]"
    inputBinding:
      position: 1
      prefix: --number_of_colours
  - id: colour_skip
    type:
      - 'null'
      - string
    doc: "If using a continuous colourmap, --colour_skip a,b (where 0 <= a < b <= 1) will skip the range between a and b"
    inputBinding:
      position: 1
      prefix: --colour_skip
  - id: plot_types
    type:
      - 'null'
      - string
    doc: "Types of plots to make, separated by commas. Choose from violin,point [violin,point]"
    inputBinding:
      position: 1
      prefix: --plot_types
  - id: hlines
    type:
      - 'null'
      - string
    doc: "Comma-separated list of positions at which to draw horizontal lines"
    inputBinding:
      position: 1
      prefix: --hlines
  - id: jitter_width
    type:
      - 'null'
      - float
    doc: "Jitter width option when plotting points [0.1]"
    inputBinding:
      position: 1
      prefix: --jitter_width
  - id: log_y
    type:
      - 'null'
      - float
    doc: "Base of log applied to y values. Set to zero to not log [2]"
    inputBinding:
      position: 1
      prefix: --log_y
  - id: point_size
    type:
      - 'null'
      - float
    doc: "Size of points when --plot_types includes point. If zero, will group points and size them proportional to the group size [4]"
    inputBinding:
      position: 1
      prefix: --point_size
  - id: point_scale
    type:
      - 'null'
      - float
    doc: "Scale point sizes when --point_size 0 [1]"
    inputBinding:
      position: 1
      prefix: --point_scale
  - id: violin_width
    type:
      - 'null'
      - float
    doc: "Width of violins [0.75]"
    inputBinding:
      position: 1
      prefix: --violin_width
  - id: dot_size
    type:
      - 'null'
      - float
    doc: "Size of dots in lower part of plot [100]"
    inputBinding:
      position: 1
      prefix: --dot_size
  - id: dot_outline
    type:
      - 'null'
      - boolean
    doc: "Black outline around all dots (whether coloured or not) in lower part of plots"
    inputBinding:
      position: 1
      prefix: --dot_outline
  - id: dot_y_text_size
    type:
      - 'null'
      - int
    doc: "Text size of labels [7]"
    inputBinding:
      position: 1
      prefix: --dot_y_text_size
outputs:
  - id: plot_files
    type: File[]
    doc: Plot image and its data tables (outprefix.pdf/png, outprefix.boxplot.tsv, ...)
    outputBinding:
      glob: $(inputs.outprefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
