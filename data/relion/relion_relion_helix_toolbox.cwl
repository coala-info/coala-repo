cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_helix_toolbox
label: relion_relion_helix_toolbox
doc: "Collection of helical-reconstruction utilities: cylinders, symmetry imposition, parameter checks\
  \ and STAR file edits.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: function_help
    type:
      - 'null'
      - boolean
    doc: Show usage for the selected function (FEB 19, 2017)
    inputBinding:
      position: 101
      prefix: --function_help
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check parameters for 3D helical reconstruction in RELION
    inputBinding:
      position: 101
      prefix: --check
  - id: cut_out
    type:
      - 'null'
      - boolean
    doc: Cut out a small part of the helix
    inputBinding:
      position: 101
      prefix: --cut_out
  - id: cylinder
    type:
      - 'null'
      - boolean
    doc: Create a cylinder as 3D initial reference
    inputBinding:
      position: 101
      prefix: --cylinder
  - id: impose
    type:
      - 'null'
      - boolean
    doc: Impose helical symmetry (in real space)
    inputBinding:
      position: 101
      prefix: --impose
  - id: interpo
    type:
      - 'null'
      - boolean
    doc: Interpolate 3D curve for 3D helical sub-tomogram extraction
    inputBinding:
      position: 101
      prefix: --interpo
  - id: norm
    type:
      - 'null'
      - boolean
    doc: Normalise 2D/3D helical segments in a STAR file
    inputBinding:
      position: 101
      prefix: --norm
  - id: pdb_helix
    type:
      - 'null'
      - boolean
    doc: Simulate a helix from a single PDB file of protein molecule
    inputBinding:
      position: 101
      prefix: --pdb_helix
  - id: remove_bad_ctf
    type:
      - 'null'
      - boolean
    doc: Remove micrographs with poor-quality CTF
    inputBinding:
      position: 101
      prefix: --remove_bad_ctf
  - id: remove_bad_tilt
    type:
      - 'null'
      - boolean
    doc: Remove helical segments with large tilt angle deviation (away from 90 degrees)
    inputBinding:
      position: 101
      prefix: --remove_bad_tilt
  - id: remove_bad_psi
    type:
      - 'null'
      - boolean
    doc: Remove helical segments with large psi angle deviation (away from psi prior)
    inputBinding:
      position: 101
      prefix: --remove_bad_psi
  - id: search
    type:
      - 'null'
      - boolean
    doc: Local search of helical symmetry
    inputBinding:
      position: 101
      prefix: --search
  - id: select_3dtomo
    type:
      - 'null'
      - boolean
    doc: Select 3D subtomograms given 2D projections
    inputBinding:
      position: 101
      prefix: --select_3dtomo
  - id: simulate_helix
    type:
      - 'null'
      - boolean
    doc: Create a helical 3D reference of spheres
    inputBinding:
      position: 101
      prefix: --simulate_helix
  - id: simulate_segments
    type:
      - 'null'
      - boolean
    doc: Simulate helical segments using a STAR file
    inputBinding:
      position: 101
      prefix: --simulate_segments
  - id: sort_tube_id
    type:
      - 'null'
      - boolean
    doc: Sort segments in _data.star file according to helical tube IDs
    inputBinding:
      position: 101
      prefix: --sort_tube_id
  - id: spherical_mask
    type:
      - 'null'
      - boolean
    doc: Apply soft spherical mask to 3D helical reference
    inputBinding:
      position: 101
      prefix: --spherical_mask
  - id: average_au_2d
    type:
      - 'null'
      - boolean
    doc: Average multiple asymmetrical units in 2D along the helical axis?
    inputBinding:
      position: 101
      prefix: --average_au_2d
  - id: combine_gctf
    type:
      - 'null'
      - boolean
    doc: Combine Autopicker priors (tilt and psi) with Gctf local search results
    inputBinding:
      position: 101
      prefix: --combine_gctf
  - id: central_mask
    type:
      - 'null'
      - boolean
    doc: Crop the central part of a helix
    inputBinding:
      position: 101
      prefix: --central_mask
  - id: coords_emn2rln
    type:
      - 'null'
      - boolean
    doc: Convert EMAN2 coordinates of helical segments into RELION STAR format
    inputBinding:
      position: 101
      prefix: --coords_emn2rln
  - id: coords_xim2rln
    type:
      - 'null'
      - boolean
    doc: Convert XIMDISP coordinates of helical segments into RELION STAR format
    inputBinding:
      position: 101
      prefix: --coords_xim2rln
  - id: divide
    type:
      - 'null'
      - boolean
    doc: Divide one huge STAR file into many small ones
    inputBinding:
      position: 101
      prefix: --divide
  - id: extract_emn
    type:
      - 'null'
      - boolean
    doc: Extract EMAN2 coordinates of helical segments from specified straight tubes
    inputBinding:
      position: 101
      prefix: --extract_emn
  - id: extract_rln
    type:
      - 'null'
      - boolean
    doc: Extract RELION coordinates of helical segments from specified straight tubes
    inputBinding:
      position: 101
      prefix: --extract_rln
  - id: extract_xim
    type:
      - 'null'
      - boolean
    doc: Extract XIMDISP coordinates of helical segments from specified straight tubes
    inputBinding:
      position: 101
      prefix: --extract_xim
  - id: impose_fourier
    type:
      - 'null'
      - boolean
    doc: Impose helical symmetry (simulate what is done in 3D reconstruction in Fourier space)
    inputBinding:
      position: 101
      prefix: --impose_fourier
  - id: init_tilt
    type:
      - 'null'
      - boolean
    doc: Set tilt angles to 90 degrees for all helical segments
    inputBinding:
      position: 101
      prefix: --init_tilt
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge small STAR files into a huge one
    inputBinding:
      position: 101
      prefix: --merge
  - id: set_xmipp_origin
    type:
      - 'null'
      - boolean
    doc: Set Xmipp origin
    inputBinding:
      position: 101
      prefix: --set_xmipp_origin
  - id: debug
    type:
      - 'null'
      - boolean
    doc: (Debug only)
    inputBinding:
      position: 101
      prefix: --debug
  - id: opt_3d_tomo
    type:
      - 'null'
      - boolean
    doc: Simulate 3D subtomograms using a STAR file?
    inputBinding:
      position: 101
      prefix: --3d_tomo
  - id: ang
    type:
      - 'null'
      - float
    doc: 'Cut out a small part of the helix within this angle (in degrees) (RELION default: 91.)'
    inputBinding:
      position: 101
      prefix: --ang
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (in Angstroms) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: bimodal
    type:
      - 'null'
      - boolean
    doc: Do bimodal searches of tilt and psi angles in 3D helical reconstruction?
    inputBinding:
      position: 101
      prefix: --bimodal
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning factor used in manual segment picking (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --bin
  - id: boxdim
    type:
      - 'null'
      - int
    doc: 'Box size (in pixels) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --boxdim
  - id: center_pdb
    type:
      - 'null'
      - boolean
    doc: Translate all atoms in the original PDB to the center of mass of this molecule?
    inputBinding:
      position: 101
      prefix: --center_pdb
  - id: ctf_fom_min
    type:
      - 'null'
      - float
    doc: 'Minimum figure-of-merit - threshold used in removing micrographs with bad CTF (RELION default:
      -999)'
    inputBinding:
      position: 101
      prefix: --ctf_fom_min
  - id: cyl_inner_diameter
    type:
      - 'null'
      - float
    doc: 'Inner diameter of the cylindrical mask (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --cyl_inner_diameter
  - id: cyl_outer_diameter
    type:
      - 'null'
      - float
    doc: 'Outer diameter of the cylindrical mask (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --cyl_outer_diameter
  - id: df_min
    type:
      - 'null'
      - float
    doc: 'Minimum defocus (in Angstroms) (RELION default: -999999.)'
    inputBinding:
      position: 101
      prefix: --df_min
  - id: df_max
    type:
      - 'null'
      - float
    doc: 'Maximum defocus (in Angstroms) (RELION default: 999999.)'
    inputBinding:
      position: 101
      prefix: --df_max
  - id: EPA_lowest_res
    type:
      - 'null'
      - float
    doc: 'Lowest EPA resolution (in Angstroms) - threshold used in removing micrographs with bad CTF (RELION
      default: 999)'
    inputBinding:
      position: 101
      prefix: --EPA_lowest_res
  - id: input
    type:
      - 'null'
      - File
    doc: 'Input file (RELION default: file.in)'
    inputBinding:
      position: 101
      prefix: --i
  - id: i1
    type:
      - 'null'
      - File
    doc: 'Input file #1 (RELION default: file01.in)'
    inputBinding:
      position: 101
      prefix: --i1
  - id: i2
    type:
      - 'null'
      - File
    doc: 'Input file #2 (RELION default: file02.in)'
    inputBinding:
      position: 101
      prefix: --i2
  - id: i_root
    type:
      - 'null'
      - string
    doc: 'Rootname of input files (RELION default: _rootnameIn.star)'
    inputBinding:
      position: 101
      prefix: --i_root
  - id: i1_root
    type:
      - 'null'
      - string
    doc: 'Rootname #1 of input files (RELION default: _rootnameIn01.star)'
    inputBinding:
      position: 101
      prefix: --i1_root
  - id: i2_root
    type:
      - 'null'
      - string
    doc: 'Rootname #2 of input files (RELION default: _rootnameIn02.star)'
    inputBinding:
      position: 101
      prefix: --i2_root
  - id: ignore_helical_symmetry
    type:
      - 'null'
      - boolean
    doc: Ignore helical symmetry in 3D reconstruction?
    inputBinding:
      position: 101
      prefix: --ignore_helical_symmetry
  - id: nr_asu
    type:
      - 'null'
      - int
    doc: 'Number of helical asymmetrical units (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --nr_asu
  - id: nr_outfiles
    type:
      - 'null'
      - int
    doc: 'Number of output files (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --nr_outfiles
  - id: nr_subunits
    type:
      - 'null'
      - int
    doc: 'Number of helical subunits (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --nr_subunits
  - id: nr_tubes
    type:
      - 'null'
      - int
    doc: 'Number of helical tubes (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --nr_tubes
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output file (RELION default: file.out)'
    inputBinding:
      position: 101
      prefix: --o
    default: file.out
  - id: o_root
    type:
      - 'null'
      - string
    doc: 'Rootname of output files (RELION default: _rootnameOut.star)'
    inputBinding:
      position: 101
      prefix: --o_root
  - id: polar
    type:
      - 'null'
      - boolean
    doc: Construct a 3D reference for helical reconstruction with polarity along Z axis?
    inputBinding:
      position: 101
      prefix: --polar
  - id: psi_max_dev
    type:
      - 'null'
      - float
    doc: 'Maximum deviation of psi angles allowed (away from psi prior) (RELION default: 15.)'
    inputBinding:
      position: 101
      prefix: --psi_max_dev
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random seed (set to system time if negative) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: rise
    type:
      - 'null'
      - float
    doc: 'Helical rise (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --rise
  - id: rise_inistep
    type:
      - 'null'
      - float
    doc: 'Initial step of helical rise search (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --rise_inistep
  - id: rise_min
    type:
      - 'null'
      - float
    doc: 'Minimum helical rise (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --rise_min
  - id: rise_max
    type:
      - 'null'
      - float
    doc: 'Maximum helical rise (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --rise_max
  - id: seam_nr_filaments
    type:
      - 'null'
      - float
    doc: 'Number of filaments in a helix with seam (>= 2) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --seam_nr_filaments
  - id: search_sym
    type:
      - 'null'
      - boolean
    doc: Perform local searches of helical symmetry in 3D reconstruction?
    inputBinding:
      position: 101
      prefix: --search_sym
  - id: segments
    type:
      - 'null'
      - boolean
    doc: Cut helical tubes into segments?
    inputBinding:
      position: 101
      prefix: --segments
  - id: sigma_offset
    type:
      - 'null'
      - float
    doc: 'Sigma of translational offsets (in pixels) (RELION default: 5.)'
    inputBinding:
      position: 101
      prefix: --sigma_offset
  - id: sigma_psi
    type:
      - 'null'
      - float
    doc: 'Sigma of psi angles (in degrees) (RELION default: 5.)'
    inputBinding:
      position: 101
      prefix: --sigma_psi
  - id: sigma_tilt
    type:
      - 'null'
      - float
    doc: 'Sigma of tilt angles (in degrees) (RELION default: 5.)'
    inputBinding:
      position: 101
      prefix: --sigma_tilt
  - id: sphere_percentage
    type:
      - 'null'
      - float
    doc: 'Diameter of spherical mask divided by the box size (0.10~0.90 or 0.01~0.99) (RELION default:
      0.9)'
    inputBinding:
      position: 101
      prefix: --sphere_percentage
  - id: subunit_diameter
    type:
      - 'null'
      - float
    doc: 'Diameter of helical subunits (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --subunit_diameter
  - id: sym_Cn
    type:
      - 'null'
      - int
    doc: 'Rotational symmetry Cn (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --sym_Cn
  - id: tilt_max_dev
    type:
      - 'null'
      - float
    doc: 'Maximum deviation of tilt angles allowed (away from +90 degrees) (RELION default: 15.)'
    inputBinding:
      position: 101
      prefix: --tilt_max_dev
  - id: topbottom_ratio
    type:
      - 'null'
      - float
    doc: 'Top-bottom width ratio for construction of polarised helical reference (RELION default: 0.5)'
    inputBinding:
      position: 101
      prefix: --topbottom_ratio
  - id: twist
    type:
      - 'null'
      - float
    doc: 'Helical twist (in degrees, + for right-handedness) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --twist
  - id: twist_inistep
    type:
      - 'null'
      - float
    doc: 'Initial step of helical twist search (in degrees) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --twist_inistep
  - id: twist_min
    type:
      - 'null'
      - float
    doc: 'Minimum helical twist (in degrees, + for right-handedness) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --twist_min
  - id: twist_max
    type:
      - 'null'
      - float
    doc: 'Maximum helical twist (in degrees, + for right-handedness) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --twist_max
  - id: verb
    type:
      - 'null'
      - boolean
    doc: Detailed screen output?
    inputBinding:
      position: 101
      prefix: --verb
  - id: white_noise
    type:
      - 'null'
      - float
    doc: 'Standard deviation of added white Gaussian noise (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --white_noise
  - id: width
    type:
      - 'null'
      - float
    doc: 'Width of cosine soft edge (in pixels) (RELION default: 5.)'
    inputBinding:
      position: 101
      prefix: --width
  - id: xdim
    type:
      - 'null'
      - int
    doc: 'Dimension X (in pixels) of the micrographs (RELION default: 4096)'
    inputBinding:
      position: 101
      prefix: --xdim
  - id: ydim
    type:
      - 'null'
      - int
    doc: 'Dimension Y (in pixels) of the micrographs (RELION default: 4096)'
    inputBinding:
      position: 101
      prefix: --ydim
  - id: z_percentage
    type:
      - 'null'
      - float
    doc: 'Percentage of cropped length (along Z axis, 0.1~0.9) (RELION default: 0.3)'
    inputBinding:
      position: 101
      prefix: --z_percentage
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files
    outputBinding:
      glob:
        - $(inputs.output)*
        - $(inputs.o_root)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_helix_toolbox.out
