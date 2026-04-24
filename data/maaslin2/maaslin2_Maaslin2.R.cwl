cwlVersion: v1.2
class: CommandLineTool
baseCommand: Maaslin2.R
label: maaslin2_Maaslin2.R
doc: "Maaslin2 is a tool for analyzing microbiome compositional data.\n\nTool homepage:
  http://huttenhower.sph.harvard.edu/maaslin2"
inputs:
  - id: data_file
    type: File
    doc: Input data file in TSV format.
    inputBinding:
      position: 1
  - id: metadata_file
    type: File
    doc: Input metadata file in TSV format.
    inputBinding:
      position: 2
  - id: output_folder
    type: Directory
    doc: Output folder for results.
    inputBinding:
      position: 3
  - id: analysis_method
    type:
      - 'null'
      - string
    doc: The analysis method to apply
    inputBinding:
      position: 104
      prefix: --analysis_method
  - id: cores
    type:
      - 'null'
      - int
    doc: The number of R processes to run in parallel
    inputBinding:
      position: 104
      prefix: --cores
  - id: correction
    type:
      - 'null'
      - string
    doc: The correction method for computing the q-value
    inputBinding:
      position: 104
      prefix: --correction
  - id: fixed_effects
    type:
      - 'null'
      - string
    doc: The fixed effects for the model, comma-delimited for multiple effects
    inputBinding:
      position: 104
      prefix: --fixed_effects
  - id: heatmap_first_n
    type:
      - 'null'
      - int
    doc: In heatmap, plot top N features with significant associations
    inputBinding:
      position: 104
      prefix: --heatmap_first_n
  - id: max_pngs
    type:
      - 'null'
      - int
    doc: The maximum number of scatterplots for signficant associations to save 
      as png files
    inputBinding:
      position: 104
      prefix: --max_pngs
  - id: max_significance
    type:
      - 'null'
      - float
    doc: The q-value threshold for significance
    inputBinding:
      position: 104
      prefix: --max_significance
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: The minimum abundance for each feature
    inputBinding:
      position: 104
      prefix: --min_abundance
  - id: min_prevalence
    type:
      - 'null'
      - float
    doc: The minimum percent of samples for which a feature is detected at 
      minimum abundance
    inputBinding:
      position: 104
      prefix: --min_prevalence
  - id: min_variance
    type:
      - 'null'
      - float
    doc: Keep features with variances greater than value
    inputBinding:
      position: 104
      prefix: --min_variance
  - id: normalization
    type:
      - 'null'
      - string
    doc: The normalization method to apply
    inputBinding:
      position: 104
      prefix: --normalization
  - id: plot_heatmap
    type:
      - 'null'
      - boolean
    doc: Generate a heatmap for the significant associations
    inputBinding:
      position: 104
      prefix: --plot_heatmap
  - id: plot_scatter
    type:
      - 'null'
      - boolean
    doc: Generate scatter plots for the significant associations
    inputBinding:
      position: 104
      prefix: --plot_scatter
  - id: random_effects
    type:
      - 'null'
      - string
    doc: The random effects for the model, comma-delimited for multiple effects
    inputBinding:
      position: 104
      prefix: --random_effects
  - id: reference
    type:
      - 'null'
      - string
    doc: The factor to use as a reference for a variable with more than two 
      levels provided as a string of 'variable,reference' semi-colon delimited 
      for multiple variables
    inputBinding:
      position: 104
      prefix: --reference
  - id: save_models
    type:
      - 'null'
      - boolean
    doc: Return the full model outputs and save to an RData file
    inputBinding:
      position: 104
      prefix: --save_models
  - id: save_scatter
    type:
      - 'null'
      - boolean
    doc: Save all scatter plot ggplot objects to an RData file
    inputBinding:
      position: 104
      prefix: --save_scatter
  - id: standardize
    type:
      - 'null'
      - boolean
    doc: Apply z-score so continuous metadata are on the same scale
    inputBinding:
      position: 104
      prefix: --standardize
  - id: transform
    type:
      - 'null'
      - string
    doc: The transform to apply
    inputBinding:
      position: 104
      prefix: --transform
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maaslin2:1.16.0--r43hdfd78af_0
stdout: maaslin2_Maaslin2.R.out
