cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquantome viz
label: metaquantome_viz
doc: "The viz module is the final step in the metaQuantome analysis workflow. The
  available visualizations are:\n-bar plot\n-volcano plot\n-heatmap\n-PCA plot\nPlease
  consult the manuscript (https://doi.org/10.1074/mcp.ra118.001240.) for full details
  on each of these plots.\n\nTool homepage: https://github.com/galaxyproteomics/metaquant"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: If filter_to_sig, the q-value significance level.
    inputBinding:
      position: 101
      prefix: --alpha
  - id: barcol
    type:
      - 'null'
      - string
    doc: (Tax bar and FT dist). Color for the bar fill. The color vector in R is
      c("dodgerblue", "darkorange", "yellow2", "red2", "darkviolet", "black"),  
      so providing a 1 will give the "dodgerblue" color. These same colors are 
      also used in the  heatmap and PCA plot, so the colors can be tweaked to 
      match.
    inputBinding:
      position: 101
      prefix: --barcol
  - id: calculate_sep
    type:
      - 'null'
      - boolean
    doc: Flag. Calculate separation between groups and include in title?
    inputBinding:
      position: 101
      prefix: --calculate_sep
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Path to data directory. The default is <metaquantome_pkg_dir>/data
    inputBinding:
      position: 101
      prefix: --data_dir
  - id: fc_corr_p
    type:
      - 'null'
      - string
    doc: Name of the corrected p-value column in the stat dataframe. Used while 
      generating volcano plot and while using filter_to_sig in heatmap
    inputBinding:
      position: 101
      prefix: --fc_corr_p
  - id: fc_name
    type:
      - 'null'
      - string
    doc: Name of the fold change column in the stat dataframe.
    inputBinding:
      position: 101
      prefix: --fc_name
  - id: feature_cluster_size
    type:
      - 'null'
      - int
    doc: Number of clusters 'k' to cut the feature dendrogram tree. Default = 2
    default: 2
    inputBinding:
      position: 101
      prefix: --feature_cluster_size
  - id: filter_to_sig
    type:
      - 'null'
      - boolean
    doc: Flag. Only plot significant terms? Necessitates use of results from 
      `test`.
    inputBinding:
      position: 101
      prefix: --filter_to_sig
  - id: flip_fc
    type:
      - 'null'
      - boolean
    doc: Flag. Whether to flip the fold change (i.e., multiply log fold change 
      by -1)
    inputBinding:
      position: 101
      prefix: --flip_fc
  - id: gosplit
    type:
      - 'null'
      - boolean
    doc: If using GO terms, whether to make one plot for each of BP, CC, and MF.
    inputBinding:
      position: 101
      prefix: --gosplit
  - id: height
    type:
      - 'null'
      - int
    doc: Height of the image in inches. Defaults vary by plot type.
    inputBinding:
      position: 101
      prefix: --height
  - id: id
    type:
      - 'null'
      - string
    doc: (FT dist bar only) Taxonomic or functional term id - either a NCBI 
      taxID or a GO term id (GO:XXXXXXX)
    inputBinding:
      position: 101
      prefix: --id
  - id: infile
    type: File
    doc: Input file from stat or filter.
    inputBinding:
      position: 101
      prefix: --infile
  - id: meancol
    type:
      - 'null'
      - string
    doc: (Tax bar and FT dist). Mean intensity column name for desired 
      experimental conditio.
    inputBinding:
      position: 101
      prefix: --meancol
  - id: mode
    type: string
    doc: Analysis mode. If ft is chosen, both function and taxonomy files must 
      be provided
    inputBinding:
      position: 101
      prefix: --mode
  - id: name
    type:
      - 'null'
      - string
    doc: (FT dist only) Provide either a taxonomic or functional term name. 
      Either provide this or an --id.
    inputBinding:
      position: 101
      prefix: --name
  - id: nterms
    type:
      - 'null'
      - int
    doc: (Tax bar, FT dist, and stacked bar). Number of taxa or functional terms
      to display. The default is 5.
    default: 5
    inputBinding:
      position: 101
      prefix: --nterms
  - id: ontology
    type:
      - 'null'
      - string
    doc: Which functional terms to use. Ignored (and not required) if mode is 
      not f or ft.
    inputBinding:
      position: 101
      prefix: --ontology
  - id: plottype
    type: string
    doc: Select the type of plot to generate.
    inputBinding:
      position: 101
      prefix: --plottype
  - id: sample_cluster_size
    type:
      - 'null'
      - int
    doc: Number of clusters 'k' to cut the sample dendrogram tree. Default = 2
    default: 2
    inputBinding:
      position: 101
      prefix: --sample_cluster_size
  - id: samps
    type: string
    doc: 'Give the column names in the intensity file that correspond to a given sample
      group. This can either be JSON formatted or be a path to a tabular file. JSON
      example of two experimental groups and two samples in each group: {"A": ["A1",
      "A2"], "B": ["B1", "B2"]}'
    inputBinding:
      position: 101
      prefix: --samps
  - id: strip
    type:
      - 'null'
      - string
    doc: Text to remove from column names for plotting.
    inputBinding:
      position: 101
      prefix: --strip
  - id: target_onto
    type:
      - 'null'
      - string
    doc: (Function and FT dist bar only) Ontology to restrict to, for function 
      distribution.
    inputBinding:
      position: 101
      prefix: --target_onto
  - id: target_rank
    type:
      - 'null'
      - string
    doc: (Tax bar, FT dist, and stacked bar). Taxonomic rank to restrict to in 
      the plot.
    inputBinding:
      position: 101
      prefix: --target_rank
  - id: textannot
    type:
      - 'null'
      - string
    doc: Name of the text annotation column to optionally include in the 
      volcano. If missing, no text will be plotted.
    inputBinding:
      position: 101
      prefix: --textannot
  - id: whichway
    type:
      - 'null'
      - string
    doc: (FT dist only) Which distribution - functional distribution for a taxon
      (f_dist) or taxonomic distribution for a function (t_dist)?
    inputBinding:
      position: 101
      prefix: --whichway
  - id: width
    type:
      - 'null'
      - int
    doc: Width of the image in inches. Defaults vary by plot type.
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: img
    type: File
    doc: Path to the PNG image file (must end in ".png").
    outputBinding:
      glob: $(inputs.img)
  - id: tabfile
    type:
      - 'null'
      - File
    doc: Optional. File to write plot table to.
    outputBinding:
      glob: $(inputs.tabfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
