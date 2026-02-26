cwlVersion: v1.2
class: CommandLineTool
baseCommand: schicexplorer_scHicCorrelate
label: schicexplorer_scHicCorrelate
doc: "Computes pairwise correlations between Hi-C matrices data. The correlation is
  computed taking the values from each pair of matrices and discarding values that
  are zero in both matrices.Parameters that strongly affect correlations are bin size
  of the Hi-C matrices and the considered range. The smaller the bin size of the matrices,
  the finer differences you score. The --range parameter should be selected at a meaningful
  genomic scale according to, for example, the mean size of the TADs in the organism
  you work with.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosomes to be included in the correlation.
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: color_map
    type:
      - 'null'
      - boolean
    doc: 'Color map to use for the heatmap. Available values can be seen here: http://matplotlib.org/examples/color/colormaps_reference.html'
    inputBinding:
      position: 101
      prefix: --colorMap
  - id: figure_size
    type:
      - 'null'
      - string
    doc: Fontsize in the plot for x and y axis.
    default: (25, 20)
    inputBinding:
      position: 101
      prefix: --figuresize
  - id: font_size
    type:
      - 'null'
      - int
    doc: Fontsize in the plot for x and y axis.
    default: 30
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: User defined labels instead of default labels from file names. Multiple
      labels have to be separated by space, e.g. --labels sample1 sample2 
      sample3
    inputBinding:
      position: 101
      prefix: --labels
  - id: log1p
    type:
      - 'null'
      - boolean
    doc: If set, then the log1p of the matrix values is used. This parameter has
      no effect for Spearman correlations but changes the output of Pearson 
      correlation and, for the scatter plot, if set, the visualization of the 
      values is easier.
    inputBinding:
      position: 101
      prefix: --log1p
  - id: matrix
    type: File
    doc: Cells to correlate stored in scool hicCorrelate is better used on 
      un-corrected matrices in order to exclude any changes introduced by the 
      correction.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: method
    type:
      - 'null'
      - string
    doc: Correlation method to use.
    default: pearson
    inputBinding:
      position: 101
      prefix: --method
  - id: plot_file_format
    type:
      - 'null'
      - string
    doc: 'Image format type. If given, this option overrides the image format based
      on the plotFile ending. The available options are: png, emf, eps, pdf and svg.'
    inputBinding:
      position: 101
      prefix: --plotFileFormat
  - id: plot_numbers
    type:
      - 'null'
      - boolean
    doc: If set, then the correlation number is plotted on top of the heatmap.
    inputBinding:
      position: 101
      prefix: --plotNumbers
  - id: range
    type:
      - 'null'
      - string
    doc: In bp with the format low_range:high_range, for example 
      1000000:2000000. If --range is given only counts within this range are 
      considered. The range should be adjusted to the size of interacting 
      domains in the genome you are working with.
    inputBinding:
      position: 101
      prefix: --range
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Using the python multiprocessing module. Is only 
      used with 'cool' matrix format. One master process which is used to read 
      the input file into the buffer and one process which is merging the output
      bam files of the processes into one output bam file. All other threads do 
      the actual computation.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: z_max
    type:
      - 'null'
      - float
    doc: Maximum value for the heatmap intensities.If not specified the value is
      set automatically.
    inputBinding:
      position: 101
      prefix: --zMax
  - id: z_min
    type:
      - 'null'
      - float
    doc: Minimum value for the heatmap intensities. If not specified the value 
      is set automatically.
    inputBinding:
      position: 101
      prefix: --zMin
outputs:
  - id: out_file_name_heatmap
    type:
      - 'null'
      - File
    doc: File name to save the resulting heatmap plot.
    outputBinding:
      glob: $(inputs.out_file_name_heatmap)
  - id: out_file_name_scatter
    type:
      - 'null'
      - File
    doc: File name to save the resulting scatter plot.
    outputBinding:
      glob: $(inputs.out_file_name_scatter)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
