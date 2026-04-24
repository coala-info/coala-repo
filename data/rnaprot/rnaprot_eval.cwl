cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaprot eval
label: rnaprot_eval
doc: "Evaluation of trained models\n\nTool homepage: https://github.com/BackofenLab/RNAProt"
inputs:
  - id: add_train_in
    type:
      - 'null'
      - string
    doc: Second model training folder (output of rnaprot train) for comparing 
      prediction scores of both models on --gt-in positive dataset. Note that if
      dataset features of the two models are not identical, comparison might be 
      less informative
    inputBinding:
      position: 101
      prefix: --add-train-in
  - id: bottom_up
    type:
      - 'null'
      - boolean
    doc: Plot bottom profiles as well
    inputBinding:
      position: 101
      prefix: --bottom-up
  - id: gt_in
    type: Directory
    doc: Input training data folder (output of rnaprot gt)
    inputBinding:
      position: 101
      prefix: --gt-in
  - id: lookup_profile
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide site ID(s) for which to plot the feature profile in addition to
      --nr-top-profiles (e.g. --lookup-profile site_id1 site_id2 ). Site ID 
      needs to be in positive set from --gt-in
    inputBinding:
      position: 101
      prefix: --lookup-profile
  - id: motif_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Motif size(s) (widths) for extracting and plotting motifs. Provide 
      multiple sizes (e.g. --motif-size 5 7 9) to extract a motif for each size
    inputBinding:
      position: 101
      prefix: --motif-size
  - id: nr_top_profiles
    type:
      - 'null'
      - int
    doc: Specify number of top predicted sites to plot profiles for
    inputBinding:
      position: 101
      prefix: --nr-top-profiles
  - id: nr_top_sites
    type:
      - 'null'
      - type: array
        items: int
    doc: Specify number(s) of top-predicted sites used for motif extraction. 
      Provide multiple numbers (e.g. --nr- top-sites 100 200 500) to extract one
      motif plot from each site set
    inputBinding:
      position: 101
      prefix: --nr-top-sites
  - id: plot_format
    type:
      - 'null'
      - string
    doc: 'Plotting format of motifs and profiles (does not affect plots generated
      for --report). 1: png, 2: pdf'
    inputBinding:
      position: 101
      prefix: --plot-format
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate an .html report containing various additional statistics and 
      plots
    inputBinding:
      position: 101
      prefix: --report
  - id: theme
    type:
      - 'null'
      - string
    doc: 'Set theme for .html report (1: palm beach, 2: midnight sunset)'
    inputBinding:
      position: 101
      prefix: --theme
  - id: train_in
    type: Directory
    doc: Input model training folder (output of rnaprot train)
    inputBinding:
      position: 101
      prefix: --train-in
outputs:
  - id: out
    type: Directory
    doc: Evaluation results output folder
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
