cwlVersion: v1.2
class: CommandLineTool
baseCommand: lpp_flip_flop
label: biobb_mem_lipyphilic_flipflop
doc: "Find flip-flop events in a lipid bilayer using the LiPyphilic library.\n\nTool
  homepage: https://github.com/bioexcel/biobb_mem"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file (YAML or JSON) with the tool properties (e.g. lipid_sel,
      ignore_no_box, frame_cutoff)
    inputBinding:
      position: 101
      prefix: --config
  - id: input_top_path
    type: File
    doc: 'Path to the input structure or topology file. Accepted formats: crd, gro, mdcrd,
      mol2, pdb, pdbqt, prmtop, psf, top, tpr, xml, xyz.'
    inputBinding:
      position: 101
      prefix: --input_top_path
  - id: input_traj_path
    type: File
    doc: 'Path to the input trajectory to be processed. Accepted formats: arc, crd, dcd,
      ent, gro, inpcrd, mdcrd, mol2, nc, pdb, pdbqt, restrt, tng, trr, xtc, xyz.'
    inputBinding:
      position: 101
      prefix: --input_traj_path
  - id: input_leaflets_path
    type: File
    doc: 'Path to the input leaflet assignments. Accepted formats: csv, npy.'
    inputBinding:
      position: 101
      prefix: --input_leaflets_path
  - id: output_flip_flop_path
    type: string
    doc: 'Path to the output flip-flop data. Accepted formats: csv.'
    inputBinding:
      position: 102
      prefix: --output_flip_flop_path
outputs:
  - id: output_flip_flop
    type: File
    doc: Output CSV file with the flip-flop events
    outputBinding:
      glob: $(inputs.output_flip_flop_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0
