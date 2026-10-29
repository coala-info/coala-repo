cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_image_handler
label: relion_relion_image_handler
doc: "Image and volume operations: filters, rescaling, arithmetic, statistics, format conversion and movie\
  \ averaging.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file, image (.mrc) or movie/stack (.mrcs)
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output name (for STAR-input: insert this string before each image''s extension)'
    inputBinding:
      position: 101
      prefix: --o
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write in half-precision 16 bit floating point numbers (MRC mode 12), instead of 32 bit (MRC mode
      0).
    inputBinding:
      position: 101
      prefix: --float16
  - id: multiply_constant
    type:
      - 'null'
      - float
    doc: 'Multiply the image(s) pixel values by this constant (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --multiply_constant
  - id: divide_constant
    type:
      - 'null'
      - float
    doc: 'Divide the image(s) pixel values by this constant (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --divide_constant
  - id: add_constant
    type:
      - 'null'
      - float
    doc: 'Add this constant to the image(s) pixel values (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --add_constant
  - id: subtract_constant
    type:
      - 'null'
      - float
    doc: 'Subtract this constant from the image(s) pixel values (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --subtract_constant
  - id: threshold_above
    type:
      - 'null'
      - float
    doc: 'Set all values higher than this value to this value (RELION default: 999.)'
    inputBinding:
      position: 101
      prefix: --threshold_above
  - id: threshold_below
    type:
      - 'null'
      - float
    doc: 'Set all values lower than this value to this value (RELION default: -999.)'
    inputBinding:
      position: 101
      prefix: --threshold_below
  - id: multiply
    type:
      - 'null'
      - File
    doc: Multiply input image(s) by the pixel values in this image
    inputBinding:
      position: 101
      prefix: --multiply
  - id: divide
    type:
      - 'null'
      - File
    doc: Divide input image(s) by the pixel values in this image
    inputBinding:
      position: 101
      prefix: --divide
  - id: add
    type:
      - 'null'
      - File
    doc: Add the pixel values in this image to the input image(s)
    inputBinding:
      position: 101
      prefix: --add
  - id: subtract
    type:
      - 'null'
      - File
    doc: Subtract the pixel values in this image to the input image(s)
    inputBinding:
      position: 101
      prefix: --subtract
  - id: fsc
    type:
      - 'null'
      - File
    doc: Calculate FSC curve of the input image with this image
    inputBinding:
      position: 101
      prefix: --fsc
  - id: power
    type:
      - 'null'
      - boolean
    doc: Calculate power spectrum (|F|^2) of the input image
    inputBinding:
      position: 101
      prefix: --power
  - id: guinier
    type:
      - 'null'
      - boolean
    doc: Calculate Guinier plot and determine B-factor of the input image
    inputBinding:
      position: 101
      prefix: --guinier
  - id: guinier_minres
    type:
      - 'null'
      - float
    doc: 'Lowest resolution (in A) to include in fitting of the B-factor (RELION default: 10.)'
    inputBinding:
      position: 101
      prefix: --guinier_minres
  - id: guinier_maxres
    type:
      - 'null'
      - float
    doc: 'Highest resolution (in A) to include in fitting of the B-factor (RELION default: 0.01)'
    inputBinding:
      position: 101
      prefix: --guinier_maxres
  - id: adjust_power
    type:
      - 'null'
      - File
    doc: Adjust the power spectrum of the input image to be the same as this image
    inputBinding:
      position: 101
      prefix: --adjust_power
  - id: fourier_filter
    type:
      - 'null'
      - File
    doc: Multiply the Fourier transform of the input image(s) with this one image
    inputBinding:
      position: 101
      prefix: --fourier_filter
  - id: optimise_scale_subtract
    type:
      - 'null'
      - boolean
    doc: Optimise scale between maps before subtraction?
    inputBinding:
      position: 101
      prefix: --optimise_scale_subtract
  - id: optimise_bfactor_subtract
    type:
      - 'null'
      - float
    doc: 'Search range for relative B-factor for subtraction (in A^2) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --optimise_bfactor_subtract
  - id: mask_optimise_subtract
    type:
      - 'null'
      - File
    doc: Use only voxels in this mask to optimise scale for subtraction
    inputBinding:
      position: 101
      prefix: --mask_optimise_subtract
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Calculate per-image statistics?
    inputBinding:
      position: 101
      prefix: --stats
  - id: com
    type:
      - 'null'
      - boolean
    doc: Calculate center of mass?
    inputBinding:
      position: 101
      prefix: --com
  - id: bfactor
    type:
      - 'null'
      - float
    doc: 'Apply a B-factor (in A^2) (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --bfactor
  - id: lowpass
    type:
      - 'null'
      - float
    doc: 'Low-pass filter frequency (in A) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --lowpass
  - id: highpass
    type:
      - 'null'
      - float
    doc: 'High-pass filter frequency (in A) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --highpass
  - id: directional
    type:
      - 'null'
      - string
    doc: Directionality of low-pass filter frequency ('X', 'Y' or 'Z', default non-directional)
    inputBinding:
      position: 101
      prefix: --directional
  - id: LoG
    type:
      - 'null'
      - float
    doc: 'Diameter for optimal response of Laplacian of Gaussian filter (in A) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --LoG
  - id: angpix
    type:
      - 'null'
      - float
    doc: 'Pixel size (in A) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix
  - id: rescale_angpix
    type:
      - 'null'
      - float
    doc: 'Scale input image(s) to this new pixel size (in A) (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --rescale_angpix
  - id: force_header_angpix
    type:
      - 'null'
      - float
    doc: 'Change the pixel size in the header (in A). Without --rescale_angpix, the image is not scaled.
      (RELION default: -1.)'
    inputBinding:
      position: 101
      prefix: --force_header_angpix
  - id: new_box
    type:
      - 'null'
      - int
    doc: 'Resize the image(s) to this new box size (in pixel) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --new_box
  - id: filter_edge_width
    type:
      - 'null'
      - int
    doc: 'Width of the raised cosine on the low/high-pass filter edge (in resolution shells) (RELION default:
      2)'
    inputBinding:
      position: 101
      prefix: --filter_edge_width
  - id: flipX
    type:
      - 'null'
      - boolean
    doc: Flip (mirror) a 2D image or 3D map in the X-direction?
    inputBinding:
      position: 101
      prefix: --flipX
  - id: flipY
    type:
      - 'null'
      - boolean
    doc: Flip (mirror) a 2D image or 3D map in the Y-direction?
    inputBinding:
      position: 101
      prefix: --flipY
  - id: flipZ
    type:
      - 'null'
      - boolean
    doc: Flip (mirror) a 3D map in the Z-direction?
    inputBinding:
      position: 101
      prefix: --flipZ
  - id: invert_hand
    type:
      - 'null'
      - boolean
    doc: Invert hand by flipping X? Similar to flipX, but preserves the symmetry origin. Edge pixels are
      wrapped around.
    inputBinding:
      position: 101
      prefix: --invert_hand
  - id: shift_com
    type:
      - 'null'
      - boolean
    doc: Shift image(s) to their center-of-mass (only on positive pixel values)
    inputBinding:
      position: 101
      prefix: --shift_com
  - id: shift_x
    type:
      - 'null'
      - float
    doc: 'Shift images this many pixels in the X-direction (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --shift_x
  - id: shift_y
    type:
      - 'null'
      - float
    doc: 'Shift images this many pixels in the Y-direction (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --shift_y
  - id: shift_z
    type:
      - 'null'
      - float
    doc: 'Shift images this many pixels in the Z-direction (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --shift_z
  - id: avg_ampl
    type:
      - 'null'
      - boolean
    doc: Calculate average amplitude spectrum for all images?
    inputBinding:
      position: 101
      prefix: --avg_ampl
  - id: avg_ampl2
    type:
      - 'null'
      - boolean
    doc: Calculate average amplitude spectrum for all images?
    inputBinding:
      position: 101
      prefix: --avg_ampl2
  - id: avg_ampl2_ali
    type:
      - 'null'
      - boolean
    doc: Calculate average amplitude spectrum for all aligned images?
    inputBinding:
      position: 101
      prefix: --avg_ampl2_ali
  - id: average
    type:
      - 'null'
      - boolean
    doc: Calculate average of all images (without alignment)
    inputBinding:
      position: 101
      prefix: --average
  - id: correct_avg_ampl
    type:
      - 'null'
      - File
    doc: Correct all images with this average amplitude spectrum
    inputBinding:
      position: 101
      prefix: --correct_avg_ampl
  - id: minr_ampl_corr
    type:
      - 'null'
      - int
    doc: 'Minimum radius (in Fourier pixels) to apply average amplitudes (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --minr_ampl_corr
  - id: remove_nan
    type:
      - 'null'
      - boolean
    doc: Replace non-numerical values (NaN, inf, etc) in the image(s)
    inputBinding:
      position: 101
      prefix: --remove_nan
  - id: replace_nan
    type:
      - 'null'
      - float
    doc: 'Replace non-numerical values (NaN, inf, etc) with this value (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --replace_nan
  - id: phase_randomise
    type:
      - 'null'
      - float
    doc: 'Randomise phases beyond this resolution (in Angstroms) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --phase_randomise
  - id: sym
    type:
      - 'null'
      - string
    doc: Symmetrise 3D map with this point group (e.g. D6)
    inputBinding:
      position: 101
      prefix: --sym
  - id: flipXY
    type:
      - 'null'
      - boolean
    doc: Flip the image(s) in the XY direction?
    inputBinding:
      position: 101
      prefix: --flipXY
  - id: flipmXY
    type:
      - 'null'
      - boolean
    doc: Flip the image(s) in the -XY direction?
    inputBinding:
      position: 101
      prefix: --flipmXY
  - id: add_edge
    type:
      - 'null'
      - boolean
    doc: Add a barcode-like edge to the micrograph/movie frames?
    inputBinding:
      position: 101
      prefix: --add_edge
  - id: edge_x0
    type:
      - 'null'
      - int
    doc: 'Pixel column to be used for the left edge (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --edge_x0
  - id: edge_y0
    type:
      - 'null'
      - int
    doc: 'Pixel row to be used for the top edge (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --edge_y0
  - id: edge_xF
    type:
      - 'null'
      - int
    doc: 'Pixel column to be used for the right edge (RELION default: 4095)'
    inputBinding:
      position: 101
      prefix: --edge_xF
  - id: edge_yF
    type:
      - 'null'
      - int
    doc: 'Pixel row to be used for the bottom edge (RELION default: 4095)'
    inputBinding:
      position: 101
      prefix: --edge_yF
  - id: avg_bin
    type:
      - 'null'
      - int
    doc: 'Width (in frames) for binning average, i.e. of every so-many frames (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --avg_bin
  - id: avg_first
    type:
      - 'null'
      - int
    doc: 'First frame to include in averaging (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --avg_first
  - id: avg_last
    type:
      - 'null'
      - int
    doc: 'Last frame to include in averaging (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --avg_last
  - id: average_all_movie_frames
    type:
      - 'null'
      - boolean
    doc: Average all movie frames of all movies in the input STAR file.
    inputBinding:
      position: 101
      prefix: --average_all_movie_frames
  - id: black
    type:
      - 'null'
      - float
    doc: 'Pixel value for black (default is auto-contrast) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --black
  - id: white
    type:
      - 'null'
      - float
    doc: 'Pixel value for white (default is auto-contrast) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --white
  - id: sigma_contrast
    type:
      - 'null'
      - float
    doc: 'Set white and black pixel values this many times the image stddev from the mean (RELION default:
      0)'
    inputBinding:
      position: 101
      prefix: --sigma_contrast
  - id: colour_fire
    type:
      - 'null'
      - boolean
    doc: Show images in black-grey-white-red colour scheme (highlight high signal)?
    inputBinding:
      position: 101
      prefix: --colour_fire
  - id: colour_ice
    type:
      - 'null'
      - boolean
    doc: Show images in blue-black-grey-white colour scheme (highlight low signal)?
    inputBinding:
      position: 101
      prefix: --colour_ice
  - id: colour_fire_n_ice
    type:
      - 'null'
      - boolean
    doc: Show images in blue-grey-red colour scheme (highlight high&low signal)?
    inputBinding:
      position: 101
      prefix: --colour_fire-n-ice
  - id: colour_rainbow
    type:
      - 'null'
      - boolean
    doc: Show images in cyan-blue-black-red-yellow colour scheme?
    inputBinding:
      position: 101
      prefix: --colour_rainbow
  - id: colour_difference
    type:
      - 'null'
      - boolean
    doc: Show images in cyan-blue-black-red-yellow colour scheme (for difference images)?
    inputBinding:
      position: 101
      prefix: --colour_difference
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
    doc: Written images, volumes or tables
    outputBinding:
      glob:
        - $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_image_handler.out
