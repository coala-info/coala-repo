cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qsmxt
  - run
label: qsmxt_run
doc: "Run the full Quantitative Susceptibility Mapping (QSM) pipeline on a BIDS dataset: masking, phase offset removal, phase unwrapping, echo combination into a field map, background field removal, dipole inversion and referencing. Writes the susceptibility map in ppm on the acquired grid.\n\nTool homepage: https://github.com/QSMxT/QSMxT"
inputs:
  - id: bids_dir
    type: Directory
    doc: "Input BIDS directory: the folder that holds sub-*/[ses-*/]anat/ with *_part-phase_MEGRE.nii, *_part-mag_MEGRE.nii (multi-echo: *_echo-<n>_part-...) and their JSON sidecars."
    inputBinding:
      position: 101
  - id: output_dir
    type: string
    default: qsmxt_out
    doc: Output directory. Results go into <output_dir>/derivatives/qsmxt/.
    inputBinding:
      position: 102
  - id: config
    type:
      - 'null'
      - File
    doc: Pipeline configuration file (TOML), such as the pipeline_config.toml an earlier run wrote.
    inputBinding:
      position: 1
      prefix: --config
  - id: pipeline
    type:
      - 'null'
      - string
    doc: "Start from a pipeline: qsmxt-defaults, medi-toolbox, sti-suite-ilsqr, sti-suite-star, qsmart, heidi, chi-sep-ilsqr, chi-sep-medi, chi-sepnet, decompose, uk-biobank."
    inputBinding:
      position: 1
      prefix: --pipeline
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: Include only runs matching these glob patterns (e.g. "sub-1*" "*ses-pre*").
    inputBinding:
      position: 1
      prefix: --include
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude runs matching these glob patterns.
    inputBinding:
      position: 1
      prefix: --exclude
  - id: num_echoes
    type:
      - 'null'
      - int
    doc: Limit the number of echoes to process.
    inputBinding:
      position: 1
      prefix: --num-echoes
  - id: mask_preset
    type:
      - 'null'
      - string
    doc: "Mask preset: robust-threshold, bet, hd-bet, bet-and-phase, rs2-net, mindgrab. Default: an Otsu threshold of the ROMEO phase-quality map, dilated, hole-filled and eroded."
    inputBinding:
      position: 1
      prefix: --mask-preset
  - id: masking_input
    type:
      - 'null'
      - string
    doc: "Masking input image: magnitude-first, magnitude, magnitude-last, phase-quality."
    inputBinding:
      position: 1
      prefix: --masking-input
  - id: mask
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mask
    doc: "Mask section, repeatable: <input>,<generator>,<refinement>,... e.g. phase-quality,threshold:otsu,dilate:2,fill-holes:0,erode:2 or magnitude,bet:0.5,erode:2."
    inputBinding:
      position: 1
  - id: use_custom_masks
    type:
      - 'null'
      - boolean
    doc: Prefer a mask already in the dataset's derivatives (derivatives/<tool>/sub-*/anat/*_mask.nii*) when present.
    inputBinding:
      position: 1
      prefix: --use-custom-masks
  - id: phase_offset_removal
    type:
      - 'null'
      - string
    doc: "Phase offset removal for multi-echo data (MCPC-3D-S): true (default) or false."
    inputBinding:
      position: 1
      prefix: --phase-offset-removal
  - id: unwrapping_algorithm
    type:
      - 'null'
      - string
    doc: "Unwrapping algorithm: romeo (default), laplacian, prelude, medi-region-growing."
    inputBinding:
      position: 1
      prefix: --unwrapping-algorithm
  - id: b0_estimation
    type:
      - 'null'
      - string
    doc: "B0 field estimation from the echoes: weighted-avg (default), linear-fit, robust-fit, and others listed by qsmxt run --help."
    inputBinding:
      position: 1
      prefix: --b0-estimation
  - id: bf_algorithm
    type:
      - 'null'
      - string
    doc: "Background field removal algorithm: vsharp (default), pdf, lbv, ismv, sharp, resharp, harperella, iharperella, bfrnet, iqfm."
    inputBinding:
      position: 1
      prefix: --bf-algorithm
  - id: bf_erode_voxels
    type:
      - 'null'
      - int
    doc: Erode the brain mask by N voxels after field mapping, before background removal (default 0).
    inputBinding:
      position: 1
      prefix: --bf-erode-voxels
  - id: qsm_algorithm
    type:
      - 'null'
      - string
    doc: "Dipole inversion algorithm: ilsqr (default), rts, tv, tkd, tsvd, tgv, tikhonov, nltv, medi, tfi, star, lsqr, heidi, qsmart, ndi, fansi and the deep-learning ones listed by qsmxt run --help."
    inputBinding:
      position: 1
      prefix: --qsm-algorithm
  - id: qsm_reference
    type:
      - 'null'
      - string
    doc: "What the map's zero is pinned to: mean (default, the mean over the reconstruction mask), none, or a SynthSeg region such as ventricles."
    inputBinding:
      position: 1
      prefix: --qsm-reference
  - id: two_pass
    type:
      - 'null'
      - boolean
    doc: "Two-pass artefact reduction: reconstruct a second time against a mask whose holes are left unfilled and keep that result where it is defined. For strong sources (air, haemorrhage, calcification, implants). Roughly doubles background removal and inversion time."
    inputBinding:
      position: 1
      prefix: --two-pass
  - id: do_swi
    type:
      - 'null'
      - boolean
    doc: Also compute SWI.
    inputBinding:
      position: 1
      prefix: --do-swi
  - id: n_procs
    type:
      - 'null'
      - int
    doc: Number of parallel threads.
    inputBinding:
      position: 1
      prefix: --n-procs
  - id: mem_limit_gb
    type:
      - 'null'
      - float
    doc: Memory limit in GB for concurrent run scheduling.
    inputBinding:
      position: 1
      prefix: --mem-limit-gb
  - id: dry
    type:
      - 'null'
      - boolean
    doc: Print the processing plan and the methods text without running or writing anything.
    inputBinding:
      position: 1
      prefix: --dry
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force a re-run, ignoring cached pipeline state.
    inputBinding:
      position: 1
      prefix: --force
  - id: clean_intermediates
    type:
      - 'null'
      - boolean
    doc: Delete the intermediate images under workflow/ once every run is done.
    inputBinding:
      position: 1
      prefix: --clean-intermediates
outputs:
  - id: derivatives
    type: Directory
    doc: "The output directory. Under derivatives/qsmxt/: sub-*/anat/*_Chimap.nii (susceptibility in ppm), *_mask.nii, methods.md, pipeline_config.toml, and workflow/ with the intermediate images."
    outputBinding:
      glob: $(inputs.output_dir)
  - id: chimaps
    type:
      type: array
      items: File
    doc: The susceptibility maps, one per run, in ppm.
    outputBinding:
      glob:
        - $(inputs.output_dir)/derivatives/qsmxt/sub-*/anat/*_Chimap.nii
        - $(inputs.output_dir)/derivatives/qsmxt/sub-*/ses-*/anat/*_Chimap.nii
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: vnmd/qsmxt_12.0.0:20261115
