cwlVersion: v1.2
class: CommandLineTool
baseCommand: export2graphlan.py
label: export2graphlan_export2graphlan.py
doc: "Convert MetaPhlAn, LEfSe, and/or HUMAnN output to GraPhlAn input format.\n\n\
  Tool homepage: https://github.com/segatalab/export2graphlan"
inputs:
  - id: abundance_threshold
    type:
      - 'null'
      - float
    doc: Set the minimun abundace value for a clade to be annotated.
    inputBinding:
      position: 101
      prefix: --abundance_threshold
  - id: annotation_legend_font_size
    type:
      - 'null'
      - int
    doc: Set the font size for the annotation legend.
    inputBinding:
      position: 101
      prefix: --annotation_legend_font_size
  - id: annotations
    type:
      - 'null'
      - string
    doc: List which levels should be annotated in the tree. Use a comma separate
      values form, e.g., --annotation_levels 1,2,3.
    inputBinding:
      position: 101
      prefix: --annotations
  - id: background_clades
    type:
      - 'null'
      - string
    doc: Specify the clades that should be highlight with a shaded background. 
      Use a comma separate values form and surround the string with " if there 
      are spaces.
    inputBinding:
      position: 101
      prefix: --background_clades
  - id: background_colors
    type:
      - 'null'
      - string
    doc: Set the color to use for the shaded background. Colors can be either in
      RGB or HSV format. Can also be a mapping file.
    inputBinding:
      position: 101
      prefix: --background_colors
  - id: background_levels
    type:
      - 'null'
      - string
    doc: List which levels should be highlight with a shaded background. Use a 
      comma separate values form, e.g., --background_levels 1,2,3.
    inputBinding:
      position: 101
      prefix: --background_levels
  - id: biomarkers2colors
    type:
      - 'null'
      - File
    doc: Mapping file that associates biomarkers to a specific color.
    inputBinding:
      position: 101
      prefix: --biomarkers2colors
  - id: def_clade_size
    type:
      - 'null'
      - int
    doc: Set a default size for clades that are not found as biomarkers by 
      LEfSe.
    inputBinding:
      position: 101
      prefix: --def_clade_size
  - id: def_font_size
    type:
      - 'null'
      - int
    doc: Set a default font size.
    inputBinding:
      position: 101
      prefix: --def_font_size
  - id: def_na
    type:
      - 'null'
      - string
    doc: Set the default value for missing values
    inputBinding:
      position: 101
      prefix: --def_na
  - id: discard_otus
    type:
      - 'null'
      - boolean
    doc: If specified the OTU ids will be discarde from the taxonmy.
    inputBinding:
      position: 101
      prefix: --discard_otus
  - id: external_annotations
    type:
      - 'null'
      - string
    doc: List which levels should use the external legend for the annotation. 
      Use a comma separate values form, e.g., --annotation_levels 1,2,3.
    inputBinding:
      position: 101
      prefix: --external_annotations
  - id: fname_row
    type:
      - 'null'
      - int
    doc: row number containing the names of the features
    inputBinding:
      position: 101
      prefix: --fname_row
  - id: fperc
    type:
      - 'null'
      - int
    doc: Percentile of feature value distribution for sample selection
    inputBinding:
      position: 101
      prefix: --fperc
  - id: ftop
    type:
      - 'null'
      - int
    doc: Number of top features to select
    inputBinding:
      position: 101
      prefix: --ftop
  - id: internal_levels
    type:
      - 'null'
      - boolean
    doc: If specified sum-up from leaf to root the abundances values.
    inputBinding:
      position: 101
      prefix: --internal_levels
  - id: least_biomarkers
    type:
      - 'null'
      - int
    doc: When only lefse_input is provided, you can specify the minimum number 
      of biomarkers to extract.
    inputBinding:
      position: 101
      prefix: --least_biomarkers
  - id: lefse_input
    type:
      - 'null'
      - File
    doc: LEfSe input data. A file that can be given to LEfSe for biomarkers 
      analysis. It can be the result of a MetaPhlAn or HUMAnN analysis
    inputBinding:
      position: 101
      prefix: --lefse_input
  - id: lefse_output
    type:
      - 'null'
      - File
    doc: LEfSe output result data. The result of LEfSe analysis performed on the
      lefse_input file
    inputBinding:
      position: 101
      prefix: --lefse_output
  - id: max_clade_size
    type:
      - 'null'
      - int
    doc: Set the maximum value of clades that are biomarkers.
    inputBinding:
      position: 101
      prefix: --max_clade_size
  - id: max_font_size
    type:
      - 'null'
      - int
    doc: Set the maximum font size.
    inputBinding:
      position: 101
      prefix: --max_font_size
  - id: metadata_rows
    type:
      - 'null'
      - string
    doc: Row numbers to use as metadata
    inputBinding:
      position: 101
      prefix: --metadata_rows
  - id: min_clade_size
    type:
      - 'null'
      - int
    doc: Set the minimum value of clades that are biomarkers.
    inputBinding:
      position: 101
      prefix: --min_clade_size
  - id: min_font_size
    type:
      - 'null'
      - int
    doc: Set the minimum font size to use.
    inputBinding:
      position: 101
      prefix: --min_font_size
  - id: most_abundant
    type:
      - 'null'
      - int
    doc: When only lefse_input is provided, you can specify how many clades 
      highlight.
    inputBinding:
      position: 101
      prefix: --most_abundant
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator for input data matrix
    inputBinding:
      position: 101
      prefix: --sep
  - id: skip_rows
    type:
      - 'null'
      - string
    doc: Row numbers to skip (0-indexed, comma separated) from the input file
    inputBinding:
      position: 101
      prefix: --skip_rows
  - id: sname_row
    type:
      - 'null'
      - int
    doc: column number containing the names of the samples
    inputBinding:
      position: 101
      prefix: --sname_row
  - id: sperc
    type:
      - 'null'
      - int
    doc: Percentile of sample value distribution for sample selection
    inputBinding:
      position: 101
      prefix: --sperc
  - id: stop
    type:
      - 'null'
      - int
    doc: Number of top samples to select
    inputBinding:
      position: 101
      prefix: --stop
  - id: title
    type:
      - 'null'
      - string
    doc: If specified set the title of the GraPhlAn plot.
    inputBinding:
      position: 101
      prefix: --title
  - id: title_font_size
    type:
      - 'null'
      - int
    doc: Set the title font size.
    inputBinding:
      position: 101
      prefix: --title_font_size
outputs:
  - id: tree
    type: File
    doc: Output filename where save the input tree for GraPhlAn
    outputBinding:
      glob: $(inputs.tree)
  - id: annotation
    type: File
    doc: Output filename where save GraPhlAn annotation
    outputBinding:
      glob: $(inputs.annotation)
  - id: out_table
    type:
      - 'null'
      - File
    doc: Write processed data matrix to file
    outputBinding:
      glob: $(inputs.out_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/export2graphlan:0.22--py_0
