cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_class_ranker
label: relion_relion_class_ranker
doc: "Rank 2D classes with a trained neural network and select them by score.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: opt
    type:
      - 'null'
      - File
    doc: Input optimiser.star file
    inputBinding:
      position: 101
      prefix: --opt
  - id: output
    type:
      - 'null'
      - string
    doc: 'Directory name for output files (RELION default: ./)'
    inputBinding:
      position: 101
      prefix: --o
    default: ./
  - id: ext
    type:
      - 'null'
      - string
    doc: 'Extension for root filenames of output optimiser.star and model.star (RELION default: ranked)'
    inputBinding:
      position: 101
      prefix: --ext
  - id: auto_select
    type:
      - 'null'
      - boolean
    doc: Perform auto-selection of particles based on below thresholds for the score
    inputBinding:
      position: 101
      prefix: --auto_select
  - id: min_score
    type:
      - 'null'
      - float
    doc: 'Minimum selected score to be included in class selection (RELION default: 0.5)'
    inputBinding:
      position: 101
      prefix: --min_score
  - id: max_score
    type:
      - 'null'
      - float
    doc: 'Maximum selected score to be included in class selection (RELION default: 999.)'
    inputBinding:
      position: 101
      prefix: --max_score
  - id: select_min_nr_particles
    type:
      - 'null'
      - int
    doc: 'select at least this many particles, regardless of their class score (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --select_min_nr_particles
  - id: select_min_nr_classes
    type:
      - 'null'
      - int
    doc: 'OR: Select at least this many classes, regardless of their score (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --select_min_nr_classes
  - id: relative_thresholds
    type:
      - 'null'
      - boolean
    doc: If true, interpret the above min and max_scores as fractions of the maximum score of all predicted
      classes in the input
    inputBinding:
      position: 101
      prefix: --relative_thresholds
  - id: fn_sel_parts
    type:
      - 'null'
      - string
    doc: 'Filename for output star file with selected particles (RELION default: particles.star)'
    inputBinding:
      position: 101
      prefix: --fn_sel_parts
  - id: fn_sel_classavgs
    type:
      - 'null'
      - string
    doc: 'Filename for output star file with selected class averages (RELION default: class_averages.star)'
    inputBinding:
      position: 101
      prefix: --fn_sel_classavgs
  - id: fn_root
    type:
      - 'null'
      - string
    doc: 'rootname for output model.star and optimiser.star files (RELION default: rank)'
    inputBinding:
      position: 101
      prefix: --fn_root
  - id: train
    type:
      - 'null'
      - boolean
    doc: Only write output files for training purposes (don't rank classes)
    inputBinding:
      position: 101
      prefix: --train
  - id: select
    type:
      - 'null'
      - File
    doc: 'Input class_averages.star from the Selection job or backup_selection.star (RELION default: backup_selection.star)'
    inputBinding:
      position: 101
      prefix: --select
  - id: fn_score
    type:
      - 'null'
      - File
    doc: 'Input job score file (RELION default: job_score.txt)'
    inputBinding:
      position: 101
      prefix: --fn_score
  - id: cf_file
    type:
      - 'null'
      - File
    doc: Input class feature star file
    inputBinding:
      position: 101
      prefix: --cf_file
  - id: only_class_nr
    type:
      - 'null'
      - int
    doc: 'Class number of the class of interest (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --only_class_nr
  - id: skip_angular_errors
    type:
      - 'null'
      - boolean
    doc: Skip angular error calculation
    inputBinding:
      position: 101
      prefix: --skip_angular_errors
  - id: do_granularity_features
    type:
      - 'null'
      - boolean
    doc: Calculate granularity features
    inputBinding:
      position: 101
      prefix: --do_granularity_features
  - id: save_masks
    type:
      - 'null'
      - boolean
    doc: Save the automatically generated 2D solvent masks for all references
    inputBinding:
      position: 101
      prefix: --save_masks
  - id: save_mask_c
    type:
      - 'null'
      - boolean
    doc: Write out images of protein mask circumferences.
    inputBinding:
      position: 101
      prefix: --save_mask_c
  - id: mask_folder_name
    type:
      - 'null'
      - string
    doc: 'Folder name for saving all masks. (RELION default: protein_solvent_masks)'
    inputBinding:
      position: 101
      prefix: --mask_folder_name
  - id: extract_subimages
    type:
      - 'null'
      - boolean
    doc: Extract subimages for each class
    inputBinding:
      position: 101
      prefix: --extract_subimages
  - id: nr_subimages
    type:
      - 'null'
      - int
    doc: 'Number of subimage to extract (randonly) (RELION default: 25)'
    inputBinding:
      position: 101
      prefix: --nr_subimages
  - id: subimage_boxsize
    type:
      - 'null'
      - int
    doc: 'Boxsize (in pixels) for subimages (RELION default: 24)'
    inputBinding:
      position: 101
      prefix: --subimage_boxsize
  - id: only_do_subimages
    type:
      - 'null'
      - boolean
    doc: Dont do anything else than extracting subimages
    inputBinding:
      position: 101
      prefix: --only_do_subimages
  - id: radius_ratio
    type:
      - 'null'
      - float
    doc: 'Ratio of inner radius of the interested ring area in proportion to the current circular mask
      radius (RELION default: 0.95)'
    inputBinding:
      position: 101
      prefix: --radius_ratio
  - id: radius
    type:
      - 'null'
      - int
    doc: 'Inner radius of the interested ring area to the current circular mask radius (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --radius
  - id: lowpass
    type:
      - 'null'
      - float
    doc: 'Image lowpass filter threshold for generating binary masks. (RELION default: 25)'
    inputBinding:
      position: 101
      prefix: --lowpass
  - id: binary_threshold
    type:
      - 'null'
      - float
    doc: 'Threshold for generating binary masks. (RELION default: 0.)'
    inputBinding:
      position: 101
      prefix: --binary_threshold
  - id: debug
    type:
      - 'null'
      - int
    doc: 'Debug level (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: verb
    type:
      - 'null'
      - int
    doc: 'Verbosity level (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --verb
  - id: fn_features
    type:
      - 'null'
      - string
    doc: 'Filename for output features star file (RELION default: features.star)'
    inputBinding:
      position: 101
      prefix: --fn_features
  - id: write_normalized_features
    type:
      - 'null'
      - boolean
    doc: Also write out normalized feature vectors
    inputBinding:
      position: 101
      prefix: --write_normalized_features
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
    doc: Ranked optimiser and model STAR files and selection files
    outputBinding:
      glob:
        - $(inputs.output)*.star
        - $(inputs.output)*.txt
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_class_ranker.out
