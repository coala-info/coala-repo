cwlVersion: v1.2
class: CommandLineTool
baseCommand: correlationplus calculate
label: correlationplus_calculate
doc: "A Python package to calculate, visualize and analyze protein correlation maps.\n\
  \nTool homepage: https://github.com/tekpinar/correlationplus"
inputs:
  - id: beginning_frame
    type:
      - 'null'
      - int
    doc: Beginning frame in the trajectory to calculate the correlation map 
      (Valid only if you are using a trajectory).
    inputBinding:
      position: 101
      prefix: -b
  - id: correlation_type
    type:
      - 'null'
      - string
    doc: Type of the correlation matrix. It can be dcc, ndcc, tldcc (time-lagged
      dynamical cross-correlations), tlndcc (time-lagged normalized dynamical 
      cross-correlations), lmi or nlmi (normalized lmi). Default value is ndcc. 
      (Optional)
    inputBinding:
      position: 101
      prefix: -t
  - id: cutoff_radius
    type:
      - 'null'
      - float
    doc: Cutoff radius in Angstrom for ANM or GNM. (Optional) Default is 15 for 
      ANM and 10 for GNM.
    inputBinding:
      position: 101
      prefix: -c
  - id: elastic_network_model
    type:
      - 'null'
      - string
    doc: Elastic network model to calculate the correlations. It can be ANM or 
      GNM. Default is ANM. (Optional) (Valid only when you don't have a 
      trajectory file.)
    inputBinding:
      position: 101
      prefix: -m
  - id: ending_frame
    type:
      - 'null'
      - int
    doc: Ending frame in the trajectory to calculate the correlation map (Valid 
      only if you are using a trajectory).
    inputBinding:
      position: 101
      prefix: -e
  - id: num_non_zero_modes
    type:
      - 'null'
      - int
    doc: Number of non-zero modes, when ANM or GNM is used. Default is 100. 
      (Optional) (It can not exceed 3N-6 in ANM and N-1 in GNM, where N is 
      number of Calpha atoms.)
    inputBinding:
      position: 101
      prefix: -n
  - id: pdb_file
    type: File
    doc: PDB file of the protein.
    inputBinding:
      position: 101
      prefix: -p
  - id: trajectory_file
    type:
      - 'null'
      - File
    doc: A trajectory file in dcd, xtc or trr format.
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: This will be your output data file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
