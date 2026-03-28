[HippUnfold Documentation](../index.html)

Getting started

* [Installation](../getting_started/installation.html)
* [Running HippUnfold with Docker on Windows](../getting_started/docker.html)
* [Running HippUnfold with Singularity](../getting_started/singularity.html)
* [Running HippUnfold with a Vagrant VM](../getting_started/vagrant.html)

Usage Notes

* Command-line interface
  + [HippUnfold Command-line interface](#hippunfold-command-line-interface)
    - [Positional Arguments](#positional-arguments)
    - [Named Arguments](#named-arguments)
    - [BIDS FILTERS](#bids-filters)
    - [INPUT WILDCARDS](#input-wildcards)
    - [PATH OVERRIDE](#path-override)
  + [Snakemake command-line interface](#snakemake-command-line-interface)
    - [EXECUTION](#execution)
    - [GROUPING](#grouping)
    - [REPORTS](#reports)
    - [NOTEBOOKS](#notebooks)
    - [UTILITIES](#utilities)
    - [OUTPUT](#output)
    - [BEHAVIOR](#behavior)
    - [SLURM](#slurm)
    - [CLUSTER](#cluster)
    - [FLUX](#flux)
    - [GOOGLE\_LIFE\_SCIENCE](#google_life_science)
    - [KUBERNETES](#kubernetes)
    - [TES](#tes)
    - [TIBANNA](#tibanna)
    - [AZURE\_BATCH](#azure_batch)
    - [CONDA](#conda)
    - [SINGULARITY](#singularity)
    - [ENVIRONMENT MODULES](#environment-modules)
* [Running HippUnfold on your data](useful_options.html)
* [Specialized scans](specializedScans.html)
* [Template-base segmentation](templates.html)
* [Frequently asked questions](faq.html)

Processing pipeline details

* [Pipeline Details](../pipeline/pipeline.html)
* [Algorithmic details](../pipeline/algorithms.html)

Outputs of HippUnfold

* [Output Files](../outputs/output_files.html)
* [Visualization](../outputs/visualization.html)
* [Quality Control](../outputs/QC.html)

Contributing

* [References](../contributing/references.html)
* [Contributing to Hippunfold](../contributing/contributing.html)

[HippUnfold Documentation](../index.html)

* Command-line interface
* [View page source](../_sources/usage/cli.md.txt)

---

# Command-line interface[](#command-line-interface "Permalink to this heading")

## HippUnfold Command-line interface[](#hippunfold-command-line-interface "Permalink to this heading")

The following can also be seen by entering `hippunfold -h` into your terminal.

These are all the required and optional arguments HippUnfold accepts in order to run flexibly on many different input data types and with many options, but in most cases only the required arguments are needed.

Snakebids helps build BIDS Apps with Snakemake

```
usage: hippunfold [-h]
                  [--participant-label PARTICIPANT_LABEL [PARTICIPANT_LABEL ...]]
                  [--exclude_participant_label EXCLUDE_PARTICIPANT_LABEL [EXCLUDE_PARTICIPANT_LABEL ...]]
                  [--version] --modality
                  {T1w,T2w,hippb500,segT1w,segT2w,cropseg}
                  [--template {CITI168,dHCP,MBMv2,MBMv3,CIVM,ABAv3,bigbrain}]
                  [--inject_template {upenn,dHCP,MBMv2,MBMv3,CIVM,ABAv3,bigbrain}]
                  [--use-template-seg]
                  [--template-seg-smoothing-factor TEMPLATE_SEG_SMOOTHING_FACTOR]
                  [--derivatives DERIVATIVES] [--skip_preproc] [--skip-coreg]
                  [--skip-inject-template-labels]
                  [--inject_template_smoothing_factor INJECT_TEMPLATE_SMOOTHING_FACTOR]
                  [--rigid_reg_template] [--no-reg-template]
                  [--t1-reg-template] [--crop-native-res CROP_NATIVE_RES]
                  [--crop_native_box CROP_NATIVE_BOX]
                  [--atlas {bigbrain,magdeburg,freesurfer,multihist7,macaque,mouse} [{bigbrain,magdeburg,freesurfer,multihist7,macaque,mouse} ...]]
                  [--no-unfolded-reg] [--generate-myelin-map] [--use-gpu]
                  [--nnunet_enable_tta]
                  [--output_spaces {native,T1w} [{native,T1w} ...]]
                  [--output_density {0p5mm,1mm,2mm,unfoldiso} [{0p5mm,1mm,2mm,unfoldiso} ...]]
                  [--hemi {L,R} [{L,R} ...]]
                  [--laminar-coords-method {laplace,equivolume}]
                  [--autotop-labels {hipp,dentate} [{hipp,dentate} ...]]
                  [--keep-work]
                  [--force-nnunet-model {T1w,T2w,T1T2w,b1000,trimodal,hippb500,neonateT1w,synthseg_v0.1,synthseg_v0.2,neonateT1w_v2,ADNI_T1w_v1}]
                  [--filter-T2w ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-hippb500 ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-T1w ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-seg ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--filter-cropseg ENTITY[:METHOD][=VALUE]
                  [ENTITY[:METHOD][=VALUE] ...]]
                  [--wildcards-T2w WILDCARD [WILDCARD ...]]
                  [--wildcards-hippb500 WILDCARD [WILDCARD ...]]
                  [--wildcards-T1w WILDCARD [WILDCARD ...]]
                  [--wildcards-seg WILDCARD [WILDCARD ...]]
                  [--wildcards-cropseg WILDCARD [WILDCARD ...]]
                  [--path-T2w PATH] [--path-hippb500 PATH] [--path-T1w PATH]
                  [--path-seg PATH] [--path-cropseg PATH]
                  [--pybidsdb-dir PATH] [--pybidsdb-reset] [--help-snakemake]
                  [--force-output]
                  bids_dir output_dir {participant,group}
```

### Positional Arguments[](#positional-arguments "Permalink to this heading")

`bids_dir`
:   The directory with the input dataset formatted according to the BIDS standard.

`output_dir`
:   The directory where the output files should be stored. If you are running group level analysis this folder should be prepopulated with the results of the participant level analysis.

`analysis_level`
:   Possible choices: participant, group

    Level of the analysis that will be performed.

### Named Arguments[](#named-arguments "Permalink to this heading")

`--participant-label, --participant_label`
:   The label(s) of the participant(s) that should be analyzed. The label corresponds to sub-<participant\_label> from the BIDS spec (so it does not include “sub-“). If this parameter is not provided all subjects should be analyzed. Multiple participants can be specified with a space separated list.

`--exclude_participant_label, --exclude-participant-label`
:   The label(s) of the participant(s) that should be excluded. The label corresponds to sub-<participant\_label> from the BIDS spec (so it does not include “sub-“). If this parameter is not provided all subjects should be analyzed. Multiple participants can be specified with a space separated list.

`--version`
:   Print the version of HippUnfold

`--modality`
:   Possible choices: T1w, T2w, hippb500, segT1w, segT2w, cropseg

    Type of image to run hippunfold on. Modality prefixed with seg will import an existing (manual) hippocampal tissue segmentation from that space, instead of running neural network (default: None)

`--template`
:   Possible choices: CITI168, dHCP, MBMv2, MBMv3, CIVM, ABAv3, bigbrain

    Set the template to use for registration to coronal oblique (and optionally for template-based segmentation if –use-template-seg is enabled). CITI168 is for adult human data, dHCP is for neonatal human data, MBMv2 is for ex vivo marmoset data, MBMv3 is for in vivo marmoset data, CIVM is for in vivo macaque data, and ABAv3 is for mouse data. When using a non-human template, consider using a corresponding atlas. (default: “CITI168”)

    Default: “CITI168”

`--inject_template, --inject-template`
:   Possible choices: upenn, dHCP, MBMv2, MBMv3, CIVM, ABAv3, bigbrain

    Set the template to use for shape injection. (default: “upenn”)

    Default: “upenn”

`--use-template-seg, --use_template_seg`
:   Use template-based segmentation for hippocampal tissue *instead of* nnUnet and shape injection. This is only to be used if nnUnet models are not trained for the data you are using, e.g. for non-human primate data with the MBMv2 (ex vivo marmoset), MBMv3 (in vivo marmoset), or CIVM (ex vivo macaque) template. (default: False)

    Default: False

`--template-seg-smoothing-factor, --template_seg_smoothing_factor`
:   Scales the default smoothing sigma for gradient and warp in greedy registration for template-based segmentation. Using a value higher than 1 will use result in a smoother warp. (default: 2.0)

    Default: 2.0

`--derivatives`
:   Path to the derivatives folder (e.g. for finding manual segs) (default: False)

    Default: False

`--skip_preproc, --skip-preproc`
:   Set this flag if your inputs (e.g. T2w, dwi) are already pre-processed (default: False)

    Default: False

`--skip-coreg, --skip_coreg`
:   Set this flag if your inputs (e.g. T2w, dwi) are already registered to T1w space (default: False)

    Default: False

`--skip-inject-template-labels, --skip_inject_template_labels`
:   Set this flag to skip post-processing template injection into CNN segmentation. Note this will disable generation of DG surfaces. (default: False)

    Default: False

`--inject_template_smoothing_factor, --inject-template-smoothing-factor`
:   Scales the default smoothing sigma for gradient and warp in template shape injection. Using a value higher than 1 will use result in a smoother warp, and greater capacity to patch larger holes in segmentations. Try setting to 2 if nnunet segmentations have large holes. Note: the better solution is to re-train network on the data you are using (default: 1.0)

    Default: 1.0

`--rigid_reg_template, --rigid-reg-template`
:   Use rigid instead of affine for registration to template. Try this if your images are reduced FOV (default: False)

    Default: False

`--no-reg-template, --no_reg_template`
:   Use if input data is already in space-CITI168 (default: False)

    Default: False

`--t1-reg-template, --t1_reg_template`
:   Use T1w to register to template space, instead of the segmentation modality. Note: this was the default behavior prior to v1.0.0. (default: False)

    Default: False

`--crop-native-res, --crop_native_res`
:   Sets the bounding box resolution for the crop native (e.g. cropT1w space). Under the hood, hippUnfold operates at higher resolution than the native image, so this tries to preserve some of that detail. (default: “0.2x0.2x0.2mm”)

    Default: “0.2x0.2x0.2mm”

`--crop_native_box, --crop-native-box`
:   Sets the bounding box size for the crop native (e.g. cropT1w space). Make this larger if your hippocampi in crop{T1w,T2w} space are getting cut-off. This must be in voxels (vox) not millimeters (mm). (default: “256x256x256vox”)

    Default: “256x256x256vox”

`--atlas`
:   Possible choices: bigbrain, magdeburg, freesurfer, multihist7, macaque, mouse

    Select the atlas (unfolded space) to use for subfield labels. (default: [‘multihist7’])

    Default: [‘multihist7’]

`--no-unfolded-reg, --no_unfolded_reg`
:   Do not perform unfolded space (2D) registration based on thickness, curvature, and gyrification for closer alignment to the reference atlas. NOTE: only multihist7 has these features currently, so this unfolded\_reg is automatically skipped if a different atlas is chosen. (default: False)

    Default: False

`--generate-myelin-map, --generate_myelin_map`
:   Generate myelin map using T1w divided by T2w, and map to surface with ribbon approach. Requires both T1w and T2w images to be present. (default: False)

    Default: False

`--use-gpu, --use_gpu`
:   Enable gpu for inference by setting resource gpus=1 in run\_inference rule (default: False)

    Default: False

`--nnunet_enable_tta, --nnunet-enable-tta`
:   Enable test-time augmentation for nnU-net inference, slows down inference by 8x, but potentially increases accuracy (default: False)

    Default: False

`--output_spaces, --output-spaces`
:   Possible choices: native, T1w

    Sets output spaces for results (default: [‘native’])

    Default: [‘native’]

`--output_density, --output-density`
:   Possible choices: 0p5mm, 1mm, 2mm, unfoldiso

    Sets the output vertex density for results. Options correspond to approximate vertex spacings of 0.5mm, 1.0mm, and 2.0mm, respectively, with the unfoldiso (32k hipp) vertices legacy option having unequal vertex spacing. (default: [‘0p5mm’])

    Default: [‘0p5mm’]

`--hemi`
:   Possible choices: L, R

    Hemisphere(s) to process (default: [‘L’, ‘R’])

    Default: [‘L’, ‘R’]

`--laminar-coords-method, --laminar_coords_method`
:   Possible choices: laplace, equivolume

    Method to use for laminar coordinates. Equivolume uses equivolumetric layering from Waehnert et al 2014 (Nighres implementation). (default: [‘equivolume’])

    Default: [‘equivolume’]

`--autotop-labels, --autotop_labels`
:   Possible choices: hipp, dentate

    Run hipp (CA + subiculum) alone or include dentate (default: [‘hipp’, ‘dentate’])

    Default: [‘hipp’, ‘dentate’]

`--keep-work, --keep_work`
:   Keep work folder intact instead of archiving it for each subject (default: False)

    Default: False

`--force-nnunet-model, --force_nnunet_model`
:   Possible choices: T1w, T2w, T1T2w, b1000, trimodal, hippb500, neonateT1w, synthseg\_v0.1, synthseg\_v0.2, neonateT1w\_v2, ADNI\_T1w\_v1

    Force nnunet model to use (expert option). (default: False)

    Default: False

`--pybidsdb-dir, --pybidsdb_dir`
:   Optional path to directory of SQLite databasefile for PyBIDS. If directory is passed and folder exists, indexing is skipped. If pybidsdb\_reset is called, indexing will persist

`--pybidsdb-reset, --pybidsdb_reset`
:   Reindex existing PyBIDS SQLite database

    Default: False

`--help-snakemake, --help_snakemake`
:   Options to Snakemake can also be passed directly at the command-line, use this to print Snakemake usage

`--force-output, --force_output`
:   Force output in a new directory that already has contents

    Default: False

### BIDS FILTERS[](#bids-filters "Permalink to this heading")

Update filters for input components. Each filter can be specified as a ENTITY=VALUE pair to select an value directly. To use regex filtering, ENTITY:match=REGEX or ENTITY:search=REGEX can be used for re.match() or re.search() respectively. Regex can also be used to select multiple values, e.g. ‘session:match=01|02’. ENTITY:required and ENTITY:none can be used to require or prohibit presence of an entity in selected paths, respectively. ENTITY:optional can be used to remove a filter.

`--filter-T2w, --filter_T2w`
:   (default: suffix=T2w extension=.nii.gz datatype=anat invalid\_filters=allow space=None)

`--filter-hippb500, --filter_hippb500`
:   (default: suffix=b500 extension=.nii.gz invalid\_filters=allow datatype=dwi)

`--filter-T1w, --filter_T1w`
:   (default: suffix=T1w extension=.nii.gz datatype=anat invalid\_filters=allow space=None)

`--filter-seg, --filter_seg`
:   (default: suffix=dseg extension=.nii.gz datatype=anat invalid\_filters=allow)

`--filter-crop