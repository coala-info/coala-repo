cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fatslim, thickness]
label: fatslim_biobb_thickness
doc: "FATSLiM (Fast Analysis Toolbox for Simulations of Lipid Membranes): retrieve bilayer thickness\n\nTool homepage: https://fatslim.github.io/"
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
  - id: plot_thickness
    type: ['null', string]
    doc: "Name of the .xvg file for the plot of thickness over the trajectory"
    inputBinding:
      position: 15
      prefix: --plot-thickness
  - id: export_thickness_raw
    type: ['null', string]
    doc: "Prefix for raw thickness values (one .csv file per frame, named <prefix>_frame_<n>.csv)"
    inputBinding:
      position: 16
      prefix: --export-thickness-raw
  - id: thickness_cutoff
    type: ['null', float]
    doc: "Cutoff distance (in nm) used to identify inter-leaflet neighbors (default 6.0)"
    inputBinding:
      position: 17
      prefix: --thickness-cutoff
outputs:
  - id: thickness_plot
    type: 'File[]'
    doc: "Thickness plot"
    outputBinding:
      glob: "$(inputs.plot_thickness)"
  - id: thickness_raw
    type: 'File[]'
    doc: "Raw thickness values"
    outputBinding:
      glob: "$(inputs.export_thickness_raw)_*.csv"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
stdout: fatslim_biobb_thickness.out
