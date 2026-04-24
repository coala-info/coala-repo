cwlVersion: v1.2
class: CommandLineTool
baseCommand: hippunfold
label: hippunfold_group
doc: "Performs hippocampal unfolding and analysis.\n\nTool homepage: https://github.com/khanlab/hippunfold"
inputs:
  - id: bids_dir
    type: Directory
    doc: The directory with the input dataset formatted according to the BIDS 
      standard.
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: The directory where the output files should be stored. If you are 
      running group level analysis this folder should be prepopulated with the 
      results of the participant level analysis.
    inputBinding:
      position: 2
  - id: analysis_level
    type: string
    doc: Level of the analysis that will be performed.
    inputBinding:
      position: 3
  - id: atlas
    type:
      - 'null'
      - string
    doc: Select the atlas (unfolded space) to use for subfield labels.
    inputBinding:
      position: 104
      prefix: --atlas
  - id: autotop_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Run hipp (CA + subiculum) alone or include dentate
      - hipp
      - dentate
    inputBinding:
      position: 104
      prefix: --autotop_labels
  - id: crop_native_box
    type:
      - 'null'
      - string
    doc: Sets the bounding box size for the crop native (e.g. cropT1w space). 
      Make this larger if your hippocampi in crop{T1w,T2w} space are getting 
      cut-off. This must be in voxels (vox) not millimeters (mm).
    inputBinding:
      position: 104
      prefix: --crop_native_box
  - id: crop_native_res
    type:
      - 'null'
      - string
    doc: Sets the bounding box resolution for the crop native (e.g. cropT1w 
      space). Under the hood, hippUnfold operates at higher resolution than the 
      native image, so this tries to preserve some of that detail.
    inputBinding:
      position: 104
      prefix: --crop_native_res
  - id: derivatives
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Path(s) to a derivatives dataset, for folder(s) that contains multiple 
      derivatives datasets
    inputBinding:
      position: 104
      prefix: --derivatives
  - id: enable_bids_validation
    type:
      - 'null'
      - boolean
    doc: Enable validation of BIDS dataset. BIDS validation would be performed 
      using the bids-validator plugin (if installed/enabled) or with the pybids 
      validator implementation (if bids-validator is not installed/enabled).
    inputBinding:
      position: 104
      prefix: --enable-bids-validation
  - id: exclude_participant_label
    type:
      - 'null'
      - type: array
        items: string
    doc: The label(s) of the participant(s) that should be excluded. The label 
      corresponds to sub-<participant_label> from the BIDS spec (so it does not 
      include "sub-"). If this parameter is not provided all subjects should be 
      analyzed. Multiple participants can be specified with a space separated 
      list.
    inputBinding:
      position: 104
      prefix: --exclude-participant-label
  - id: filter_T1w
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: suffix=T1w extension=.nii.gz datatype=anat)'
    inputBinding:
      position: 104
      prefix: --filter-T1w
  - id: filter_T2w
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: suffix=T2w extension=.nii.gz datatype=anat)'
    inputBinding:
      position: 104
      prefix: --filter-T2w
  - id: filter_dsegsubfields
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: suffix=dseg extension=.nii.gz datatype=anat)'
    inputBinding:
      position: 104
      prefix: --filter-dsegsubfields
  - id: filter_dsegtissue
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: suffix=dseg extension=.nii.gz datatype=anat)'
    inputBinding:
      position: 104
      prefix: --filter-dsegtissue
  - id: filter_hippb500
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: suffix=b500 extension=.nii.gz datatype=dwi)'
    inputBinding:
      position: 104
      prefix: --filter-hippb500
  - id: force_nnunet_model
    type:
      - 'null'
      - string
    doc: Force nnunet model to use (expert option).
    inputBinding:
      position: 104
      prefix: --force-nnunet-model
  - id: force_output
    type:
      - 'null'
      - boolean
    doc: Force output in a new directory that already has contents
    inputBinding:
      position: 104
      prefix: --force-output
  - id: generate_myelin_map
    type:
      - 'null'
      - boolean
    doc: Generate myelin map using T1w divided by T2w, and map to surface with 
      ribbon approach. Requires both T1w and T2w images to be present.
    inputBinding:
      position: 104
      prefix: --generate-myelin-map
  - id: help_snakemake
    type:
      - 'null'
      - boolean
    doc: Options to Snakemake can also be passed directly at the command-line, 
      use this to print Snakemake usage
    inputBinding:
      position: 104
      prefix: --help-snakemake
  - id: hemi
    type:
      - 'null'
      - type: array
        items: string
    doc: Hemisphere(s) to process
      - L
      - R
    inputBinding:
      position: 104
      prefix: --hemi
  - id: inject_template
    type:
      - 'null'
      - string
    doc: Set the template to use for shape injection.
    inputBinding:
      position: 104
      prefix: --inject-template
  - id: inject_template_smoothing_factor
    type:
      - 'null'
      - float
    doc: 'Scales the default smoothing sigma for gradient and warp in template shape
      injection. Using a value higher than 1 will use result in a smoother warp, and
      greater capacity to patch larger holes in segmentations. Try setting to 2 if
      nnunet segmentations have large holes. Note: the better solution is to re-train
      network on the data you are using'
    inputBinding:
      position: 104
      prefix: --inject_template_smoothing_factor
  - id: laminar_coords_method
    type:
      - 'null'
      - string
    doc: Method to use for laminar coordinates. Equivol and equidist are from 
      the laynii LN2_LAYERS tool.
    inputBinding:
      position: 104
      prefix: --laminar_coords_method
  - id: laminar_coords_res_dentate
    type:
      - 'null'
      - string
    doc: Set the resolution that the laminar (IO) coords will be computed with 
      for the dentate gyrus. This is implemented by resampling the segmentation 
      to this resolution prior to generating the coords.
    inputBinding:
      position: 104
      prefix: --laminar_coords_res_dentate
  - id: laminar_coords_res_hipp
    type:
      - 'null'
      - string
    doc: Set the resolution that the laminar (IO) coords will be computed with 
      for hippocampus. This is implemented by resampling the segmentation to 
      this resolution prior to generating the coords.
    inputBinding:
      position: 104
      prefix: --laminar_coords_res_hipp
  - id: modality
    type: string
    doc: Type of image to run hippunfold on. For dsegtissue and be sure to match
      the label scheme applied in the look up table (lut) online. For best 
      performance, please also make sure the input is approximately aligned to 
      the template space, with separate hemi-L|R in the name(s).
    inputBinding:
      position: 104
      prefix: --modality
  - id: nnunet_enable_tta
    type:
      - 'null'
      - boolean
    doc: Enable test-time augmentation for nn-net inference, slows down 
      inference by 8x, but potentially increases accuracy
    inputBinding:
      position: 104
      prefix: --nnunet-enable-tta
  - id: no_reg_template
    type:
      - 'null'
      - boolean
    doc: Use if input data is already in space-CITI168
    inputBinding:
      position: 104
      prefix: --no-reg-template
  - id: no_unfolded_reg
    type:
      - 'null'
      - boolean
    doc: Do not perform unfolded space (2D) registration based on surface 
      metrics (e.g. thickness, curvature, and gyrification) for closer alignment
      to the reference atlas.
    inputBinding:
      position: 104
      prefix: --no-unfolded-reg
  - id: output_density
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets the output vertex density for results. Options correspond to 
      approximate vertex spacings of 0.5mm, 1.0mm, and 2.0mm, respectively, with
      the unfoldiso (32k hipp) vertices legacy option having unequal vertex 
      spacing.
      - 0p5mm
    inputBinding:
      position: 104
      prefix: --output_density
  - id: output_spaces
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets output spaces for results
      - native
    inputBinding:
      position: 104
      prefix: --output-spaces
  - id: participant_label
    type:
      - 'null'
      - type: array
        items: string
    doc: The label(s) of the participant(s) that should be analyzed. The label 
      corresponds to sub-<participant_label> from the BIDS sec (so it does not 
      include "sub-"). If this parameter is not provided all subjects should be 
      analyzed. Multiple participants can be specified with a space separated 
      list.
    inputBinding:
      position: 104
      prefix: --participant-label
  - id: path_T1w
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 104
      prefix: --path-T1w
  - id: path_T2w
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 104
      prefix: --path-T2w
  - id: path_dsegsubfields
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 104
      prefix: --path-dsegsubfields
  - id: path_dsegtissue
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 104
      prefix: --path-dsegtissue
  - id: path_hippb500
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 104
      prefix: --path-hippb500
  - id: pybidsdb_dir
    type:
      - 'null'
      - Directory
    doc: Optional path to directory of SQLite databasefile for PyBIDS. If 
      directory is passed and folder exists, indexing is skipped. If 
      pybidsdb_reset is called, indexing will persist
    inputBinding:
      position: 104
      prefix: --pybidsdb-dir
  - id: pybidsdb_reset
    type:
      - 'null'
      - boolean
    doc: Reindex existing PyBIDS SQLite database
    inputBinding:
      position: 104
      prefix: --pybidsdb-reset
  - id: resample_dsegtissue
    type:
      - 'null'
      - string
    doc: 'Resample the manual segmentation (for --modality dsegtissue), keeping the
      bounding box the same, but changing the number of voxels in the image. This
      can be specified as voxels ("300x300x300"), or a percentage ("20%") or percentage
      in each direction ("20x20x40%"). Note: the segmentation will always be subsequently
      cropped around the segmentation, with a padding of 5 voxels.'
    inputBinding:
      position: 104
      prefix: --resample-dsegtissue
  - id: rigid_reg_template
    type:
      - 'null'
      - boolean
    doc: Use rigid instead of affine for registration to template. Try this if 
      your images are reduced FOV
    inputBinding:
      position: 104
      prefix: --rigid-reg-template
  - id: skip_coreg
    type:
      - 'null'
      - boolean
    doc: Set this flag if your inputs (e.g. T2w, dwi) are already registered to 
      T1w space
    inputBinding:
      position: 104
      prefix: --skip-coreg
  - id: skip_inject_template_labels
    type:
      - 'null'
      - boolean
    doc: Set this flag to skip post-processing template injection into CNN 
      segmentation. Note this will disable generation of DG surfaces.
    inputBinding:
      position: 104
      prefix: --skip_inject_template_labels
  - id: skip_preproc
    type:
      - 'null'
      - boolean
    doc: Set this flag if your inputs (e.g. T2w, dwi) are already pre-processed
    inputBinding:
      position: 104
      prefix: --skip_preproc
  - id: t1_reg_template
    type:
      - 'null'
      - boolean
    doc: 'Use T1w to register to template space, instead of the segmentation modality.
      Note: this was the default behavior prior to v1.0.0.'
    inputBinding:
      position: 104
      prefix: --t1-reg-template
  - id: template
    type:
      - 'null'
      - string
    doc: Set the template to use for registration to coronal oblique (and 
      optionally for template-based segmentation if --use-template-seg is 
      enabled). CITI168 is for adult human data, dHCP is for neonatal human 
      data, MBMv2 is for ex vivo marmoset data, MBMv3 is for in vivo marmoset 
      data, CIVM is for in vivo macaque data, and ABAv3 is for mouse data. When 
      using a non-human template, consider using a corresponding atlas.
    inputBinding:
      position: 104
      prefix: --template
  - id: template_seg_smoothing_factor
    type:
      - 'null'
      - float
    doc: Scales the default smoothing sigma for gradient and warp in greedy 
      registration for template-based segmentation. Using a value higher than 1 
      will use result in a smoother warp.
    inputBinding:
      position: 104
      prefix: --template_seg_smoothing_factor
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: Enable gpu for inference by setting resource gpus=1 in run_inference 
      rule
    inputBinding:
      position: 104
      prefix: --use_gpu
  - id: use_template_seg
    type:
      - 'null'
      - boolean
    doc: Use template-based segmentation for hippocampal tissue *instead of* 
      nnUnet and shape injection. This is only to be used if nnUnet models are 
      not trained for the data you are using, e.g. for non-human primate data 
      with the MBMv2 (ex vivo marmoset), MBMv3 (in vivo marmoset), or CIVM (ex 
      vivo macaque) template.
    inputBinding:
      position: 104
      prefix: --use-template-seg
  - id: wildcards_T1w
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: subject session acquisition run)'
      - subject
      - session
      - acquisition
      - run
    inputBinding:
      position: 104
      prefix: --wildcards-T1w
  - id: wildcards_T2w
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: subject session acquisition run)'
      - subject
      - session
      - acquisition
      - run
    inputBinding:
      position: 104
      prefix: --wildcards-T2w
  - id: wildcards_dsegsubfields
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: subject session hemi acquisition run)'
      - subject
      - session
      - hemi
      - acquisition
      - run
    inputBinding:
      position: 104
      prefix: --wildcards-dsegsubfields
  - id: wildcards_dsegtissue
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: subject session hemi acquisition run)'
      - subject
      - session
      - hemi
      - acquisition
      - run
    inputBinding:
      position: 104
      prefix: --wildcards-dsegtissue
  - id: wildcards_hippb500
    type:
      - 'null'
      - type: array
        items: string
    doc: '(default: subject session)'
      - subject
      - session
    inputBinding:
      position: 104
      prefix: --wildcards-hippb500
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Folder for storing working files. If not specified, will be in "work/" 
      subfolder in the output folder. You can also use environment variables 
      when setting the workdir, e.g. --workdir '$SLURM_TMPDIR'.
    inputBinding:
      position: 104
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hippunfold:2.0.0--pyh7e72e81_0
stdout: hippunfold_group.out
