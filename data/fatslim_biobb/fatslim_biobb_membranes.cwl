cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fatslim, membranes]
label: fatslim_biobb_membranes
doc: "FATSLiM (Fast Analysis Toolbox for Simulations of Lipid Membranes): identify and report membranes\n\nTool homepage: https://fatslim.github.io/"
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
  - id: output
    type: ['null', string]
    doc: "Name of the plot file with the number of membranes over the selected frames"
    inputBinding:
      position: 13
      prefix: --output
  - id: output_index_hg
    type: ['null', string]
    doc: "Index group file prefix to store headgroups (one file per frame, named <prefix>_<frame>.ndx)"
    inputBinding:
      position: 14
      prefix: --output-index-hg
  - id: output_index
    type: ['null', string]
    doc: "Index group file prefix to store leaflets or aggregates (one file per frame)"
    inputBinding:
      position: 15
      prefix: --output-index
  - id: cutoff
    type: ['null', float]
    doc: "Cutoff distance (in nm) for leaflet identification (default 2.0)"
    inputBinding:
      position: 16
      prefix: --cutoff
outputs:
  - id: output_plot
    type: 'File[]'
    doc: "Plot of the number of membranes"
    outputBinding:
      glob: "$(inputs.output)"
  - id: index_files_headgroups
    type: 'File[]'
    doc: "Index files with leaflet headgroups"
    outputBinding:
      glob: "$(inputs.output_index_hg)_*.ndx"
  - id: index_files_leaflets
    type: 'File[]'
    doc: "Index files with leaflets"
    outputBinding:
      glob: "$(inputs.output_index)_*.ndx"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
stdout: fatslim_biobb_membranes.out
