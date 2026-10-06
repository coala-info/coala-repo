cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ananse
  - plot
label: ananse_plot
doc: "Plot the TF influence scores and the differential gene regulatory network of the top TFs (ANANSE influence output)\n\nTool homepage: https://github.com/vanheeringen-lab/ANANSE"
inputs:
  - id: influence
    type: File
    doc: "TF influence file (ANANSE influence output)"
    inputBinding:
      position: 0
  - id: diff_network
    type: ['null', File]
    doc: "TF influence diffnetwork file (also ANANSE influence output)"
    inputBinding:
      position: 1
      prefix: --diff-network
  - id: outdir
    type: ['null', string]
    doc: "Directory where you wish to store the output (default: ./ANANSE_plot)"
    default: ANANSE_plot
    inputBinding:
      position: 1
      prefix: --outdir
  - id: edge_info
    type: ['null', string]
    doc: "Column to use for edges of GRN, default: 'weight'. When full_output is specified, options are 'wb_diff', 'tf_act_diff', 'tf_expr_diff', 'tg_expr_diff'"
    inputBinding:
      position: 1
      prefix: --edge-info
  - id: edge_min
    type: ['null', float]
    doc: "Minimum value for an edge to be included in the GRN image"
    inputBinding:
      position: 1
      prefix: --edge-min
  - id: node_placement
    type: ['null', string]
    doc: "pyviz cluster algorithm used for node placement, options include: neato, dot, fdp, twopi, sfdp, circo"
    inputBinding:
      position: 1
      prefix: --node-placement
  - id: n_tfs
    type: ['null', int]
    doc: "Amount of TFs to plot in the GRN, default is top 20 differential TFs"
    inputBinding:
      position: 1
      prefix: --n-tfs
  - id: cmap
    type: ['null', string]
    doc: "matlotlib colour library"
    inputBinding:
      position: 1
      prefix: --cmap
  - id: full_output
    type: ['null', boolean]
    doc: "Select if the diffnetwork is a full output file"
    inputBinding:
      position: 1
      prefix: --full-output
  - id: type
    type: ['null', string]
    doc: "Specify the output filetype (default: pdf)"
    inputBinding:
      position: 1
      prefix: --type
outputs:
  - id: plot_dir
    type: Directory
    doc: Output directory with the influence plot and the GRN image
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
