cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_localsym
label: relion_relion_localsym
doc: "Apply, search, duplicate or transform local symmetry operators of 3D maps.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: function_help
    type:
      - 'null'
      - boolean
    doc: Show usage for the selected function (JUN 30, 2017)
    inputBinding:
      position: 101
      prefix: --function_help
  - id: apply
    type:
      - 'null'
      - boolean
    doc: Apply local symmetry to a 3D cryo-EM density map
    inputBinding:
      position: 101
      prefix: --apply
  - id: duplicate
    type:
      - 'null'
      - boolean
    doc: Duplicate subunits/masks according to local symmetry operators
    inputBinding:
      position: 101
      prefix: --duplicate
  - id: search
    type:
      - 'null'
      - boolean
    doc: Local searches of local symmetry operators
    inputBinding:
      position: 101
      prefix: --search
  - id: transform
    type:
      - 'null'
      - boolean
    doc: Transform a map according to three Euler angles and XYZ translations
    inputBinding:
      position: 101
      prefix: --transform
  - id: txt2rln
    type:
      - 'null'
      - boolean
    doc: Convert operators from DM to RELION STAR format
    inputBinding:
      position: 101
      prefix: --txt2rln
  - id: debug
    type:
      - 'null'
      - boolean
    doc: (DEBUG ONLY)
    inputBinding:
      position: 101
      prefix: --debug
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (in Angstroms) of input image (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: ang_range
    type:
      - 'null'
      - float
    doc: 'Angular search range of operators (in degrees), overwrite rot-tilt-psi ranges if set to positive
      (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --ang_range
  - id: ang_rot_range
    type:
      - 'null'
      - float
    doc: 'Angular (rot) search range of operators (in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --ang_rot_range
  - id: ang_tilt_range
    type:
      - 'null'
      - float
    doc: 'Angular (tilt) search range of operators (in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --ang_tilt_range
  - id: ang_psi_range
    type:
      - 'null'
      - float
    doc: 'Angular (psi) search range of operators (in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --ang_psi_range
  - id: ang_step
    type:
      - 'null'
      - float
    doc: 'Angular search step of operators (in degrees) (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --ang_step
  - id: bin
    type:
      - 'null'
      - float
    doc: 'Binning factor (<= 1 means no binning) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --bin
  - id: ini_threshold
    type:
      - 'null'
      - float
    doc: 'Initial threshold for binarization (RELION default: 0.01)'
    inputBinding:
      position: 101
      prefix: --ini_threshold
  - id: i_map
    type:
      - 'null'
      - File
    doc: Input 3D unsymmetrised map
    inputBinding:
      position: 101
      prefix: --i_map
  - id: i_mask_info
    type:
      - 'null'
      - File
    doc: 'Input file with mask filenames and rotational / translational operators (for local searches)
      (RELION default: maskinfo.txt)'
    inputBinding:
      position: 101
      prefix: --i_mask_info
  - id: i_op_mask_info
    type:
      - 'null'
      - File
    doc: Input file with mask filenames for all operators (for global searches)
    inputBinding:
      position: 101
      prefix: --i_op_mask_info
  - id: n
    type:
      - 'null'
      - int
    doc: 'Create this number of masks according to the input density map (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --n
  - id: offset_range
    type:
      - 'null'
      - float
    doc: 'Translational search range of operators (in Angstroms), overwrite x-y-z ranges if set to positive
      (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --offset_range
  - id: offset_x_range
    type:
      - 'null'
      - float
    doc: 'Translational (x) search range of operators (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --offset_x_range
  - id: offset_y_range
    type:
      - 'null'
      - float
    doc: 'Translational (y) search range of operators (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --offset_y_range
  - id: offset_z_range
    type:
      - 'null'
      - float
    doc: 'Translational (z) search range of operators (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --offset_z_range
  - id: offset_step
    type:
      - 'null'
      - float
    doc: 'Translational search step of operators (in Angstroms) (RELION default: 1.)'
    inputBinding:
      position: 101
      prefix: --offset_step
  - id: o_map
    type:
      - 'null'
      - string
    doc: Output 3D symmetrised map
    inputBinding:
      position: 101
      prefix: --o_map
  - id: o_mask_info
    type:
      - 'null'
      - string
    doc: 'Output file with mask filenames and rotational / translational operators (RELION default: maskinfo_refined.txt)'
    inputBinding:
      position: 101
      prefix: --o_mask_info
  - id: psi
    type:
      - 'null'
      - float
    doc: 'Third Euler angle (psi, in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --psi
  - id: rot
    type:
      - 'null'
      - float
    doc: 'First Euler angle (rot, in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --rot
  - id: sphere_percentage
    type:
      - 'null'
      - float
    doc: 'Diameter of spherical mask divided by the box size (< 0.99) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --sphere_percentage
  - id: tilt
    type:
      - 'null'
      - float
    doc: 'Second Euler angle (tilt, in degrees) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --tilt
  - id: xoff
    type:
      - 'null'
      - float
    doc: 'X-offset (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --xoff
  - id: yoff
    type:
      - 'null'
      - float
    doc: 'Y-offset (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --yoff
  - id: zoff
    type:
      - 'null'
      - float
    doc: 'Z-offset (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --zoff
  - id: verb
    type:
      - 'null'
      - boolean
    doc: Verbose output?
    inputBinding:
      position: 101
      prefix: --verb
  - id: i_mask
    type:
      - 'null'
      - File
    doc: '(DEBUG) Input mask (RELION default: mask.mrc)'
    inputBinding:
      position: 101
      prefix: --i_mask
  - id: i_mask_info_parsed_ext
    type:
      - 'null'
      - string
    doc: 'Extension of parsed input file with mask filenames and rotational / translational operators
      (RELION default: parsed)'
    inputBinding:
      position: 101
      prefix: --i_mask_info_parsed_ext
  - id: use_healpix
    type:
      - 'null'
      - boolean
    doc: Use Healpix for angular samplings?
    inputBinding:
      position: 101
      prefix: --use_healpix
  - id: width
    type:
      - 'null'
      - float
    doc: 'Width of cosine soft edge (in pixels) (RELION default: 5.)'
    inputBinding:
      position: 101
      prefix: --width
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
    doc: Symmetrised map and refined operator files
    outputBinding:
      glob:
        - $(inputs.o_map)*
        - $(inputs.o_mask_info)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_localsym.out
