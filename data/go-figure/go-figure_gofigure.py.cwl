cwlVersion: v1.2
class: CommandLineTool
baseCommand: gofigure.py
label: go-figure_gofigure.py
doc: "GO enrichment visualization based on semantic similarity.\n\nTool homepage:
  https://gitlab.com/evogenlab/GO-Figure"
inputs:
  - id: cluster_labels
    type:
      - 'null'
      - string
    doc: Label clusters numbered based on the sorting option ('numbered'), based
      on the representative GO term ('go'), based on the representative GO term 
      with arrows ('go-arrows') based on the representative GO term name 
      ('description'), or based on the representative GO term name with arrows 
      ('description-numbered').
    inputBinding:
      position: 101
      prefix: --cluster_labels
  - id: colour_label
    type:
      - 'null'
      - string
    doc: Colourbar label. Default is the description of the input used for 
      --colours
    inputBinding:
      position: 101
      prefix: --colour_label
  - id: colours
    type:
      - 'null'
      - string
    doc: Color GO clusters based on p-value ('pval'), log10 p-value 
      ('log10-pval'), number of GO terms that are a member of the cluster 
      ('members'), frequency of the GO term in the GOA database ('frequency'), a
      unique colour per cluster ('unique'), or a user defined value ('user').
    inputBinding:
      position: 101
      prefix: --colours
  - id: description_limit
    type:
      - 'null'
      - int
    doc: Integer character limit of GO term descriptions in the legend.
    inputBinding:
      position: 101
      prefix: --description_limit
  - id: dpi
    type:
      - 'null'
      - int
    doc: Set DPI for outfiles.
    inputBinding:
      position: 101
      prefix: --dpi
  - id: file_type
    type:
      - 'null'
      - string
    doc: Image file type. 'png', 'pdf', 'svg', or 'tiff'.
    inputBinding:
      position: 101
      prefix: --file_type
  - id: font_size
    type:
      - 'null'
      - string
    doc: Font size of the legend. 'xx-small', 'x-small', 'small', 'medium', 
      'large' , 'x-large', or 'xx-large'.
    inputBinding:
      position: 101
      prefix: --font_size
  - id: input_file
    type: File
    doc: "Input file in tabular format with the columns: GO ID + P-value for standard
      input, GO ID + P-Value + Significant for standard-plus input, TopGO output as
      an input, or GoStats output as an input. Can use # or ! or % to comment out
      lines. Change --input_type accordingly. Default input is 'standard'. Example
      input files are found in the root directory."
    inputBinding:
      position: 101
      prefix: --input
  - id: input_type
    type:
      - 'null'
      - string
    doc: Type of input file. Use 'topgo' for standard TopGO input, 'gostats' for
      standard GOStats input, 'standard' for an input file where the first 
      column is the GO ID and the second is the p-value, and 'standard-plus' for
      standard input but with a third column containing a user defined numerical
      value (for TopGO and GOStats input, this is the 'significant' value).
    inputBinding:
      position: 101
      prefix: --input_type
  - id: legend
    type:
      - 'null'
      - string
    doc: Option to show GO terms and descriptions in the legend ('full'), GO 
      term only 'go', description only ('description'), or no legend ('none').
    inputBinding:
      position: 101
      prefix: --legend
  - id: legend_columns
    type:
      - 'null'
      - string
    doc: Legend as a single ('single') column or double ('double') column.
    inputBinding:
      position: 101
      prefix: --legend_columns
  - id: legend_position
    type:
      - 'null'
      - string
    doc: Position the legend at the bottom left ('left'), bottom right 
      ('right'), or bottom center ('center').
    inputBinding:
      position: 101
      prefix: --legend_position
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: Maximum amount of clusters to plot (integer value).
    inputBinding:
      position: 101
      prefix: --max_clusters
  - id: max_label
    type:
      - 'null'
      - int
    doc: Maximum labels to display in the legend.
    inputBinding:
      position: 101
      prefix: --max_label
  - id: max_pvalue
    type:
      - 'null'
      - float
    doc: Maximum p-value to consider (floating value).
    inputBinding:
      position: 101
      prefix: --max_pvalue
  - id: name_changes
    type:
      - 'null'
      - string
    doc: A list of GO terms that will be used as representative of a cluster 
      specifically for naming purposes, but not for internal calculations. This 
      is opposed to the'-- representatives option, which provides GO terms to be
      used as representatives of a cluster both internally and externally. This 
      specific option allows for the renaming of clusters without recalculating 
      the clusters when there is a need to reproduce the original figure. Input 
      is a list of GO terms separated by a comma, such as 
      'GO:0000001,GO:0000002'.
    inputBinding:
      position: 101
      prefix: --name_changes
  - id: ontology
    type:
      - 'null'
      - string
    doc: "Which ontology to use: biological process ('bpo'), molecular function ('mfo'),
      cellular component ('cco'), or all ontologies ('all')."
    inputBinding:
      position: 101
      prefix: --ontology
  - id: opacity
    type:
      - 'null'
      - float
    doc: Set opacity for the clusters, floating point from 0 to 1.
    inputBinding:
      position: 101
      prefix: --opacity
  - id: outfile_appendix
    type:
      - 'null'
      - string
    doc: What to add to the outfiles after 'biological_process', 
      'molecular_function', or 'cellular_component'. By default it will add the 
      value given for --outdir, replacing '/' with '_'.
    inputBinding:
      position: 101
      prefix: --outfile_appendix
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: palette
    type:
      - 'null'
      - string
    doc: Set to any color brewer palette available for MatPlotLib 
      (https://matplotlib.org/3.1.1/tutorials/colors/colormaps.html).
    inputBinding:
      position: 101
      prefix: --palette
  - id: random_state
    type:
      - 'null'
      - int
    doc: Set random state for the calculation of the X and Y label. Useful if 
      you want the figures to be exactly the same. Needs to be an integer or 
      None. Specifying 'None' will create a different orientation of the plot 
      every time.
    inputBinding:
      position: 101
      prefix: --random_state
  - id: representatives
    type:
      - 'null'
      - string
    doc: A list of GO terms that have priority for being a representative of a 
      cluster. I.e. if one term in a cluster has priority, that term will always
      be the representative. If two terms in a cluster have priority, only those
      two will be considered. Input is a list of GO terms separated by a comma, 
      such as 'GO:0000001,GO:0000002'.
    inputBinding:
      position: 101
      prefix: --representatives
  - id: similarity_cutoff
    type:
      - 'null'
      - float
    doc: Similarity cutoff to be used between GO terms, a value between 0 and 1.
    inputBinding:
      position: 101
      prefix: --similarity_cutoff
  - id: size
    type:
      - 'null'
      - string
    doc: Size of GO clusters based on how many GO terms are a member of the 
      cluster ('members'), frequency in GOA database ('frequency'), p-value 
      where smaller = larger size ('pval'), the user defined value ('user'), or 
      a fixed integer for every cluster.
    inputBinding:
      position: 101
      prefix: --size
  - id: size_range
    type:
      - 'null'
      - string
    doc: Set cluster size range to 'small', 'medium', or 'big'.
    inputBinding:
      position: 101
      prefix: --size_range
  - id: sort_by
    type:
      - 'null'
      - string
    doc: "Which values to use for sorting the clusters: 'pval' (p-value) or 'user'
      (user-defined value) or 'user- descending' (user-defined value descending)."
    inputBinding:
      position: 101
      prefix: --sort_by
  - id: sum_user
    type:
      - 'null'
      - boolean
    doc: To sum the user-defined values (column 3) for each member of a cluster.
      Either 'True' or 'False'.
    inputBinding:
      position: 101
      prefix: --sum_user
  - id: title
    type:
      - 'null'
      - string
    doc: Set figure title. Has to be between single or double quotation marks.
    inputBinding:
      position: 101
      prefix: --title
  - id: title_size
    type:
      - 'null'
      - string
    doc: Set title size. 'xx-small', 'x-small', 'small', 'medium', 'large' , 
      'x-large', or 'xx-large'.
    inputBinding:
      position: 101
      prefix: --title_size
  - id: top_level
    type:
      - 'null'
      - string
    doc: "Set top level GO terms for clusters as given by the GO DAG (see https://www.ebi.ac.uk/QuickGO).
      Top level GO terms have to be given separated by comma's, without spaces. E.g.:
      'GO:000001,GO:000008'."
    inputBinding:
      position: 101
      prefix: --top_level
  - id: xlabel
    type:
      - 'null'
      - string
    doc: X-axis label.
    inputBinding:
      position: 101
      prefix: --xlabel
  - id: ylabel
    type:
      - 'null'
      - string
    doc: Y-axis label.
    inputBinding:
      position: 101
      prefix: --ylabel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go-figure:1.0.2--hdfd78af_0
stdout: go-figure_gofigure.py.out
