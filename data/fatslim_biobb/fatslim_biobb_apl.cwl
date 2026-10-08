cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fatslim, apl]
label: fatslim_biobb_apl
doc: "FATSLiM (Fast Analysis Toolbox for Simulations of Lipid Membranes): retrieve area per lipid\n\nTool homepage: https://fatslim.github.io/"
inputs:
  - id: conf
    type: File
    doc: "Configuration file (.gro, default conf.gro)"
    inputBinding:
      position: 1
      prefix: --conf
  - id: trajectory
    type: ['null', File]
    doc: "Trajectory file (default traj.trr)"
    inputBinding:
      position: 2
      prefix: --trajectory
  - id: index
    type: File
    doc: "Index file (.ndx, default index.ndx)"
    inputBinding:
      position: 3
      prefix: --index
  - id: hg_group
    type: ['null', string]
    doc: "Index group name used to define lipid headgroups (default headgroups)"
    inputBinding:
      position: 4
      prefix: --hg-group
  - id: interacting_group
    type: ['null', string]
    doc: "Index group name used to define interacting atoms, e.g. protein (default protein)"
    inputBinding:
      position: 5
      prefix: --interacting-group
  - id: nthreads
    type: ['null', int]
    doc: "Number of threads to use (default -1)"
    inputBinding:
      position: 6
      prefix: --nthreads
  - id: begin
    type: ['null', int]
    doc: "First timestep (ps) to use for analysis (default -1)"
    inputBinding:
      position: 7
      prefix: --begin
  - id: begin_frame
    type: ['null', int]
    doc: "First frame (index) to use for analysis (default -1)"
    inputBinding:
      position: 8
      prefix: --begin-frame
  - id: end
    type: ['null', int]
    doc: "Last timestep (ps) to use for analysis (default -1)"
    inputBinding:
      position: 9
      prefix: --end
  - id: end_frame
    type: ['null', int]
    doc: "Last frame (index) to use for analysis (default -1)"
    inputBinding:
      position: 10
      prefix: --end-frame
  - id: verbose
    type: ['null', boolean]
    doc: "Be loud and noisy"
    inputBinding:
      position: 11
      prefix: --verbose
  - id: debug
    type: ['null', boolean]
    doc: "Enable debug output"
    inputBinding:
      position: 12
      prefix: --debug
  - id: idfreq
    type: ['null', int]
    doc: "Frequency used to update membrane identification (identification is always done for the first frame, default 1)"
    inputBinding:
      position: 13
      prefix: --idfreq
  - id: cutoff
    type: ['null', float]
    doc: "Cutoff distance for leaflet identification (default 2)"
    inputBinding:
      position: 14
      prefix: --cutoff
  - id: plot_apl
    type: ['null', string]
    doc: "Name of the .xvg file for the plot of area per lipid over the trajectory"
    inputBinding:
      position: 15
      prefix: --plot-apl
  - id: export_apl_raw
    type: ['null', string]
    doc: "Prefix for raw area per lipid values (one .csv file per frame, named <prefix>_frame_<n>.csv)"
    inputBinding:
      position: 16
      prefix: --export-apl-raw
  - id: apl_by_type
    type: ['null', boolean]
    doc: "Group area per lipid values by lipid types"
    inputBinding:
      position: 17
      prefix: --apl-by-type
  - id: apl_cutoff
    type: ['null', float]
    doc: "Cutoff distance (in nm) used to approximate planar region (default 3.0)"
    inputBinding:
      position: 18
      prefix: --apl-cutoff
  - id: apl_limit
    type: ['null', float]
    doc: "Upper limit (in nm2) considered when calculating individual APL values (default 10.0)"
    inputBinding:
      position: 19
      prefix: --apl-limit
  - id: plot_area
    type: ['null', string]
    doc: "Name of the .xvg file for the plot of area over the trajectory"
    inputBinding:
      position: 20
      prefix: --plot-area
outputs:
  - id: apl_plot
    type: 'File[]'
    doc: "Area per lipid plot"
    outputBinding:
      glob: "$(inputs.plot_apl)"
  - id: apl_raw
    type: 'File[]'
    doc: "Raw area per lipid values"
    outputBinding:
      glob: "$(inputs.export_apl_raw)_*.csv"
  - id: area_plot
    type: 'File[]'
    doc: "Area plot"
    outputBinding:
      glob: "$(inputs.plot_area)"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
stdout: fatslim_biobb_apl.out
