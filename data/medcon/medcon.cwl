cwlVersion: v1.2
class: CommandLineTool
baseCommand: medcon
label: medcon
doc: "CLI Medical Image Conversion Utility\n\nTool homepage: https://github.com/nadavlab/MedConceptsQA"
inputs:
  - id: alias_naming
    type:
      - 'null'
      - boolean
    doc: output name based  on patient/study id's
    inputBinding:
      position: 101
      prefix: --alias-naming
  - id: analyze_spm
    type:
      - 'null'
      - boolean
    doc: use analyze format for SPM software
    inputBinding:
      position: 101
      prefix: --analyze-spm
  - id: anonymous
    type:
      - 'null'
      - boolean
    doc: make patient/study anonymous
    inputBinding:
      position: 101
      prefix: --anonymous
  - id: big_endian
    type:
      - 'null'
      - boolean
    doc: write files in big    endian
    inputBinding:
      position: 101
      prefix: --big-endian
  - id: calibration
    type:
      - 'null'
      - boolean
    doc: calibration    (use two scale factors)
    inputBinding:
      position: 101
      prefix: --calibration
  - id: cine_sorting
    type:
      - 'null'
      - boolean
    doc: apply cine sorting
    inputBinding:
      position: 101
      prefix: --cine-sorting
  - id: cine_undo
    type:
      - 'null'
      - boolean
    doc: undo  cine sorting
    inputBinding:
      position: 101
      prefix: --cine-undo
  - id: convert_format
    type:
      - 'null'
      - type: array
        items: string
    doc: give list of conversion <format> strings
    inputBinding:
      position: 101
      prefix: --convert
  - id: coronal
    type:
      - 'null'
      - boolean
    doc: reslice images coronal
    inputBinding:
      position: 101
      prefix: --coronal
  - id: crop_images
    type:
      - 'null'
      - string
    doc: crop image dimensions
    inputBinding:
      position: 101
      prefix: --crop-images
  - id: database
    type:
      - 'null'
      - boolean
    doc: print database info
    inputBinding:
      position: 101
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: give debug information (printout FI)
    inputBinding:
      position: 101
      prefix: --debug
  - id: dither_color
    type:
      - 'null'
      - boolean
    doc: apply dithering on color reduction
    inputBinding:
      position: 101
      prefix: --dither-color
  - id: echo_alias_name
    type:
      - 'null'
      - boolean
    doc: echo alias name on screen
    inputBinding:
      position: 101
      prefix: --echo-alias-name
  - id: edit_fileinfo
    type:
      - 'null'
      - boolean
    doc: edit internal entries (images/slice/origent)
    inputBinding:
      position: 101
      prefix: --edit-fileinfo
  - id: enable_contrast
    type:
      - 'null'
      - boolean
    doc: enable support for contrast changes
    inputBinding:
      position: 101
      prefix: --enable-contrast
  - id: enable_mosaic
    type:
      - 'null'
      - boolean
    doc: enable mosaic by "detected" stamps layout
    inputBinding:
      position: 101
      prefix: --enable-mosaic
  - id: extract
    type:
      - 'null'
      - boolean
    doc: extract images from file
    inputBinding:
      position: 101
      prefix: --extract
  - id: fallback_analyze
    type:
      - 'null'
      - boolean
    doc: fallback on Analyze (SPM)
    inputBinding:
      position: 101
      prefix: --fallback-analyze
  - id: fallback_concorde
    type:
      - 'null'
      - boolean
    doc: fallback on Concorde uPET
    inputBinding:
      position: 101
      prefix: --fallback-concorde
  - id: fallback_dicom
    type:
      - 'null'
      - boolean
    doc: fallback on DICOM 3.0
    inputBinding:
      position: 101
      prefix: --fallback-dicom
  - id: fallback_disabled
    type:
      - 'null'
      - boolean
    doc: fallback disabled
    inputBinding:
      position: 101
      prefix: --without-fallback
  - id: fallback_ecat
    type:
      - 'null'
      - boolean
    doc: fallback on ECAT 6.4
    inputBinding:
      position: 101
      prefix: --fallback-ecat
  - id: files
    type:
      type: array
      items: File
    doc: file or list of files to handle
    inputBinding:
      position: 101
      prefix: --file
  - id: flip_horizontal
    type:
      - 'null'
      - boolean
    doc: flip images horizontally (along x-axis)
    inputBinding:
      position: 101
      prefix: --flip-horizontal
  - id: flip_vertical
    type:
      - 'null'
      - boolean
    doc: flip images vertically   (along y-axis)
    inputBinding:
      position: 101
      prefix: --flip-vertical
  - id: force_contrast_remapping
    type:
      - 'null'
      - string
    doc: force specified contrast remapping
    inputBinding:
      position: 101
      prefix: --cw
  - id: force_mosaic
    type:
      - 'null'
      - string
    doc: force  mosaic by predefined stamps layout
    inputBinding:
      position: 101
      prefix: --force-mosaic
  - id: force_rescale
    type:
      - 'null'
      - string
    doc: force slope/intercept rescaling
    inputBinding:
      position: 101
      prefix: --si
  - id: force_window_center_width
    type:
      - 'null'
      - string
    doc: force window center/width contrast
    inputBinding:
      position: 101
      prefix: --cw
  - id: hack_acrtags
    type:
      - 'null'
      - boolean
    doc: try to locate and interpret acr tags in file
    inputBinding:
      position: 101
      prefix: --hack-acrtags
  - id: identify
    type:
      - 'null'
      - boolean
    doc: ask for patient/study information
    inputBinding:
      position: 101
      prefix: --identify
  - id: ignore_path
    type:
      - 'null'
      - boolean
    doc: ignore path in 'name of data file' key
    inputBinding:
      position: 101
      prefix: --ignore-path
  - id: indexed_color
    type:
      - 'null'
      - boolean
    doc: color mode of  8 bits indexed colormap
    inputBinding:
      position: 101
      prefix: --indexed-color
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: read raw files after user input
    inputBinding:
      position: 101
      prefix: --interactive
  - id: little_endian
    type:
      - 'null'
      - boolean
    doc: write files in little endian
    inputBinding:
      position: 101
      prefix: --little-endian
  - id: load_lut
    type:
      - 'null'
      - File
    doc: load specified LUT colormap
    inputBinding:
      position: 101
      prefix: --load-lut
  - id: make_gray
    type:
      - 'null'
      - boolean
    doc: remap images to grayscale
    inputBinding:
      position: 101
      prefix: --make-gray
  - id: make_square
    type:
      - 'null'
      - boolean
    doc: make square images (largest dimension)
    inputBinding:
      position: 101
      prefix: --make-square
  - id: make_square_two
    type:
      - 'null'
      - boolean
    doc: make square images (nearest power)
    inputBinding:
      position: 101
      prefix: --make-square-two
  - id: map_combined
    type:
      - 'null'
      - boolean
    doc: load colormap combined (gray/rainbow)
    inputBinding:
      position: 101
      prefix: --map-combined
  - id: map_hotmetal
    type:
      - 'null'
      - boolean
    doc: load colormap hotmetal
    inputBinding:
      position: 101
      prefix: --map-hotmetal
  - id: map_inverted
    type:
      - 'null'
      - boolean
    doc: load colormap gray inverted
    inputBinding:
      position: 101
      prefix: --map-inverted
  - id: map_rainbow
    type:
      - 'null'
      - boolean
    doc: load colormap rainbow
    inputBinding:
      position: 101
      prefix: --map-rainbow
  - id: mosaic_fix_voxel
    type:
      - 'null'
      - boolean
    doc: rescale voxel sizes by mosaic factor
    inputBinding:
      position: 101
      prefix: --mosaic-fix-voxel
  - id: mosaic_interlaced
    type:
      - 'null'
      - boolean
    doc: consider mosaic stamp slices as interlaced
    inputBinding:
      position: 101
      prefix: --mosaic-interlaced
  - id: negatives
    type:
      - 'null'
      - boolean
    doc: enable negative pixels
    inputBinding:
      position: 101
      prefix: --negatives
  - id: norm_over_frames
    type:
      - 'null'
      - boolean
    doc: normalize values over each frames
    inputBinding:
      position: 101
      prefix: --norm-over-frames
  - id: options_gif
    type:
      - 'null'
      - boolean
    doc: ask for GIF related options
    inputBinding:
      position: 101
      prefix: --options-gif
  - id: options_spm
    type:
      - 'null'
      - boolean
    doc: ask for SPM related options
    inputBinding:
      position: 101
      prefix: --options-spm
  - id: output_name
    type:
      - 'null'
      - string
    doc: output name set from command-line
    inputBinding:
      position: 101
      prefix: --output-name
  - id: overwrite_files
    type:
      - 'null'
      - boolean
    doc: always overwrite files
    inputBinding:
      position: 101
      prefix: --overwrite-files
  - id: pad_around
    type:
      - 'null'
      - boolean
    doc: padding symmetrical around image
    inputBinding:
      position: 101
      prefix: --pad-around
  - id: pad_bottom_right
    type:
      - 'null'
      - boolean
    doc: padding after last row and column (default)
    inputBinding:
      position: 101
      prefix: --pad-bottom-right
  - id: pad_top_left
    type:
      - 'null'
      - boolean
    doc: padding before first row and column
    inputBinding:
      position: 101
      prefix: --pad-top-left
  - id: prefix_acquisition
    type:
      - 'null'
      - boolean
    doc: use acquisition number as filename prefix
    inputBinding:
      position: 101
      prefix: --prefix-acquisition
  - id: prefix_series
    type:
      - 'null'
      - boolean
    doc: use series      number as filename prefix
    inputBinding:
      position: 101
      prefix: --prefix-series
  - id: print_all_values
    type:
      - 'null'
      - boolean
    doc: print all values without asking
    inputBinding:
      position: 101
      prefix: --print-all-values
  - id: print_values
    type:
      - 'null'
      - boolean
    doc: print values of specified pixels
    inputBinding:
      position: 101
      prefix: --print-values
  - id: quantification
    type:
      - 'null'
      - boolean
    doc: quantification (use one scale factor )
    inputBinding:
      position: 101
      prefix: --quantification
  - id: quantitation
    type:
      - 'null'
      - boolean
    doc: quantitation using all factors (-qc)
    inputBinding:
      position: 101
      prefix: --quantitation
  - id: rename_file
    type:
      - 'null'
      - boolean
    doc: rename file after user input
    inputBinding:
      position: 101
      prefix: --rename-file
  - id: reverse_slices
    type:
      - 'null'
      - boolean
    doc: reverse slices sequence
    inputBinding:
      position: 101
      prefix: --reverse-slices
  - id: sagittal
    type:
      - 'null'
      - boolean
    doc: reslice images sagittal
    inputBinding:
      position: 101
      prefix: --sagittal
  - id: signed_short
    type:
      - 'null'
      - boolean
    doc: write signed short integers (16 bits)
    inputBinding:
      position: 101
      prefix: --signed-short
  - id: signed_short_12bit
    type:
      - 'null'
      - boolean
    doc: write unsigned shorts, only 12 bits used
    inputBinding:
      position: 101
      prefix: -b16.12
  - id: silent
    type:
      - 'null'
      - boolean
    doc: force silent mode, suppress all messages
    inputBinding:
      position: 101
      prefix: --silent
  - id: single_file
    type:
      - 'null'
      - boolean
    doc: write header and image to same file
    inputBinding:
      position: 101
      prefix: --single-file
  - id: skip_preview_slice
    type:
      - 'null'
      - boolean
    doc: skip first preview slice
    inputBinding:
      position: 101
      prefix: --skip-preview-slice
  - id: sort_by_frame
    type:
      - 'null'
      - boolean
    doc: sort ECAT images by frame (not anatomical)
    inputBinding:
      position: 101
      prefix: --sort-by-frame
  - id: spacing_true_gap
    type:
      - 'null'
      - boolean
    doc: slice spacing is true gap or overlap
    inputBinding:
      position: 101
      prefix: --spacing-true-gap
  - id: split_frames
    type:
      - 'null'
      - boolean
    doc: split volume time frames  in separate files
    inputBinding:
      position: 101
      prefix: --split-frames
  - id: split_slices
    type:
      - 'null'
      - boolean
    doc: split single image slices in separate files
    inputBinding:
      position: 101
      prefix: --split-slices
  - id: stack_frames
    type:
      - 'null'
      - boolean
    doc: stack volume time  frames into one 4D file
    inputBinding:
      position: 101
      prefix: --stack-frames
  - id: stack_slices
    type:
      - 'null'
      - boolean
    doc: stack single image slices into one 3D file
    inputBinding:
      position: 101
      prefix: --stack-slices
  - id: tranverse
    type:
      - 'null'
      - boolean
    doc: reslice images transverse
    inputBinding:
      position: 101
      prefix: --tranverse
  - id: true_color
    type:
      - 'null'
      - boolean
    doc: color mode of 24 bits RGB triplets
    inputBinding:
      position: 101
      prefix: --true-color
  - id: unsigned_char
    type:
      - 'null'
      - boolean
    doc: write unsigned char pixels  (8  bits)
    inputBinding:
      position: 101
      prefix: --unsigned-char
  - id: use_institution_name
    type:
      - 'null'
      - boolean
    doc: override default name of institution
    inputBinding:
      position: 101
      prefix: --use-institution-name
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: run in verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
  - id: without_prefix
    type:
      - 'null'
      - boolean
    doc: output name without default prefix
    inputBinding:
      position: 101
      prefix: --without-prefix
  - id: write_implicit
    type:
      - 'null'
      - boolean
    doc: output file as implicit little endian
    inputBinding:
      position: 101
      prefix: --write-implicit
  - id: write_without_meta
    type:
      - 'null'
      - boolean
    doc: output file without (part 10) meta header
    inputBinding:
      position: 101
      prefix: --write-without-meta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/medcon:v0.16.1dfsg-1-deb_cv1
stdout: medcon.out
