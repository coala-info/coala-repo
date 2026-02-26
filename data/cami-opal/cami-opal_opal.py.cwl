cwlVersion: v1.2
class: CommandLineTool
baseCommand: opal.py
label: cami-opal_opal.py
doc: "OPAL: Open-community Profiling Assessment tooL\n\nTool homepage: https://github.com/CAMI-challenge/OPAL"
inputs:
  - id: profiles_files
    type:
      type: array
      items: File
    doc: Files of profiles
    inputBinding:
      position: 1
  - id: branch_length_function
    type:
      - 'null'
      - string
    doc: 'UniFrac tree branch length function (default: "lambda x: 1/x", where x=tree
      depth)'
    default: '"lambda x: 1/x"'
    inputBinding:
      position: 102
      prefix: --branch_length_function
  - id: desc
    type:
      - 'null'
      - string
    doc: Description for HTML page
    inputBinding:
      position: 102
      prefix: --desc
  - id: filter
    type:
      - 'null'
      - float
    doc: Filter out the predictions with the smallest relative abundances 
      summing up to [FILTER]% within a rank
    inputBinding:
      position: 102
      prefix: --filter
  - id: gold_standard_file
    type: File
    doc: Gold standard file
    inputBinding:
      position: 102
      prefix: --gold_standard_file
  - id: labels
    type:
      - 'null'
      - string
    doc: Comma-separated profiles names
    inputBinding:
      position: 102
      prefix: --labels
  - id: memory
    type:
      - 'null'
      - string
    doc: Comma-separated memory usages in gigabytes
    inputBinding:
      position: 102
      prefix: --memory
  - id: metrics_plot_abs
    type:
      - 'null'
      - string
    doc: 'Metrics for spider plot of absolute performances, first character, comma-separated.
      Valid metrics: c:completeness, p:purity, b:Bray-Curtis (default: c,p)'
    default: c,p
    inputBinding:
      position: 102
      prefix: --metrics_plot_abs
  - id: metrics_plot_rel
    type:
      - 'null'
      - string
    doc: 'Metrics for spider plot of relative performances, first character, comma-separated.
      Valid metrics: w:weighted Unifrac, l:L1 norm, c:completeness, p:purity, f:false
      positives, t:true positives (default: w,l,c,p,f)'
    default: w,l,c,p,f
    inputBinding:
      position: 102
      prefix: --metrics_plot_rel
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize samples
    inputBinding:
      position: 102
      prefix: --normalize
  - id: normalized_unifrac
    type:
      - 'null'
      - boolean
    doc: Compute normalized version of weighted UniFrac by dividing by the 
      theoretical max unweighted UniFrac
    inputBinding:
      position: 102
      prefix: --normalized_unifrac
  - id: plot_abundances
    type:
      - 'null'
      - boolean
    doc: Plot abundances in the gold standard (can take some minutes)
    inputBinding:
      position: 102
      prefix: --plot_abundances
  - id: ranks
    type:
      - 'null'
      - string
    doc: 'Highest and lowest taxonomic ranks to consider in performance rankings,
      comma-separated. Valid ranks: superkingdom, phylum, class, order, family, genus,
      species, strain (default:superkingdom,species)'
    default: superkingdom,species
    inputBinding:
      position: 102
      prefix: --ranks
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silent mode
    inputBinding:
      position: 102
      prefix: --silent
  - id: time
    type:
      - 'null'
      - string
    doc: Comma-separated runtimes in hours
    inputBinding:
      position: 102
      prefix: --time
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write the results to
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-opal:1.0.13--pyhdfd78af_0
