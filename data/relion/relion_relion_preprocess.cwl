cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_preprocess
label: relion_relion_preprocess
doc: "Extract particles from micrographs and normalise, rescale or re-window particle images.\n\nTool\
  \ homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: The STAR file with all (selected) micrographs to extract particles from
    inputBinding:
      position: 101
      prefix: --i
  - id: coord_suffix
    type:
      - 'null'
      - string
    doc: The suffix for the coordinate files, e.g. "_picked.star" or ".box"
    inputBinding:
      position: 101
      prefix: --coord_suffix
  - id: coord_dir
    type:
      - 'null'
      - string
    doc: 'The directory where the coordinate files are (default is same as micrographs) (RELION default:
      ASINPUT)'
    inputBinding:
      position: 101
      prefix: --coord_dir
  - id: coord_list
    type:
      - 'null'
      - File
    doc: 'Alternative to coord_suffix&dir: provide a 2-column STAR file with micrographs and coordinate
      files'
    inputBinding:
      position: 101
      prefix: --coord_list
  - id: part_dir
    type:
      - 'null'
      - string
    doc: 'Output directory for particle stacks (RELION default: Particles/)'
    inputBinding:
      position: 101
      prefix: --part_dir
    default: Particles/
  - id: part_star
    type:
      - 'null'
      - string
    doc: Output STAR file with all particles metadata
    inputBinding:
      position: 101
      prefix: --part_star
    default: particles.star
  - id: pick_star
    type:
      - 'null'
      - string
    doc: Output STAR file with 2 columns for micrographs and coordinate files
    inputBinding:
      position: 101
      prefix: --pick_star
  - id: reextract_data_star
    type:
      - 'null'
      - File
    doc: A _data.star file from a refinement to re-extract, e.g. with different binning or re-centered
      (instead of --coord_suffix)
    inputBinding:
      position: 101
      prefix: --reextract_data_star
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write in half-precision 16 bit floating point numbers (MRC mode 12), instead of 32 bit (MRC mode
      0).
    inputBinding:
      position: 101
      prefix: --float16
  - id: keep_ctfs_micrographs
    type:
      - 'null'
      - boolean
    doc: By default, CTFs from fn_data will be kept. Use this flag to keep CTFs from input micrographs
      STAR file
    inputBinding:
      position: 101
      prefix: --keep_ctfs_micrographs
  - id: reset_offsets
    type:
      - 'null'
      - boolean
    doc: reset the origin offsets from the input _data.star file to zero?
    inputBinding:
      position: 101
      prefix: --reset_offsets
  - id: recenter
    type:
      - 'null'
      - boolean
    doc: Re-center particle according to rlnOriginX/Y in --reextract_data_star STAR file
    inputBinding:
      position: 101
      prefix: --recenter
  - id: recenter_x
    type:
      - 'null'
      - float
    doc: 'X-coordinate (in pixel inside the reference) to recenter re-extracted data on (RELION default:
      0.)'
    inputBinding:
      position: 101
      prefix: --recenter_x
  - id: recenter_y
    type:
      - 'null'
      - float
    doc: 'Y-coordinate (in pixel inside the reference) to recenter re-extracted data on (RELION default:
      0.)'
    inputBinding:
      position: 101
      prefix: --recenter_y
  - id: recenter_z
    type:
      - 'null'
      - float
    doc: 'Z-coordinate (in pixel inside the reference) to recenter re-extracted data on (RELION default:
      0.)'
    inputBinding:
      position: 101
      prefix: --recenter_z
  - id: ref_angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size of the reference used for recentering. -1 uses the pixel size of particles. (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --ref_angpix
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Extract all particles from the micrographs
    inputBinding:
      position: 101
      prefix: --extract
  - id: selection_type
    type:
      - 'null'
      - int
    doc: 'Only extract particles with this selection type in the coordinate files (default = extract all)
      (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --selection_type
  - id: extract_size
    type:
      - 'null'
      - int
    doc: 'Size of the box to extract the particles in (in pixels) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --extract_size
  - id: premultiply_ctf
    type:
      - 'null'
      - boolean
    doc: Premultiply the micrograph/frame with its CTF prior to particle extraction
    inputBinding:
      position: 101
      prefix: --premultiply_ctf
  - id: premultiply_extract_size
    type:
      - 'null'
      - int
    doc: 'Size of the box to extract the particles in (in pixels) before CTF premultiplication (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --premultiply_extract_size
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: When premultiplying with the CTF, leave frequencies intact until the first peak
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: phase_flip
    type:
      - 'null'
      - boolean
    doc: Flip CTF-phases in the micrograph/frame prior to particle extraction
    inputBinding:
      position: 101
      prefix: --phase_flip
  - id: extract_bias_x
    type:
      - 'null'
      - int
    doc: 'Bias in X-direction of picked particles (this value in pixels will be added to the coords) (RELION
      default: 0)'
    inputBinding:
      position: 101
      prefix: --extract_bias_x
  - id: extract_bias_y
    type:
      - 'null'
      - int
    doc: 'Bias in Y-direction of picked particles (this value in pixels will be added to the coords) (RELION
      default: 0)'
    inputBinding:
      position: 101
      prefix: --extract_bias_y
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Extract only particles if the STAR file for that micrograph does not yet exist.
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: minimum_pick_fom
    type:
      - 'null'
      - float
    doc: 'Minimum value for rlnAutopickFigureOfMerit for particle extraction (RELION default: -999.)'
    inputBinding:
      position: 101
      prefix: --minimum_pick_fom
  - id: project3d
    type:
      - 'null'
      - boolean
    doc: Project sub-tomograms along Z to generate 2D particles
    inputBinding:
      position: 101
      prefix: --project3d
  - id: scale
    type:
      - 'null'
      - int
    doc: 'Re-scale the particles to this size (in pixels) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --scale
  - id: window
    type:
      - 'null'
      - int
    doc: 'Re-window the particles to this size (in pixels) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --window
  - id: norm
    type:
      - 'null'
      - boolean
    doc: Normalise the background to average zero and stddev one
    inputBinding:
      position: 101
      prefix: --norm
  - id: no_ramp
    type:
      - 'null'
      - boolean
    doc: Just subtract the background mean in the normalisation, instead of subtracting a fitted ramping
      background.
    inputBinding:
      position: 101
      prefix: --no_ramp
  - id: bg_radius
    type:
      - 'null'
      - int
    doc: 'Radius of the circular mask that will be used to define the background area (in pixels) (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --bg_radius
  - id: white_dust
    type:
      - 'null'
      - float
    doc: 'Sigma-values above which white dust will be removed (negative value means no dust removal) (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --white_dust
  - id: black_dust
    type:
      - 'null'
      - float
    doc: 'Sigma-values above which black dust will be removed (negative value means no dust removal) (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --black_dust
  - id: invert_contrast
    type:
      - 'null'
      - boolean
    doc: Invert the contrast in the input images
    inputBinding:
      position: 101
      prefix: --invert_contrast
  - id: operate_on
    type:
      - 'null'
      - File
    doc: Use this option to operate on an input image stack
    inputBinding:
      position: 101
      prefix: --operate_on
  - id: operate_out
    type:
      - 'null'
      - string
    doc: 'Output name when operating on an input image stack (RELION default: preprocessed.mrcs)'
    inputBinding:
      position: 101
      prefix: --operate_out
  - id: helix
    type:
      - 'null'
      - boolean
    doc: Extract helical segments
    inputBinding:
      position: 101
      prefix: --helix
  - id: helical_outer_diameter
    type:
      - 'null'
      - float
    doc: 'Outer diameter of helical tubes in Angstroms (for masks of helical segments) (RELION default:
      -1.)'
    inputBinding:
      position: 101
      prefix: --helical_outer_diameter
  - id: helical_tubes
    type:
      - 'null'
      - boolean
    doc: Extract helical segments from tube coordinates
    inputBinding:
      position: 101
      prefix: --helical_tubes
  - id: helical_nr_asu
    type:
      - 'null'
      - int
    doc: 'Number of helical asymmetrical units (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --helical_nr_asu
  - id: helical_rise
    type:
      - 'null'
      - float
    doc: 'Helical rise (in Angstroms) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --helical_rise
  - id: helical_bimodal_angular_priors
    type:
      - 'null'
      - boolean
    doc: Add bimodal angular priors for helical segments
    inputBinding:
      position: 101
      prefix: --helical_bimodal_angular_priors
  - id: helical_cut_into_segments
    type:
      - 'null'
      - boolean
    doc: Cut helical tubes into segments
    inputBinding:
      position: 101
      prefix: --helical_cut_into_segments
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: particles_dir
    type: Directory
    doc: Directory with the extracted particle stacks
    outputBinding:
      glob: $(inputs.part_dir)
  - id: particles_star
    type: File
    doc: STAR file with all particles
    outputBinding:
      glob: $(inputs.part_star)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_preprocess.out
