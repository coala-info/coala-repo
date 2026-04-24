cwlVersion: v1.2
class: CommandLineTool
baseCommand: chap
label: chap
doc: "CHAP finds pores in biological macromolecules like ion channels and determines
  the hydration state of these permeation pathways. It can operate on both individual
  structures and on molecular dynamics trajectories. Visit www.channotation.org for
  the full documentation.\n\nTool homepage: https://github.com/channotation/chap"
inputs:
  - id: density_estimation_bandwidth
    type:
      - 'null'
      - float
    doc: Bandwidth for the kernel density estimator. Ignored for other methods. 
      If negative or zero, bandwidth will be determined automatically to 
      minimise the asymptotic mean integrated squared error (AMISE).
    inputBinding:
      position: 101
      prefix: -de-bandwidth
  - id: density_estimation_bandwidth_scale
    type:
      - 'null'
      - float
    doc: Scaling factor for the band width. Useful to set a bandwidth relative 
      to the AMISE-optimal value.
    inputBinding:
      position: 101
      prefix: -de-bw-scale
  - id: density_estimation_evaluation_cutoff
    type:
      - 'null'
      - float
    doc: Evaluation range cutoff for kernel density estimator in multiples of 
      bandwidth. Ignored for other methods. Ensures that the density falls off 
      smoothly to zero outside the data range.
    inputBinding:
      position: 101
      prefix: -de-eval-cutoff
  - id: density_estimation_method
    type:
      - 'null'
      - string
    doc: 'Method used for estimating the probability density of the solvent particles
      along the permeation pathway: histogram, kernel'
    inputBinding:
      position: 101
      prefix: -de-method
  - id: density_estimation_resolution
    type:
      - 'null'
      - float
    doc: Spatial resolution of the density estimator. In case of a histogram, 
      this is the bin width, in case of a kernel density estimator, this is the 
      spacing of the evaluation points.
    inputBinding:
      position: 101
      prefix: -de-res
  - id: first_frame
    type:
      - 'null'
      - float
    doc: First frame (ps) to read from trajectory
    inputBinding:
      position: 101
      prefix: -b
  - id: frame_interval
    type:
      - 'null'
      - float
    doc: Only use frame if t MOD dt == first time (ps)
    inputBinding:
      position: 101
      prefix: -dt
  - id: hydrophobicity_bandwidth
    type:
      - 'null'
      - float
    doc: Bandwidth for hydrophobicity kernel.
    inputBinding:
      position: 101
      prefix: -hydrophob-bandwidth
  - id: hydrophobicity_database
    type:
      - 'null'
      - string
    doc: 'Database of hydrophobicity scale for pore forming residues: hessa_2005,
      kyte_doolittle_1982, monera_1995, moon_2011, wimley_white_1996, zhu_2016, memprotmd,
      user'
    inputBinding:
      position: 101
      prefix: -hydrophob-database
  - id: hydrophobicity_fallback
    type:
      - 'null'
      - float
    doc: Fallback hydrophobicity for residues in the pathway defining group. If 
      unset (nan), residues missing in the database will cause an error.
    inputBinding:
      position: 101
      prefix: -hydrophob-fallback
  - id: hydrophobicity_json
    type:
      - 'null'
      - File
    doc: JSON file with user defined hydrophobicity scale. Will be ignored 
      unless -hydrophobicity-database is set to 'user'.
    inputBinding:
      position: 101
      prefix: -hydrophob-json
  - id: index_file
    type:
      - 'null'
      - File
    doc: Extra index groups
    inputBinding:
      position: 101
      prefix: -n
  - id: last_frame
    type:
      - 'null'
      - float
    doc: Last frame (ps) to read from trajectory
    inputBinding:
      position: 101
      prefix: -e
  - id: nelder_mead_initial_shift
    type:
      - 'null'
      - float
    doc: Distance of vertices in initial Nelder-Mead simplex.
    inputBinding:
      position: 101
      prefix: -nm-init-shift
  - id: nelder_mead_max_iterations
    type:
      - 'null'
      - int
    doc: Number of Nelder-Mead simplex iterations in path finding algorithm.
    inputBinding:
      position: 101
      prefix: -nm-max-iter
  - id: output_detailed
    type:
      - 'null'
      - boolean
    doc: If true, CHAP will write detailed per-frame information to a newline 
      delimited JSON file including original probe positions and spline 
      parameters. This is mostly useful for debugging.
    inputBinding:
      position: 101
      prefix: -out-detailed
  - id: output_extrapolate_distance
    type:
      - 'null'
      - float
    doc: Extrapolation distance beyond the pathway endpoints for both JSON and 
      OBJ output.
    inputBinding:
      position: 101
      prefix: -out-extrap-dist
  - id: output_filename
    type:
      - 'null'
      - string
    doc: File name for output files without file extension.
    inputBinding:
      position: 101
      prefix: -out-filename
  - id: output_grid_distance
    type:
      - 'null'
      - float
    doc: Controls the sampling distance of vertices on the pathway surface which
      are subsequently interpolated to yield a smooth surface. Very small values
      may yield visual artifacts.
    inputBinding:
      position: 101
      prefix: -out-grid-dist
  - id: output_num_points
    type:
      - 'null'
      - int
    doc: Number of spatial sample points that are written to the JSON output 
      file.
    inputBinding:
      position: 101
      prefix: -out-num-points
  - id: output_visual_tweak
    type:
      - 'null'
      - float
    doc: Visual tweaking factor that controls the smoothness of the pathway 
      surface in the OBJ output. Varies between -1 and 1 (exculisvely), where 
      larger values result in a smoother surface. Negative values may result in 
      visualisation artifacts.
    inputBinding:
      position: 101
      prefix: -out-vis-tweak
  - id: path_finding_alignment_method
    type:
      - 'null'
      - string
    doc: 'Method for aligning pathway coordinates across time steps: none, ipp'
    inputBinding:
      position: 101
      prefix: -pf-align-method
  - id: path_finding_channel_direction_vector
    type:
      - 'null'
      - string
    doc: Channel direction vector. Will be normalised to unit vector internally.
    inputBinding:
      position: 101
      prefix: -pf-chan-dir-vec
  - id: path_finding_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff for distance searches in path finding algorithm. A value of zero
      or less means no cutoff is applied. If unset, an appropriate cutoff is 
      determined automatically.
    inputBinding:
      position: 101
      prefix: -pf-cutoff
  - id: path_finding_initial_probe_position
    type:
      - 'null'
      - string
    doc: Initial position of probe in probe-based pore finding algorithms. If 
      set explicitly, it will overwrite the COM-based initial position set with 
      the ippSelflag.
    inputBinding:
      position: 101
      prefix: -pf-init-probe-pos
  - id: path_finding_initial_probe_position_selection
    type:
      - 'null'
      - string
    doc: Selection of atoms whose COM will be used as initial probe position. If
      not set, the selection specified with 'sel-pathway' will be used.
    inputBinding:
      position: 101
      prefix: -pf-sel-ipp
  - id: path_finding_max_free_distance
    type:
      - 'null'
      - float
    doc: Maximum radius of pore.
    inputBinding:
      position: 101
      prefix: -pf-max-free-dist
  - id: path_finding_max_probe_steps
    type:
      - 'null'
      - int
    doc: Maximum number of steps the probe is moved in either direction.
    inputBinding:
      position: 101
      prefix: -pf-max-probe-steps
  - id: path_finding_method
    type:
      - 'null'
      - string
    doc: 'Path finding method. The default inplane_optim implements the algorithm
      used in the HOLE programme, where the position of a probe sphere is optimised
      in subsequent parallel planes so as to maximise its radius. The alternative
      naive_cylindrical simply uses a cylindrical volume as permeation pathway.: cylindrical,
      inplane_optim'
    inputBinding:
      position: 101
      prefix: -pf-method
  - id: path_finding_probe_step
    type:
      - 'null'
      - float
    doc: Step length for probe movement.
    inputBinding:
      position: 101
      prefix: -pf-probe-step
  - id: path_finding_vdwr_database
    type:
      - 'null'
      - string
    doc: 'Database of van-der-Waals radii to be used in pore finding: hole_amberuni,
      hole_bondi, hole_hardcore, hole_simple, hole_xplor, user'
    inputBinding:
      position: 101
      prefix: -pf-vdwr-database
  - id: path_finding_vdwr_fallback
    type:
      - 'null'
      - float
    doc: Fallback van-der-Waals radius for atoms that are not listed in 
      van-der-Waals radius database. Unless this is set to a positive value, an 
      error will be thrown if a pathway-forming atom has no associated 
      van-der-Waals radius in the database.
    inputBinding:
      position: 101
      prefix: -pf-vdwr-fallback
  - id: path_finding_vdwr_json
    type:
      - 'null'
      - File
    doc: JSON file with user defined van-der-Waals radii. Will be ignored unless
      -pf-vdwr-database is set to 'user'.
    inputBinding:
      position: 101
      prefix: -pf-vdwr-json
  - id: pathway_selection
    type:
      - 'null'
      - string
    doc: Reference group that defines the permeation pathway (usually 'Protein')
    inputBinding:
      position: 101
      prefix: -sel-pathway
  - id: pore_model_path_finding_selection
    type:
      - 'null'
      - string
    doc: Selection string that determines the group of atoms in each residue 
      whose centre of geometry's distance from the centre line is used to 
      determine if a residue is pore-facing.
    inputBinding:
      position: 101
      prefix: -pm-pf-sel
  - id: pore_model_pathway_lining_margin
    type:
      - 'null'
      - float
    doc: Margin for determining pathway lining residues. A residue is considered
      to be pathway lining if it is no further than the local path radius plus 
      this margin from the pathway's centre line.
    inputBinding:
      position: 101
      prefix: -pm-pl-margin
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Provide selections from files
    inputBinding:
      position: 101
      prefix: -sf
  - id: selection_output_position
    type:
      - 'null'
      - string
    doc: 'Default selection output positions: atom, res_com, res_cog, mol_com, mol_cog,
      whole_res_com, whole_res_cog, whole_mol_com, whole_mol_cog, part_res_com, part_res_cog,
      part_mol_com, part_mol_cog, dyn_res_com, dyn_res_cog, dyn_mol_com, dyn_mol_cog'
    inputBinding:
      position: 101
      prefix: -seltype
  - id: selection_reference_position
    type:
      - 'null'
      - string
    doc: 'Selection reference positions: atom, res_com, res_cog, mol_com, mol_cog,
      whole_res_com, whole_res_cog, whole_mol_com, whole_mol_cog, part_res_com, part_res_cog,
      part_mol_com, part_mol_cog, dyn_res_com, dyn_res_cog, dyn_mol_com, dyn_mol_cog'
    inputBinding:
      position: 101
      prefix: -selrpos
  - id: simulated_annealing_cooling_factor
    type:
      - 'null'
      - float
    doc: Simulated annealing cooling factor.
    inputBinding:
      position: 101
      prefix: -sa-cooling-fac
  - id: simulated_annealing_initial_temperature
    type:
      - 'null'
      - float
    doc: Simulated annealing initial temperature.
    inputBinding:
      position: 101
      prefix: -sa-init-temp
  - id: simulated_annealing_max_iterations
    type:
      - 'null'
      - int
    doc: Number of cooling iterations in one simulated annealing run.
    inputBinding:
      position: 101
      prefix: -sa-max-iter
  - id: simulated_annealing_seed
    type:
      - 'null'
      - int
    doc: Seed used in pseudo random number generation for simulated annealing. 
      If not set explicitly, a random seed is used.
    inputBinding:
      position: 101
      prefix: -sa-seed
  - id: simulated_annealing_step
    type:
      - 'null'
      - float
    doc: Step length factor used in candidate generation.
    inputBinding:
      position: 101
      prefix: -sa-step
  - id: solvent_selection
    type:
      - 'null'
      - string
    doc: Group of small particles to calculate density of (usually 'Water')
    inputBinding:
      position: 101
      prefix: -sel-solvent
  - id: structure_file
    type:
      - 'null'
      - File
    doc: 'Input structure: tpr gro g96 pdb brk ent'
    inputBinding:
      position: 101
      prefix: -s
  - id: time_unit
    type:
      - 'null'
      - string
    doc: 'Unit for time values: fs, ps, ns, us, ms, s'
    inputBinding:
      position: 101
      prefix: -tu
  - id: trajectory_file
    type:
      - 'null'
      - File
    doc: 'Input trajectory or single configuration: xtc trr cpt gro g96 pdb tng'
    inputBinding:
      position: 101
      prefix: -f
  - id: trajectory_group_selection
    type:
      - 'null'
      - string
    doc: Atoms stored in the trajectory file (if not set, assume first N atoms)
    inputBinding:
      position: 101
      prefix: -fgroup
  - id: xvg_format
    type:
      - 'null'
      - string
    doc: 'Plot formatting: none, xmgrace, xmgr'
    inputBinding:
      position: 101
      prefix: -xvg
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chap:0.9.1--h2df963e_2
stdout: chap.out
