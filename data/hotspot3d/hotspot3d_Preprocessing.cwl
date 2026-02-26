cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
label: hotspot3d_Preprocessing
doc: "3D mutation proximity analysis program. Preprocessing steps include parsing
  drugport database, updating proximity files, and running ROI generation, statistical
  calculation, annotation, and prioritization.\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute. Options include: drugport, uppro, prep, calroi,
      statis, anno, trans, cosmic, prior, main, search, cluster, sigclus, summary,
      visual.'
    inputBinding:
      position: 1
  - id: anno
    type:
      - 'null'
      - boolean
    doc: 2c) Add region of interest (ROI) annotation
    inputBinding:
      position: 102
  - id: calroi
    type:
      - 'null'
      - boolean
    doc: 2a) Generate region of interest (ROI) information
    inputBinding:
      position: 102
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: b) Determine mutation-mutation and mutation-drug clusters
    inputBinding:
      position: 102
  - id: cosmic
    type:
      - 'null'
      - boolean
    doc: 2e) Add COSMIC annotation to proximity file
    inputBinding:
      position: 102
  - id: drugport
    type:
      - 'null'
      - boolean
    doc: 0) Parse drugport database (OPTIONAL)
    inputBinding:
      position: 102
  - id: main
    type:
      - 'null'
      - boolean
    doc: 0) Run steps a-f of analysis (BETA)
    inputBinding:
      position: 102
  - id: prep
    type:
      - 'null'
      - boolean
    doc: 2) Run steps 2a-2f of preprocessing
    inputBinding:
      position: 102
  - id: prior
    type:
      - 'null'
      - boolean
    doc: 2f) Prioritization
    inputBinding:
      position: 102
  - id: search
    type:
      - 'null'
      - boolean
    doc: a) 3D mutation proximity searching
    inputBinding:
      position: 102
  - id: sigclus
    type:
      - 'null'
      - boolean
    doc: c) Determine significance of clusters (BETA)
    inputBinding:
      position: 102
  - id: statis
    type:
      - 'null'
      - boolean
    doc: 2b) Calculate p_values for pairs of mutations
    inputBinding:
      position: 102
  - id: summary
    type:
      - 'null'
      - boolean
    doc: d) Summarize clusters
    inputBinding:
      position: 102
  - id: trans
    type:
      - 'null'
      - boolean
    doc: 2d) Add transcript annotation
    inputBinding:
      position: 102
  - id: uppro
    type:
      - 'null'
      - boolean
    doc: 1) Update proximity files
    inputBinding:
      position: 102
  - id: visual
    type:
      - 'null'
      - boolean
    doc: e) Visulization of 3D proximity
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
stdout: hotspot3d_Preprocessing.out
