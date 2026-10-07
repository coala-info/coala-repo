cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmip
label: cmip
doc: "Classical Molecular Interaction Potentials (CMIP). Code for ASA (Accessible
  Surface Area) calculation. Computes molecular interaction potentials, electrostatic
  potentials (Poisson-Boltzmann), solvation energies, interaction energies and rigid
  docking of a probe on a host molecule. The calculation is set in a namelist
  parameter file (-i).\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/gelpi/CMIP"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.restart_in)
        writable: true
  - class: EnvVarRequirement
    envDef:
      OMP_NUM_THREADS: $(String(inputs.threads))
inputs:
  - id: parameter_file
    type: File
    doc: Input parameter file (namelist &cntrl ... &end)
    inputBinding:
      position: 1
      prefix: -i
  - id: vdw_params
    type: File
    doc: Van der Waals parameter file (vdwprm; the image holds 
      /usr/local/share/cmip/dat/vdwprm)
    inputBinding:
      position: 1
      prefix: -vdw
  - id: host_pdb
    type:
      - 'null'
      - File
    doc: Host structure in PDB format with charges and atom types
    inputBinding:
      position: 1
      prefix: -hs
  - id: probe_pdb
    type:
      - 'null'
      - File
    doc: Probe structure in PDB format (docking and interaction energy)
    inputBinding:
      position: 1
      prefix: -pr
  - id: grid_in
    type:
      - 'null'
      - File
    doc: Input grid file
    inputBinding:
      position: 1
      prefix: -grdin
  - id: restart_in
    type:
      - 'null'
      - File
    doc: Restart file to read (irest=1); staged writable because CMIP also 
      writes to it
    inputBinding:
      position: 1
      prefix: -rst
  - id: restart_out
    type:
      - 'null'
      - string
    doc: Restart file to write (orest=1); do not combine with restart_in
    inputBinding:
      position: 1
      prefix: -rst
  - id: output
    type: string
    doc: Main output file
    default: cmip.out
    inputBinding:
      position: 1
      prefix: -o
  - id: log
    type:
      - 'null'
      - string
    doc: Log file name
    inputBinding:
      position: 1
      prefix: -l
  - id: grid_out
    type:
      - 'null'
      - string
    doc: Output grid file name
    inputBinding:
      position: 1
      prefix: -grdout
  - id: cube
    type:
      - 'null'
      - string
    doc: Output grid in Gaussian cube format (cubeoutput=1)
    inputBinding:
      position: 1
      prefix: -cube
  - id: out_pdb
    type:
      - 'null'
      - string
    doc: Prefix of the output PDB file with docked probe positions (written as 
      <prefix>.pdb)
    inputBinding:
      position: 1
      prefix: -outpdb
  - id: byatom
    type:
      - 'null'
      - string
    doc: Output file with interaction energies by atom (ebyatom=1)
    inputBinding:
      position: 1
      prefix: -byat
  - id: energies
    type:
      - 'null'
      - string
    doc: Output file name for energies
    inputBinding:
      position: 1
      prefix: -epr
  - id: grid_b
    type:
      - 'null'
      - string
    doc: Output file name for gridB
    inputBinding:
      position: 1
      prefix: -grdb
  - id: gradient
    type:
      - 'null'
      - string
    doc: Output file name for the gradient
    inputBinding:
      position: 1
      prefix: -grad
  - id: desolvation_grid
    type:
      - 'null'
      - string
    doc: Output file name for the desolvation grid (gdesolv)
    inputBinding:
      position: 1
      prefix: -gds
  - id: surface
    type:
      - 'null'
      - string
    doc: Output file name for the surface
    inputBinding:
      position: 1
      prefix: -srf
  - id: ats
    type:
      - 'null'
      - string
    doc: Output file name for ats
    inputBinding:
      position: 1
      prefix: -ats
  - id: ats_grid
    type:
      - 'null'
      - string
    doc: Output file name for the ats grid
    inputBinding:
      position: 1
      prefix: -atsgrd
  - id: threads
    type: int
    doc: Number of OpenMP threads (OMP_NUM_THREADS); 1 gives reproducible 
      results
    default: 1
outputs:
  - id: output_file
    type: File
    doc: Main output file
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
  - id: grid_out_file
    type:
      - 'null'
      - File
    doc: Output grid file
    outputBinding:
      glob: $(inputs.grid_out)
  - id: cube_file
    type:
      - 'null'
      - File
    doc: Output grid in cube format
    outputBinding:
      glob: $(inputs.cube)
  - id: out_pdb_file
    type:
      - 'null'
      - File
    doc: PDB file with docked probe positions
    outputBinding:
      glob: "$(inputs.out_pdb ? inputs.out_pdb + '.pdb' : null)"
  - id: restart_file
    type:
      - 'null'
      - File
    doc: Written restart file
    outputBinding:
      glob: $(inputs.restart_out)
  - id: byatom_file
    type:
      - 'null'
      - File
    doc: Interaction energies by atom
    outputBinding:
      glob: $(inputs.byatom)
  - id: other_outputs
    type:
      type: array
      items: File
    doc: Other requested output files (energies, gridB, gradient, desolvation 
      grid, surface, ats, ats grid)
    outputBinding:
      glob: "$([inputs.energies, inputs.grid_b, inputs.gradient, inputs.desolvation_grid,
        inputs.surface, inputs.ats, inputs.ats_grid].filter(function(x){ return x; }))"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmip:2.7.0--h8c3ec31_0
