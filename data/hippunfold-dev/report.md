# hippunfold-dev CWL Generation Report

## hippunfold-dev_hippunfold

### Tool Description
Performs hippocampal unfolding analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/hippunfold-dev:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/khanlab/hippunfold
- **Package**: https://anaconda.org/channels/bioconda/packages/hippunfold-dev/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hippunfold-dev/overview
- **Total Downloads**: 331
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/khanlab/hippunfold
- **Stars**: N/A
### Original Help Text
```text
usage: hippunfold [-h] --modality {T1w,T2w,hippb500,dsegtissue}
                  [--template {CITI168,dHCP,MBMv2,MBMv3,CIVM,ABAv3,bigbrain}]
                  [--inject-template {upenn}] [--use_template_seg]
                  [--template_seg_smoothing_factor TEMPLATE_SEG_SMOOTHING_FACTOR]
                  [--skip-preproc] [--skip-coreg]
                  [--skip_inject_template_labels]
                  [--inject_template_smoothing_factor INJECT_TEMPLATE_SMOOTHING_FACTOR]
                  [--rigid-reg-template] [--no-reg-template]
                  [--t1_reg_template] [--crop_native_res CROP_NATIVE_RES]
                  [--crop_native_box CROP_NATIVE_BOX]
                  [--resample_dsegtissue RESAMPLE_DSEGTISSUE]
                  [--laminar-coords-res-hipp LAMINAR_COORDS_RES.HIPP]
                  [--laminar-coords-res-dentate LAMINAR_COORDS_RES.DENTATE]
                  [--atlas {multihist7,bbhist}] [--no_unfolded_reg]
                  [--generate-myelin-map] [--use-gpu] [--nnunet-enable-tta]
                  [--output-spaces {native,T1w} [{native,T1w} ...]]
                  [--output_density {0p5mm,1mm,2mm,unfoldiso} [{0p5mm,1mm,2mm,unfoldiso} ...]]
                  [--hemi {L,R} [{L,R} ...]]
                  [--laminar_coords_method {laplace,equivol,equidist}]
                  [--autotop_labels {hipp,dentate} [{hipp,dentate} ...]]
                  [--force-nnunet-model {T1w,T2w,T1T2w,b1000,trimodal,hippb500,neonateT1w,synthseg_v0.1,synthseg_v0.2,neonateT1w_v2}]
                  [--enable_bids_validation] [--workdir WORKDIR] [--version]
                  [--participant-label LABEL [LABEL ...]]
                  [--exclude-participant-label LABEL [LABEL ...]]
                  [--derivatives [PATH ...]] [--pybidsdb-dir PATH]
                  [--pybidsdb-reset] [--filter-T2w ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-hippb500 ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-T1w ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-dsegtissue ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-dsegsubfields ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--wildcards-T2w WILDCARD [WILDCARD ...]]
                  [--wildcards-hippb500 WILDCARD [WILDCARD ...]]
                  [--wildcards-T1w WILDCARD [WILDCARD ...]]
                  [--wildcards-dsegtissue WILDCARD [WILDCARD ...]]
                  [--wildcards-dsegsubfields WILDCARD [WILDCARD ...]]
                  [--path-T2w PATH] [--path-hippb500 PATH] [--path-T1w PATH]
                  [--path-dsegtissue PATH] [--path-dsegsubfields PATH]
                  [--help-snakemake] [--force-output]
                  bids_dir output_dir
                  {participant,participant_create_template,group}

positional arguments:
  bids_dir              The directory with the input dataset formatted
                        according to the BIDS standard.
  output_dir            The directory where the output files should be stored.
                        If you are running group level analysis this folder
                        should be prepopulated with the results of the
                        participant level analysis.
  {participant,participant_create_template,group}
                        Level of the analysis that will be performed.

options:
  -h, --help            show this help message and exit
  --modality {T1w,T2w,hippb500,dsegtissue}
                        Type of image to run hippunfold on. For dsegtissue and
                        be sure to match the label scheme applied in the look
                        up table (lut) online. For best performance, please
                        also make sure the input is approximately aligned to
                        the template space, with separate hemi-L|R in the
                        name(s). (default: None)
  --template {CITI168,dHCP,MBMv2,MBMv3,CIVM,ABAv3,bigbrain}
                        Set the template to use for registration to coronal
                        oblique (and optionally for template-based
                        segmentation if --use-template-seg is enabled).
                        CITI168 is for adult human data, dHCP is for neonatal
                        human data, MBMv2 is for ex vivo marmoset data, MBMv3
                        is for in vivo marmoset data, CIVM is for in vivo
                        macaque data, and ABAv3 is for mouse data. When using
                        a non-human template, consider using a corresponding
                        atlas. (default: CITI168)
  --inject-template {upenn}, --inject_template {upenn}
                        Set the template to use for shape injection. (default:
                        upenn)
  --use_template_seg, --use-template-seg
                        Use template-based segmentation for hippocampal tissue
                        *instead of* nnUnet and shape injection. This is only
                        to be used if nnUnet models are not trained for the
                        data you are using, e.g. for non-human primate data
                        with the MBMv2 (ex vivo marmoset), MBMv3 (in vivo
                        marmoset), or CIVM (ex vivo macaque) template.
                        (default: False)
  --template_seg_smoothing_factor TEMPLATE_SEG_SMOOTHING_FACTOR, --template-seg-smoothing-factor TEMPLATE_SEG_SMOOTHING_FACTOR
                        Scales the default smoothing sigma for gradient and
                        warp in greedy registration for template-based
                        segmentation. Using a value higher than 1 will use
                        result in a smoother warp. (default: 2.0)
  --skip-preproc, --skip_preproc
                        Set this flag if your inputs (e.g. T2w, dwi) are
                        already pre-processed (default: False)
  --skip-coreg, --skip_coreg
                        Set this flag if your inputs (e.g. T2w, dwi) are
                        already registered to T1w space (default: False)
  --skip_inject_template_labels, --skip-inject-template-labels
                        Set this flag to skip post-processing template
                        injection into CNN segmentation. Note this will
                        disable generation of DG surfaces. (default: False)
  --inject_template_smoothing_factor INJECT_TEMPLATE_SMOOTHING_FACTOR, --inject-template-smoothing-factor INJECT_TEMPLATE_SMOOTHING_FACTOR
                        Scales the default smoothing sigma for gradient and
                        warp in template shape injection. Using a value higher
                        than 1 will use result in a smoother warp, and greater
                        capacity to patch larger holes in segmentations. Try
                        setting to 2 if nnunet segmentations have large holes.
                        Note: the better solution is to re-train network on
                        the data you are using (default: 1.0)
  --rigid-reg-template, --rigid_reg_template
                        Use rigid instead of affine for registration to
                        template. Try this if your images are reduced FOV
                        (default: False)
  --no-reg-template, --no_reg_template
                        Use if input data is already in space-CITI168
                        (default: False)
  --t1_reg_template, --t1-reg-template
                        Use T1w to register to template space, instead of the
                        segmentation modality. Note: this was the default
                        behavior prior to v1.0.0. (default: False)
  --crop_native_res CROP_NATIVE_RES, --crop-native-res CROP_NATIVE_RES
                        Sets the bounding box resolution for the crop native
                        (e.g. cropT1w space). Under the hood, hippUnfold
                        operates at higher resolution than the native image,
                        so this tries to preserve some of that detail.
                        (default: 0.2x0.2x0.2mm)
  --crop_native_box CROP_NATIVE_BOX, --crop-native-box CROP_NATIVE_BOX
                        Sets the bounding box size for the crop native (e.g.
                        cropT1w space). Make this larger if your hippocampi in
                        crop{T1w,T2w} space are getting cut-off. This must be
                        in voxels (vox) not millimeters (mm). (default:
                        256x256x256vox)
  --resample_dsegtissue RESAMPLE_DSEGTISSUE, --resample-dsegtissue RESAMPLE_DSEGTISSUE
                        Resample the manual segmentation (for --modality
                        dsegtissue), keeping the bounding box the same, but
                        changing the number of voxels in the image. This can
                        be specified as voxels ("300x300x300"), or a
                        percentage ("20%") or percentage in each direction
                        ("20x20x40%"). Note: the segmentation will always be
                        subsequently cropped around the segmentation, with a
                        padding of 5 voxels. (default: None)
  --laminar-coords-res-hipp LAMINAR_COORDS_RES.HIPP, --laminar_coords_res_hipp LAMINAR_COORDS_RES.HIPP
                        Set the resolution that the laminar (IO) coords will
                        be computed with for hippocampus. This is implemented
                        by resampling the segmentation to this resolution
                        prior to generating the coords. (default:
                        0.3x0.3x0.3mm)
  --laminar-coords-res-dentate LAMINAR_COORDS_RES.DENTATE, --laminar_coords_res_dentate LAMINAR_COORDS_RES.DENTATE
                        Set the resolution that the laminar (IO) coords will
                        be computed with for the dentate gyrus. This is
                        implemented by resampling the segmentation to this
                        resolution prior to generating the coords. (default:
                        0.1x0.1x0.1mm)
  --atlas {multihist7,bbhist}
                        Select the atlas (unfolded space) to use for subfield
                        labels. (default: multihist7)
  --no_unfolded_reg, --no-unfolded-reg
                        Do not perform unfolded space (2D) registration based
                        on surface metrics (e.g. thickness, curvature, and
                        gyrification) for closer alignment to the reference
                        atlas. (default: False)
  --generate-myelin-map, --generate_myelin_map
                        Generate myelin map using T1w divided by T2w, and map
                        to surface with ribbon approach. Requires both T1w and
                        T2w images to be present. (default: False)
  --use-gpu, --use_gpu  Enable gpu for inference by setting resource gpus=1 in
                        run_inference rule (default: False)
  --nnunet-enable-tta, --nnunet_enable_tta
                        Enable test-time augmentation for nnU-net inference,
                        slows down inference by 8x, but potentially increases
                        accuracy (default: False)
  --output-spaces {native,T1w} [{native,T1w} ...], --output_spaces {native,T1w} [{native,T1w} ...]
                        Sets output spaces for results (default: ['native'])
  --output_density {0p5mm,1mm,2mm,unfoldiso} [{0p5mm,1mm,2mm,unfoldiso} ...], --output-density {0p5mm,1mm,2mm,unfoldiso} [{0p5mm,1mm,2mm,unfoldiso} ...]
                        Sets the output vertex density for results. Options
                        correspond to approximate vertex spacings of 0.5mm,
                        1.0mm, and 2.0mm, respectively, with the unfoldiso
                        (32k hipp) vertices legacy option having unequal
                        vertex spacing. (default: ['0p5mm'])
  --hemi {L,R} [{L,R} ...]
                        Hemisphere(s) to process (default: ['L', 'R'])
  --laminar_coords_method {laplace,equivol,equidist}, --laminar-coords-method {laplace,equivol,equidist}
                        Method to use for laminar coordinates. Equivol and
                        equidist are from the laynii LN2_LAYERS tool.
                        (default: equidist)
  --autotop_labels {hipp,dentate} [{hipp,dentate} ...], --autotop-labels {hipp,dentate} [{hipp,dentate} ...]
                        Run hipp (CA + subiculum) alone or include dentate
                        (default: ['hipp', 'dentate'])
  --force-nnunet-model {T1w,T2w,T1T2w,b1000,trimodal,hippb500,neonateT1w,synthseg_v0.1,synthseg_v0.2,neonateT1w_v2}, --force_nnunet_model {T1w,T2w,T1T2w,b1000,trimodal,hippb500,neonateT1w,synthseg_v0.1,synthseg_v0.2,neonateT1w_v2}
                        Force nnunet model to use (expert option). (default:
                        False)
  --enable_bids_validation, --enable-bids-validation
                        Enable validation of BIDS dataset. BIDS validation
                        would be performed using the bids-validator plugin (if
                        installed/enabled) or with the pybids validator
                        implementation (if bids-validator is not
                        installed/enabled).
  --workdir WORKDIR     Folder for storing working files. If not specified,
                        will be in "work/" subfolder in the output folder. You
                        can also use environment variables when setting the
                        workdir, e.g. --workdir '$SLURM_TMPDIR'.
  --version             Print the version of HippUnfold
  --participant-label LABEL [LABEL ...], --participant_label LABEL [LABEL ...]
                        The label(s) of the participant(s) that should be
                        analyzed. The label corresponds to
                        sub-<participant_label> from the BIDS sec (so it does
                        not include "sub-"). If this parameter is not provided
                        all subjects should be analyzed. Multiple participants
                        can be specified with a space separated list.
  --exclude-participant-label LABEL [LABEL ...], --exclude_participant_label LABEL [LABEL ...]
                        The label(s) of the participant(s) that should be
                        excluded. The label corresponds to
                        sub-<participant_label> from the BIDS spec (so it does
                        not include "sub-"). If this parameter is not provided
                        all subjects should be analyzed. Multiple participants
                        can be specified with a space separated list.
  --derivatives [PATH ...]
                        Path(s) to a derivatives dataset, for folder(s) that
                        contains multiple derivatives datasets
  --pybidsdb-dir PATH, --pybidsdb_dir PATH
                        Optional path to directory of SQLite databasefile for
                        PyBIDS. If directory is passed and folder exists,
                        indexing is skipped. If pybidsdb_reset is called,
                        indexing will persist
  --pybidsdb-reset, --pybidsdb_reset
                        Reindex existing PyBIDS SQLite database
  --help-snakemake, --help_snakemake
                        Options to Snakemake can also be passed directly at
                        the command-line, use this to print Snakemake usage
  --force-output, --force_output
                        Force output in a new directory that already has
                        contents

BIDS FILTERS:
  Update filters for input components. Each filter can be specified as a
  ENTITY=VALUE pair to select an value directly. To use regex filtering,
  ENTITY:match=REGEX or ENTITY:search=REGEX can be used for re.match() or
  re.search() respectively. Regex can also be used to select multiple
  values, e.g. 'session:match=01|02'. ENTITY:required and ENTITY:none can be
  used to require or prohibit presence of an entity in selected paths,
  respectively. ENTITY:optional can be used to remove a filter.

  --filter-T2w ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...], --filter_T2w ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...]
                        (default: suffix=T2w extension=.nii.gz datatype=anat)
  --filter-hippb500 ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...], --filter_hippb500 ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...]
                        (default: suffix=b500 extension=.nii.gz datatype=dwi)
  --filter-T1w ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...], --filter_T1w ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...]
                        (default: suffix=T1w extension=.nii.gz datatype=anat)
  --filter-dsegtissue ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...], --filter_dsegtissue ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...]
                        (default: suffix=dseg extension=.nii.gz datatype=anat)
  --filter-dsegsubfields ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...], --filter_dsegsubfields ENTITY[:METHOD][=VALUE] [ENTITY[:METHOD][=VALUE] ...]
                        (default: suffix=dseg extension=.nii.gz datatype=anat)

INPUT WILDCARDS:
  Provide entities to be used as wildcards.

  --wildcards-T2w WILDCARD [WILDCARD ...], --wildcards_T2w WILDCARD [WILDCARD ...]
                        (default: subject session acquisition run)
  --wildcards-hippb500 WILDCARD [WILDCARD ...], --wildcards_hippb500 WILDCARD [WILDCARD ...]
                        (default: subject session)
  --wildcards-T1w WILDCARD [WILDCARD ...], --wildcards_T1w WILDCARD [WILDCARD ...]
                        (default: subject session acquisition run)
  --wildcards-dsegtissue WILDCARD [WILDCARD ...], --wildcards_dsegtissue WILDCARD [WILDCARD ...]
                        (default: subject session hemi acquisition run)
  --wildcards-dsegsubfields WILDCARD [WILDCARD ...], --wildcards_dsegsubfields WILDCARD [WILDCARD ...]
                        (default: subject session hemi acquisition run)

PATH OVERRIDE:
  Options for overriding BIDS by specifying absolute paths that include
  wildcards, e.g.: /path/to/my_data/{subject}/t1.nii.gz

  --path-T2w PATH, --path_T2w PATH
  --path-hippb500 PATH, --path_hippb500 PATH
  --path-T1w PATH, --path_T1w PATH
  --path-dsegtissue PATH, --path_dsegtissue PATH
  --path-dsegsubfields PATH, --path_dsegsubfields PATH
```

