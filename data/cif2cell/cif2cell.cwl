cwlVersion: v1.2
class: CommandLineTool
baseCommand: cif2cell
label: cif2cell
doc: "A program for generating input lattice structures to various electronic structure
  programs from a CIF (Crystallographic Information Framework) file.\n\nTool homepage:
  https://github.com/torbjornbjorkman/cif2cell"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: cif_file
    type: File
    doc: Input CIF file
    inputBinding:
      position: 1
  - id: verbose
    type: ['null', boolean]
    doc: "Be as verbose as possible."
    inputBinding:
      position: 2
      prefix: --verbose
  - id: quiet
    type: ['null', boolean]
    doc: "Suppress all but explicitly requested screen output. Overrides --verbose flag."
    inputBinding:
      position: 2
      prefix: --quiet
  - id: program
    type: ['null', string]
    doc: "The electronic structure code you want to create input file(s) for. Currently supports: abinit, ase, atat, bmdl, castep, cellgen, cfg, cif, coo, cp2k, cpmd, crystal09, elk, emto, exciting, fhi-aims, fleur, hutsepot, kfcd, kgrn, kstr, lammps, mopac, ncol, pwscf, quantum-espresso, rspt, shape, siesta, spacegroup, spc, sprkkr, vasp, xband, xyz. This keyword is case insensitive."
    inputBinding:
      position: 2
      prefix: --program
  - id: outputfile
    type: ['null', string]
    doc: "Name of output file (if other than default for you electronic structure code)."
    inputBinding:
      position: 2
      prefix: --outputfile
  - id: grammar
    type: ['null', string]
    doc: "Set the CIF grammar to be used when parsing the input file (default is 1.1)."
    inputBinding:
      position: 2
      prefix: --grammar
  - id: which_filename
    type: ['null', boolean]
    doc: "If given together with the --program option, the name of the output file will be printed to screen."
    inputBinding:
      position: 2
      prefix: --which-filename
  - id: block
    type: ['null', string]
    doc: "Block of data in input file (if there are more than one block in the CIF file)."
    inputBinding:
      position: 2
      prefix: --block
  - id: no_reduce
    type: ['null', boolean]
    doc: "Do not reduce to the primitive cell."
    inputBinding:
      position: 2
      prefix: --no-reduce
  - id: force
    type: ['null', boolean]
    doc: "Attempt to force generation of output file despite problems and/or ambiguities in the input file. Implies --force-alloy."
    inputBinding:
      position: 2
      prefix: --force
  - id: force_alloy
    type: ['null', boolean]
    doc: "Force generation of output file for an alloy compound for an electronic structure code that does not implement any alloy theory (such as CPA)."
    inputBinding:
      position: 2
      prefix: --force-alloy
  - id: vca
    type: ['null', boolean]
    doc: "Set up an alloy using the virtual crystal approximation (VCA). Currently only supported by the CASTEP interface."
    inputBinding:
      position: 2
      prefix: --vca
  - id: cartesian
    type: ['null', boolean]
    doc: "Make the program generate any output in cartesian coordinates."
    inputBinding:
      position: 2
      prefix: --cartesian
  - id: coordinate_tolerance
    type: ['null', float]
    doc: "Parameter for determining when two coordinates are the same (default=0.0002)."
    inputBinding:
      position: 2
      prefix: --coordinate-tolerance
  - id: setup_all
    type: ['null', boolean]
    doc: "Make a more complete setup, not just the geometrical part. This is currently only available for mopac, pwscf, quantum-espresso, rspt, vasp."
    inputBinding:
      position: 2
      prefix: --setup-all
  - id: k_resolution
    type: ['null', float]
    doc: "The desired resolution in k-space (default=0.2). Used for generating k-space grid options if --setup-all is specified."
    inputBinding:
      position: 2
      prefix: --k-resolution
  - id: transform_cell
    type: ['null', string]
    doc: "Transformation matrix applied to the lattice vectors and the symmetry operations, as [[],[],[]]."
    inputBinding:
      position: 2
      prefix: --transform-cell
  - id: body_centred_setting
    type: ['null', string]
    doc: "If set to 1, use the more symmetrical set of primitive translation vectors used for the bcc structure also for other body-centred crystals (0 or 1)."
    inputBinding:
      position: 2
      prefix: --body-centred-setting
  - id: cubic_diagonal_z
    type: ['null', boolean]
    doc: "Set up cubic cell with [111] direction along the z-axis."
    inputBinding:
      position: 2
      prefix: --cubic-diagonal-z
  - id: rhombohedral_diagonal
    type: ['null', boolean]
    doc: "Set up rhombohedral cell with threefold axis along pseudocubic [111] direction."
    inputBinding:
      position: 2
      prefix: --rhombohedral-diagonal
  - id: random_displacements
    type: ['null', float]
    doc: "Randomly displace all atoms by this size (maximal displacement for uniform, standard deviation for gaussian distribution) in Angstrom."
    inputBinding:
      position: 2
      prefix: --random-displacements
  - id: random_displacements_distribution
    type: ['null', string]
    doc: "The distribution used for displacing the atoms (uniform or gaussian)."
    inputBinding:
      position: 2
      prefix: --random-displacements-distribution
  - id: export_cif_labels
    type: ['null', boolean]
    doc: "Export atom labels from the CIF file (currently only supported for castep and RSPt)."
    inputBinding:
      position: 2
      prefix: --export-cif-labels
  - id: supercell
    type: ['null', string]
    doc: "Supercell dimensions [k,l,m] or map [[],[],[]] from the primitive cell. Combined with --no-reduce the supercell is generated from the conventional cell."
    inputBinding:
      position: 2
      prefix: --supercell
  - id: supercell_dimensions
    type: ['null', string]
    doc: "Desired absolute supercell dimensions in angstrom [x,y,z], or lattice vectors [[],[],[]]."
    inputBinding:
      position: 2
      prefix: --supercell-dimensions
  - id: supercell_vacuum
    type: ['null', string]
    doc: "Unit cell units of vacuum [k,l,m] to add along the generated lattice vectors."
    inputBinding:
      position: 2
      prefix: --supercell-vacuum
  - id: supercell_translation_vector
    type: ['null', string]
    doc: "Shift [k,l,m] of all atomic positions prior to vacuum generation (in units of the supercell lattice vectors)."
    inputBinding:
      position: 2
      prefix: --supercell-translation-vector
  - id: supercell_postvacuum_translation
    type: ['null', string]
    doc: "Final shift [k,l,m] of all atomic positions (in units of the lattice vectors of the new cell)."
    inputBinding:
      position: 2
      prefix: --supercell-postvacuum-translation
  - id: supercell_realign
    type: ['null', string]
    doc: "Realign the supercell lattice vectors with respect to the cartesian reference frame (0 or 1)."
    inputBinding:
      position: 2
      prefix: --supercell-realign
  - id: supercell_sort
    type: ['null', string]
    doc: "Sort the atom positions by cartesian coordinate (e.g. xzy) or by lattice vector (e.g. 132)."
    inputBinding:
      position: 2
      prefix: --supercell-sort
  - id: surface_wizard
    type: ['null', string]
    doc: "An (hkl) plane [h,k,l]; the wizard suggests a supercell map with the first two lattice vectors in this plane."
    inputBinding:
      position: 2
      prefix: --surface-wizard
  - id: print_digits
    type: ['null', int]
    doc: "Number of digits used when printing coordinates etc. to screen (default=8)."
    inputBinding:
      position: 2
      prefix: --print-digits
  - id: print_atomic_units
    type: ['null', boolean]
    doc: "Output lattice parameters in bohrradii rather than angstrom."
    inputBinding:
      position: 2
      prefix: --print-atomic-units
  - id: print_cartesian
    type: ['null', boolean]
    doc: "Atomic sites printed to screen in cartesian rather than lattice coordinates."
    inputBinding:
      position: 2
      prefix: --print-cartesian
  - id: print_symmetry_operations
    type: ['null', boolean]
    doc: "Print symmetry operations of the generated cell."
    inputBinding:
      position: 2
      prefix: --print-symmetry-operations
  - id: print_seitz_matrices
    type: ['null', boolean]
    doc: "Print symmetry operations of the generated cell in Seitz matrix form."
    inputBinding:
      position: 2
      prefix: --print-seitz-matrices
  - id: print_charge_state
    type: ['null', boolean]
    doc: "Print information about the oxidation state from the CIF file."
    inputBinding:
      position: 2
      prefix: --print-charge-state
  - id: abinit_braces
    type: ['null', boolean]
    doc: "Put curly braces around input values for ABINIT."
    inputBinding:
      position: 2
      prefix: --abinit-braces
  - id: cellgen_map
    type: ['null', string]
    doc: "Supercell map [[k,l,m],[n,o,p],[q,r,s]] for the RSPt supercell generator 'cellgen'. Overrides --cellgen-supercell-dimensions."
    inputBinding:
      position: 2
      prefix: --cellgen-map
  - id: cellgen_supercell_dimensions
    type: ['null', string]
    doc: "Supercell dimensions [k,l,m] for the RSPt supercell generator 'cellgen'."
    inputBinding:
      position: 2
      prefix: --cellgen-supercell-dimensions
  - id: cellgen_reference_vector
    type: ['null', string]
    doc: "Optional origin shift [x,y,z] used by the RSPt supercell generator 'cellgen'."
    inputBinding:
      position: 2
      prefix: --cellgen-reference-vector
  - id: castep_cartesian
    type: ['null', boolean]
    doc: "Output atom positions in cartesian rather than lattice coordinates."
    inputBinding:
      position: 2
      prefix: --castep-cartesian
  - id: castep_atomic_units
    type: ['null', boolean]
    doc: "Output to CASTEP in atomic units (bohr radii) rather than angstrom."
    inputBinding:
      position: 2
      prefix: --castep-atomic-units
  - id: cpmd_cutoff
    type: ['null', float]
    doc: "Set the cutoff written to the &SYSTEM block (default=100.0 Ry)."
    inputBinding:
      position: 2
      prefix: --cpmd-cutoff
  - id: crystal09_rhombohedral_setting
    type: ['null', boolean]
    doc: "For trigonal spacegroups where this is possible, specify the rhombohedral cell in the Crystal09 input."
    inputBinding:
      position: 2
      prefix: --crystal09-rhombohedral-setting
  - id: emto_hard_sphere_radii
    type: ['null', float]
    doc: "Set hard spheres in KSTR to something other than the default (=0.67)."
    inputBinding:
      position: 2
      prefix: --emto-hard-sphere-radii
  - id: fhi_aims_cartesian
    type: ['null', boolean]
    doc: "Store the coordinates for FHI-AIMS in cartesian format."
    inputBinding:
      position: 2
      prefix: --fhi-aims-cartesian
  - id: mopac_first_line
    type: ['null', string]
    doc: "String to be used for the first line (the run commands) of the MOPAC input."
    inputBinding:
      position: 2
      prefix: --mopac-first-line
  - id: mopac_second_line
    type: ['null', string]
    doc: "String to be used for the second line (documentation) of the MOPAC input."
    inputBinding:
      position: 2
      prefix: --mopac-second-line
  - id: mopac_third_line
    type: ['null', string]
    doc: "String to be used for the third line (documentation) of the MOPAC input."
    inputBinding:
      position: 2
      prefix: --mopac-third-line
  - id: mopac_freeze_structure
    type: ['null', string]
    doc: "If set to 'T' then add a 0 after each coordinate (freezing the structure), if set to 'F' then add a 1 (allowing everything to relax)."
    inputBinding:
      position: 2
      prefix: --mopac-freeze-structure
  - id: pwscf_pseudostring
    type: ['null', string]
    doc: "String to attach to the element name to identify the pseudopotential file (e.g. \"_HSCV_PBE-1.0.UPF\")."
    inputBinding:
      position: 2
      prefix: --pwscf-pseudostring
  - id: pwscf_atomic_units
    type: ['null', boolean]
    doc: "Write PWSCF .in file in atomic units (bohr) rather than angstrom."
    inputBinding:
      position: 2
      prefix: --pwscf-atomic-units
  - id: pwscf_alat_units
    type: ['null', boolean]
    doc: "Use 'alat' units for the positions in the PWSCF .in file."
    inputBinding:
      position: 2
      prefix: --pwscf-alat-units
  - id: pwscf_cartesian
    type: ['null', boolean]
    doc: "Write lattice vectors and positions to PWSCF .in file in cartesian coordinates and set the lengths scale to 1."
    inputBinding:
      position: 2
      prefix: --pwscf-cartesian
  - id: pwscf_cartesian_latticevectors
    type: ['null', boolean]
    doc: "Write lattice vectors to PWSCF .in file in cartesian coordinates and set the lengths scale to 1."
    inputBinding:
      position: 2
      prefix: --pwscf-cartesian-latticevectors
  - id: pwscf_cartesian_positions
    type: ['null', boolean]
    doc: "Write lattice positions to PWSCF .in file in cartesian coordinates."
    inputBinding:
      position: 2
      prefix: --pwscf-cartesian-positions
  - id: rspt_new
    type: ['null', boolean]
    doc: "Generate a symt.inp file in the new format."
    inputBinding:
      position: 2
      prefix: --rspt-new
  - id: rspt_spinpol
    type: ['null', boolean]
    doc: "Generate new format symt.inp file with spin polarization."
    inputBinding:
      position: 2
      prefix: --rspt-spinpol
  - id: rspt_relativistic
    type: ['null', boolean]
    doc: "Generate new format symt.inp file with relativistic effects."
    inputBinding:
      position: 2
      prefix: --rspt-relativistic
  - id: rspt_spinaxis
    type: ['null', string]
    doc: "Spin axis [x,y,z] for symt.inp (default is [0.0,0.0,0.0])."
    inputBinding:
      position: 2
      prefix: --rspt-spinaxis
  - id: rspt_no_spin
    type: ['null', boolean]
    doc: "Force a nonmagnetic setup in conjunction with --setup-all."
    inputBinding:
      position: 2
      prefix: --rspt-no-spin
  - id: rspt_mtradii
    type: ['null', int]
    doc: "Integer that gives the method for setting muffin tin radii."
    inputBinding:
      position: 2
      prefix: --rspt-mtradii
  - id: rspt_cartesian_latticevectors
    type: ['null', boolean]
    doc: "Put lattice vectors in atomic units and the lenght scale parameter to 1."
    inputBinding:
      position: 2
      prefix: --rspt-cartesian-latticevectors
  - id: rspt_pass_wyckoff
    type: ['null', boolean]
    doc: "Pass wyckoff labels from CIF file to the symt/rspt.inp file."
    inputBinding:
      position: 2
      prefix: --rspt-pass-wyckoff
  - id: sprkkr_minangmom
    type: ['null', int]
    doc: "Enforce minimum onsite angular momentum (=l+1, so that 3 will be d-states)."
    inputBinding:
      position: 2
      prefix: --sprkkr-minangmom
  - id: spacegroup_supercell
    type: ['null', string]
    doc: "Supercell dimensions [k,l,m] to be output to the elk input generator 'spacegroup'."
    inputBinding:
      position: 2
      prefix: --spacegroup-supercell
  - id: vasp_format
    type: ['null', int]
    doc: "Format of the generated POSCAR file, either 4 or 5. Default is 4."
    inputBinding:
      position: 2
      prefix: --vasp-format
  - id: vasp_print_species
    type: ['null', boolean]
    doc: "Print the atomic species to screen in the order they are put in the POSCAR file."
    inputBinding:
      position: 2
      prefix: --vasp-print-species
  - id: vasp_cartesian
    type: ['null', boolean]
    doc: "Write lattice vectors and positions to POSCAR file in cartesian coordinates and set length to 1."
    inputBinding:
      position: 2
      prefix: --vasp-cartesian
  - id: vasp_cartesian_lattice_vectors
    type: ['null', boolean]
    doc: "Write lattice vectors to POSCAR file in cartesian coordinates and set the length scale to 1."
    inputBinding:
      position: 2
      prefix: --vasp-cartesian-lattice-vectors
  - id: vasp_cartesian_positions
    type: ['null', boolean]
    doc: "Write atomic positions to POSCAR file in Cartesian rather than Direct coordinates."
    inputBinding:
      position: 2
      prefix: --vasp-cartesian-positions
  - id: vasp_selective_dynamics
    type: ['null', boolean]
    doc: "Output POSCAR in selective dynamics format (without any constrained atoms)."
    inputBinding:
      position: 2
      prefix: --vasp-selective-dynamics
  - id: vasp_pseudo_libdr
    type: ['null', Directory]
    doc: "Path to the VASP pseudopotential library. Also settable by the VASP_PAWLIB environment variable."
    inputBinding:
      position: 2
      prefix: --vasp-pseudo-libdr
  - id: vasp_pseudo_priority
    type: ['null', string]
    doc: "Set the priority of different pseudopotentials by a list of suffixes (e.g. \"_d,_pv,_sv,_h,_s\")."
    inputBinding:
      position: 2
      prefix: --vasp-pseudo-priority
  - id: vasp_encutfac
    type: ['null', float]
    doc: "Factor that multiplies the maximal ENCUT found in the POTCAR file."
    inputBinding:
      position: 2
      prefix: --vasp-encutfac
  - id: xyz_atomic_units
    type: ['null', boolean]
    doc: "Output xyz file in atomic units (bohr radii) rather than angstrom."
    inputBinding:
      position: 2
      prefix: --xyz-atomic-units
outputs:
  - id: screen_output
    type: stdout
    doc: Cell description printed to screen
  - id: output_files
    type:
      type: array
      items: File
    doc: Input file(s) written for the chosen electronic structure program
    outputBinding:
      glob: '*'
      outputEval: '${ return self.filter(function(f) { return f.basename != "cif2cell.out"; }); }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cif2cell:2.0.0a3
stdout: cif2cell.out
