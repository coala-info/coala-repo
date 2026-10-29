# mrtrix3 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mrtrix3_5tt2gmwmi | PASS |  |
| mrtrix3_5tt2vis | PASS |  |
| mrtrix3_5ttcheck | PASS |  |
| mrtrix3_5ttedit | PASS |  |
| mrtrix3_5ttgen_freesurfer | PASS | uses a FreeSurfer parcellation and its colour table, passed with -lut |
| mrtrix3_5ttgen_fsl | Failed | image problem: FSL is not in the image (FSLDIR is not set; the script stops at once) |
| mrtrix3_5ttgen_gif | Not completed | no Geodesic Information Flow segmentation image available as test data (the script stops on a wrong input) |
| mrtrix3_5ttgen_hsvs | Not completed | needs a FreeSurfer subject directory (not available as test data) and FreeSurfer and FSL tools that the image does not contain |
| mrtrix3_afdconnectivity | PASS |  |
| mrtrix3_amp2response | PASS |  |
| mrtrix3_amp2sh | PASS |  |
| mrtrix3_connectome2tck | PASS |  |
| mrtrix3_connectomeedit | PASS |  |
| mrtrix3_connectomestats | PASS |  |
| mrtrix3_convert_bruker | Not completed | no Bruker 2dseq dataset (with its parameter files) available as test data |
| mrtrix3_dcmedit | PASS |  |
| mrtrix3_dcminfo | PASS |  |
| mrtrix3_dirflip | PASS |  |
| mrtrix3_dirgen | PASS |  |
| mrtrix3_dirmerge | PASS |  |
| mrtrix3_dirorder | PASS |  |
| mrtrix3_dirsplit | PASS |  |
| mrtrix3_dirstat | PASS |  |
| mrtrix3_dwi2adc | PASS |  |
| mrtrix3_dwi2fod | PASS |  |
| mrtrix3_dwi2mask | PASS |  |
| mrtrix3_dwi2response_dhollander | PASS |  |
| mrtrix3_dwi2response_fa | PASS |  |
| mrtrix3_dwi2response_manual | PASS |  |
| mrtrix3_dwi2response_msmt_5tt | PASS | synthetic data: the 5TT image is derived from the real multi-shell tissue maps (no real co-registered 5TT exists in the test data) |
| mrtrix3_dwi2response_tax | PASS |  |
| mrtrix3_dwi2response_tournier | PASS |  |
| mrtrix3_dwi2tensor | PASS |  |
| mrtrix3_dwibiascorrect_ants | Failed | image problem: ANTs N4BiasFieldCorrection is not in the image |
| mrtrix3_dwibiascorrect_fsl | Failed | image problem: FSL is not in the image (FSLDIR is not set; the script stops at once) |
| mrtrix3_dwicat | PASS |  |
| mrtrix3_dwidenoise | PASS |  |
| mrtrix3_dwiextract | PASS |  |
| mrtrix3_dwifslpreproc | Failed | image problem: FSL (eddy, topup) is not in the image (FSLDIR is not set; the script stops at once) |
| mrtrix3_dwigradcheck | PASS |  |
| mrtrix3_dwinormalise_group | PASS |  |
| mrtrix3_dwinormalise_individual | PASS |  |
| mrtrix3_dwishellmath | PASS |  |
| mrtrix3_fixel2peaks | PASS |  |
| mrtrix3_fixel2sh | PASS |  |
| mrtrix3_fixel2tsf | PASS |  |
| mrtrix3_fixel2voxel | PASS |  |
| mrtrix3_fixelcfestats | PASS |  |
| mrtrix3_fixelconnectivity | PASS |  |
| mrtrix3_fixelconvert | PASS |  |
| mrtrix3_fixelcorrespondence | PASS |  |
| mrtrix3_fixelcrop | PASS |  |
| mrtrix3_fixelfilter | PASS |  |
| mrtrix3_fixelreorient | PASS |  |
| mrtrix3_fod2dec | PASS |  |
| mrtrix3_fod2fixel | PASS |  |
| mrtrix3_for_each | PASS |  |
| mrtrix3_gen_scheme | PASS |  |
| mrtrix3_label2colour | PASS |  |
| mrtrix3_label2mesh | PASS |  |
| mrtrix3_labelconvert | PASS |  |
| mrtrix3_labelsgmfix | Failed | image problem: FSL (FIRST) is not in the image; the script stops with FSLDIR is not set |
| mrtrix3_labelstats | PASS |  |
| mrtrix3_maskdump | PASS |  |
| mrtrix3_maskfilter | PASS |  |
| mrtrix3_mesh2voxel | PASS |  |
| mrtrix3_meshconvert | PASS |  |
| mrtrix3_meshfilter | PASS |  |
| mrtrix3_mraverageheader | PASS |  |
| mrtrix3_mrcalc | PASS |  |
| mrtrix3_mrcat | PASS |  |
| mrtrix3_mrcentroid | PASS |  |
| mrtrix3_mrcheckerboardmask | PASS |  |
| mrtrix3_mrclusterstats | PASS | synthetic data: six scaled copies of a real FA map with a planted group effect; the planted effect was recovered |
| mrtrix3_mrcolour | PASS |  |
| mrtrix3_mrconvert | PASS |  |
| mrtrix3_mrdegibbs | PASS |  |
| mrtrix3_mrdump | PASS |  |
| mrtrix3_mredit | PASS |  |
| mrtrix3_mrfilter | PASS |  |
| mrtrix3_mrgrid | PASS |  |
| mrtrix3_mrhistmatch | PASS | synthetic data: target is the real FA map multiplied by 2; scale matching works |
| mrtrix3_mrhistogram | PASS |  |
| mrtrix3_mrinfo | PASS |  |
| mrtrix3_mrmath | PASS |  |
| mrtrix3_mrmetric | PASS | synthetic data: compares a real FA map with a copy multiplied by 2 |
| mrtrix3_mrregister | PASS | synthetic data: real FA map shifted by 3 mm; the rigid registration recovered the shift |
| mrtrix3_mrstats | PASS |  |
| mrtrix3_mrthreshold | PASS |  |
| mrtrix3_mrtransform | PASS |  |
| mrtrix3_mrtrix_cleanup | PASS | synthetic data: planted temporary files; test mode lists them |
| mrtrix3_mtnormalise | PASS |  |
| mrtrix3_peaks2amp | PASS |  |
| mrtrix3_peaks2fixel | PASS |  |
| mrtrix3_population_template | PASS |  |
| mrtrix3_responsemean | PASS |  |
| mrtrix3_sh2amp | PASS |  |
| mrtrix3_sh2peaks | PASS |  |
| mrtrix3_sh2power | PASS |  |
| mrtrix3_sh2response | PASS |  |
| mrtrix3_shbasis | PASS |  |
| mrtrix3_shconv | PASS |  |
| mrtrix3_tck2connectome | PASS |  |
| mrtrix3_tck2fixel | PASS |  |
| mrtrix3_tckconvert | PASS |  |
| mrtrix3_tckdfc | PASS |  |
| mrtrix3_tckedit | PASS |  |
| mrtrix3_tckgen | PASS |  |
| mrtrix3_tckglobal | PASS |  |
| mrtrix3_tckinfo | PASS |  |
| mrtrix3_tckmap | PASS |  |
| mrtrix3_tckresample | PASS |  |
| mrtrix3_tcksample | PASS |  |
| mrtrix3_tcksift | PASS |  |
| mrtrix3_tcksift2 | PASS |  |
| mrtrix3_tckstats | PASS |  |
| mrtrix3_tcktransform | PASS |  |
| mrtrix3_tensor2metric | PASS |  |
| mrtrix3_transformcalc | PASS |  |
| mrtrix3_transformcompose | PASS |  |
| mrtrix3_transformconvert | PASS |  |
| mrtrix3_tsfdivide | PASS |  |
| mrtrix3_tsfinfo | PASS |  |
| mrtrix3_tsfmult | PASS |  |
| mrtrix3_tsfsmooth | PASS |  |
| mrtrix3_tsfthreshold | PASS |  |
| mrtrix3_tsfvalidate | PASS |  |
| mrtrix3_vectorstats | PASS |  |
| mrtrix3_voxel2fixel | PASS |  |
| mrtrix3_voxel2mesh | PASS |  |
| mrtrix3_warp2metric | PASS |  |
| mrtrix3_warpconvert | PASS |  |
| mrtrix3_warpcorrect | PASS |  |
| mrtrix3_warpinit | PASS |  |
| mrtrix3_warpinvert | PASS |  |

## mrtrix3_dwi2adc

### Tool Description
Convert mean dwi (trace-weighted) images to mean ADC maps

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dwi2adc                         Oct 21 2025

     dwi2adc: part of the MRtrix3 package

SYNOPSIS

     Convert mean dwi (trace-weighted) images to mean ADC maps

USAGE

     dwi2adc [ options ] input output

        input        the input image.

        output       the output image.


DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2mask

### Tool Description
Generates a whole brain mask from a DWI image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        dwi2mask                         Oct 21 2025

     dwi2mask: part of the MRtrix3 package

SYNOPSIS

     Generates a whole brain mask from a DWI image

USAGE

     dwi2mask [ options ] input output

        input        the input DWI image containing volumes that are both
                     diffusion weighted and b=0

        output       the output whole-brain mask image


DESCRIPTION

     All diffusion weighted and b=0 volumes are used to obtain a mask that
     includes both brain tissue and CSF.

     In a second step peninsula-like extensions, where the peninsula itself is
     wider than the bridge connecting it to the mask, are removed. This may
     help removing artefacts and non-brain parts, e.g. eyes, from the mask.

OPTIONS

  -clean_scale value
     the maximum scale used to cut bridges. A certain maximum scale cuts
     bridges up to a width (in voxels) of 2x the provided scale. Setting this
     to 0 disables the mask cleaning step. (Default: 2)

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au), Thijs Dhollander
     (thijs.dhollander@gmail.com) and Ben Jeurissen
     (ben.jeurissen@uantwerpen.be)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Dhollander T, Raffelt D, Connelly A. Unsupervised 3-tissue response
     function estimation from single-shell or multi-shell diffusion MR data
     without a co-registered T1 image. ISMRM Workshop on Breaking the Barriers
     of Diffusion MRI, 2016, 5

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2tensor

### Tool Description
Diffusion (kurtosis) tensor estimation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       dwi2tensor                        Oct 21 2025

     dwi2tensor: part of the MRtrix3 package

SYNOPSIS

     Diffusion (kurtosis) tensor estimation

USAGE

     dwi2tensor [ options ] dwi dt

        dwi          the input dwi image.

        dt           the output dt image.


DESCRIPTION

     By default, the diffusion tensor (and optionally its kurtosis) is fitted
     to the log-signal in two steps: firstly, using weighted least-squares
     (WLS) with weights based on the empirical signal intensities; secondly, by
     further iterated weighted least-squares (IWLS) with weights determined by
     the signal predictions from the previous iteration (by default, 2
     iterations will be performed). This behaviour can be altered in two ways:

     * The -ols option will cause the first fitting step to be performed using
     ordinary least-squares (OLS); that is, all measurements contribute equally
     to the fit, instead of the default behaviour of weighting based on the
     empirical signal intensities.

     * The -iter option controls the number of iterations of the IWLS
     prodedure. If this is set to zero, then the output model parameters will
     be those resulting from the first fitting step only: either WLS by
     default, or OLS if the -ols option is used in conjunction with -iter 0.

     The tensor coefficients are stored in the output image as follows:
     volumes 0-5: D11, D22, D33, D12, D13, D23

     If diffusion kurtosis is estimated using the -dkt option, these are stored
     as follows:
     volumes 0-2: W1111, W2222, W3333
     volumes 3-8: W1112, W1113, W1222, W1333, W2223, W2333
     volumes 9-11: W1122, W1133, W2233
     volumes 12-14: W1123, W1223, W1233

OPTIONS

  -ols
     perform initial fit using an ordinary least-squares (OLS) fit (see
     Description).

  -mask image
     only perform computation within the specified binary brain mask image.

  -b0 image
     the output b0 image.

  -dkt image
     the output dkt image.

  -iter integer
     number of iterative reweightings for IWLS algorithm (default: 2) (see
     Description).

  -predicted_signal image
     the predicted dwi image.

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Ben Jeurissen (ben.jeurissen@uantwerpen.be)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     References based on fitting algorithm used:

     * OLS, WLS:
     Basser, P.J.; Mattiello, J.; LeBihan, D. Estimation of the effective
     self-diffusion tensor from the NMR spin echo. J Magn Reson B., 1994, 103,
     247–254.

     * IWLS:
     Veraart, J.; Sijbers, J.; Sunaert, S.; Leemans, A. & Jeurissen, B.
     Weighted linear least squares estimation of diffusion MRI parameters:
     strengths, limitations, and pitfalls. NeuroImage, 2013, 81, 335-346

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwiextract

### Tool Description
Extract diffusion-weighted volumes, b=0 volumes, or certain shells from a DWI dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       dwiextract                        Oct 21 2025

     dwiextract: part of the MRtrix3 package

SYNOPSIS

     Extract diffusion-weighted volumes, b=0 volumes, or certain shells from a
     DWI dataset

USAGE

     dwiextract [ options ] input output

        input        the input DW image.

        output       the output image (diffusion-weighted volumes by default).


EXAMPLE USAGES

     Calculate_the_mean_b=0_image_from_a_4D_DWI_series:
       $ dwiextract dwi.mif - -bzero | mrmath - mean mean_bzero.mif -axis 3
     The dwiextract command extracts all volumes for which the b-value is
     (approximately) zero; the resulting 4D image can then be provided to the
     mrmath command to calculate the mean intensity across volumes for each
     voxel.

OPTIONS

  -bzero
     Output b=0 volumes (instead of the diffusion weighted volumes, if
     -singleshell is not specified).

  -no_bzero
     Output only non b=0 volumes (default, if -singleshell is not specified).

  -singleshell
     Force a single-shell (single non b=0 shell) output. This will include b=0
     volumes, if present. Use with -bzero to enforce presence of b=0 volumes
     (error if not present) or with -no_bzero to exclude them.

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

DW shell selection options

  -shells b-values
     specify one or more b-values to use during processing, as a
     comma-separated list of the desired approximate b-values (b-values are
     clustered to allow for small deviations). Note that some commands are
     incompatible with multiple b-values, and will report an error if more than
     one b-value is provided.
     WARNING: note that, even though the b=0 volumes are never referred to as
     shells in the literature, they still have to be explicitly included in the
     list of b-values as provided to the -shell option! Several algorithms
     which include the b=0 volumes in their computations may otherwise return
     an undesired result.

DW gradient table export options

  -export_grad_mrtrix path
     export the diffusion-weighted gradient table to file in MRtrix format

  -export_grad_fsl bvecs_path bvals_path
     export the diffusion-weighted gradient table to files in FSL (bvecs /
     bvals) format

Options for importing phase-encode tables

  -import_pe_table file
     import a phase-encoding table from file

  -import_pe_topup file
     import a phase-encoding table intended for FSL TOPUP from file

  -import_pe_eddy config indices
     import phase-encoding information from an EDDY-style config / index file
     pair

Options for selecting volumes based on phase-encoding

  -pe desc
     select volumes with a particular phase encoding; this can be three
     comma-separated values (for i,j,k components of vector direction) or four
     (direction & total readout time)

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) and Thijs Dhollander
     (thijs.dhollander@gmail.com) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwidenoise

### Tool Description
dMRI noise level estimation and denoising using Marchenko-Pastur PCA

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       dwidenoise                        Oct 21 2025

     dwidenoise: part of the MRtrix3 package

SYNOPSIS

     dMRI noise level estimation and denoising using Marchenko-Pastur PCA

USAGE

     dwidenoise [ options ] dwi out

        dwi          the input diffusion-weighted image.

        out          the output denoised DWI image.


DESCRIPTION

     DWI data denoising and noise map estimation by exploiting data redundancy
     in the PCA domain using the prior knowledge that the eigenspectrum of
     random covariance matrices is described by the universal Marchenko-Pastur
     (MP) distribution. Fitting the MP distribution to the spectrum of
     patch-wise signal matrices hence provides an estimator of the noise level
     'sigma', as was first shown in Veraart et al. (2016) and later improved in
     Cordero-Grande et al. (2019). This noise level estimate then determines
     the optimal cut-off for PCA denoising.

     Important note: image denoising must be performed as the first step of the
     image processing pipeline. The routine will fail if interpolation or
     smoothing has been applied to the data prior to denoising.

     Note that this function does not correct for non-Gaussian noise biases
     present in magnitude-reconstructed MRI images. If available, including the
     MRI phase data can reduce such non-Gaussian biases, and the command now
     supports complex input data.

OPTIONS

  -mask image
     Only process voxels within the specified binary brain mask image.

  -extent window
     Set the patch size of the denoising filter. By default, the command will
     select the smallest isotropic patch size that exceeds the number of DW
     images in the input data, e.g., 5x5x5 for data with <= 125 DWI volumes,
     7x7x7 for data with <= 343 DWI volumes, etc.

  -noise level
     The output noise map, i.e., the estimated noise level 'sigma' in the data.
     Note that on complex input data, this will be the total noise level across
     real and imaginary channels, so a scale factor sqrt(2) applies.

  -datatype float32/float64
     Datatype for the eigenvalue decomposition (single or double precision).
     For complex input data, this will select complex float32 or complex
     float64 datatypes.

  -estimator Exp1/Exp2
     Select the noise level estimator (default = Exp2), either:
     * Exp1: the original estimator used in Veraart et al. (2016), or
     * Exp2: the improved estimator introduced in Cordero-Grande et al. (2019).

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Daan Christiaens (daan.christiaens@kcl.ac.uk) & Jelle Veraart
     (jelle.veraart@nyumc.org) & J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2016 New York University, University of Antwerp, and the
     MRtrix3 contributors

     Permission is hereby granted, free of charge, to any non-commercial entity
     ('Recipient') obtaining a copy of this software and associated
     documentation files (the 'Software'), to the Software solely for
     non-commercial research, including the rights to use, copy and modify the
     Software, subject to the following conditions:

       1. The above copyright notice and this permission notice shall be
     included by Recipient in all copies or substantial portions of the
     Software.

       2. THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIESOF
     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
     NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BELIABLE FOR ANY CLAIM,
     DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
     OTHERWISE, ARISING FROM, OUT OF ORIN CONNECTION WITH THE SOFTWARE OR THE
     USE OR OTHER DEALINGS IN THE SOFTWARE.

       3. In no event shall NYU be liable for direct, indirect, special,
     incidental or consequential damages in connection with the Software.
     Recipient will defend, indemnify and hold NYU harmless from any claims or
     liability resulting from the use of the Software by recipient.

       4. Neither anything contained herein nor the delivery of the Software to
     recipient shall be deemed to grant the Recipient any right or licenses
     under any patents or patent application owned by NYU.

       5. The Software may only be used for non-commercial research and may not
     be used for clinical care.

       6. Any publication by Recipient of research involving the Software shall
     cite the references listed below.

REFERENCES
     Veraart, J.; Novikov, D.S.; Christiaens, D.; Ades-aron, B.; Sijbers, J. &
     Fieremans, E. Denoising of diffusion MRI using random matrix theory.
     NeuroImage, 2016, 142, 394-406, doi: 10.1016/j.neuroimage.2016.08.016

     Veraart, J.; Fieremans, E. & Novikov, D.S. Diffusion MRI noise mapping
     using random matrix theory. Magn. Res. Med., 2016, 76(5), 1582-1593, doi:
     10.1002/mrm.26059

     Cordero-Grande, L.; Christiaens, D.; Hutter, J.; Price, A.N.; Hajnal, J.V.
     Complex diffusion-weighted image estimation via matrix recovery under
     general noise models. NeuroImage, 2019, 200, 391-404, doi:
     10.1016/j.neuroimage.2019.06.039

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwishellmath

### Tool Description
Apply an mrmath operation to each b-value shell in a DWI series

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      dwishellmath

     dwishellmath: part of the MRtrix3 package

SYNOPSIS

     Apply an mrmath operation to each b-value shell in a DWI series

USAGE

     dwishellmath [ options ] input operation output

        input        The input diffusion MRI series

        operation    The operation to be applied to each shell; this must be one
                     of the following: mean, median, sum, product, rms, norm,
                     var, std, min, max, absmax, magmax

        output       The output image series

DESCRIPTION

     The output of this command is a 4D image, where each volume corresponds to
     a b-value shell (in order of increasing b-value), and the intensities
     within each volume correspond to the chosen statistic having been computed
     from across the DWI volumes belonging to that b-value shell.

EXAMPLE USAGES

     To_compute_the_mean_diffusion-weighted_signal_in_each_b-value_shell:
       $ dwishellmath dwi.mif mean shellmeans.mif

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Daan Christiaens (daan.christiaens@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwigradcheck

### Tool Description
Check the orientation of the diffusion gradient table

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      dwigradcheck

     dwigradcheck: part of the MRtrix3 package

SYNOPSIS

     Check the orientation of the diffusion gradient table

USAGE

     dwigradcheck [ options ] input

        input        The input DWI series to be checked

DESCRIPTION

     Note that the corrected gradient table can be output using the
     -export_grad_{mrtrix,fsl} option.

OPTIONS

  -mask image
     Provide a brain mask image

  -number INT
     Set the number of tracks to generate for each test

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

Options for exporting the diffusion gradient table

  -export_grad_mrtrix grad
     Export the final gradient table in MRtrix format

  -export_grad_fsl bvecs bvals
     Export the final gradient table in FSL bvecs/bvals format

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Jeurissen, B.; Leemans, A.; Sijbers, J. Automated correction of improperly
     rotated diffusion gradient orientations in diffusion weighted MRI. Medical
     Image Analysis, 2014, 18(7), 953-962

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwicat

### Tool Description
Concatenating multiple DWI series accounting for differential intensity scaling

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dwicat

     dwicat: part of the MRtrix3 package

SYNOPSIS

     Concatenating multiple DWI series accounting for differential intensity
     scaling

USAGE

     dwicat [ options ] inputs output

        inputs       Multiple input diffusion MRI series

        output       The output image series (all DWIs concatenated)

DESCRIPTION

     This script concatenates two or more 4D DWI series, accounting for the fact
     that there may be differences in intensity scaling between those series.
     This intensity scaling is corrected by determining scaling factors that
     will make the overall image intensities in the b=0 volumes of each series
     approximately equivalent.

OPTIONS

  -mask image
     Provide a binary mask within which image intensities will be matched

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Lena Dorfschmidt (ld548@cam.ac.uk) and Jakub Vohryzek
     (jakub.vohryzek@queens.ox.ac.uk) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_amp2sh

### Tool Description
Convert a set of amplitudes (defined along a set of corresponding directions) to their spherical harmonic representation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         amp2sh                          Oct 21 2025

     amp2sh: part of the MRtrix3 package

SYNOPSIS

     Convert a set of amplitudes (defined along a set of corresponding
     directions) to their spherical harmonic representation

USAGE

     amp2sh [ options ] amp SH

        amp          the input amplitude image.

        SH           the output spherical harmonics coefficients image.


DESCRIPTION

     The spherical harmonic decomposition is calculated by least-squares linear
     fitting to the amplitude data.

     The directions can be defined either as a DW gradient scheme (for example
     to compute the SH representation of the DW signal), a set of [az el] pairs
     as output by the dirgen command, or a set of [ x y z ] directions in
     Cartesian coordinates. The DW gradient scheme or direction set can be
     supplied within the input image header or using the -gradient or
     -directions option. Note that if a direction set and DW gradient scheme
     can be found, the direction set will be used by default.

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link:
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

OPTIONS

  -lmax order
     set the maximum harmonic order for the output series. By default, the
     program will use the highest possible lmax given the number of
     diffusion-weighted images, up to a maximum of 8.

  -normalise
     normalise the DW signal to the b=0 image

  -directions file
     the directions corresponding to the input amplitude image used to sample
     AFD. By default this option is not required providing the direction set is
     supplied in the amplitude image. This should be supplied as a list of
     directions [az el], as generated using the dirgen command, or as a list of
     [ x y z ] Cartesian coordinates.

  -rician noise
     correct for Rician noise induced bias, using noise map supplied

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

DW shell selection options

  -shells b-values
     specify one or more b-values to use during processing, as a
     comma-separated list of the desired approximate b-values (b-values are
     clustered to allow for small deviations). Note that some commands are
     incompatible with multiple b-values, and will report an error if more than
     one b-value is provided.
     WARNING: note that, even though the b=0 volumes are never referred to as
     shells in the literature, they still have to be explicitly included in the
     list of b-values as provided to the -shell option! Several algorithms
     which include the b=0 volumes in their computations may otherwise return
     an undesired result.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5tt2gmwmi

### Tool Description
Generate a mask image appropriate for seeding streamlines on the grey matter-white matter interface

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        5tt2gmwmi                        Oct 21 2025

     5tt2gmwmi: part of the MRtrix3 package

SYNOPSIS

     Generate a mask image appropriate for seeding streamlines on the grey
     matter-white matter interface

USAGE

     5tt2gmwmi [ options ] 5tt_in mask_out

        5tt_in       the input 5TT segmented anatomical image

        mask_out     the output mask image


OPTIONS

  -mask_in image
     Filter an input mask image according to those voxels that lie upon the
     grey matter - white matter boundary. If no input mask is provided, the
     output will be a whole-brain mask image calculated using the anatomical
     image only.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A.
     Anatomically-constrained tractography:Improved diffusion MRI streamlines
     tractography through effective use of anatomical information. NeuroImage,
     2012, 62, 1924-1938

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5tt2vis

### Tool Description
Generate an image for visualisation purposes from an ACT 5TT segmented anatomical image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         5tt2vis                         Oct 21 2025

     5tt2vis: part of the MRtrix3 package

SYNOPSIS

     Generate an image for visualisation purposes from an ACT 5TT segmented
     anatomical image

USAGE

     5tt2vis [ options ] input output

        input        the input 4D tissue-segmented image

        output       the output 3D image for visualisation


OPTIONS

  -bg value
     image intensity of background (default: 0)

  -cgm value
     image intensity of cortical grey matter (default: 0.5)

  -sgm value
     image intensity of sub-cortical grey matter (default: 0.75)

  -wm value
     image intensity of white matter (default: 1)

  -csf value
     image intensity of CSF (default: 0.15)

  -path value
     image intensity of pathological tissue (default: 2)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5ttcheck

### Tool Description
Thoroughly check that one or more images conform to the expected ACT five-tissue-type (5TT) format

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        5ttcheck                         Oct 21 2025

     5ttcheck: part of the MRtrix3 package

SYNOPSIS

     Thoroughly check that one or more images conform to the expected ACT
     five-tissue-type (5TT) format

USAGE

     5ttcheck [ options ] input [ input ... ]

        input        the 5TT image(s) to be tested


OPTIONS

  -voxels prefix
     output mask images highlighting voxels where the input does not conform to
     5TT requirements

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5ttedit

### Tool Description
Manually set the partial volume fractions in an ACT five-tissue-type (5TT) image using mask images

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         5ttedit                         Oct 21 2025

     5ttedit: part of the MRtrix3 package

SYNOPSIS

     Manually set the partial volume fractions in an ACT five-tissue-type (5TT)
     image using mask images

USAGE

     5ttedit [ options ] input output

        input        the 5TT image to be modified

        output       the output modified 5TT image


OPTIONS

  -cgm image
     provide a mask of voxels that should be set to cortical grey matter

  -sgm image
     provide a mask of voxels that should be set to sub-cortical grey matter

  -wm image
     provide a mask of voxels that should be set to white matter

  -csf image
     provide a mask of voxels that should be set to CSF

  -path image
     provide a mask of voxels that should be set to pathological tissue

  -none image
     provide a mask of voxels that should be cleared (i.e. are non-brain); note
     that this will supersede all other provided masks

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2fod

### Tool Description
Estimate fibre orientation distributions from diffusion data using spherical deconvolution

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dwi2fod                         Oct 21 2025

     dwi2fod: part of the MRtrix3 package

SYNOPSIS

     Estimate fibre orientation distributions from diffusion data using
     spherical deconvolution

USAGE

     dwi2fod [ options ] algorithm dwi response odf [ response odf ... ]

        algorithm    the algorithm to use for FOD estimation. (options are:
                     csd,msmt_csd)

        dwi          the input diffusion-weighted image

        response odf  pairs of input tissue response and output ODF images


DESCRIPTION

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link:
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

EXAMPLE USAGES

     Perform_single-shell_single-tissue_CSD:
       $ dwi2fod csd dwi.mif response_wm.txt wmfod.mif
     This algorithm is designed for single-shell data and only uses a single
     b-value. The response function text file provided should only contain a a
     single row, corresponding to the b-value used for CSD.

     Perform_multi-shell_multi-tissue_CSD:
       $ dwi2fod msmt_csd dwi.mif response_wm.txt wmfod.mif response_gm.txt gm.mif response_csf.txt csf.mif
     This example is the most common use case of multi-tissue CSD, estimating a
     white matter FOD, and grey matter and CSF compartments. This algorithm
     requires at least three unique b-values to estimate three tissue
     compartments. Each response function text file should have a number of
     rows equal to the number of b-values used. If only two unique b-values are
     available, it's also possible to estimate only two tissue compartments,
     e.g., white matter and CSF.

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

DW shell selection options

  -shells b-values
     specify one or more b-values to use during processing, as a
     comma-separated list of the desired approximate b-values (b-values are
     clustered to allow for small deviations). Note that some commands are
     incompatible with multiple b-values, and will report an error if more than
     one b-value is provided.
     WARNING: note that, even though the b=0 volumes are never referred to as
     shells in the literature, they still have to be explicitly included in the
     list of b-values as provided to the -shell option! Several algorithms
     which include the b=0 volumes in their computations may otherwise return
     an undesired result.

Options common to more than one algorithm

  -directions file
     specify the directions over which to apply the non-negativity constraint
     (by default, the built-in 300 direction set is used). These should be
     supplied as a text file containing [ az el ] pairs for the directions.

  -lmax order
     the maximum spherical harmonic order for the output FOD(s).For algorithms
     with multiple outputs, this should be provided as a comma-separated list
     of integers, one for each output image; for single-output algorithms, only
     a single integer should be provided. If omitted, the command will use the
     lmax of the corresponding response function (i.e based on its number of
     coefficients), up to a maximum of 8.

  -mask image
     only perform computation within the specified binary brain mask image.

Options for the Constrained Spherical Deconvolution algorithm

  -filter spec
     the linear frequency filtering parameters used for the initial linear
     spherical deconvolution step (default = [ 1 1 1 0 0 ]). These should be
     supplied as a text file containing the filtering coefficients for each
     even harmonic order.

  -neg_lambda value
     the regularisation parameter lambda that controls the strength of the
     non-negativity constraint (default = 1).

  -norm_lambda value
     the regularisation parameter lambda that controls the strength of the
     constraint on the norm of the solution (default = 1).

  -threshold value
     the threshold below which the amplitude of the FOD is assumed to be zero,
     expressed as an absolute amplitude (default = 0).

  -niter number
     the maximum number of iterations to perform for each voxel (default = 50).
     Use '-niter 0' for a linear unconstrained spherical deconvolution.

Options for the Multi-Shell, Multi-Tissue Constrained Spherical Deconvolution algorithm

  -norm_lambda value
     the regularisation parameter lambda that controls the strength of the
     constraint on the norm of the solution (default = 1e-10).

  -neg_lambda value
     the regularisation parameter lambda that controls the strength of the
     non-negativity constraint (default = 1e-10).

  -predicted_signal image
     output the predicted dwi image.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com) and Ben Jeurissen
     (ben.jeurissen@uantwerpen.be)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If using csd algorithm:
     Tournier, J.-D.; Calamante, F. & Connelly, A. Robust determination of the
     fibre orientation distribution in diffusion MRI: Non-negativity
     constrained super-resolved spherical deconvolution. NeuroImage, 2007, 35,
     1459-1472

     * If using msmt_csd algorithm:
     Jeurissen, B; Tournier, J-D; Dhollander, T; Connelly, A & Sijbers, J.
     Multi-tissue constrained spherical deconvolution for improved analysis of
     multi-shell diffusion MRI data. NeuroImage, 2014, 103, 411-426

     Tournier, J.-D.; Calamante, F., Gadian, D.G. & Connelly, A. Direct
     estimation of the fiber orientation density function from
     diffusion-weighted MRI data using spherical deconvolution. NeuroImage,
     2004, 23, 1176-1185

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dirgen

### Tool Description
Generate a set of uniformly distributed directions using a bipolar electrostatic repulsion model

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dirgen                          Oct 21 2025

     dirgen: part of the MRtrix3 package

SYNOPSIS

     Generate a set of uniformly distributed directions using a bipolar
     electrostatic repulsion model

USAGE

     dirgen [ options ] ndir dirs

        ndir         the number of directions to generate.

        dirs         the text file to write the directions to, as [ az el ]
                     pairs.


DESCRIPTION

     Directions are distributed by analogy to an electrostatic repulsion
     system, with each direction corresponding to a single electrostatic charge
     (for -unipolar), or a pair of diametrically opposed charges (for the
     default bipolar case). The energy of the system is determined based on the
     Coulomb repulsion, which assumes the form 1/r^power, where r is the
     distance between any pair of charges, and p is the power assumed for the
     repulsion law (default: 1). The minimum energy state is obtained by
     gradient descent.

OPTIONS

  -power exp
     specify exponent to use for repulsion power law (default: 1). This must be
     a power of 2 (i.e. 1, 2, 4, 8, 16, ...).

  -niter num
     specify the maximum number of iterations to perform (default: 10000).

  -restarts num
     specify the number of restarts to perform (default: 10).

  -unipolar
     optimise assuming a unipolar electrostatic repulsion model rather than the
     bipolar model normally assumed in DWI

  -cartesian
     Output the directions in Cartesian coordinates [x y z] instead of [az el].

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Jones, D.; Horsfield, M. & Simmons, A. Optimal strategies for measuring
     diffusion in anisotropic systems by magnetic resonance imaging. Magnetic
     Resonance in Medicine, 1999, 42: 515-525

     Papadakis, N. G.; Murrills, C. D.; Hall, L. D.; Huang, C. L.-H. & Adrian
     Carpenter, T. Minimal gradient encoding for robust estimation of diffusion
     anisotropy. Magnetic Resonance Imaging, 2000, 18: 671-679

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_afdconnectivity

### Tool Description
Obtain an estimate of fibre connectivity between two regions using AFD and streamlines tractography

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     afdconnectivity                     Oct 21 2025

     afdconnectivity: part of the MRtrix3 package

SYNOPSIS

     Obtain an estimate of fibre connectivity between two regions using AFD and
     streamlines tractography

USAGE

     afdconnectivity [ options ] image tracks

        image        the input FOD image.

        tracks       the input track file defining the bundle of interest.


DESCRIPTION

     This estimate is obtained by determining a fibre volume (AFD) occupied by
     the pathway of interest, and dividing by the streamline length.

     If only the streamlines belonging to the pathway of interest are provided,
     then ALL of the fibre volume within each fixel selected will contribute to
     the result. If the -wbft option is used to provide whole-brain
     fibre-tracking (of which the pathway of interest should contain a subset),
     only the fraction of the fibre volume in each fixel estimated to belong to
     the pathway of interest will contribute to the result.

     Use -quiet to suppress progress messages and output fibre connectivity
     value only.

     For valid comparisons of AFD connectivity across scans, images MUST be
     intensity normalised and bias field corrected, and a common response
     function for all subjects must be used.

     Note that the sum of the AFD is normalised by streamline length to account
     for subject differences in fibre bundle length. This normalisation results
     in a measure that is more related to the cross-sectional volume of the
     tract (and therefore 'connectivity'). Note that SIFT-ed tract count is a
     superior measure because it is unaffected by tangential yet unrelated
     fibres. However, AFD connectivity may be used as a substitute when
     Anatomically Constrained Tractography is not possible due to uncorrectable
     EPI distortions, and SIFT may therefore not be as effective.

     Longer discussion regarding this command can additionally be found at:
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/afd_connectivity.html (as
     well as in the relevant reference).

OPTIONS

  -wbft tracks
     provide a whole-brain fibre-tracking data set (of which the input track
     file should be a subset), to improve the estimate of fibre bundle volume
     in the presence of partial volume

  -afd_map image
     output a 3D image containing the AFD estimated for each voxel.

  -all_fixels
     if whole-brain fibre-tracking is NOT provided, then if multiple fixels
     within a voxel are traversed by the pathway of interest, by default the
     fixel with the greatest streamlines density is selected to contribute to
     the AFD in that voxel. If this option is provided, then ALL fixels with
     non-zero streamlines density will contribute to the result, even if
     multiple fixels per voxel are selected.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Smith, R. E.; Raffelt, D.; Tournier, J.-D.; Connelly, A. Quantitative
     Streamlines Tractography: Methods and Inter-Subject Normalisation. OHBM
     Aperture, 10.52294/ApertureNeuro.2022.2.NEOD9565.

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dirorder

### Tool Description
Reorder a set of directions to ensure near-uniformity upon truncation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        dirorder                         Oct 21 2025

     dirorder: part of the MRtrix3 package

SYNOPSIS

     Reorder a set of directions to ensure near-uniformity upon truncation

USAGE

     dirorder [ options ] input output

        input        the input directions file

        output       the output directions file


DESCRIPTION

     The intent of this command is to reorder a set of gradient directions such
     that if a scan is terminated prematurely, at any point, the acquired
     directions will still be close to optimally distributed on the
     half-sphere.

OPTIONS

  -cartesian
     Output the directions in Cartesian coordinates [x y z] instead of [az el].

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dirflip

### Tool Description
Invert the polarity of individual directions so as to optimise a unipolar electrostatic repulsion model

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dirflip                         Oct 21 2025

     dirflip: part of the MRtrix3 package

SYNOPSIS

     Invert the polarity of individual directions so as to optimise a unipolar
     electrostatic repulsion model

USAGE

     dirflip [ options ] in out

        in           the input files for the directions.

        out          the output files for the directions.


DESCRIPTION

     The orientations themselves are not affected, only their polarity; this is
     necessary to ensure near-optimal distribution of DW directions for
     eddy-current correction.

OPTIONS

  -permutations num
     number of permutations to try (default: 100000000)

  -cartesian
     Output the directions in Cartesian coordinates [x y z] instead of [az el].

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dirsplit

### Tool Description
Split a set of evenly distributed directions (as generated by dirgen) into approximately uniformly distributed subsets

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        dirsplit                         Oct 21 2025

     dirsplit: part of the MRtrix3 package

SYNOPSIS

     Split a set of evenly distributed directions (as generated by dirgen) into
     approximately uniformly distributed subsets

USAGE

     dirsplit [ options ] dirs out [ out ... ]

        dirs         the text file containing the directions.

        out          the output partitioned directions


OPTIONS

  -permutations num
     number of permutations to try (default: 100000000)

  -cartesian
     Output the directions in Cartesian coordinates [x y z] instead of [az el].

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dirstat

### Tool Description
Report statistics on a direction set

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dirstat                         Oct 21 2025

     dirstat: part of the MRtrix3 package

SYNOPSIS

     Report statistics on a direction set

USAGE

     dirstat [ options ] dirs

        dirs         the text file or image containing the directions.


DESCRIPTION

     This command will accept as inputs:

     - directions file in spherical coordinates (ASCII text, [ az el ]
     space-separated values, one per line);

     - directions file in Cartesian coordinates (ASCII text, [ x y z ]
     space-separated values, one per line);

     - DW gradient files (MRtrix format: ASCII text, [ x y z b ]
     space-separated values, one per line);

     - image files, using the DW gradient scheme found in the header (or
     provided using the appropriate command line options below).

     By default, this produces all relevant metrics for the direction set
     provided. If the direction set contains multiple shells, metrics are
     provided for each shell separately.

     Metrics are produced assuming a unipolar or bipolar electrostatic
     repulsion model, producing the potential energy (total, mean, min & max),
     and the nearest-neighbour angles (mean, min & max). The condition number
     is also produced for the spherical harmonic fits up to the highest
     harmonic order supported by the number of volumes. Finally, the norm of
     the mean direction vector is provided as a measure of the overall symmetry
     of the direction set (important with respect to eddy-current resilience).

     Specific metrics can also be queried independently via the "-output"
     option, using these shorthands:
     U/B for unipolar/bipolar model,
     E/N for energy and nearest-neighbour respectively,
     t/-/+ for total/min/max respectively (mean implied otherwise);
     SHn for condition number of SH fit at order n (with n an even integer);
     ASYM for asymmetry index (norm of mean direction vector);
     N for the number of directions.

EXAMPLE USAGES

     Default_usage:
       $ dirstat directions.txt
     This provides a pretty-printed list of all metrics available.

     Write_a_single_metric_of_interest_to_standard_output:
       $ dirstat grad.b -shell 3000 -output SH8
     requests the condition number of SH fit of b=3000 shell directions at SH
     order 8

     Write_multiple_metrics_of_interest_to_standard_output:
       $ dirstat dwi.mif -output BN,BN-,BN+
     requests the mean, min and max nearest-neighour angles assuming a bipolar
     model.

OPTIONS

  -output list
     output selected metrics as a space-delimited list, suitable for use in
     scripts. This will produce one line of values per selected shell. Valid
     metrics are as specified in the description above.

DW shell selection options

  -shells b-values
     specify one or more b-values to use during processing, as a
     comma-separated list of the desired approximate b-values (b-values are
     clustered to allow for small deviations). Note that some commands are
     incompatible with multiple b-values, and will report an error if more than
     one b-value is provided.
     WARNING: note that, even though the b=0 volumes are never referred to as
     shells in the literature, they still have to be explicitly included in the
     list of b-values as provided to the -shell option! Several algorithms
     which include the b=0 volumes in their computations may otherwise return
     an undesired result.

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dirmerge

### Tool Description
Splice / merge multiple sets of directions in such a way as to maintain near-optimality upon truncation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        dirmerge                         Oct 21 2025

     dirmerge: part of the MRtrix3 package

SYNOPSIS

     Splice / merge multiple sets of directions in such a way as to maintain
     near-optimality upon truncation

USAGE

     dirmerge [ options ] subsets bvalue files [ bvalue files ... ] out

        subsets      the number of subsets (eg. phase encoding directions) per
                     b-value

        bvalue files  the b-value and sets of corresponding files, in order

        out          the output directions file, with each row listing the X Y
                     Z gradient directions, the b-value, and an index
                     representing the phase encode direction


OPTIONS

  -unipolar_weight value
     set the weight given to the unipolar electrostatic repulsion model
     compared to the bipolar model (default: 0.2).

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_amp2response

### Tool Description
Estimate response function coefficients based on the DWI signal in single-fibre voxels

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      amp2response                       Oct 21 2025

     amp2response: part of the MRtrix3 package

SYNOPSIS

     Estimate response function coefficients based on the DWI signal in
     single-fibre voxels

USAGE

     amp2response [ options ] amps mask directions response

        amps         the amplitudes image

        mask         the mask containing the voxels from which to estimate the
                     response function

        directions   a 4D image containing the estimated fibre directions

        response     the output zonal spherical harmonic coefficients


DESCRIPTION

     This command uses the image data from all selected single-fibre voxels
     concurrently, rather than simply averaging their individual spherical
     harmonic coefficients. It also ensures that the response function is
     non-negative, and monotonic (i.e. its amplitude must increase from the
     fibre direction out to the orthogonal plane).

     If multi-shell data are provided, and one or more b-value shells are not
     explicitly requested, the command will generate a response function for
     every b-value shell (including b=0 if present).

OPTIONS

  -isotropic
     estimate an isotropic response function (lmax=0 for all shells)

  -noconstraint
     disable the non-negativity and monotonicity constraints

  -directions path
     provide an external text file containing the directions along which the
     amplitudes are sampled

DW shell selection options

  -shells b-values
     specify one or more b-values to use during processing, as a
     comma-separated list of the desired approximate b-values (b-values are
     clustered to allow for small deviations). Note that some commands are
     incompatible with multiple b-values, and will report an error if more than
     one b-value is provided.
     WARNING: note that, even though the b=0 volumes are never referred to as
     shells in the literature, they still have to be explicitly included in the
     list of b-values as provided to the -shell option! Several algorithms
     which include the b=0 volumes in their computations may otherwise return
     an undesired result.

  -lmax values
     specify the maximum harmonic degree of the response function to estimate
     (can be a comma-separated list for multi-shell data)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and J-Donald Tournier
     (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Smith, R. E.; Dhollander, T. & Connelly, A. Constrained linear least
     squares estimation of anisotropic response function for spherical
     deconvolution. ISMRM Workshop on Breaking the Barriers of Diffusion MRI,
     23.

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_connectomeedit

### Tool Description
Perform basic operations on a connectome

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     connectomeedit                      Oct 21 2025

     connectomeedit: part of the MRtrix3 package

SYNOPSIS

     Perform basic operations on a connectome

USAGE

     connectomeedit [ options ] input operation output

        input        the input connectome.

        operation    the operation to apply, one of: to_symmetric,
                     upper_triangular, lower_triangular, transpose,
                     zero_diagonal.

        output       the output connectome.


Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Matteo Frigo (matteo.frigo@inria.fr)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixel2peaks

### Tool Description
Convert data in the fixel directory format into a 4D image of 3-vectors

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       fixel2peaks                       Oct 21 2025

     fixel2peaks: part of the MRtrix3 package

SYNOPSIS

     Convert data in the fixel directory format into a 4D image of 3-vectors

USAGE

     fixel2peaks [ options ] in out

        in           the input fixel information

        out          the output peaks image


DESCRIPTION

     If a fixel data file is provided as input, then the 3-vectors in the
     output image will be scaled based on the data in that file. If the input
     is instead the fixel directory, or the index or directions file, then all
     output 3-vectors will possess unit norm.

OPTIONS

  -number value
     maximum number of fixels in each voxel (default: based on input data)

  -nan
     fill excess peak data with NaNs rather than zeroes

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixel2sh

### Tool Description
Convert a fixel-based sparse-data image into an spherical harmonic image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        fixel2sh                         Oct 21 2025

     fixel2sh: part of the MRtrix3 package

SYNOPSIS

     Convert a fixel-based sparse-data image into an spherical harmonic image

USAGE

     fixel2sh [ options ] fixel_in sh_out

        fixel_in     the input fixel data file.

        sh_out       the output sh image.


DESCRIPTION

     This command generates spherical harmonic data from fixels that can be
     visualised using the ODF tool in MRview. The output ODF lobes are scaled
     according to the values in the input fixel image.

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link:
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

OPTIONS

  -lmax order
     set the maximum harmonic order for the output series (Default: 8)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) & David Raffelt
     (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixel2tsf

### Tool Description
Map fixel values to a track scalar file based on an input tractogram

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        fixel2tsf                        Oct 21 2025

     fixel2tsf: part of the MRtrix3 package

SYNOPSIS

     Map fixel values to a track scalar file based on an input tractogram

USAGE

     fixel2tsf [ options ] fixel_in tracks tsf

        fixel_in     the input fixel data file (within the fixel directory)

        tracks       the input track file

        tsf          the output track scalar file


DESCRIPTION

     This command is useful for visualising all brain fixels (e.g. the output
     from fixelcfestats) in 3D.

OPTIONS

  -angle value
     the max anglular threshold for computing correspondence between a fixel
     direction and track tangent (default = 45 degrees)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixel2voxel

### Tool Description
Convert a fixel-based sparse-data image into some form of scalar image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       fixel2voxel                       Oct 21 2025

     fixel2voxel: part of the MRtrix3 package

SYNOPSIS

     Convert a fixel-based sparse-data image into some form of scalar image

USAGE

     fixel2voxel [ options ] fixel_in operation image_out

        fixel_in     the input fixel data file

        operation    the operation to apply, one of: mean, sum, product, min,
                     max, absmax, magmax, count, complexity, sf, dec_unit,
                     dec_scaled, none.

        image_out    the output scalar image.


DESCRIPTION

     Fixel data can be reduced to voxel data in a number of ways:

     - Some statistic computed across all fixel values within a voxel: mean,
     sum, product, min, max, absmax, magmax

     - The number of fixels in each voxel: count

     - Some measure of crossing-fibre organisation: complexity, sf
     ('single-fibre')

     - A 4D directionally-encoded colour image: dec_unit, dec_scaled

     - A 4D image containing all fixel data values in each voxel unmodified:
     none

     The -weighted option deals with the case where there is some per-fixel
     metric of interest that you wish to collapse into a single scalar measure
     per voxel, but each fixel possesses a different volume, and you wish for
     those fixels with greater volume to have a greater influence on the
     calculation than fixels with lesser volume. For instance, when estimating
     a voxel-based measure of mean axon diameter from per-fixel mean axon
     diameters, a fixel's mean axon diameter should be weigthed by its relative
     volume within the voxel in the calculation of that voxel mean.

OPTIONS

  -number N
     use only the largest N fixels in calculation of the voxel-wise statistic;
     in the case of operation "none", output only the largest N fixels in each
     voxel.

  -fill value
     for "none" operation, specify the value to fill when number of fixels is
     fewer than the maximum (default: 0.0)

  -weighted fixel_in
     weight the contribution of each fixel to the per-voxel result according to
     its volume.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) & David Raffelt
     (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * Reference for 'complexity' operation:
     Riffert, T. W.; Schreiber, J.; Anwander, A. & Knosche, T. R. Beyond
     Fractional Anisotropy: Extraction of bundle-specific structural metrics
     from crossing fibre models. NeuroImage, 2014, 100, 176-191

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixelconnectivity

### Tool Description
Generate a fixel-fixel connectivity matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                    fixelconnectivity                    Oct 21 2025

     fixelconnectivity: part of the MRtrix3 package

SYNOPSIS

     Generate a fixel-fixel connectivity matrix

USAGE

     fixelconnectivity [ options ] fixel_directory tracks matrix

        fixel_directory  the directory containing the fixels between which
                     connectivity will be quantified

        tracks       the tracks used to determine fixel-fixel connectivity

        matrix       the output fixel-fixel connectivity matrix directory path


DESCRIPTION

     This command will generate a directory containing three images, which
     encodes the fixel-fixel connectivity matrix. Documentation regarding this
     format and how to use it will come in the future.

Options that influence generation of the connectivity matrix / matrices

  -threshold value
     a threshold to define the required fraction of shared connections to be
     included in the neighbourhood (default: 0.01)

  -angle value
     the max angle threshold for assigning streamline tangents to fixels
     (Default: 45 degrees)

  -mask file
     provide a fixel data file containing a mask of those fixels to be
     computed; fixels outside the mask will be empty in the output matrix

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixelconvert

### Tool Description
Convert between the old format fixel image (.msf / .msh) and the new fixel directory format

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      fixelconvert                       Oct 21 2025

     fixelconvert: part of the MRtrix3 package

SYNOPSIS

     Convert between the old format fixel image (.msf / .msh) and the new fixel
     directory format

USAGE

     fixelconvert [ options ] fixel_in fixel_out

        fixel_in     the input fixel file / directory.

        fixel_out    the output fixel file / directory.


EXAMPLE USAGES

     Convert_from_the_old_file_format_to_the_new_directory_format:
       $ fixelconvert old_fixels.msf new_fixels/ -out_size
     This performs a simple conversion from old to new format, and additionally
     writes the contents of the "size" field within old-format fixel images
     stored using the "FixelMetric" class (likely all of them) as an additional
     fixel data file.

     Convert_multiple_files_from_old_to_new_format,_preserving_fixel_
     correspondence:
       $ for_each *.msf : fixelconvert IN NAME_new/ -template template_fixels/
     In this example, the for_each script is used to execute the fixelconvert
     command once for each of a series of input files in the old fixel format,
     generating a new output fixel directory for each.Importantly here though,
     the -template option is used to ensure that the ordering of fixels within
     these output directories is identical, such that fixel data files can be
     exchanged between them (e.g. accumulating fixel data files across subjects
     into a single template fixel directory

     Convert_from_the_new_directory_format_to_the_old_file_format:
       $ fixelconvert new_fixels/ old_fixels.msf -value parameter.mif -in_size new_fixels/afd.mif
     Conversion from the new directory format will contain the value 1.0 for
     all output fixels in both the "size" and "value" fields of the
     "FixelMetric" class, unless the -in_size and/or -value options are used
     respectively to indicate which fixel data files should be used as the
     source(s) of this information.

Options for converting from old to new format

  -name string
     assign a different name to the value field output (Default: value). Do not
     include the file extension.

  -nii
     output the index, directions and data file in NIfTI format instead of .mif

  -out_size
     also output the 'size' field from the old format

  -template path
     specify an existing fixel directory (in the new format) to which the new
     output should conform

Options for converting from new to old format

  -value path
     nominate the data file to import to the 'value' field in the old format

  -in_size path
     import data for the 'size' field in the old format

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixelcorrespondence

### Tool Description
Obtain fixel-fixel correpondence between a subject fixel image and a template fixel mask

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                   fixelcorrespondence                   Oct 21 2025

     fixelcorrespondence: part of the MRtrix3 package

SYNOPSIS

     Obtain fixel-fixel correpondence between a subject fixel image and a
     template fixel mask

USAGE

     fixelcorrespondence [ options ] subject_data template_directory output_directory output_data

        subject_data  the input subject fixel data file. This should be a file
                     inside the fixel directory

        template_directory  the input template fixel directory.

        output_directory  the fixel directory where the output file will be
                     written.

        output_data  the name of the output fixel data file. This will be
                     placed in the output fixel directory


DESCRIPTION

     It is assumed that the subject image has already been spatially normalised
     and is aligned with the template. The output fixel image will have the
     same fixels (and directions) of the template.

OPTIONS

  -angle value
     the max angle threshold for computing inter-subject fixel correspondence
     (Default: 45 degrees)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixelcrop

### Tool Description
Crop/remove fixels from sparse fixel image using a binary fixel mask

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        fixelcrop                        Oct 21 2025

     fixelcrop: part of the MRtrix3 package

SYNOPSIS

     Crop/remove fixels from sparse fixel image using a binary fixel mask

USAGE

     fixelcrop [ options ] input_fixel_directory input_fixel_mask output_fixel_directory

        input_fixel_directory  input fixel directory, all data files and
                     directions file will be cropped and saved in the output
                     fixel directory

        input_fixel_mask  the input fixel data file defining which fixels to
                     crop. Fixels with zero values will be removed

        output_fixel_directory  the output directory to store the cropped
                     directions and data files


DESCRIPTION

     The mask must be input as a fixel data file the same dimensions as the
     fixel data file(s) to be cropped.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) & Rami Tabarra
     (rami.tabarra@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2response_tournier

### Tool Description
Use the Tournier et al. (2013) iterative algorithm for single-fibre voxel selection and response function estimation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                  dwi2response tournier

     dwi2response tournier: part of the MRtrix3 package

SYNOPSIS

     Use the Tournier et al. (2013) iterative algorithm for single-fibre voxel
     selection and response function estimation

USAGE

     dwi2response tournier [ options ] input output

        input        The input DWI

        output       The output response function text file

Options specific to the 'tournier' algorithm

  -number INT
     Number of single-fibre voxels to use when calculating response function

  -iter_voxels INT
     Number of single-fibre voxels to select when preparing for the next
     iteration (default = 10 x value given in -number)

  -dilate INT
     Number of mask dilation steps to apply when deriving voxel mask to test in
     the next iteration

  -max_iters INT
     Maximum number of iterations

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

General dwi2response options

  -mask MASK
     Provide an initial mask for response voxel selection

  -voxels VOXELS
     Output an image showing the final voxel selection(s)

  -shells SHELLS
     The b-value(s) to use in response function estimation (comma-separated list
     in case of multiple b-values, b=0 must be included explicitly)

  -lmax LMAX
     The maximum harmonic degree(s) for response function estimation (comma-
     separated list in case of multiple b-values)

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Calamante, F. & Connelly, A. Determination of the
     appropriate b-value and number of gradient directions for high-angular-
     resolution diffusion-weighted imaging. NMR Biomedicine, 2013, 26, 1775-1786

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2response_fa

### Tool Description
Use the old FA-threshold heuristic for single-fibre voxel selection and response function estimation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     dwi2response fa

     dwi2response fa: part of the MRtrix3 package

SYNOPSIS

     Use the old FA-threshold heuristic for single-fibre voxel selection and
     response function estimation

USAGE

     dwi2response fa [ options ] input output

        input        The input DWI

        output       The output response function text file

Options specific to the 'fa' algorithm

  -erode INT
     Number of brain mask erosion steps to apply prior to threshold (not used if
     mask is provided manually)

  -number INT
     The number of highest-FA voxels to use

  -threshold FLOAT
     Apply a hard FA threshold, rather than selecting the top voxels

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

General dwi2response options

  -mask MASK
     Provide an initial mask for response voxel selection

  -voxels VOXELS
     Output an image showing the final voxel selection(s)

  -shells SHELLS
     The b-value(s) to use in response function estimation (comma-separated list
     in case of multiple b-values, b=0 must be included explicitly)

  -lmax LMAX
     The maximum harmonic degree(s) for response function estimation (comma-
     separated list in case of multiple b-values)

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Calamante, F.; Gadian, D. G. & Connelly, A. Direct
     estimation of the fiber orientation density function from diffusion-
     weighted MRI data using spherical deconvolution. NeuroImage, 2004, 23,
     1176-1185

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2response_tax

### Tool Description
Use the Tax et al. (2014) recursive calibration algorithm for single-fibre voxel selection and response function estimation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                    dwi2response tax

     dwi2response tax: part of the MRtrix3 package

SYNOPSIS

     Use the Tax et al. (2014) recursive calibration algorithm for single-fibre
     voxel selection and response function estimation

USAGE

     dwi2response tax [ options ] input output

        input        The input DWI

        output       The output response function text file

Options specific to the 'tax' algorithm

  -peak_ratio FLOAT
     Second-to-first-peak amplitude ratio threshold

  -max_iters INT
     Maximum number of iterations

  -convergence FLOAT
     Percentile change in any RF coefficient required to continue iterating

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

General dwi2response options

  -mask MASK
     Provide an initial mask for response voxel selection

  -voxels VOXELS
     Output an image showing the final voxel selection(s)

  -shells SHELLS
     The b-value(s) to use in response function estimation (comma-separated list
     in case of multiple b-values, b=0 must be included explicitly)

  -lmax LMAX
     The maximum harmonic degree(s) for response function estimation (comma-
     separated list in case of multiple b-values)

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tax, C. M.; Jeurissen, B.; Vos, S. B.; Viergever, M. A. & Leemans, A.
     Recursive calibration of the fiber response function for spherical
     deconvolution of diffusion MRI data. NeuroImage, 2014, 86, 67-80

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2response_dhollander

### Tool Description
Unsupervised estimation of WM, GM and CSF response functions that does not require a T1 image (or segmentation thereof)

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                 dwi2response dhollander

     dwi2response dhollander: part of the MRtrix3 package

SYNOPSIS

     Unsupervised estimation of WM, GM and CSF response functions that does not
     require a T1 image (or segmentation thereof)

USAGE

     dwi2response dhollander [ options ] input out_sfwm out_gm out_csf

        input        Input DWI dataset

        out_sfwm     Output single-fibre WM response function text file

        out_gm       Output GM response function text file

        out_csf      Output CSF response function text file

DESCRIPTION

     This is an improved version of the Dhollander et al. (2016) algorithm for
     unsupervised estimation of WM, GM and CSF response functions, which
     includes the Dhollander et al. (2019) improvements for single-fibre WM
     response function estimation (prior to this update, the "dwi2response
     tournier" algorithm had been utilised specifically for the single-fibre WM
     response function estimation step).

Options for the 'dhollander' algorithm

  -erode INT
     Number of erosion passes to apply to initial (whole brain) mask. Set to 0
     to not erode the brain mask. (default: 3)

  -fa FLOAT
     FA threshold for crude WM versus GM-CSF separation. (default: 0.2)

  -sfwm FLOAT
     Final number of single-fibre WM voxels to select, as a percentage of
     refined WM. (default: 0.5 per cent)

  -gm FLOAT
     Final number of GM voxels to select, as a percentage of refined GM.
     (default: 2 per cent)

  -csf FLOAT
     Final number of CSF voxels to select, as a percentage of refined CSF.
     (default: 10 per cent)

  -wm_algo algorithm
     Use external dwi2response algorithm for WM single-fibre voxel selection
     (options: fa, tax, tournier) (default: built-in Dhollander 2019)

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

General dwi2response options

  -mask MASK
     Provide an initial mask for response voxel selection

  -voxels VOXELS
     Output an image showing the final voxel selection(s)

  -shells SHELLS
     The b-value(s) to use in response function estimation (comma-separated list
     in case of multiple b-values, b=0 must be included explicitly)

  -lmax LMAX
     The maximum harmonic degree(s) for response function estimation (comma-
     separated list in case of multiple b-values)

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Thijs Dhollander (thijs.dhollander@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Dhollander, T.; Raffelt, D. & Connelly, A. Unsupervised 3-tissue response
     function estimation from single-shell or multi-shell diffusion MR data
     without a co-registered T1 image. ISMRM Workshop on Breaking the Barriers
     of Diffusion MRI, 2016, 5

     * If -wm_algo option is not used:
     Dhollander, T.; Mito, R.; Raffelt, D. & Connelly, A. Improved white matter
     response function estimation for 3-tissue constrained spherical
     deconvolution. Proc Intl Soc Mag Reson Med, 2019, 555

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2response_manual

### Tool Description
Derive a response function using an input mask image alone (i.e. pre- selected voxels)

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                   dwi2response manual

     dwi2response manual: part of the MRtrix3 package

SYNOPSIS

     Derive a response function using an input mask image alone (i.e. pre-
     selected voxels)

USAGE

     dwi2response manual [ options ] input in_voxels output

        input        The input DWI

        in_voxels    Input voxel selection mask

        output       Output response function text file

Options specific to the 'manual' algorithm

  -dirs DIRS
     Manually provide the fibre direction in each voxel (a tensor fit will be
     used otherwise)

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

General dwi2response options

  -mask MASK
     Provide an initial mask for response voxel selection

  -voxels VOXELS
     Output an image showing the final voxel selection(s)

  -shells SHELLS
     The b-value(s) to use in response function estimation (comma-separated list
     in case of multiple b-values, b=0 must be included explicitly)

  -lmax LMAX
     The maximum harmonic degree(s) for response function estimation (comma-
     separated list in case of multiple b-values)

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwi2response_msmt_5tt

### Tool Description
Derive MSMT-CSD tissue response functions based on a co-registered five- tissue-type (5TT) image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                  dwi2response msmt_5tt

     dwi2response msmt_5tt: part of the MRtrix3 package

SYNOPSIS

     Derive MSMT-CSD tissue response functions based on a co-registered five-
     tissue-type (5TT) image

USAGE

     dwi2response msmt_5tt [ options ] input in_5tt out_wm out_gm out_csf

        input        The input DWI

        in_5tt       Input co-registered 5TT image

        out_wm       Output WM response text file

        out_gm       Output GM response text file

        out_csf      Output CSF response text file

Options specific to the 'msmt_5tt' algorithm

  -dirs DIRS
     Manually provide the fibre direction in each voxel (a tensor fit will be
     used otherwise)

  -fa FLOAT
     Upper fractional anisotropy threshold for GM and CSF voxel selection
     (default: 0.2)

  -pvf FLOAT
     Partial volume fraction threshold for tissue voxel selection (default:
     0.95)

  -wm_algo algorithm
     dwi2response algorithm to use for WM single-fibre voxel selection (options:
     fa, tax, tournier; default: tournier)

  -sfwm_fa_threshold FLOAT
     Sets -wm_algo to fa and allows to specify a hard FA threshold for single-
     fibre WM voxels, which is passed to the -threshold option of the fa
     algorithm (warning: overrides -wm_algo option)

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

General dwi2response options

  -mask MASK
     Provide an initial mask for response voxel selection

  -voxels VOXELS
     Output an image showing the final voxel selection(s)

  -shells SHELLS
     The b-value(s) to use in response function estimation (comma-separated list
     in case of multiple b-values, b=0 must be included explicitly)

  -lmax LMAX
     The maximum harmonic degree(s) for response function estimation (comma-
     separated list in case of multiple b-values)

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Jeurissen, B.; Tournier, J.-D.; Dhollander, T.; Connelly, A. & Sijbers, J.
     Multi-tissue constrained spherical deconvolution for improved analysis of
     multi-shell diffusion MRI data. NeuroImage, 2014, 103, 411-426

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwinormalise_group

### Tool Description
Performs a global DWI intensity normalisation on a group of subjects using the median b=0 white matter value as the reference

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                   dwinormalise group

     dwinormalise group: part of the MRtrix3 package

SYNOPSIS

     Performs a global DWI intensity normalisation on a group of subjects using
     the median b=0 white matter value as the reference

USAGE

     dwinormalise group [ options ] input_dir mask_dir output_dir fa_template
     wm_mask

        input_dir    The input directory containing all DWI images

        mask_dir     Input directory containing brain masks, corresponding to
                     one per input image (with the same file name prefix)

        output_dir   The output directory containing all of the intensity
                     normalised DWI images

        fa_template  The output population specific FA template, which is
                     threshold to estimate a white matter mask

        wm_mask      The output white matter mask (in template space), used to
                     estimate the median b=0 white matter value for
                     normalisation

DESCRIPTION

     The white matter mask is estimated from a population average FA template
     then warped back to each subject to perform the intensity normalisation.
     Note that bias field correction should be performed prior to this step.

     All input DWI files must contain an embedded diffusion gradient table; for
     this reason, these images must all be in either .mif or .mif.gz format.

OPTIONS

  -fa_threshold
     The threshold applied to the Fractional Anisotropy group template used to
     derive an approximate white matter mask (default: 0.4)

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwinormalise_individual

### Tool Description
Intensity normalise a DWI series based on the b=0 signal within a supplied mask

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                 dwinormalise individual

     dwinormalise individual: part of the MRtrix3 package

SYNOPSIS

     Intensity normalise a DWI series based on the b=0 signal within a supplied
     mask

USAGE

     dwinormalise individual [ options ] input_dwi input_mask output_dwi

        input_dwi    The input DWI series

        input_mask   The mask within which a reference b=0 intensity will be
                     sampled

        output_dwi   The output intensity-normalised DWI series

OPTIONS

  -intensity FLOAT
     Normalise the b=0 signal to a specified value (Default: 1000)

  -percentile INT
     Define the percentile of the b=0 image intensties within the mask used for
     normalisation; if this option is not supplied then the median value (50th
     percentile) will be normalised to the desired intensity value

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and David Raffelt
     (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_peaks2amp

### Tool Description
Extract amplitudes from a peak directions image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        peaks2amp                        Oct 21 2025

     peaks2amp: part of the MRtrix3 package

SYNOPSIS

     Extract amplitudes from a peak directions image

USAGE

     peaks2amp [ options ] directions amplitudes

        directions   the input directions image. Each volume corresponds to the
                     x, y & z component of each direction vector in turn.

        amplitudes   the output amplitudes image.


Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_peaks2fixel

### Tool Description
Convert peak directions image to a fixel directory

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       peaks2fixel                       Oct 21 2025

     peaks2fixel: part of the MRtrix3 package

SYNOPSIS

     Convert peak directions image to a fixel directory

USAGE

     peaks2fixel [ options ] directions fixels

        directions   the input directions image; each volume corresponds to the
                     x, y & z component of each direction vector in turn.

        fixels       the output fixel directory.


OPTIONS

  -dataname path
     the name of the output fixel data file encoding peak amplitudes

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_population_template

### Tool Description
Generates an unbiased group-average template from a series of images

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                   population_template

     population_template: part of the MRtrix3 package

SYNOPSIS

     Generates an unbiased group-average template from a series of images

USAGE

     population_template [ options ] input_dir template

        input_dir    Input directory containing all images used to build the
                     template

        template     Corresponding output template image. For multi-contrast
                     registration, provide multiple paired input_dir and
                     template arguments. Example: WM_dir WM_template.mif GM_dir
                     GM_template.mif

DESCRIPTION

     First a template is optimised with linear registration (rigid and/or
     affine, both by default), then non-linear registration is used to optimise
     the template further.

Input, output and general options

  -type
     Specify the types of registration stages to perform. Options are "rigid"
     (perform rigid registration only which might be useful for intra-subject
     registration in longitudinal analysis), "affine" (perform affine
     registration) and "nonlinear" as well as cominations of registration types:
     "rigid_affine", "rigid_nonlinear", "affine_nonlinear",
     "rigid_affine_nonlinear". Default: rigid_affine_nonlinear

  -voxel_size VOXEL_SIZE
     Define the template voxel size in mm. Use either a single value for
     isotropic voxels or 3 comma separated values.

  -initial_alignment
     Method of alignment to form the initial template. Options are "mass"
     (default), "robust_mass" (requires masks), "geometric" and "none".

  -mask_dir MASK_DIR
     Optionally input a set of masks inside a single directory, one per input
     image (with the same file name prefix). Using masks will speed up
     registration significantly. Note that masks are used for registration, not
     for aggregation. To exclude areas from aggregation, NaN-mask your input
     images.

  -warp_dir WARP_DIR
     Output a directory containing warps from each input to the template. If the
     folder does not exist it will be created

  -transformed_dir TRANSFORMED_DIR
     Output a directory containing the input images transformed to the template.
     If the folder does not exist it will be created. For multi-contrast
     registration, provide comma separated list of directories.

  -linear_transformations_dir LINEAR_TRANSFORMATIONS_DIR
     Output a directory containing the linear transformations used to generate
     the template. If the folder does not exist it will be created

  -template_mask TEMPLATE_MASK
     Output a template mask. Only works if -mask_dir has been input. The
     template mask is computed as the intersection of all subject masks in
     template space.

  -noreorientation
     Turn off FOD reorientation in mrregister. Reorientation is on by default if
     the number of volumes in the 4th dimension corresponds to the number of
     coefficients in an antipodally symmetric spherical harmonic series (i.e. 6,
     15, 28, 45, 66 etc)

  -leave_one_out LEAVE_ONE_OUT
     Register each input image to a template that does not contain that image.
     Valid choices: 0, 1, auto. (Default: auto (true if n_subjects larger than 2
     and smaller than 15))

  -aggregate AGGREGATE
     Measure used to aggregate information from transformed images to the
     template image. Valid choices: mean, median. Default: mean

  -aggregation_weights AGGREGATION_WEIGHTS
     Comma separated file containing weights used for weighted image
     aggregation. Each row must contain the identifiers of the input image and
     its weight. Note that this weighs intensity values not transformations
     (shape).

  -nanmask
     Optionally apply masks to (transformed) input images using NaN values to
     specify include areas for registration and aggregation. Only works if
     -mask_dir has been input.

  -copy_input
     Copy input images and masks into local scratch directory.

Options for the non-linear registration

  -nl_scale NL_SCALE
     Specify the multi-resolution pyramid used to build the non-linear template,
     in the form of a list of scale factors (default:
     0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0). This
     implicitly defines the number of template levels

  -nl_lmax NL_LMAX
     Specify the lmax used for non-linear registration for each scale factor, in
     the form of a list of integers (default: 2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4).
     The list must be the same length as the nl_scale factor list

  -nl_niter NL_NITER
     Specify the number of registration iterations used within each level before
     updating the template, in the form of a list of integers (default:
     5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5). The list must be the same length as the
     nl_scale factor list

  -nl_update_smooth
     Regularise the gradient update field with Gaussian smoothing (standard
     deviation in voxel units, Default 2.0 x voxel_size)

  -nl_disp_smooth
     Regularise the displacement field with Gaussian smoothing (standard
     deviation in voxel units, Default 1.0 x voxel_size)

  -nl_grad_step
     The gradient step size for non-linear registration (Default: 0.5)

Options for the linear registration

  -linear_no_pause
     Do not pause the script if a linear registration seems implausible

  -linear_estimator LINEAR_ESTIMATOR
     Specify estimator for intensity difference metric. Valid choices are: l1
     (least absolute: |x|), l2 (ordinary least squares), lp (least powers:
     |x|^1.2), Default: None (no robust estimator used)

  -rigid_scale RIGID_SCALE
     Specify the multi-resolution pyramid used to build the rigid template, in
     the form of a list of scale factors (default: 0.3,0.4,0.6,0.8,1.0,1.0).
     This and affine_scale implicitly  define the number of template levels

  -rigid_lmax RIGID_LMAX
     Specify the lmax used for rigid registration for each scale factor, in the
     form of a list of integers (default: 2,2,2,4,4,4). The list must be the
     same length as the linear_scale factor list

  -rigid_niter RIGID_NITER
     Specify the number of registration iterations used within each level before
     updating the template, in the form of a list of integers (default:50 for
     each scale). This must be a single number or a list of same length as the
     linear_scale factor list

  -affine_scale AFFINE_SCALE
     Specify the multi-resolution pyramid used to build the affine template, in
     the form of a list of scale factors (default: 0.3,0.4,0.6,0.8,1.0,1.0).
     This and rigid_scale implicitly define the number of template levels

  -affine_lmax AFFINE_LMAX
     Specify the lmax used for affine registration for each scale factor, in the
     form of a list of integers (default: 2,2,2,4,4,4). The list must be the
     same length as the linear_scale factor list

  -affine_niter AFFINE_NITER
     Specify the number of registration iterations used within each level before
     updating the template, in the form of a list of integers (default:500 for
     each scale). This must be a single number or a list of same length as the
     linear_scale factor list

Multi-contrast options

  -mc_weight_initial_alignment MC_WEIGHT_INITIAL_ALIGNMENT
     Weight contribution of each contrast to the initial alignment. Comma
     separated, default: 1.0

  -mc_weight_rigid MC_WEIGHT_RIGID
     Weight contribution of each contrast to the objective of rigid
     registration. Comma separated, default: 1.0

  -mc_weight_affine MC_WEIGHT_AFFINE
     Weight contribution of each contrast to the objective of affine
     registration. Comma separated, default: 1.0

  -mc_weight_nl MC_WEIGHT_NL
     Weight contribution of each contrast to the objective of nonlinear
     registration. Comma separated, default: 1.0

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) & Max Pietsch
     (maximilian.pietsch@kcl.ac.uk) & Thijs Dhollander
     (thijs.dhollander@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_responsemean

### Tool Description
Calculate the mean response function from a set of text files

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      responsemean

     responsemean: part of the MRtrix3 package

SYNOPSIS

     Calculate the mean response function from a set of text files

USAGE

     responsemean [ options ] inputs output

        inputs       The input response functions

        output       The output mean response function

DESCRIPTION

     Example usage: responsemean input_response1.txt input_response2.txt
     input_response3.txt ... output_average_response.txt

     All response function files provided must contain the same number of unique
     b-values (lines), as well as the same number of coefficients per line.

     As long as the number of unique b-values is identical across all input
     files, the coefficients will be averaged. This is performed on the
     assumption that the actual acquired b-values are identical. This is however
     impossible for the responsemean command to determine based on the data
     provided; it is therefore up to the user to ensure that this requirement is
     satisfied.

OPTIONS

  -legacy
     Use the legacy behaviour of former command 'average_response': average
     response function coefficients directly, without compensating for global
     magnitude differences between input files

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and David Raffelt
     (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_sh2amp

### Tool Description
Evaluate the amplitude of an image of spherical harmonic functions along specified directions

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         sh2amp                          Oct 21 2025

     sh2amp: part of the MRtrix3 package

SYNOPSIS

     Evaluate the amplitude of an image of spherical harmonic functions along
     specified directions

USAGE

     sh2amp [ options ] input directions output

        input        the input image consisting of spherical harmonic (SH)
                     coefficients.

        directions   the list of directions along which the SH functions will
                     be sampled, generated using the dirgen command

        output       the output image consisting of the amplitude of the SH
                     functions along the specified directions.


DESCRIPTION

     The input image should consist of a 4D or 5D image, with SH coefficients
     along the 4th dimension according to the convention below. If 4D (or size
     1 along the 5th dimension), the program expects to be provided with a
     single shell of directions. If 5D, each set of coefficients along the 5th
     dimension is understood to correspond to a different shell.

     The directions can be provided as:
     - a 2-column ASCII text file contained azimuth / elevation pairs (as
     produced by dirgen)
     - a 3-column ASCII text file containing x, y, z Cartesian direction
     vectors (as produced by dirgen -cart)
     - a 4-column ASCII text file containing the x, y, z, b components of a
     full DW encoding scheme (in MRtrix format, see main documentation for
     details).
     - an image file whose header contains a valid DW encoding scheme

     If a full DW encoding is provided, the number of shells needs to match
     those found in the input image of coefficients (i.e. its size along the
     5th dimension). If needed, the -shell option can be used to pick out the
     specific shell(s) of interest.

     If the input image contains multiple shells (its size along the 5th
     dimension is greater than one), the program will expect the direction set
     to contain multiple shells, which can only be provided as a full DW
     encodings (the last two options in the list above).

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link: 
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

OPTIONS

  -nonnegative
     cap all negative amplitudes to zero

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) and J-Donald Tournier
     (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_sh2peaks

### Tool Description
Extract the peaks of a spherical harmonic function in each voxel

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        sh2peaks                         Oct 21 2025

     sh2peaks: part of the MRtrix3 package

SYNOPSIS

     Extract the peaks of a spherical harmonic function in each voxel

USAGE

     sh2peaks [ options ] SH output

        SH           the input image of SH coefficients.

        output       the output image. Each volume corresponds to the x, y & z
                     component of each peak direction vector in turn.


DESCRIPTION

     Peaks of the spherical harmonic function in each voxel are located by
     commencing a Newton search along each of a set of pre-specified directions

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link: 
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

OPTIONS

  -num peaks
     the number of peaks to extract (default: 3).

  -direction phi theta  (multiple uses permitted)
     the direction of a peak to estimate. The algorithm will attempt to find
     the same number of peaks as have been specified using this option.

  -peaks image
     the program will try to find the peaks that most closely match those in
     the image provided.

  -threshold value
     only peak amplitudes greater than the threshold will be considered.

  -seeds file
     specify a set of directions from which to start the multiple restarts of
     the optimisation (by default, the built-in 60 direction set is used)

  -mask image
     only perform computation within the specified binary brain mask image.

  -fast
     use lookup table to compute associated Legendre polynomials (faster, but
     approximate).

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Jeurissen, B.; Leemans, A.; Tournier, J.-D.; Jones, D.K.; Sijbers, J.
     Investigating the prevalence of complex fiber configurations in white
     matter tissue with diffusion magnetic resonance imaging. Human Brain
     Mapping, 2013, 34(11), 2747-2766

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_sh2power

### Tool Description
Compute the total power of a spherical harmonics image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        sh2power                         Oct 21 2025

     sh2power: part of the MRtrix3 package

SYNOPSIS

     Compute the total power of a spherical harmonics image

USAGE

     sh2power [ options ] SH power

        SH           the input spherical harmonics coefficients image.

        power        the output power image.


DESCRIPTION

     This command computes the sum of squared SH coefficients, which equals the
     mean-squared amplitude of the spherical function it represents.

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link: 
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

OPTIONS

  -spectrum
     output the power spectrum, i.e., the power contained within each harmonic
     degree (l=0, 2, 4, ...) as a 4-D image.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_sh2response

### Tool Description
Generate an appropriate response function from the image data for spherical deconvolution

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       sh2response                       Oct 21 2025

     sh2response: part of the MRtrix3 package

SYNOPSIS

     Generate an appropriate response function from the image data for
     spherical deconvolution

USAGE

     sh2response [ options ] SH mask directions response

        SH           the spherical harmonic decomposition of the
                     diffusion-weighted images

        mask         the mask containing the voxels from which to estimate the
                     response function

        directions   a 4D image containing the direction vectors along which to
                     estimate the response function

        response     the output axially-symmetric spherical harmonic
                     coefficients


DESCRIPTION

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link: 
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

OPTIONS

  -lmax value
     specify the maximum harmonic degree of the response function to estimate

  -dump file
     dump the m=0 SH coefficients from all voxels in the mask to the output
     file, rather than their mean

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_shbasis

### Tool Description
Examine the values in spherical harmonic images to estimate (and optionally change) the SH basis used

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         shbasis                         Oct 21 2025

     shbasis: part of the MRtrix3 package

SYNOPSIS

     Examine the values in spherical harmonic images to estimate (and
     optionally change) the SH basis used

USAGE

     shbasis [ options ] SH [ SH ... ]

        SH           the input image(s) of SH coefficients.


DESCRIPTION

     In previous versions of MRtrix, the convention used for storing spherical
     harmonic coefficients was a non-orthonormal basis (the m!=0 coefficients
     were a factor of sqrt(2) too large). This error has been rectified in
     newer versions of MRtrix, but will cause issues if processing SH data that
     was generated using an older version of MRtrix (or vice-versa).

     This command provides a mechanism for testing the basis used in storage of
     image data representing a spherical harmonic series per voxel, and allows
     the user to forcibly modify the raw image data to conform to the desired
     basis.

     Note that the "force_*" conversion choices should only be used in cases
     where this command has previously been unable to automatically determine
     the SH basis from the image data, but the user themselves are confident of
     the SH basis of the data.

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link: 
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

OPTIONS

  -convert mode
     convert the image data in-place to the desired basis; options are:
     old,new,force_oldtonew,force_newtoold.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_shconv

### Tool Description
Perform spherical convolution

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         shconv                          Oct 21 2025

     shconv: part of the MRtrix3 package

SYNOPSIS

     Perform spherical convolution

USAGE

     shconv [ options ] odf response [ odf response ... ] SH_out

        odf response  pairs of input ODF image and corresponding responses

        SH_out       the output spherical harmonics coefficients image.


DESCRIPTION

     Provided with matching pairs of response function and ODF images
     (containing SH coefficients), perform spherical convolution to provide the
     corresponding SH coefficients of the signal.

     If multiple pairs of inputs are provided, their contributions will be
     summed into a single output.

     If the responses are multi-shell (with one line of coefficients per
     shell), the output will be a 5-dimensional image, with the SH coefficients
     of the signal in each shell stored at different indices along the 5th
     dimension.

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link: 
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

     The spherical harmonic coefficients are stored according the conventions
     described the main documentation, which can be found at the following
     link: 
     https://mrtrix.readthedocs.io/en/3.0.8/concepts/spherical_harmonics.html

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) and J-Donald Tournier
     (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tck2connectome

### Tool Description
Generate a connectome matrix from a streamlines file and a node parcellation image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     tck2connectome                      Oct 21 2025

     tck2connectome: part of the MRtrix3 package

SYNOPSIS

     Generate a connectome matrix from a streamlines file and a node
     parcellation image

USAGE

     tck2connectome [ options ] tracks_in nodes_in connectome_out

        tracks_in    the input track file

        nodes_in     the input node parcellation image

        connectome_out  the output .csv file containing edge weights


DESCRIPTION

     The default mechanism by which streamlines are ascribed to connectome
     parcels is the "radial search" algorithm as described in reference (Smith
     et al., 2015), with a default maximal search distance of 4mm. For each
     streamline endpoint, if there is no voxel with a non-zero parcel index
     whose centre is closer to the streamline endpoint than the maximal search
     distance, then that streamline endpoint will not be assigned to any
     parcel, and the streamline will be omitted from the connectome matrix
     (unless the -keep_unassigned option is specified). The maximal search
     distance can be modified using the -assignment_radial_search option, or an
     alternative algorithm can be activated using one of the other
     -assignment_* options.

EXAMPLE USAGES

     Default usage:
       $ tck2connectome tracks.tck nodes.mif connectome.csv -tck_weights_in weights.csv -out_assignments assignments.txt
     By default, the metric of connectivity quantified in the connectome matrix
     is the number of streamlines; or, if tcksift2 is used, the sum of
     streamline weights via the -tck_weights_in option. Use of the
     -out_assignments option is recommended as this enables subsequent use of
     the connectome2tck command.

     Generate a matrix consisting of the mean streamline length between each
     node pair:
       $ tck2connectome tracks.tck nodes.mif distances.csv -scale_length -stat_edge mean
     By multiplying the contribution of each streamline to the connectome by
     the length of that streamline, and then, for each edge, computing the mean
     value across the contributing streamlines, one obtains a matrix where the
     value in each entry is the mean length across those streamlines belonging
     to that edge.

     Generate a connectome matrix where the value of connectivity is the "mean
     FA":
       $ tcksample tracks.tck FA.mif mean_FA_per_streamline.csv -stat_tck mean; tck2connectome tracks.tck nodes.mif mean_FA_connectome.csv -scale_file mean_FA_per_streamline.csv -stat_edge mean
     Here, a connectome matrix that is "weighted by FA" is generated in
     multiple steps: firstly, for each streamline, the value of the underlying
     FA image is sampled at each vertex, and the mean of these values is
     calculated to produce a single scalar value of "mean FA" per streamline;
     then, as each streamline is assigned to nodes within the connectome, the
     magnitude of the contribution of that streamline to the matrix is
     multiplied by the mean FA value calculated prior for that streamline;
     finally, for each connectome edge, across the values of "mean FA" that
     were contributed by all of the streamlines assigned to that particular
     edge, the mean value is calculated.

     Generate the connectivity fingerprint for streamlines seeded from a
     particular region:
       $ tck2connectome fixed_seed_tracks.tck nodes.mif fingerprint.csv -vector
     This usage assumes that the streamlines being provided to the command have
     all been seeded from the (effectively) same location, and as such, only
     the endpoint of each streamline (not their starting point) is assigned
     based on the provided parcellation image. Accordingly, the output file
     contains only a vector of connectivity values rather than a matrix, since
     each streamline is assigned to only one node rather than two.

Structural connectome streamline assignment option

  -assignment_end_voxels
     use a simple voxel lookup value at each streamline endpoint

  -assignment_radial_search radius
     perform a radial search from each streamline endpoint to locate the
     nearest node. Argument is the maximum radius in mm; if no node is found
     within this radius, the streamline endpoint is not assigned to any node.
     Default search distance is 4mm.

  -assignment_reverse_search max_dist
     traverse from each streamline endpoint inwards along the streamline, in
     search of the last node traversed by the streamline. Argument is the
     maximum traversal length in mm (set to 0 to allow search to continue to
     the streamline midpoint).

  -assignment_forward_search max_dist
     project the streamline forwards from the endpoint in search of a
     parcellation node voxel. Argument is the maximum traversal length in mm.

  -assignment_all_voxels
     assign the streamline to all nodes it intersects along its length (note
     that this means a streamline may be assigned to more than two nodes, or
     indeed none at all)

Structural connectome metric options

  -scale_length
     scale each contribution to the connectome edge by the length of the
     streamline

  -scale_invlength
     scale each contribution to the connectome edge by the inverse of the
     streamline length

  -scale_invnodevol
     scale each contribution to the connectome edge by the inverse of the two
     node volumes

  -scale_file path
     scale each contribution to the connectome edge according to the values in
     a vector file

Options for outputting connectome matrices

  -symmetric
     Make matrices symmetric on output

  -zero_diagonal
     Set matrix diagonal to zero on output

Other options for tck2connectome

  -stat_edge statistic
     statistic for combining the values from all streamlines in an edge into a
     single scale value for that edge (options are: sum,mean,min,max;
     default=sum)

  -tck_weights_in path
     specify a text scalar file containing the streamline weights

  -keep_unassigned
     By default, the program discards the information regarding those
     streamlines that are not successfully assigned to a node pair. Set this
     option to keep these values (will be the first row/column in the output
     matrix)

  -out_assignments path
     output the node assignments of each streamline to a file; this can be used
     subsequently e.g. by the command connectome2tck

  -vector
     output a vector representing connectivities from a given seed point to
     target nodes, rather than a matrix of node-node connectivities

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     If using the default "radial search" streamline-parcel assignment
     mechanism: Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. The
     effects of SIFT on the reproducibility and biological accuracy of the
     structural connectome. NeuroImage, 2015, 104, 253-265

     If using -scale_invlength or -scale_invnodevol options: Hagmann, P.;
     Cammoun, L.; Gigandet, X.; Meuli, R.; Honey, C.; Wedeen, V. & Sporns, O.
     Mapping the Structural Core of Human Cerebral Cortex. PLoS Biology 6(7),
     e159

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tck2fixel

### Tool Description
Compute a fixel TDI map from a tractogram

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        tck2fixel                        Oct 21 2025

     tck2fixel: part of the MRtrix3 package

SYNOPSIS

     Compute a fixel TDI map from a tractogram

USAGE

     tck2fixel [ options ] tracks fixel_folder_in fixel_folder_out fixel_data_out

        tracks       the input tracks.

        fixel_folder_in  the input fixel folder. Used to define the fixels and
                     their directions

        fixel_folder_out  the fixel folder to which the output will be written.
                     This can be the same as the input folder if desired

        fixel_data_out  the name of the fixel data image.


OPTIONS

  -angle value
     the max angle threshold for assigning streamline tangents to fixels
     (Default: 45 degrees)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckconvert

### Tool Description
Convert between different track file formats

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       tckconvert                        Oct 21 2025

     tckconvert: part of the MRtrix3 package

SYNOPSIS

     Convert between different track file formats

USAGE

     tckconvert [ options ] input output

        input        the input track file.

        output       the output track file.


DESCRIPTION

     The program currently supports MRtrix .tck files (input/output), ascii
     text files (input/output), VTK polydata files (input/output), and
     RenderMan RIB (export only).

     Note that ascii files will be stored with one streamline per numbered
     file. To support this, the command will use the multi-file numbering
     syntax, where square brackets denote the position of the numbering for the
     files, for example:

     $ tckconvert input.tck output-'[]'.txt

     will produce files named output-0000.txt, output-0001.txt,
     output-0002.txt, ...

OPTIONS

  -scanner2voxel reference
     if specified, the properties of this image will be used to convert track
     point positions from real (scanner) coordinates into voxel coordinates.

  -scanner2image reference
     if specified, the properties of this image will be used to convert track
     point positions from real (scanner) coordinates into image coordinates (in
     mm).

  -voxel2scanner reference
     if specified, the properties of this image will be used to convert track
     point positions from voxel coordinates into real (scanner) coordinates.

  -image2scanner reference
     if specified, the properties of this image will be used to convert track
     point positions from image coordinates (in mm) into real (scanner)
     coordinates.

Options specific to PLY writer

  -sides sides
     number of sides for streamlines

  -increment increment
     generate streamline points at every (increment) points

Options specific to RIB writer

  -dec
     add DEC as a primvar

Options for both PLY and RIB writer

  -radius radius
     radius of the streamlines

Options specific to VTK writer

  -ascii
     write an ASCII VTK file (this is the default)

  -binary
     write a binary VTK file

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Daan Christiaens (daan.christiaens@kcl.ac.uk), J-Donald Tournier
     (jdtournier@gmail.com), Philip Broser (philip.broser@me.com), Daniel
     Blezek (daniel.blezek@gmail.com).

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckdfc

### Tool Description
Perform the Track-Weighted Dynamic Functional Connectivity (TW-dFC) method

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tckdfc                          Oct 21 2025

     tckdfc: part of the MRtrix3 package

SYNOPSIS

     Perform the Track-Weighted Dynamic Functional Connectivity (TW-dFC) method

USAGE

     tckdfc [ options ] tracks fmri output

        tracks       the input track file.

        fmri         the pre-processed fMRI time series

        output       the output TW-dFC image


DESCRIPTION

     This command generates a Track-Weighted Image (TWI), where the
     contribution from each streamline to the image is the Pearson correlation
     between the fMRI time series at the streamline endpoints.

     The output image can be generated in one of two ways (note that one of
     these two command-line options MUST be provided): 

     - "Static" functional connectivity (-static option): Each streamline
     contributes to a static 3D output image based on the correlation between
     the signals at the streamline endpoints using the entirety of the input
     time series.

     - "Dynamic" functional connectivity (-dynamic option): The output image is
     a 4D image, with the same number of volumes as the input fMRI time series.
     For each volume, the contribution from each streamline is calculated based
     on a finite-width sliding time window, centred at the timepoint
     corresponding to that volume.

     Note that the -backtrack option in this command is similar, but not
     precisely equivalent, to back-tracking as can be used with
     Anatomically-Constrained Tractography (ACT) in the tckgen command.
     However, here the feature does not change the streamlines trajectories in
     any way; it simply enables detection of the fact that the input fMRI image
     may not contain a valid timeseries underneath the streamline endpoint, and
     where this occurs, searches from the streamline endpoint inwards along the
     streamline trajectory in search of a valid timeseries to sample from the
     input image.

Options for toggling between static and dynamic TW-dFC methods; note that one of these options MUST be provided

  -static
     generate a "static" (3D) output image.

  -dynamic shape width
     generate a "dynamic" (4D) output image; must additionally provide the
     shape and width (in volumes) of the sliding window.

Options for setting the properties of the output image

  -template image
     an image file to be used as a template for the output (the output image
     will have the same transform and field of view).

  -vox size
     provide either an isotropic voxel size (in mm), or comma-separated list of
     3 voxel dimensions.

  -stat_vox type
     define the statistic for choosing the final voxel intensities for a given
     contrast type given the individual values from the tracks passing through
     each voxel
     Options are: sum, min, mean, max (default: mean)

Other options for affecting the streamline sampling & mapping behaviour

  -backtrack
     if no valid timeseries is found at the streamline endpoint, back-track
     along the streamline trajectory until a valid timeseries is found

  -upsample factor
     upsample the tracks by some ratio using Hermite interpolation before
     mapping (if omitted, an appropriate ratio will be determined
     automatically)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Calamante, F.; Smith, R.E.; Liang, X.; Zalesky, A.; Connelly, A
     Track-weighted dynamic functional connectivity (TW-dFC): a new method to
     study time-resolved functional connectivity. Brain Struct Funct, 2017,
     doi: 10.1007/s00429-017-1431-1

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckedit

### Tool Description
Perform various editing operations on track files

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tckedit                         Oct 21 2025

     tckedit: part of the MRtrix3 package

SYNOPSIS

     Perform various editing operations on track files

USAGE

     tckedit [ options ] tracks_in [ tracks_in ... ] tracks_out

        tracks_in    the input track file(s)

        tracks_out   the output track file


DESCRIPTION

     This command can be used to perform various types of manipulations on
     track data. A range of such manipulations are demonstrated in the examples
     provided below.

EXAMPLE USAGES

     Concatenate data from multiple track files into one:
       $ tckedit *.tck all_tracks.tck
     Here the wildcard operator is used to select all files in the current
     working directory that have the .tck filetype suffix; but input files can
     equivalently be specified one at a time explicitly.

     Extract a reduced number of streamlines:
       $ tckedit in_many.tck out_few.tck -number 1k -skip 500
     The number of streamlines requested would typically be less than the
     number of streamlines in the input track file(s); if it is instead
     greater, then the command will issue a warning upon completion. By default
     the streamlines for the output file are extracted from the start of the
     input file(s); in this example the command is instead instructed to skip
     the first 500 streamlines, and write to the output file streamlines
     501-1500.

     Extract streamlines based on selection criteria:
       $ tckedit in.tck out.tck -include ROI1.mif -include ROI2.mif -minlength 25
     Multiple criteria can be added in a single invocation of tckedit, and a
     streamline must satisfy all criteria imposed in order to be written to the
     output file. Note that both -include and -exclude options can be specified
     multiple times to provide multiple waypoints / exclusion masks.

     Select only those streamline vertices within a mask:
       $ tckedit in.tck cropped.tck -mask mask.mif
     The -mask option is applied to each streamline vertex independently,
     rather than to each streamline, retaining only those streamline vertices
     within the mask. As such, use of this option may result in a greater
     number of output streamlines than input streamlines, as a single input
     streamline may have the vertices at either endpoint retained but some
     vertices at its midpoint removed, effectively cutting one long streamline
     into multiple shorter streamlines.

Region Of Interest processing options

  -include spec  (multiple uses permitted)
     specify an inclusion region of interest, as either a binary mask image, or
     as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines
     must traverse ALL inclusion regions to be accepted.

  -include_ordered image  (multiple uses permitted)
     specify an inclusion region of interest, as either a binary mask image, or
     as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines
     must traverse ALL inclusion_ordered regions in the order they are
     specified in order to be accepted.

  -exclude spec  (multiple uses permitted)
     specify an exclusion region of interest, as either a binary mask image, or
     as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines
     that enter ANY exclude region will be discarded.

  -mask spec  (multiple uses permitted)
     specify a masking region of interest, as either a binary mask image, or as
     a sphere using 4 comma-separared values (x,y,z,radius). If defined,
     streamlines exiting the mask will be truncated.

Streamline length threshold options

  -maxlength value
     set the maximum length of any streamline in mm

  -minlength value
     set the minimum length of any streamline in mm

Streamline count truncation options

  -number count
     set the desired number of selected streamlines to be propagated to the
     output file

  -skip count
     omit this number of selected streamlines before commencing writing to the
     output file

Thresholds pertaining to per-streamline weighting

  -maxweight value
     set the maximum weight of any streamline

  -minweight value
     set the minimum weight of any streamline

Other options specific to tckedit

  -inverse
     output the inverse selection of streamlines based on the criteria
     provided; i.e. only those streamlines that fail at least one selection
     criterion, and/or vertices that are outside masks if provided, will be
     written to file

  -ends_only
     only test the ends of each streamline against the provided include/exclude
     ROIs

Options for handling streamline weights

  -tck_weights_in path
     specify a text scalar file containing the streamline weights

  -tck_weights_out path
     specify the path for an output text scalar file containing streamline
     weights

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckgen

### Tool Description
Perform streamlines tractography

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tckgen                          Oct 21 2025

     tckgen: part of the MRtrix3 package

SYNOPSIS

     Perform streamlines tractography

USAGE

     tckgen [ options ] source tracks

        source       The image containing the source data. The type of image
                     data required depends on the algorithm used (see
                     Description section).

        tracks       the output file containing the tracks generated.


DESCRIPTION

     By default, tckgen produces a fixed number of streamlines, by attempting
     to seed from new random locations until the target number of streamlines
     have been selected (in other words, after all inclusion & exclusion
     criteria have been applied), or the maximum number of seeds has been
     exceeded (by default, this is 1000 x the desired number of selected
     streamlines). Use the -select and/or -seeds options to modify as required.
     See also the Seeding options section for alternative seeding strategies.

     Below is a list of available tracking algorithms, the input image data
     that they require, and a brief description of their behaviour:

     - FACT: Fiber Assigned by Continuous Tracking. A deterministic algorithm
     that takes as input a 4D image, with 3xN volumes, where N is the maximum
     number of fiber orientations in a voxel. Each triplet of volumes
     represents a 3D vector corresponding to a fiber orientation; the length of
     the vector additionally indicates some measure of density or anisotropy.
     As streamlines move from one voxel to another, the fiber orientation most
     collinear with the streamline orientation is selected (i.e. there is no
     intra-voxel interpolation).

     - iFOD1: First-order Integration over Fiber Orientation Distributions. A
     probabilistic algorithm that takes as input a Fiber Orientation
     Distribution (FOD) image represented in the Spherical Harmonic (SH) basis.
     At each streamline step, random samples from the local (trilinear
     interpolated) FOD are taken. A streamline is more probable to follow
     orientations where the FOD amplitude is large; but it may also rarely
     traverse orientations with small FOD amplitude.

     - iFOD2 (default): Second-order Integration over Fiber Orientation
     Distributions. A probabilistic algorithm that takes as input a Fiber
     Orientation Distribution (FOD) image represented in the Spherical Harmonic
     (SH) basis. Candidate streamline paths (based on short curved "arcs") are
     drawn, and the underlying (trilinear-interpolated) FOD amplitudes along
     those arcs are sampled. A streamline is more probable to follow a path
     where the FOD amplitudes along that path are large; but it may also rarely
     traverse orientations where the FOD amplitudes are small, as long as the
     amplitude remains above the FOD amplitude threshold along the entire path.

     - NullDist1 / NullDist2: Null Distribution tracking algorithms. These
     probabilistic algorithms expect as input the same image that was used when
     invoking the corresponding algorithm for which the null distribution is
     sought. These algorithms generate streamlines based on random orientation
     samples; that is, no image information relating to fiber orientations is
     used, and streamlines trajectories are determined entirely from random
     sampling. The NullDist2 algorithm is designed to be used in conjunction
     with iFOD2; NullDist1 should be used in conjunction with any first-order
     algorithm.

     - SD_STREAM: Streamlines tractography based on Spherical Deconvolution
     (SD). A deterministic algorithm that takes as input a Fiber Orientation
     Distribution (FOD) image represented in the Spherical Harmonic (SH) basis.
     At each streamline step, the local (trilinear-interpolated) FOD is
     sampled, and from the current streamline tangent orientation, a Newton
     optimisation on the sphere is performed in order to locate the orientation
     of the nearest FOD amplitude peak.

     - SeedTest: A dummy streamlines algorithm used for testing streamline
     seeding mechanisms. Any image can be used as input; the image will not be
     used in any way. For each seed point generated by the seeding
     mechanism(s), a streamline containing a single point corresponding to that
     seed location will be written to the output track file.

     - Tensor_Det: A deterministic algorithm that takes as input a 4D
     diffusion-weighted image (DWI) series. At each streamline step, the
     diffusion tensor is fitted to the local (trilinear-interpolated) diffusion
     data, and the streamline trajectory is determined as the principal
     eigenvector of that tensor.

     - Tensor_Prob: A probabilistic algorithm that takes as input a 4D
     diffusion-weighted image (DWI) series. Within each image voxel, a residual
     bootstrap is performed to obtain a unique realisation of the DWI data in
     that voxel for each streamline. These data are then sampled via trilinear
     interpolation at each streamline step, the diffusion tensor model is
     fitted, and the streamline follows the orientation of the principal
     eigenvector of that tensor.

     Note that the behaviour of the -angle option varies slightly depending on
     the order of integration: for any first-order method, this angle
     corresponds to the deviation in streamline trajectory per step; for
     higher-order methods, this corresponds to the change in underlying fibre
     orientation between the start and end points of each step.

OPTIONS

  -algorithm name
     specify the tractography algorithm to use. Valid choices are: FACT, iFOD1,
     iFOD2, Nulldist1, Nulldist2, SD_Stream, Seedtest, Tensor_Det, Tensor_Prob
     (default: iFOD2).

Streamlines tractography options

  -select number
     set the desired number of streamlines to be selected by tckgen, after all
     selection criteria have been applied (i.e. inclusion/exclusion ROIs,
     min/max length, etc). tckgen will keep seeding streamlines until this
     number of streamlines have been selected, or the maximum allowed number of
     seeds has been exceeded (see -seeds option). By default, 5000 streamlines
     are to be selected. Set to zero to disable, which will result in
     streamlines being seeded until the number specified by -seeds has been
     reached.

  -step size
     set the step size of the algorithm in mm (defaults: for first-order
     algorithms, 0.1 x voxelsize; if using RK4, 0.25 x voxelsize; for iFOD2:
     0.5 x voxelsize).

  -angle theta
     set the maximum angle in degrees between successive steps (defaults: 60
     for deterministic algorithms; 15 for iFOD1 / nulldist1; 45 for iFOD2 /
     nulldist2)

  -minlength value
     set the minimum length of any track in mm (defaults: without ACT, 5 x
     voxelsize; with ACT, 2 x voxelsize).

  -maxlength value
     set the maximum length of any track in mm (default: 100 x voxelsize).

  -cutoff value
     set the FOD amplitude / fixel size / tensor FA cutoff for terminating
     tracks (defaults: 0.1 for FOD-based algorithms; 0.1 for fixel-based
     algorithms; 0.1 for tensor-based algorithms; threshold multiplied by 0.5
     when using ACT).

  -trials number
     set the maximum number of sampling trials at each point (only used for
     iFOD1 / iFOD2) (default: 1000).

  -noprecomputed
     do NOT pre-compute legendre polynomial values. Warning: this will slow
     down the algorithm by a factor of approximately 4.

  -rk4
     use 4th-order Runge-Kutta integration (slower, but eliminates curvature
     overshoot in 1st-order deterministic methods)

  -stop
     stop propagating a streamline once it has traversed all include regions

  -downsample factor
     downsample the generated streamlines to reduce output file size (default
     is (samples-1) for iFOD2, no downsampling for all other algorithms)

Tractography seeding mechanisms; at least one must be provided

  -seed_image image  (multiple uses permitted)
     seed streamlines entirely at random within a mask image 

  -seed_sphere spec  (multiple uses permitted)
     spherical seed as four comma-separated values (XYZ position and radius)

  -seed_random_per_voxel image num_per_voxel  (multiple uses permitted)
     seed a fixed number of streamlines per voxel in a mask image; random
     placement of seeds in each voxel

  -seed_grid_per_voxel image grid_size  (multiple uses permitted)
     seed a fixed number of streamlines per voxel in a mask image; place seeds
     on a 3D mesh grid (grid_size argument is per axis; so a grid_size of 3
     results in 27 seeds per voxel)

  -seed_rejection image  (multiple uses permitted)
     seed from an image using rejection sampling (higher values = more probable
     to seed from)

  -seed_gmwmi image  (multiple uses permitted)
     seed from the grey matter - white matter interface (only valid if using
     ACT framework). Input image should be a 3D seeding volume; seeds drawn
     within this image will be optimised to the interface using the 5TT image
     provided using the -act option.

  -seed_dynamic fod_image
     determine seed points dynamically using the SIFT model (must not provide
     any other seeding mechanism). Note that while this seeding mechanism
     improves the distribution of reconstructed streamlines density, it should
     NOT be used as a substitute for the SIFT method itself.

Tractography seeding options and parameters

  -seeds number
     set the number of seeds that tckgen will attempt to track from. If this
     option is NOT provided, the default number of seeds is set to 1000× the
     number of selected streamlines. If -select is NOT also specified, tckgen
     will continue tracking until this number of seeds has been attempted.
     However, if -select is also specified, tckgen will stop when the number of
     seeds attempted reaches the number specified here, OR when the number of
     streamlines selected reaches the number requested with the -select option.
     This can be used to prevent the program from running indefinitely when no
     or very few streamlines can be found that match the selection criteria.
     Setting this to zero will cause tckgen to keep attempting seeds until the
     number specified by -select has been reached.

  -max_attempts_per_seed number
     set the maximum number of times that the tracking algorithm should attempt
     to find an appropriate tracking direction from a given seed point. This
     should be set high enough to ensure that an actual plausible seed point is
     not discarded prematurely as being unable to initiate tracking from.
     Higher settings may affect performance if many seeds are genuinely
     impossible to track from, as many attempts will still be made in vain for
     such seeds. (default: 1000)

  -seed_cutoff value
     set the minimum FA or FOD amplitude for seeding tracks (default is the
     same as the normal -cutoff).

  -seed_unidirectional
     track from the seed point in one direction only (default is to track in
     both directions).

  -seed_direction dir
     specify a seeding direction for the tracking (this should be supplied as a
     vector of 3 comma-separated values.

  -output_seeds path
     output the seed location of all successful streamlines to a file

Region Of Interest processing options

  -include spec  (multiple uses permitted)
     specify an inclusion region of interest, as either a binary mask image, or
     as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines
     must traverse ALL inclusion regions to be accepted.

  -include_ordered image  (multiple uses permitted)
     specify an inclusion region of interest, as either a binary mask image, or
     as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines
     must traverse ALL inclusion_ordered regions in the order they are
     specified in order to be accepted.

  -exclude spec  (multiple uses permitted)
     specify an exclusion region of interest, as either a binary mask image, or
     as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines
     that enter ANY exclude region will be discarded.

  -mask spec  (multiple uses permitted)
     specify a masking region of interest, as either a binary mask image, or as
     a sphere using 4 comma-separared values (x,y,z,radius). If defined,
     streamlines exiting the mask will be truncated.

Anatomically-Constrained Tractography options

  -act image
     use the Anatomically-Constrained Tractography framework during tracking;
     provided image must be in the 5TT (five-tissue-type) format

  -backtrack
     allow tracks to be truncated and re-tracked if a poor structural
     termination is encountered

  -crop_at_gmwmi
     crop streamline endpoints more precisely as they cross the GM-WM interface

Options specific to the iFOD tracking algorithms

  -power value
     raise the FOD to the power specified (defaults are: 1.0 for iFOD1;
     1.0/nsamples for iFOD2).

Options specific to the iFOD2 tracking algorithm

  -samples number
     set the number of FOD samples to take per step (Default: 4).

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     References based on streamlines algorithm used:

     * FACT:
     Mori, S.; Crain, B. J.; Chacko, V. P. & van Zijl, P. C. M.
     Three-dimensional tracking of axonal projections in the brain by magnetic
     resonance imaging. Annals of Neurology, 1999, 45, 265-269

     * iFOD1 or SD_STREAM:
     Tournier, J.-D.; Calamante, F. & Connelly, A. MRtrix: Diffusion
     tractography in crossing fiber regions. Int. J. Imaging Syst. Technol.,
     2012, 22, 53-66

     * iFOD2:
     Tournier, J.-D.; Calamante, F. & Connelly, A. Improved probabilistic
     streamlines tractography by 2nd order integration over fibre orientation
     distributions. Proceedings of the International Society for Magnetic
     Resonance in Medicine, 2010, 1670

     * Nulldist1 / Nulldist2:
     Morris, D. M.; Embleton, K. V. & Parker, G. J. Probabilistic fibre
     tracking: Differentiation of connections from chance events. NeuroImage,
     2008, 42, 1329-1339

     * Tensor_Det:
     Basser, P. J.; Pajevic, S.; Pierpaoli, C.; Duda, J. & Aldroubi, A. In vivo
     fiber tractography using DT-MRI data. Magnetic Resonance in Medicine,
     2000, 44, 625-632

     * Tensor_Prob:
     Jones, D. Tractography Gone Wild: Probabilistic Fibre Tracking Using the
     Wild Bootstrap With Diffusion Tensor MRI. IEEE Transactions on Medical
     Imaging, 2008, 27, 1268-1274

     References based on command-line options:

     * -rk4:
     Basser, P. J.; Pajevic, S.; Pierpaoli, C.; Duda, J. & Aldroubi, A. In vivo
     fiber tractography using DT-MRI data. Magnetic Resonance in Medicine,
     2000, 44, 625-632

     * -act, -backtrack, -seed_gmwmi:
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A.
     Anatomically-constrained tractography: Improved diffusion MRI streamlines
     tractography through effective use of anatomical information. NeuroImage,
     2012, 62, 1924-1938

     * -seed_dynamic:
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. SIFT2:
     Enabling dense quantitative assessment of brain white matter connectivity
     using streamlines tractography. NeuroImage, 2015, 119, 338-351

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckglobal

### Tool Description
Multi-Shell Multi-Tissue Global Tractography

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        tckglobal                        Oct 21 2025

     tckglobal: part of the MRtrix3 package

SYNOPSIS

     Multi-Shell Multi-Tissue Global Tractography

USAGE

     tckglobal [ options ] source response tracks

        source       the image containing the raw DWI data.

        response     the response of a track segment on the DWI signal.

        tracks       the output file containing the tracks generated.


DESCRIPTION

     This command will reconstruct the global white matter fibre tractogram
     that best explains the input DWI data, using a multi-tissue spherical
     convolution model.

     Example use: 

      $ tckglobal dwi.mif wmr.txt -riso csfr.txt -riso gmr.txt -mask mask.mif 
        -niter 1e9 -fod fod.mif -fiso fiso.mif tracks.tck 

     in which dwi.mif is the input image, wmr.txt is an anisotropic,
     multi-shell response function for WM, and csfr.txt and gmr.txt are
     isotropic response functions for CSF and GM. The output tractogram is
     saved to tracks.tck. Optional output images fod.mif and fiso.mif contain
     the predicted WM fODF and isotropic tissue fractions of CSF and GM
     respectively, estimated as part of the global optimization and thus
     affected by spatial regularization.

Input options

  -grad scheme
     specify the diffusion encoding scheme (required if not supplied in the
     header).

  -mask image
     only reconstruct the tractogram within the specified brain mask image.

  -riso response  (multiple uses permitted)
     set one or more isotropic response functions. (multiple allowed)

Parameters

  -lmax order
     set the maximum harmonic order for the output series. (default = 8)

  -length size
     set the length of the particles (fibre segments). (default = 1mm)

  -weight w
     set the weight by which particles contribute to the model. (default = 0.1)

  -ppot u
     set the particle potential, i.e., the cost of adding one segment, relative
     to the particle weight. (default = 0.05)

  -cpot v
     set the connection potential, i.e., the energy term that drives two
     segments together. (default = 0.5)

  -t0 start
     set the initial temperature of the metropolis hastings optimizer. (default
     = 0.1)

  -t1 end
     set the final temperature of the metropolis hastings optimizer. (default =
     0.001)

  -niter n
     set the number of iterations of the metropolis hastings optimizer.
     (default = 10M)

Output options

  -fod odf
     Predicted fibre orientation distribution function (fODF).
     This fODF is estimated as part of the global track optimization, and
     therefore incorporates the spatial regularization that it imposes.
     Internally, the fODF is represented as a discrete sum of apodized point
     spread functions (aPSF) oriented along the directions of all particles in
     the voxel, used to predict the DWI signal from the particle configuration.

  -noapo
     disable spherical convolution of fODF with apodized PSF, to output a sum
     of delta functions rather than a sum of aPSFs.

  -fiso iso
     Predicted isotropic fractions of the tissues for which response functions
     were provided with -riso. Typically, these are CSF and GM.

  -eext eext
     Residual external energy in every voxel.

  -etrend stats
     internal and external energy trend and cooling statistics.

Advanced parameters, if you really know what you're doing

  -balance b
     balance internal and external energy. (default = 0)
     Negative values give more weight to the internal energy, positive to the
     external energy.

  -density lambda
     set the desired density of the free Poisson process. (default = 1)

  -prob prob
     set the probabilities of generating birth, death, randshift, optshift and
     connect proposals respectively. (default = 0.25,0.05,0.25,0.1,0.35)

  -beta b
     set the width of the Hanning interpolation window. (in [0, 1], default =
     0)
     If used, a mask is required, and this mask must keep at least one voxel
     distance to the image bounding box.

  -lambda lam
     set the weight of the internal energy directly. (default = 1)
     If provided, any value of -balance will be ignored.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Daan Christiaens (daan.christiaens@kcl.ac.uk)

COPYRIGHT
     Copyright (C) 2015 KU Leuven, Dept. Electrical Engineering, ESAT/PSI,
     Herestraat 49 box 7003, 3000 Leuven, Belgium 
     This is free software; see the source for copying conditions.
     There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
     PARTICULAR PURPOSE.

REFERENCES
     Christiaens, D.; Reisert, M.; Dhollander, T.; Sunaert, S.; Suetens, P. &
     Maes, F. Global tractography of multi-shell diffusion-weighted imaging
     data using a multi-tissue model. NeuroImage, 2015, 123, 89-101

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckinfo

### Tool Description
Print out information about a track file

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tckinfo                         Oct 21 2025

     tckinfo: part of the MRtrix3 package

SYNOPSIS

     Print out information about a track file

USAGE

     tckinfo [ options ] tracks [ tracks ... ]

        tracks       the input track file.


OPTIONS

  -count
     count number of tracks in file explicitly, ignoring the header

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckmap

### Tool Description
Use track data as a form of contrast for producing a high-resolution image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tckmap                          Oct 21 2025

     tckmap: part of the MRtrix3 package

SYNOPSIS

     Use track data as a form of contrast for producing a high-resolution image

USAGE

     tckmap [ options ] tracks output

        tracks       the input track file.

        output       the output track-weighted image


DESCRIPTION

     Note: if you run into limitations with RAM usage, make sure you output the
     results to a .mif file or .mih / .dat file pair - this will avoid the
     allocation of an additional buffer to store the output for write-out.

Options for the header of the output image

  -template image
     an image file to be used as a template for the output (the output image
     will have the same transform and field of view).

  -vox size
     provide either an isotropic voxel size (in mm), or comma-separated list of
     3 voxel dimensions.

  -datatype spec
     specify output image data type.

Options for the dimensionality of the output image

  -dec
     perform track mapping in directionally-encoded colour (DEC) space

  -dixel path
     map streamlines to dixels within each voxel; requires either a number of
     dixels (references an internal direction set), or a path to a text file
     containing a set of directions stored as azimuth/elevation pairs

  -tod lmax
     generate a Track Orientation Distribution (TOD) in each voxel; need to
     specify the maximum spherical harmonic degree lmax to use when generating
     Apodised Point Spread Functions

Options for the TWI image contrast properties

  -contrast type
     define the desired form of contrast for the output image
     Options are: tdi, length, invlength, scalar_map, scalar_map_count,
     fod_amp, curvature, vector_file (default: tdi)

  -image image
     provide the scalar image map for generating images with 'scalar_map' /
     'scalar_map_count' contrast, or the spherical harmonics image for
     'fod_amp' contrast

  -vector_file path
     provide the vector data file for generating images with 'vector_file'
     contrast

  -stat_vox type
     define the statistic for choosing the final voxel intensities for a given
     contrast type given the individual values from the tracks passing through
     each voxel. 
     Options are: sum, min, mean, max (default: sum)

  -stat_tck type
     define the statistic for choosing the contribution to be made by each
     streamline as a function of the samples taken along their lengths. 
     Only has an effect for 'scalar_map', 'fod_amp' and 'curvature' contrast
     types. 
     Options are: sum, min, mean, max, median, mean_nonzero, gaussian,
     ends_min, ends_mean, ends_max, ends_prod (default: mean)

  -fwhm_tck value
     when using gaussian-smoothed per-track statistic, specify the desired
     full-width half-maximum of the Gaussian smoothing kernel (in mm)

  -map_zero
     if a streamline has zero contribution based on the contrast & statistic,
     typically it is not mapped; use this option to still contribute to the map
     even if this is the case (these non-contributing voxels can then influence
     the mean value in each voxel of the map)

  -backtrack
     when using -stat_tck ends_*, if the streamline endpoint is outside the
     FoV, backtrack along the streamline trajectory until an appropriate point
     is found

Options for the streamline-to-voxel mapping mechanism

  -upsample factor
     upsample the tracks by some ratio using Hermite interpolation before
     mappping
     (If omitted, an appropriate ratio will be determined automatically)

  -precise
     use a more precise streamline mapping strategy, that accurately quantifies
     the length through each voxel (these lengths are then taken into account
     during TWI calculation)

  -ends_only
     only map the streamline endpoints to the image

  -tck_weights_in path
     specify a text scalar file containing the streamline weights

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and J-Donald Tournier
     (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * For TDI or DEC TDI:
     Calamante, F.; Tournier, J.-D.; Jackson, G. D. & Connelly, A.
     Track-density imaging (TDI): Super-resolution white matter imaging using
     whole-brain track-density mapping. NeuroImage, 2010, 53, 1233-1243

     * If using -contrast length and -stat_vox mean:
     Pannek, K.; Mathias, J. L.; Bigler, E. D.; Brown, G.; Taylor, J. D. &
     Rose, S. E. The average pathlength map: A diffusion MRI
     tractography-derived index for studying brain pathology. NeuroImage, 2011,
     55, 133-141

     * If using -dixel option with TDI contrast only:
     Smith, R.E., Tournier, J-D., Calamante, F., Connelly, A. A novel paradigm
     for automated segmentation of very large whole-brain probabilistic
     tractography data sets. In proc. ISMRM, 2011, 19, 673

     * If using -dixel option with any other contrast:
     Pannek, K., Raffelt, D., Salvado, O., Rose, S. Incorporating directional
     information in diffusion tractography derived maps: angular track imaging
     (ATI). In Proc. ISMRM, 2012, 20, 1912

     * If using -tod option:
     Dhollander, T., Emsell, L., Van Hecke, W., Maes, F., Sunaert, S., Suetens,
     P. Track Orientation Density Imaging (TODI) and Track Orientation
     Distribution (TOD) based tractography. NeuroImage, 2014, 94, 312-336

     * If using other contrasts / statistics:
     Calamante, F.; Tournier, J.-D.; Smith, R. E. & Connelly, A. A generalised
     framework for super-resolution track-weighted imaging. NeuroImage, 2012,
     59, 2494-2503

     * If using -precise mapping option:
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. SIFT:
     Spherical-deconvolution informed filtering of tractograms. NeuroImage,
     2013, 67, 298-312 (Appendix 3)

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckresample

### Tool Description
Resample each streamline in a track file to a new set of vertices

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       tckresample                       Oct 21 2025

     tckresample: part of the MRtrix3 package

SYNOPSIS

     Resample each streamline in a track file to a new set of vertices

USAGE

     tckresample [ options ] in_tracks out_tracks

        in_tracks    the input track file

        out_tracks   the output resampled tracks


DESCRIPTION

     It is necessary to specify precisely ONE of the command-line options for
     controlling how this resampling takes place; this may be either increasing
     or decreasing the number of samples along each streamline, or may involve
     changing the positions of the samples according to some specified
     trajectory.

     Note that because the length of a streamline is calculated based on the
     sums of distances between adjacent vertices, resampling a streamline to a
     new set of vertices will typically change the quantified length of that
     streamline; the magnitude of the difference will typically depend on the
     discrepancy in the number of vertices, with less vertices leading to a
     shorter length (due to taking chordal lengths of curved trajectories).

Streamline resampling options

  -upsample ratio
     increase the density of points along the length of each streamline by some
     factor (may improve mapping streamlines to ROIs, and/or visualisation)

  -downsample ratio
     increase the density of points along the length of each streamline by some
     factor (decreases required storage space)

  -step_size value
     re-sample the streamlines to a desired step size (in mm)

  -num_points count
     re-sample each streamline to a fixed number of points

  -endpoints
     only output the two endpoints of each streamline

  -line num start end
     resample tracks at 'num' equidistant locations along a line between
     'start' and 'end' (specified as comma-separated 3-vectors in scanner
     coordinates)

  -arc num start mid end
     resample tracks at 'num' equidistant locations along a circular arc
     specified by points 'start', 'mid' and 'end' (specified as comma-separated
     3-vectors in scanner coordinates)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and J-Donald Tournier
     (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tcksample

### Tool Description
Sample values of an associated image along tracks

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        tcksample                        Oct 21 2025

     tcksample: part of the MRtrix3 package

SYNOPSIS

     Sample values of an associated image along tracks

USAGE

     tcksample [ options ] tracks image values

        tracks       the input track file

        image        the image to be sampled

        values       the output sampled values


DESCRIPTION

     By default, the value of the underlying image at each point along the
     track is written to either an ASCII file (with all values for each track
     on the same line), or a track scalar file (.tsf). Alternatively, some
     statistic can be taken from the values along each streamline and written
     to a vector file.

OPTIONS

  -stat_tck statistic
     compute some statistic from the values along each streamline (options are:
     mean,median,min,max)

  -nointerp
     do not use trilinear interpolation when sampling image values

  -precise
     use the precise mechanism for mapping streamlines to voxels (obviates the
     need for trilinear interpolation) (only applicable if some per-streamline
     statistic is requested)

  -use_tdi_fraction
     each streamline is assigned a fraction of the image intensity in each
     voxel based on the fraction of the track density contributed by that
     streamline (this is only appropriate for processing a whole-brain
     tractogram, and images for which the quantiative parameter is additive)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If using -precise option: Smith, R. E.; Tournier, J.-D.; Calamante, F. &
     Connelly, A. SIFT: Spherical-deconvolution informed filtering of
     tractograms. NeuroImage, 2013, 67, 298-312

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tcksift

### Tool Description
Filter a whole-brain fibre-tracking data set such that the streamline densities match the FOD lobe integrals

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tcksift                         Oct 21 2025

     tcksift: part of the MRtrix3 package

SYNOPSIS

     Filter a whole-brain fibre-tracking data set such that the streamline
     densities match the FOD lobe integrals

USAGE

     tcksift [ options ] in_tracks in_fod out_tracks

        in_tracks    the input track file

        in_fod       input image containing the spherical harmonics of the
                     fibre orientation distributions

        out_tracks   the output filtered tracks file


OPTIONS

  -nofilter
     do NOT perform track filtering - just construct the model in order to
     provide output debugging images

  -output_at_counts counts
     output filtered track files (and optionally debugging images if
     -output_debug is specified) at specific numbers of remaining streamlines;
     provide as comma-separated list of integers

Options for setting the processing mask for the SIFT fixel-streamlines comparison model

  -proc_mask image
     provide an image containing the processing mask weights for the model;
     image spatial dimensions must match the fixel image

  -act image
     use an ACT five-tissue-type segmented anatomical image to derive the
     processing mask

Options affecting the SIFT model

  -fd_scale_gm
     provide this option (in conjunction with -act) to heuristically downsize
     the fibre density estimates based on the presence of GM in the voxel. This
     can assist in reducing tissue interface effects when using a single-tissue
     deconvolution algorithm

  -no_dilate_lut
     do NOT dilate FOD lobe lookup tables; only map streamlines to FOD lobes if
     the precise tangent lies within the angular spread of that lobe

  -make_null_lobes
     add an additional FOD lobe to each voxel, with zero integral, that covers
     all directions with zero / negative FOD amplitudes

  -remove_untracked
     remove FOD lobes that do not have any streamline density attributed to
     them; this improves filtering slightly, at the expense of longer
     computation time (and you can no longer do quantitative comparisons
     between reconstructions if this is enabled)

  -fd_thresh value
     fibre density threshold; exclude an FOD lobe from filtering processing if
     its integral is less than this amount (streamlines will still be mapped to
     it, but it will not contribute to the cost function or the filtering)

Options to make SIFT provide additional output files

  -csv file
     output statistics of execution per iteration to a .csv file

  -out_mu file
     output the final value of SIFT proportionality coefficient mu to a text
     file

  -output_debug
     provide various output images for assessing & debugging performance etc.

  -out_selection path
     output a text file containing the binary selection of streamlines

Options to control when SIFT terminates filtering

  -term_number value
     number of streamlines - continue filtering until this number of
     streamlines remain

  -term_ratio value
     termination ratio - defined as the ratio between reduction in cost
     function, and reduction in density of streamlines.
     Smaller values result in more streamlines being filtered out.

  -term_mu value
     terminate filtering once the SIFT proportionality coefficient reaches a
     given value

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. SIFT:
     Spherical-deconvolution informed filtering of tractograms. NeuroImage,
     2013, 67, 298-312

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tcksift2

### Tool Description
Optimise per-streamline cross-section multipliers to match a whole-brain tractogram to fixel-wise fibre densities

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        tcksift2                         Oct 21 2025

     tcksift2: part of the MRtrix3 package

SYNOPSIS

     Optimise per-streamline cross-section multipliers to match a whole-brain
     tractogram to fixel-wise fibre densities

USAGE

     tcksift2 [ options ] in_tracks in_fod out_weights

        in_tracks    the input track file

        in_fod       input image containing the spherical harmonics of the
                     fibre orientation distributions

        out_weights  output text file containing the weighting factor for each
                     streamline


Options for setting the processing mask for the SIFT fixel-streamlines comparison model

  -proc_mask image
     provide an image containing the processing mask weights for the model;
     image spatial dimensions must match the fixel image

  -act image
     use an ACT five-tissue-type segmented anatomical image to derive the
     processing mask

Options affecting the SIFT model

  -fd_scale_gm
     provide this option (in conjunction with -act) to heuristically downsize
     the fibre density estimates based on the presence of GM in the voxel. This
     can assist in reducing tissue interface effects when using a single-tissue
     deconvolution algorithm

  -no_dilate_lut
     do NOT dilate FOD lobe lookup tables; only map streamlines to FOD lobes if
     the precise tangent lies within the angular spread of that lobe

  -make_null_lobes
     add an additional FOD lobe to each voxel, with zero integral, that covers
     all directions with zero / negative FOD amplitudes

  -remove_untracked
     remove FOD lobes that do not have any streamline density attributed to
     them; this improves filtering slightly, at the expense of longer
     computation time (and you can no longer do quantitative comparisons
     between reconstructions if this is enabled)

  -fd_thresh value
     fibre density threshold; exclude an FOD lobe from filtering processing if
     its integral is less than this amount (streamlines will still be mapped to
     it, but it will not contribute to the cost function or the filtering)

Options to make SIFT provide additional output files

  -csv file
     output statistics of execution per iteration to a .csv file

  -out_mu file
     output the final value of SIFT proportionality coefficient mu to a text
     file

  -output_debug
     provide various output images for assessing & debugging performance etc.

  -out_coeffs path
     output text file containing the weighting coefficient for each streamline

Regularisation options for SIFT2

  -reg_tikhonov value
     provide coefficient for regularising streamline weighting coefficients
     (Tikhonov regularisation) (default: 0)

  -reg_tv value
     provide coefficient for regularising variance of streamline weighting
     coefficient to fixels along its length (Total Variation regularisation)
     (default: 0.1)

Options for controlling the SIFT2 optimisation algorithm

  -min_td_frac fraction
     minimum fraction of the FOD integral reconstructed by streamlines; if the
     reconstructed streamline density is below this fraction, the fixel is
     excluded from optimisation (default: 0.1)

  -min_iters count
     minimum number of iterations to run before testing for convergence; this
     can prevent premature termination at early iterations if the cost function
     increases slightly (default: 10)

  -max_iters count
     maximum number of iterations to run before terminating program

  -min_factor factor
     minimum weighting factor for an individual streamline; if the factor falls
     below this number the streamline will be rejected entirely (factor set to
     zero) (default: 0)

  -min_coeff coeff
     minimum weighting coefficient for an individual streamline; similar to the
     '-min_factor' option, but using the exponential coefficient basis of the
     SIFT2 model; these parameters are related as: factor = e^(coeff). Note
     that the -min_factor and -min_coeff options are mutually exclusive - you
     can only provide one. (default: -inf)

  -max_factor factor
     maximum weighting factor that can be assigned to any one streamline
     (default: inf)

  -max_coeff coeff
     maximum weighting coefficient for an individual streamline; similar to the
     '-max_factor' option, but using the exponential coefficient basis of the
     SIFT2 model; these parameters are related as: factor = e^(coeff). Note
     that the -max_factor and -max_coeff options are mutually exclusive - you
     can only provide one. (default: inf)

  -max_coeff_step step
     maximum change to a streamline's weighting coefficient in a single
     iteration (default: 1)

  -min_cf_decrease frac
     minimum decrease in the cost function (as a fraction of the initial value)
     that must occur each iteration for the algorithm to continue (default:
     2.5e-05)

  -linear
     perform a linear estimation of streamline weights, rather than the
     standard non-linear optimisation (typically does not provide as accurate a
     model fit; but only requires a single pass)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. SIFT2:
     Enabling dense quantitative assessment of brain white matter connectivity
     using streamlines tractography. NeuroImage, 2015, 119, 338-351

     * If using the -linear option: 
     Smith, RE; Raffelt, D; Tournier, J-D; Connelly, A. Quantitative
     Streamlines Tractography: Methods and Inter-Subject Normalisation. OHBM
     Aperture, 10.52294/ApertureNeuro.2022.2.NEOD9565.

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tckstats

### Tool Description
Calculate statistics on streamlines lengths

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        tckstats                         Oct 21 2025

     tckstats: part of the MRtrix3 package

SYNOPSIS

     Calculate statistics on streamlines lengths

USAGE

     tckstats [ options ] tracks_in

        tracks_in    the input track file


OPTIONS

  -output field  (multiple uses permitted)
     output only the field specified. Multiple such options can be supplied if
     required. Choices are: mean, median, std, min, max, count. Useful for use
     in scripts.

  -histogram path
     output a histogram of streamline lengths

  -dump path
     dump the streamlines lengths to a text file

  -ignorezero
     do not generate a warning if the track file contains streamlines with zero
     length

  -tck_weights_in path
     specify a text scalar file containing the streamline weights

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tcktransform

### Tool Description
Apply a spatial transformation to a tracks file

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      tcktransform                       Oct 21 2025

     tcktransform: part of the MRtrix3 package

SYNOPSIS

     Apply a spatial transformation to a tracks file

USAGE

     tcktransform [ options ] tracks transform output

        tracks       the input track file.

        transform    the image containing the transform.

        output       the output track file


Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tensor2metric

### Tool Description
Generate maps of tensor-derived parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      tensor2metric                      Oct 21 2025

     tensor2metric: part of the MRtrix3 package

SYNOPSIS

     Generate maps of tensor-derived parameters

USAGE

     tensor2metric [ options ] tensor

        tensor       the input tensor image.


OPTIONS

  -adc image
     compute the mean apparent diffusion coefficient (ADC) of the diffusion
     tensor. (sometimes also referred to as the mean diffusivity (MD))

  -fa image
     compute the fractional anisotropy (FA) of the diffusion tensor.

  -ad image
     compute the axial diffusivity (AD) of the diffusion tensor. (equivalent to
     the principal eigenvalue)

  -rd image
     compute the radial diffusivity (RD) of the diffusion tensor. (equivalent
     to the mean of the two non-principal eigenvalues)

  -cl image
     compute the linearity metric of the diffusion tensor. (one of the three
     Westin shape metrics)

  -cp image
     compute the planarity metric of the diffusion tensor. (one of the three
     Westin shape metrics)

  -cs image
     compute the sphericity metric of the diffusion tensor. (one of the three
     Westin shape metrics)

  -value image
     compute the selected eigenvalue(s) of the diffusion tensor.

  -vector image
     compute the selected eigenvector(s) of the diffusion tensor.

  -num sequence
     specify the desired eigenvalue/eigenvector(s). Note that several
     eigenvalues can be specified as a number sequence. For example, '1,3'
     specifies the principal (1) and minor (3) eigenvalues/eigenvectors
     (default = 1).

  -modulate choice
     specify how to modulate the magnitude of the eigenvectors. Valid choices
     are: none, FA, eigval (default = FA).

  -mask image
     only perform computation within the specified binary brain mask image.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Thijs Dhollander (thijs.dhollander@gmail.com) & Ben Jeurissen
     (ben.jeurissen@uantwerpen.be) & J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Basser, P. J.; Mattiello, J. & Lebihan, D. MR diffusion tensor
     spectroscopy and imaging. Biophysical Journal, 1994, 66, 259-267

     Westin, C. F.; Peled, S.; Gudbjartsson, H.; Kikinis, R. & Jolesz, F. A.
     Geometrical diffusion measures for MRI from tensor basis analysis. Proc
     Intl Soc Mag Reson Med, 1997, 5, 1742

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_transformcalc

### Tool Description
Perform calculations on linear transformation matrices

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      transformcalc                      Oct 21 2025

     transformcalc: part of the MRtrix3 package

SYNOPSIS

     Perform calculations on linear transformation matrices

USAGE

     transformcalc [ options ] inputs [ inputs ... ] operation output

        inputs       the input(s) for the specified operation

        operation    the operation to perform, one of: invert, half, rigid,
                     header, average, interpolate, decompose,
                     align_vertices_rigid, align_vertices_rigid_scale (see
                     description section for details).

        output       the output transformation matrix.


EXAMPLE USAGES

     Invert a transformation:
       $ transformcalc matrix_in.txt invert matrix_out.txt

     Calculate the matrix square root of the input transformation (halfway
     transformation):
       $ transformcalc matrix_in.txt half matrix_out.txt

     Calculate the rigid component of an affine input transformation:
       $ transformcalc affine_in.txt rigid rigid_out.txt

     Calculate the transformation matrix from an original image and an image
     with modified header:
       $ transformcalc mov mapmovhdr header output

     Calculate the average affine matrix of a set of input matrices:
       $ transformcalc input1.txt ... inputN.txt average matrix_out.txt

     Create interpolated transformation matrix between two inputs:
       $ transformcalc input1.txt input2.txt interpolate matrix_out.txt
     Based on matrix decomposition with linear interpolation of translation,
     rotation and stretch described in: Shoemake, K., Hill, M., & Duff, T.
     (1992). Matrix Animation and Polar Decomposition. Matrix, 92, 258-264.
     doi:10.1.1.56.1336

     Decompose transformation matrix M into translation, rotation and stretch
     and shear (M = T * R * S):
       $ transformcalc matrix_in.txt decompose matrixes_out.txt
     The output is a key-value text file containing: scaling: vector of 3
     scaling factors in x, y, z direction; shear: list of shear factors for xy,
     xz, yz axes; angles: list of Euler angles about static x, y, z axes in
     radians in the range [0:pi]x[-pi:pi]x[-pi:pi]; angle_axis: angle in
     radians and rotation axis; translation : translation vector along x, y, z
     axes in mm; R: composed roation matrix (R = rot_x * rot_y * rot_z); S:
     composed scaling and shear matrix

     Calculate transformation that aligns two images based on sets of
     corresponding landmarks:
       $ transformcalc input moving.txt fixed.txt align_vertices_rigid rigid.txt
     Similary, 'align_vertices_rigid_scale' produces an affine matrix (rigid
     and global scale). Vertex coordinates are in scanner space, corresponding
     vertices must be stored in the same row of moving.txt and fixed.txt.
     Requires 3 or more vertices in each file. Algorithm: Kabsch 'A solution
     for the best rotation to relate two sets of vectors'
     DOI:10.1107/S0567739476001873

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Max Pietsch (maximilian.pietsch@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_transformcompose

### Tool Description
Compose any number of linear transformations and/or warps into a single transformation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                    transformcompose                     Oct 21 2025

     transformcompose: part of the MRtrix3 package

SYNOPSIS

     Compose any number of linear transformations and/or warps into a single
     transformation

USAGE

     transformcompose [ options ] input [ input ... ] output

        input        the input transforms (either linear or non-linear warps).

        output       the output file (may be a linear transformation text file,
                     or a deformation warp field image, depending on usage)


DESCRIPTION

     Any linear transforms must be supplied as a 4x4 matrix in a text file
     (e.g. as per the output of mrregister). Any warp fields must be supplied
     as a 4D image representing a deformation field (e.g. as output from
     mrrregister -nl_warp).

     Input transformations should be provided to the command in the order in
     which they would be applied to an image if they were to be applied
     individually.

     If all input transformations are linear, and the -template option is not
     provided, then the file output by the command will also be a linear
     transformation saved as a 4x4 matrix in a text file. If a template image
     is supplied, then the output will always be a deformation field. If at
     least one of the inputs is a warp field, then the output will be a
     deformation field, which will be defined on the grid of the last input
     warp image supplied if the -template option is not used.

OPTIONS

  -template image
     define the output grid defined by a template image

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_transformconvert

### Tool Description
Convert linear transformation matrices

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                    transformconvert                     Oct 21 2025

     transformconvert: part of the MRtrix3 package

SYNOPSIS

     Convert linear transformation matrices

USAGE

     transformconvert [ options ] input [ input ... ] operation output

        input        the input(s) for the specified operation

        operation    the operation to perform, one of:
                     flirt_import, itk_import

        output       the output transformation matrix.


DESCRIPTION

     This command allows to convert transformation matrices provided by other
     registration softwares to a format usable in MRtrix3. Example usages are
     provided below.

EXAMPLE USAGES

     Convert a transformation matrix produced by FSL's flirt command into a
     format usable by MRtrix3:
       $ transformconvert transform_flirt.mat flirt_in.nii flirt_ref.nii flirt_import transform_mrtrix.txt
     The two images provided as inputs for this operation must be in the
     correct order: first the image that was provided to flirt via the -in
     option, second the image that was provided to flirt via the -ref option.

     Convert a plain text transformation matrix file produced by ITK's affine
     registration (e.g. ANTS, Slicer) into a format usable by MRtrix3:
       $ transformconvert transform_itk.txt itk_import transform_mrtrix.txt

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Max Pietsch (maximilian.pietsch@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tsfdivide

### Tool Description
Divide corresponding values in track scalar files

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        tsfdivide                        Oct 21 2025

     tsfdivide: part of the MRtrix3 package

SYNOPSIS

     Divide corresponding values in track scalar files

USAGE

     tsfdivide [ options ] input1 input2 output

        input1       the first input track scalar file.

        input2       the second input track scalar file.

        output       the output track scalar file


Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tsfinfo

### Tool Description
Print out information about a track scalar file

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tsfinfo                         Oct 21 2025

     tsfinfo: part of the MRtrix3 package

SYNOPSIS

     Print out information about a track scalar file

USAGE

     tsfinfo [ options ] tracks [ tracks ... ]

        tracks       the input track scalar file.


OPTIONS

  -count
     count number of tracks in file explicitly, ignoring the header

  -ascii prefix
     save values of each track scalar file in individual ascii files, with the
     specified prefix.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tsfmult

### Tool Description
Multiply corresponding values in track scalar files

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         tsfmult                         Oct 21 2025

     tsfmult: part of the MRtrix3 package

SYNOPSIS

     Multiply corresponding values in track scalar files

USAGE

     tsfmult [ options ] input1 input1 output

        input1       the first input track scalar file.

        input1       the second input track scalar file.

        output       the output track scalar file


Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tsfsmooth

### Tool Description
Gaussian filter a track scalar file

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        tsfsmooth                        Oct 21 2025

     tsfsmooth: part of the MRtrix3 package

SYNOPSIS

     Gaussian filter a track scalar file

USAGE

     tsfsmooth [ options ] input output

        input        the input track scalar file.

        output       the output track scalar file


OPTIONS

  -stdev sigma
     apply Gaussian smoothing with the specified standard deviation. The
     standard deviation is defined in units of track points (default: 4)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tsfthreshold

### Tool Description
Threshold and invert track scalar files

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      tsfthreshold                       Oct 21 2025

     tsfthreshold: part of the MRtrix3 package

SYNOPSIS

     Threshold and invert track scalar files

USAGE

     tsfthreshold [ options ] input T output

        input        the input track scalar file.

        T            the desired threshold

        output       the binary output track scalar file


OPTIONS

  -invert
     invert the output mask

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_tsfvalidate

### Tool Description
Validate a track scalar file against the corresponding track data

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       tsfvalidate                       Oct 21 2025

     tsfvalidate: part of the MRtrix3 package

SYNOPSIS

     Validate a track scalar file against the corresponding track data

USAGE

     tsfvalidate [ options ] tsf tracks

        tsf          the input track scalar file

        tracks       the track file on which the TSF is based


Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_vectorstats

### Tool Description
Statistical testing of vector data using non-parametric permutation testing

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       vectorstats                       Oct 21 2025

     vectorstats: part of the MRtrix3 package

SYNOPSIS

     Statistical testing of vector data using non-parametric permutation
     testing

USAGE

     vectorstats [ options ] input design contrast output

        input        a text file listing the file names of the input subject
                     data

        design       the design matrix

        contrast     the contrast matrix

        output       the filename prefix for all output


DESCRIPTION

     This command can be used to perform permutation testing of any form of
     data. The data for each input subject must be stored in a text file, with
     one value per row. The data for each row across subjects will be tested
     independently, i.e. there is no statistical enhancement that occurs
     between the data; however family-wise error control will be used.

     In some software packages, a column of ones is automatically added to the
     GLM design matrix; the purpose of this column is to estimate the "global
     intercept", which is the predicted value of the observed variable if all
     explanatory variables were to be zero. However there are rare situations
     where including such a column would not be appropriate for a particular
     experimental design. Hence, in MRtrix3 statistical inference commands, it
     is up to the user to determine whether or not this column of ones should
     be included in their design matrix, and add it explicitly if necessary.
     The contrast matrix must also reflect the presence of this additional
     column.

Options relating to shuffling of data for nonparametric statistical inference

  -notest
     don't perform statistical inference; only output population statistics
     (effect size, stdev etc)

  -errors spec
     specify nature of errors for shuffling; options are: ee,ise,both (default:
     ee)

  -exchange_within file
     specify blocks of observations within each of which data may undergo
     restricted exchange

  -exchange_whole file
     specify blocks of observations that may be exchanged with one another (for
     independent and symmetric errors, sign-flipping will occur block-wise)

  -strong
     use strong familywise error control across multiple hypotheses

  -nshuffles number
     the number of shuffles (default: 5000)

  -permutations file
     manually define the permutations (relabelling). The input should be a text
     file defining a m x n matrix, where each relabelling is defined as a
     column vector of size m, and the number of columns, n, defines the number
     of permutations. Can be generated with the palm_quickperms function in
     PALM (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM). Overrides the
     -nshuffles option.

Options related to the General Linear Model (GLM)

  -variance file
     define variance groups for the G-statistic; measurements for which the
     expected variance is equivalent should contain the same index

  -ftests path
     perform F-tests; input text file should contain, for each F-test, a row
     containing ones and zeros, where ones indicate the rows of the contrast
     matrix to be included in the F-test.

  -fonly
     only assess F-tests; do not perform statistical inference on entries in
     the contrast matrix

  -column path  (multiple uses permitted)
     add a column to the design matrix corresponding to subject element-wise
     values (note that the contrast matrix must include an additional column
     for each use of this option); the text file provided via this option
     should contain a file name for each subject

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_voxel2fixel

### Tool Description
Map the scalar value in each voxel to all fixels within that voxel

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       voxel2fixel                       Oct 21 2025

     voxel2fixel: part of the MRtrix3 package

SYNOPSIS

     Map the scalar value in each voxel to all fixels within that voxel

USAGE

     voxel2fixel [ options ] image_in fixel_directory_in fixel_directory_out fixel_data_out

        image_in     the input image.

        fixel_directory_in  the input fixel directory. Used to define the
                     fixels and their directions

        fixel_directory_out  the fixel directory where the output will be
                     written. This can be the same as the input directory if
                     desired

        fixel_data_out  the name of the fixel data image.


DESCRIPTION

     This command is designed to enable CFE-based statistical analysis to be
     performed on voxel-wise measures.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_voxel2mesh

### Tool Description
Generate a surface mesh representation from a voxel image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       voxel2mesh                        Oct 21 2025

     voxel2mesh: part of the MRtrix3 package

SYNOPSIS

     Generate a surface mesh representation from a voxel image

USAGE

     voxel2mesh [ options ] input output

        input        the input image.

        output       the output mesh file.


DESCRIPTION

     This command utilises the Marching Cubes algorithm to generate a polygonal
     surface that represents the isocontour(s) of the input image at a
     particular intensity. By default, an appropriate threshold will be
     determined automatically from the input image, however the intensity value
     of the isocontour(s) can instead be set manually using the -threhsold
     option.

     If the -blocky option is used, then the Marching Cubes algorithm will not
     be used. Instead, the input image will be interpreted as a binary mask
     image, and polygonal surfaces will be generated at the outer faces of the
     voxel clusters within the mask.

OPTIONS

  -blocky
     generate a 'blocky' mesh that precisely represents the voxel edges

  -threshold value
     manually set the intensity threshold for the Marching Cubes algorithm

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_warp2metric

### Tool Description
Compute fixel-wise or voxel-wise metrics from a 4D deformation field

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       warp2metric                       Oct 21 2025

     warp2metric: part of the MRtrix3 package

SYNOPSIS

     Compute fixel-wise or voxel-wise metrics from a 4D deformation field

USAGE

     warp2metric [ options ] in

        in           the input deformation field


OPTIONS

  -fc template_fixel_directory output_fixel_directory output_fixel_data
     use an input template fixel image to define fibre orientations and output
     a fixel image describing the change in fibre cross-section (FC) in the
     perpendicular plane to the fixel orientation. e.g. warp2metric warp.mif
     -fc fixel_template_directory output_fixel_directory fc.mif

  -jmat output
     output a Jacobian matrix image stored in column-major order along the 4th
     dimension.Note the output jacobian describes the warp gradient w.r.t the
     scanner space coordinate system

  -jdet output
     output the Jacobian determinant instead of the full matrix

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Raffelt, D.; Tournier, JD/; Smith, RE.; Vaughan, DN.; Jackson, G.;
     Ridgway, GR. Connelly, A.Investigating White Matter Fibre Density and
     Morphology using Fixel-Based Analysis. Neuroimage, 2017, 144, 58-73, doi:
     10.1016/j.neuroimage.2016.09.029

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_warpconvert

### Tool Description
Convert between different representations of a non-linear warp

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       warpconvert                       Oct 21 2025

     warpconvert: part of the MRtrix3 package

SYNOPSIS

     Convert between different representations of a non-linear warp

USAGE

     warpconvert [ options ] in type out

        in           the input warp image.

        type         the conversion type required. Valid choices are:
                     deformation2displacement, displacement2deformation,
                     warpfull2deformation, warpfull2displacement

        out          the output warp image.


DESCRIPTION

     A deformation field is defined as an image where each voxel defines the
     corresponding position in the other image (in scanner space coordinates).
     A displacement field stores the displacements (in mm) to the other image
     from the each voxel's position (in scanner space). The warpfull file is
     the 5D format output from mrregister -nl_warp_full, which contains linear
     transforms, warps and their inverses that map each image to a midway
     space.

OPTIONS

  -template image
     define a template image when converting a warpfull file (which is defined
     on a grid in the midway space between image 1 & 2). For example to
     generate the deformation field that maps image1 to image2, then supply
     image2 as the template image

  -midway_space
     to be used only with warpfull2deformation and warpfull2displacement
     conversion types. The output will only contain the non-linear warp to map
     an input image to the midway space (defined by the warpfull grid). If a
     linear transform exists in the warpfull file header then it will be
     composed and included in the output.

  -from image
     to be used only with warpfull2deformation and warpfull2displacement
     conversion types. Used to define the direction of the desired output
     field.Use -from 1 to obtain the image1->image2 field and from 2 for
     image2->image1. Can be used in combination with the -midway_space option
     to produce a field that only maps to midway space.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_warpcorrect

### Tool Description
Replaces voxels in a deformation field that point to a specific out of bounds location with nan,nan,nan

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       warpcorrect                       Oct 21 2025

     warpcorrect: part of the MRtrix3 package

SYNOPSIS

     Replaces voxels in a deformation field that point to a specific out of
     bounds location with nan,nan,nan

USAGE

     warpcorrect [ options ] in out

        in           the input warp image.

        out          the output warp image.


DESCRIPTION

     This can be used in conjunction with the warpinit command to compute a
     MRtrix compatible deformation field from non-linear transformations
     generated by any other registration package.

OPTIONS

  -marker coordinates
     single value or a comma separated list of values that define out of bounds
     voxels in the input warp image. Default: (0,0,0).

  -tolerance value
     numerical precision used for L2 matrix norm comparison. Default:
     9.99999975e-06.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) & Max Pietsch
     (mail@maxpietsch.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_warpinit

### Tool Description
Create an initial warp image, representing an identity transformation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        warpinit                         Oct 21 2025

     warpinit: part of the MRtrix3 package

SYNOPSIS

     Create an initial warp image, representing an identity transformation

USAGE

     warpinit [ options ] template warp

        template     the input template image.

        warp         the output warp image.


DESCRIPTION

     This is useful to obtain the warp fields from other normalisation
     applications, by applying the transformation of interest to the warp field
     generated by this program.

     The image generated is a 4D image with the same spatial characteristics as
     the input template image. It contains 3 volumes, with each voxel
     containing its own x,y,z coordinates.

     Note that this command can be used to create 3 separate X,Y,Z images
     directly (which may be useful to create images suitable for use in the
     registration program) using the following syntax:

       $ warpinit template.mif warp-'[]'.nii

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_warpinvert

### Tool Description
Invert a non-linear warp field

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       warpinvert                        Oct 21 2025

     warpinvert: part of the MRtrix3 package

SYNOPSIS

     Invert a non-linear warp field

USAGE

     warpinvert [ options ] in out

        in           the input warp image.

        out          the output warp image.


DESCRIPTION

     By default, this command assumes that the input warp field is a
     deformation field, i.e. each voxel stores the corresponding position in
     the other image (in scanner space), and the calculated output warp image
     will also be a deformation field. If the input warp field is instead a
     displacment field, i.e. where each voxel stores an offset from which to
     sample the other image (but still in scanner space), then the
     -displacement option should be used; the output warp field will
     additionally be calculated as a displacement field in this case.

OPTIONS

  -template image
     define a template image grid for the output warp

  -displacement
     indicates that the input warp field is a displacement field; the output
     will also be a displacement field

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and David Raffelt
     (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5ttgen_freesurfer

### Tool Description
Generate the 5TT image based on a FreeSurfer parcellation image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                    5ttgen freesurfer

     5ttgen freesurfer: part of the MRtrix3 package

SYNOPSIS

     Generate the 5TT image based on a FreeSurfer parcellation image

USAGE

     5ttgen freesurfer [ options ] input output

        input        The input FreeSurfer parcellation image (any image
                     containing 'aseg' in its name)

        output       The output 5TT image

Options specific to the 'freesurfer' algorithm

  -lut LUT
     Manually provide path to the lookup table on which the input parcellation
     image is based (e.g. FreeSurferColorLUT.txt)

Options common to all 5ttgen algorithms

  -nocrop
     Do NOT crop the resulting 5TT image to reduce its size (keep the same
     dimensions as the input image)

  -sgm_amyg_hipp
     Represent the amygdalae and hippocampi as sub-cortical grey matter in the
     5TT image

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. Anatomically-
     constrained tractography: Improved diffusion MRI streamlines tractography
     through effective use of anatomical information. NeuroImage, 2012, 62,
     1924-1938

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5ttgen_fsl

### Tool Description
Use FSL commands to generate the 5TT image based on a T1-weighted image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       5ttgen fsl

     5ttgen fsl: part of the MRtrix3 package

SYNOPSIS

     Use FSL commands to generate the 5TT image based on a T1-weighted image

USAGE

     5ttgen fsl [ options ] input output

        input        The input T1-weighted image

        output       The output 5TT image

Options specific to the 'fsl' algorithm

  -t2 <T2 image>
     Provide a T2-weighted image in addition to the default T1-weighted image;
     this will be used as a second input to FSL FAST

  -mask MASK
     Manually provide a brain mask, rather than deriving one in the script

  -premasked
     Indicate that brain masking has already been applied to the input image

Options common to all 5ttgen algorithms

  -nocrop
     Do NOT crop the resulting 5TT image to reduce its size (keep the same
     dimensions as the input image)

  -sgm_amyg_hipp
     Represent the amygdalae and hippocampi as sub-cortical grey matter in the
     5TT image

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. Anatomically-
     constrained tractography: Improved diffusion MRI streamlines tractography
     through effective use of anatomical information. NeuroImage, 2012, 62,
     1924-1938

     Smith, S. M. Fast robust automated brain extraction. Human Brain Mapping,
     2002, 17, 143-155

     Zhang, Y.; Brady, M. & Smith, S. Segmentation of brain MR images through a
     hidden Markov random field model and the expectation-maximization
     algorithm. IEEE Transactions on Medical Imaging, 2001, 20, 45-57

     Patenaude, B.; Smith, S. M.; Kennedy, D. N. & Jenkinson, M. A Bayesian
     model of shape and appearance for subcortical brain segmentation.
     NeuroImage, 2011, 56, 907-922

     Smith, S. M.; Jenkinson, M.; Woolrich, M. W.; Beckmann, C. F.; Behrens, T.
     E.; Johansen-Berg, H.; Bannister, P. R.; De Luca, M.; Drobnjak, I.;
     Flitney, D. E.; Niazy, R. K.; Saunders, J.; Vickers, J.; Zhang, Y.; De
     Stefano, N.; Brady, J. M. & Matthews, P. M. Advances in functional and
     structural MR image analysis and implementation as FSL. NeuroImage, 2004,
     23, S208-S219

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwibiascorrect_fsl

### Tool Description
Perform DWI bias field correction using the 'fast' command as provided in FSL

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                   dwibiascorrect fsl

     dwibiascorrect fsl: part of the MRtrix3 package

SYNOPSIS

     Perform DWI bias field correction using the 'fast' command as provided in
     FSL

USAGE

     dwibiascorrect fsl [ options ] input output

        input        The input image series to be corrected

        output       The output corrected image series

DESCRIPTION

     The FSL 'fast' command only estimates the bias field within a brain mask,
     and cannot extrapolate this smoothly-varying field beyond the defined mask.
     As such, this algorithm by necessity introduces a hard masking of the input
     DWI. Since this attribute may interfere with the purpose of using the
     command (e.g. correction of a bias field is commonly used to improve brain
     mask estimation), use of this particular algorithm is generally not
     recommended.

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

Options common to all dwibiascorrect algorithms

  -mask image
     Manually provide a mask image for bias field estimation

  -bias image
     Output the estimated bias field

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Zhang, Y.; Brady, M. & Smith, S. Segmentation of brain MR images through a
     hidden Markov random field model and the expectation-maximization
     algorithm. IEEE Transactions on Medical Imaging, 2001, 20, 45-57

     Smith, S. M.; Jenkinson, M.; Woolrich, M. W.; Beckmann, C. F.; Behrens, T.
     E.; Johansen-Berg, H.; Bannister, P. R.; De Luca, M.; Drobnjak, I.;
     Flitney, D. E.; Niazy, R. K.; Saunders, J.; Vickers, J.; Zhang, Y.; De
     Stefano, N.; Brady, J. M. & Matthews, P. M. Advances in functional and
     structural MR image analysis and implementation as FSL. NeuroImage, 2004,
     23, S208-S219

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwibiascorrect_ants

### Tool Description
Perform DWI bias field correction using the N4 algorithm as provided in ANTs

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                   dwibiascorrect ants

     dwibiascorrect ants: part of the MRtrix3 package

SYNOPSIS

     Perform DWI bias field correction using the N4 algorithm as provided in
     ANTs

USAGE

     dwibiascorrect ants [ options ] input output

        input        The input image series to be corrected

        output       The output corrected image series

Options for ANTs N4BiasFieldCorrection command

  -ants.b [100,3]
     N4BiasFieldCorrection option -b. [initial mesh resolution in mm, spline
     order] This value is optimised for human adult data and needs to be
     adjusted for rodent data.

  -ants.c [1000,0.0]
     N4BiasFieldCorrection option -c. [numberOfIterations,convergenceThreshold]

  -ants.s 4
     N4BiasFieldCorrection option -s. shrink-factor applied to spatial
     dimensions

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

Options common to all dwibiascorrect algorithms

  -mask image
     Manually provide a mask image for bias field estimation

  -bias image
     Output the estimated bias field

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tustison, N.; Avants, B.; Cook, P.; Zheng, Y.; Egan, A.; Yushkevich, P. &
     Gee, J. N4ITK: Improved N3 Bias Correction. IEEE Transactions on Medical
     Imaging, 2010, 29, 1310-1320

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dwifslpreproc

### Tool Description
Perform diffusion image pre-processing using FSL's eddy tool; including inhomogeneity distortion correction using FSL's topup tool if possible

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      dwifslpreproc

     dwifslpreproc: part of the MRtrix3 package

SYNOPSIS

     Perform diffusion image pre-processing using FSL's eddy tool; including
     inhomogeneity distortion correction using FSL's topup tool if possible

USAGE

     dwifslpreproc [ options ] input output

        input        The input DWI series to be corrected

        output       The output corrected image series

DESCRIPTION

     This script is intended to provide convenience of use of the FSL software
     tools topup and eddy for performing DWI pre-processing, by encapsulating
     some of the surrounding image data and metadata processing steps. It is
     intended to simply these processing steps for most commonly-used DWI
     acquisition strategies, whilst also providing support for some more exotic
     acquisitions. The "example usage" section demonstrates the ways in which
     the script can be used based on the (compulsory) -rpe_* command-line
     options.

     The "-topup_options" and "-eddy_options" command-line options allow the
     user to pass desired command-line options directly to the FSL commands
     topup and eddy. The available options for those commands may vary between
     versions of FSL; users can interrogate such by querying the help pages of
     the installed software, and/or the FSL online documentation: (topup)
     https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup/TopupUsersGuide ; (eddy)
     https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy/UsersGuide

     The script will attempt to run the CUDA version of eddy; if this does not
     succeed for any reason, or is not present on the system, the CPU version
     will be attempted instead. By default, the CUDA eddy binary found that
     indicates compilation against the most recent version of CUDA will be
     attempted; this can be over-ridden by providing a soft-link "eddy_cuda"
     within your path that links to the binary you wish to be executed.

     Note that this script does not perform any explicit registration between
     images provided to topup via the -se_epi option, and the DWI volumes
     provided to eddy. In some instances (motion between acquisitions) this can
     result in erroneous application of the inhomogeneity field during
     distortion correction. Use of the -align_seepi option is advocated in this
     scenario, which ensures that the first volume in the series provided to
     topup is also the first volume in the series provided to eddy, guaranteeing
     alignment. But a prerequisite for this approach is that the image contrast
     within the images provided to the -se_epi option must match the b=0 volumes
     present within the input DWI series: this means equivalent TE, TR and flip
     angle (note that differences in multi-band factors between two acquisitions
     may lead to differences in TR).

EXAMPLE USAGES

     A_basic_DWI_acquisition,_where_all_image_volumes_are_acquired_in_a_single
     protocol_with_fixed_phase_encoding:
       $ dwifslpreproc DWI_in.mif DWI_out.mif -rpe_none -pe_dir ap -readout_time 0.55
     Due to use of a single fixed phase encoding, no EPI distortion correction
     can be applied in this case.

     DWIs_all_acquired_with_a_single_fixed_phase_encoding;_but_additionally_a
     pair_of_b=0_images_with_reversed_phase_encoding_to_estimate_the
     inhomogeneity_field:
       $ mrcat b0_ap.mif b0_pa.mif b0_pair.mif -axis 3; dwifslpreproc DWI_in.mif DWI_out.mif -rpe_pair -se_epi b0_pair.mif -pe_dir ap -readout_time 0.72 -align_seepi
     Here the two individual b=0 volumes are concatenated into a single 4D image
     series, and this is provided to the script via the -se_epi option. Note
     that with the -rpe_pair option used here, which indicates that the SE-EPI
     image series contains one or more pairs of b=0 images with reversed phase
     encoding, the FIRST HALF of the volumes in the SE-EPI series must possess
     the same phase encoding as the input DWI series, while the second half are
     assumed to contain the opposite phase encoding direction but identical
     total readout time. Use of the -align_seepi option is advocated as long as
     its use is valid (more information in the Description section).

     All_DWI_directions_&_b-values_are_acquired_twice,_with_the_phase_encoding
     direction_of_the_second_acquisition_protocol_being_reversed_with_respect_to
     the_first:
       $ mrcat DWI_lr.mif DWI_rl.mif DWI_all.mif -axis 3; dwifslpreproc DWI_all.mif DWI_out.mif -rpe_all -pe_dir lr -readout_time 0.66
     Here the two acquisition protocols are concatenated into a single DWI
     series containing all acquired volumes. The direction indicated via the
     -pe_dir option should be the direction of phase encoding used in
     acquisition of the FIRST HALF of volumes in the input DWI series; ie. the
     first of the two files that was provided to the mrcat command. In this
     usage scenario, the output DWI series will contain the same number of image
     volumes as ONE of the acquired DWI series (ie. half of the number in the
     concatenated series); this is because the script will identify pairs of
     volumes that possess the same diffusion sensitisation but reversed phase
     encoding, and perform explicit recombination of those volume pairs in such
     a way that image contrast in regions of inhomogeneity is determined from
     the stretched rather than the compressed image.

     Any_acquisition_scheme_that_does_not_fall_into_one_of_the_example_usages
     above:
       $ mrcat DWI_*.mif DWI_all.mif -axis 3; mrcat b0_*.mif b0_all.mif -axis 3; dwifslpreproc DWI_all.mif DWI_out.mif -rpe_header -se_epi b0_all.mif -align_seepi
     With this usage, the relevant phase encoding information is determined
     entirely based on the contents of the relevant image headers, and
     dwifslpreproc prepares all metadata for the executed FSL commands
     accordingly. This can therefore be used if the particular DWI acquisition
     strategy used does not correspond to one of the simple examples as
     described in the prior examples. This usage is predicated on the headers of
     the input files containing appropriately-named key-value fields such that
     MRtrix3 tools identify them as such. In some cases, conversion from DICOM
     using MRtrix3 commands will automatically extract and embed this
     information; however this is not true for all scanner vendors and/or
     software versions. In the latter case it may be possible to manually
     provide these metadata; either using the -json_import command-line option
     of dwifslpreproc, or the -json_import or one of the -import_pe_* command-
     line options of MRtrix3's mrconvert command (and saving in .mif format)
     prior to running dwifslpreproc.

OPTIONS

  -pe_dir PE
     Manually specify the phase encoding direction of the input series; can be a
     signed axis number (e.g. -0, 1, +2), an axis designator (e.g. RL, PA, IS),
     or NIfTI axis codes (e.g. i-, j, k)

  -readout_time time
     Manually specify the total readout time of the input series (in seconds)

  -se_epi image
     Provide an additional image series consisting of spin-echo EPI images,
     which is to be used exclusively by topup for estimating the inhomogeneity
     field (i.e. it will not form part of the output image series)

  -align_seepi
     Achieve alignment between the SE-EPI images used for inhomogeneity field
     estimation, and the DWIs (more information in Description section)

  -json_import file
     Import image header information from an associated JSON file (may be
     necessary to determine phase encoding information)

  -topup_options " TopupOptions"
     Manually provide additional command-line options to the topup command
     (provide a string within quotation marks that contains at least one space,
     even if only passing a single command-line option to topup)

  -eddy_options " EddyOptions"
     Manually provide additional command-line options to the eddy command
     (provide a string within quotation marks that contains at least one space,
     even if only passing a single command-line option to eddy)

  -eddy_mask image
     Provide a processing mask to use for eddy, instead of having dwifslpreproc
     generate one internally using dwi2mask

  -eddy_slspec file
     Provide a file containing slice groupings for eddy's slice-to-volume
     registration

  -eddyqc_text directory
     Copy the various text-based statistical outputs generated by eddy, and the
     output of eddy_qc (if installed), into an output directory

  -eddyqc_all directory
     Copy ALL outputs generated by eddy (including images), and the output of
     eddy_qc (if installed), into an output directory

Options for specifying the acquisition phase-encoding design; note that one of the -rpe_* options MUST be provided

  -rpe_none
     Specify that no reversed phase-encoding image data is being provided; eddy
     will perform eddy current and motion correction only

  -rpe_pair
     Specify that a set of images (typically b=0 volumes) will be provided for
     use in inhomogeneity field estimation only (using the -se_epi option)

  -rpe_all
     Specify that ALL DWIs have been acquired with opposing phase-encoding

  -rpe_header
     Specify that the phase-encoding information can be found in the image
     header(s), and that this is the information that the script should use

Options for importing the diffusion gradient table

  -grad GRAD
     Provide the diffusion gradient table in MRtrix format

  -fslgrad bvecs bvals
     Provide the diffusion gradient table in FSL bvecs/bvals format

Options for exporting the diffusion gradient table

  -export_grad_mrtrix grad
     Export the final gradient table in MRtrix format

  -export_grad_fsl bvecs bvals
     Export the final gradient table in FSL bvecs/bvals format

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Andersson, J. L. & Sotiropoulos, S. N. An integrated approach to correction
     for off-resonance effects and subject movement in diffusion MR imaging.
     NeuroImage, 2015, 125, 1063-1078

     Smith, S. M.; Jenkinson, M.; Woolrich, M. W.; Beckmann, C. F.; Behrens, T.
     E.; Johansen-Berg, H.; Bannister, P. R.; De Luca, M.; Drobnjak, I.;
     Flitney, D. E.; Niazy, R. K.; Saunders, J.; Vickers, J.; Zhang, Y.; De
     Stefano, N.; Brady, J. M. & Matthews, P. M. Advances in functional and
     structural MR image analysis and implementation as FSL. NeuroImage, 2004,
     23, S208-S219

     * If performing recombination of diffusion-weighted volume pairs with
     opposing phase encoding directions:
     Skare, S. & Bammer, R. Jacobian weighting of distortion corrected EPI data.
     Proceedings of the International Society for Magnetic Resonance in
     Medicine, 2010, 5063

     * If performing EPI susceptibility distortion correction:
     Andersson, J. L.; Skare, S. & Ashburner, J. How to correct susceptibility
     distortions in spin-echo echo-planar images: application to diffusion
     tensor imaging. NeuroImage, 2003, 20, 870-888

     * If including "--repol" in -eddy_options input:
     Andersson, J. L. R.; Graham, M. S.; Zsoldos, E. & Sotiropoulos, S. N.
     Incorporating outlier detection and replacement into a non-parametric
     framework for movement and distortion correction of diffusion MR images.
     NeuroImage, 2016, 141, 556-572

     * If including "--mporder" in -eddy_options input:
     Andersson, J. L. R.; Graham, M. S.; Drobnjak, I.; Zhang, H.; Filippini, N.
     & Bastiani, M. Towards a comprehensive framework for movement and
     distortion correction of diffusion MR images: Within volume movement.
     NeuroImage, 2017, 152, 450-466

     * If using -eddyqc_test or -eddyqc_all option and eddy_quad is installed:
     Bastiani, M.; Cottaar, M.; Fitzgibbon, S.P.; Suri, S.; Alfaro-Almagro, F.;
     Sotiropoulos, S.N.; Jbabdi, S.; Andersson, J.L.R. Automated quality control
     for within and between studies diffusion MRI data using a non-parametric
     framework for movement and distortion correction. NeuroImage, 2019, 184,
     801-812

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5ttgen_gif

### Tool Description
Generate the 5TT image based on a Geodesic Information Flow (GIF) segmentation image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       5ttgen gif

     5ttgen gif: part of the MRtrix3 package

SYNOPSIS

     Generate the 5TT image based on a Geodesic Information Flow (GIF)
     segmentation image

USAGE

     5ttgen gif [ options ] input output

        input        The input Geodesic Information Flow (GIF) segmentation
                     image

        output       The output 5TT image

Options common to all 5ttgen algorithms

  -nocrop
     Do NOT crop the resulting 5TT image to reduce its size (keep the same
     dimensions as the input image)

  -sgm_amyg_hipp
     Represent the amygdalae and hippocampi as sub-cortical grey matter in the
     5TT image

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Matteo Mancini (m.mancini@ucl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. Anatomically-
     constrained tractography: Improved diffusion MRI streamlines tractography
     through effective use of anatomical information. NeuroImage, 2012, 62,
     1924-1938

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_5ttgen_hsvs

### Tool Description
Generate a 5TT image based on Hybrid Surface and Volume Segmentation (HSVS), using FreeSurfer and FSL tools

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       5ttgen hsvs

     5ttgen hsvs: part of the MRtrix3 package

SYNOPSIS

     Generate a 5TT image based on Hybrid Surface and Volume Segmentation
     (HSVS), using FreeSurfer and FSL tools

USAGE

     5ttgen hsvs [ options ] input output

        input        The input FreeSurfer subject directory

        output       The output 5TT image

OPTIONS

  -template TEMPLATE
     Provide an image that will form the template for the generated 5TT image

  -hippocampi HIPPOCAMPI
     Select method to be used for hippocampi (& amygdalae) segmentation; options
     are: subfields,first,aseg

  -thalami THALAMI
     Select method to be used for thalamic segmentation; options are:
     nuclei,first,aseg

  -white_stem
     Classify the brainstem as white matter; streamlines will not be permitted
     to terminate within this region

Options common to all 5ttgen algorithms

  -nocrop
     Do NOT crop the resulting 5TT image to reduce its size (keep the same
     dimensions as the input image)

  -sgm_amyg_hipp
     Represent the amygdalae and hippocampi as sub-cortical grey matter in the
     5TT image

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. Anatomically-
     constrained tractography: Improved diffusion MRI streamlines tractography
     through effective use of anatomical information. NeuroImage, 2012, 62,
     1924-1938

     Smith, R.; Skoch, A.; Bajada, C.; Caspers, S.; Connelly, A. Hybrid Surface-
     Volume Segmentation for improved Anatomically-Constrained Tractography. In
     Proc OHBM 2020

     Fischl, B. Freesurfer. NeuroImage, 2012, 62(2), 774-781

     * If FreeSurfer hippocampal subfields module is utilised:
     Iglesias, J.E.; Augustinack, J.C.; Nguyen, K.; Player, C.M.; Player, A.;
     Wright, M.; Roy, N.; Frosch, M.P.; Mc Kee, A.C.; Wald, L.L.; Fischl, B.;
     and Van Leemput, K. A computational atlas of the hippocampal formation
     using ex vivo, ultra-high resolution MRI: Application to adaptive
     segmentation of in vivo MRI. NeuroImage, 2015, 115, 117-137

     * If FreeSurfer hippocampal subfields module is utilised and includes
     amygdalae segmentation:
     Saygin, Z.M. & Kliemann, D.; Iglesias, J.E.; van der Kouwe, A.J.W.; Boyd,
     E.; Reuter, M.; Stevens, A.; Van Leemput, K.; Mc Kee, A.; Frosch, M.P.;
     Fischl, B.; Augustinack, J.C. High-resolution magnetic resonance imaging
     reveals nuclei of the human amygdala: manual segmentation to automatic
     atlas. NeuroImage, 2017, 155, 370-382

     * If -thalami nuclei is used:
     Iglesias, J.E.; Insausti, R.; Lerma-Usabiaga, G.; Bocchetta, M.; Van
     Leemput, K.; Greve, D.N.; van der Kouwe, A.; ADNI; Fischl, B.; Caballero-
     Gaudes, C.; Paz-Alonso, P.M. A probabilistic atlas of the human thalamic
     nuclei combining ex vivo MRI and histology. NeuroImage, 2018, 183, 314-326

     * If ACPCDetect is installed:
     Ardekani, B.; Bachman, A.H. Model-based automatic detection of the anterior
     and posterior commissures on MRI scans. NeuroImage, 2009, 46(3), 677-682

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_connectome2tck

### Tool Description
Extract streamlines from a tractogram based on their assignment to parcellated nodes

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     connectome2tck                      Oct 21 2025

     connectome2tck: part of the MRtrix3 package

SYNOPSIS

     Extract streamlines from a tractogram based on their assignment to
     parcellated nodes

USAGE

     connectome2tck [ options ] tracks_in assignments_in prefix_out

        tracks_in    the input track file

        assignments_in  input text file containing the node assignments for
                     each streamline

        prefix_out   the output file / prefix


DESCRIPTION

     The compulsory input file "assignments_in" should contain a text file
     where there is one row for each streamline, and each row contains a list
     of numbers corresponding to the parcels to which that streamline was
     assigned (most typically there will be two entries per streamline, one for
     each endpoint; but this is not strictly a requirement). This file will
     most typically be generated using the tck2connectome command with the
     -out_assignments option.

EXAMPLE USAGES

     Default_usage:
       $ connectome2tck tracks.tck assignments.txt edge-
     The command will generate one track file for every edge in the connectome,
     with the name of each file indicating the nodes connected via that edge;
     for instance, all streamlines connecting nodes 23 and 49 will be written
     to file "edge-23-49.tck".

     Extract_only_the_streamlines_between_nodes_1_and_2:
       $ connectome2tck tracks.tck assignments.txt tracks_1_2.tck -nodes 1,2 -exclusive -files single
     Since only a single edge is of interest, this example provides only the
     two nodes involved in that edge to the -nodes option, adds the -exclusive
     option so that only streamlines for which both assigned nodes are in the
     list of nodes of interest are extracted (i.e. only streamlines connecting
     nodes 1 and 2 in this example), and writes the result to a single output
     track file.

     Extract_the_streamlines_connecting_node_15_to_all_other_nodes_in_the_
     parcellation,_with_one_track_file_for_each_edge:
       $ connectome2tck tracks.tck assignments.txt from_15_to_ -nodes 15 -keep_self
     The command will generate the same number of track files as there are
     nodes in the parcellation: one each for the streamlines connecting node 15
     to every other node; i.e. "from_15_to_1.tck", "from_15_to_2.tck",
     "from_15_to_3.tck", etc.. Because the -keep_self option is specified, file
     "from_15_to_15.tck" will also be generated, containing those streamlines
     that connect to node 15 at both endpoints.

     For_every_node,_generate_a_file_containing_all_streamlines_connected_to_
     that_node:
       $ connectome2tck tracks.tck assignments.txt node -files per_node
     Here the command will generate one track file for every node in the
     connectome: "node1.tck", "node2.tck", "node3.tck", etc.. Each of these
     files will contain all streamlines that connect the node of that index to
     another node in the connectome (it does not select all tracks connecting a
     particular node, since the -keep_self option was omitted and therefore
     e.g. a streamline that is assigned to node 41 will not be present in file
     "node41.tck"). Each streamline in the input tractogram will in fact appear
     in two different output track files; e.g. a streamline connecting nodes 8
     and 56 will be present both in file "node8.tck" and file "node56.tck".

     Get_all_streamlines_that_were_not_successfully_assigned_to_a_node_pair:
       $ connectome2tck tracks.tck assignments.txt unassigned.tck -nodes 0 -keep_self -files single
     Node index 0 corresponds to streamline endpoints that were not
     successfully assigned to a node. As such, by selecting all streamlines
     that are assigned to "node 0" (including those streamlines for which
     neither endpoint is assigned to a node due to use of the -keep_self
     option), the single output track file will contain all streamlines for
     which at least one of the two endpoints was not successfully assigned to a
     node.

     Generate_a_single_track_file_containing_edge_exemplar_trajectories:
       $ connectome2tck tracks.tck assignments.txt exemplars.tck -files single -exemplars nodes.mif
     This produces the track file that is required as input when attempting to
     display connectome edges using the streamlines or streamtubes geometries
     within the meview connectome tool.

Options for determining the content / format of output files

  -nodes list
     only select tracks that involve a set of nodes of interest (provide as a
     comma-separated list of integers)

  -exclusive
     only select tracks that exclusively connect nodes from within the list of
     nodes of interest

  -files option
     select how the resulting streamlines will be grouped in output files.
     Options are: per_edge, per_node, single (default: per_edge)

  -exemplars image
     generate a mean connection exemplar per edge, rather than keeping all
     streamlines (the parcellation node image must be provided in order to
     constrain the exemplar endpoints)

  -keep_unassigned
     by default, the program discards those streamlines that are not
     successfully assigned to a node. Set this option to generate corresponding
     outputs containing these streamlines (labelled as node index 0)

  -keep_self
     by default, the program will not output streamlines that connect to the
     same node at both ends. Set this option to instead keep these
     self-connections.

Options for importing / exporting streamline weights

  -tck_weights_in path
     specify a text scalar file containing the streamline weights

  -prefix_tck_weights_out prefix
     provide a prefix for outputting a text file corresponding to each output
     file, each containing only the streamline weights relevant for that track
     file

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_connectomestats

### Tool Description
Connectome group-wise statistics at the edge level using non-parametric permutation testing

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     connectomestats                     Oct 21 2025

     connectomestats: part of the MRtrix3 package

SYNOPSIS

     Connectome group-wise statistics at the edge level using non-parametric
     permutation testing

USAGE

     connectomestats [ options ] input algorithm design contrast output

        input        a text file listing the file names of the input
                     connectomes

        algorithm    the algorithm to use in network-based
                     clustering/enhancement. Options are: nbs, tfnbs, none

        design       the design matrix

        contrast     the contrast matrix

        output       the filename prefix for all output.


DESCRIPTION

     For the TFNBS algorithm, default parameters for statistical enhancement
     have been set based on the work in:
     Vinokur, L.; Zalesky, A.; Raffelt, D.; Smith, R.E. & Connelly, A. A Novel
     Threshold-Free Network-Based Statistics Method: Demonstration using
     Simulated Pathology. OHBM, 2015, 4144;
     and:
     Vinokur, L.; Zalesky, A.; Raffelt, D.; Smith, R.E. & Connelly, A. A novel
     threshold-free network-based statistical method: Demonstration and
     parameter optimisation using in vivo simulated pathology. In Proc ISMRM,
     2015, 2846.
     Note however that not only was the optimisation of these parameters not
     very precise, but the outcomes of statistical inference (for both this
     algorithm and the NBS method) can vary markedly for even small changes to
     enhancement parameters. Therefore the specificity of results obtained
     using either of these methods should be interpreted with caution.

     In some software packages, a column of ones is automatically added to the
     GLM design matrix; the purpose of this column is to estimate the "global
     intercept", which is the predicted value of the observed variable if all
     explanatory variables were to be zero. However there are rare situations
     where including such a column would not be appropriate for a particular
     experimental design. Hence, in MRtrix3 statistical inference commands, it
     is up to the user to determine whether or not this column of ones should
     be included in their design matrix, and add it explicitly if necessary.
     The contrast matrix must also reflect the presence of this additional
     column.

Options relating to shuffling of data for nonparametric statistical inference

  -notest
     don't perform statistical inference; only output population statistics
     (effect size, stdev etc)

  -errors spec
     specify nature of errors for shuffling; options are: ee,ise,both (default:
     ee)

  -exchange_within file
     specify blocks of observations within each of which data may undergo
     restricted exchange

  -exchange_whole file
     specify blocks of observations that may be exchanged with one another (for
     independent and symmetric errors, sign-flipping will occur block-wise)

  -strong
     use strong familywise error control across multiple hypotheses

  -nshuffles number
     the number of shuffles (default: 5000)

  -permutations file
     manually define the permutations (relabelling). The input should be a text
     file defining a m x n matrix, where each relabelling is defined as a
     column vector of size m, and the number of columns, n, defines the number
     of permutations. Can be generated with the palm_quickperms function in
     PALM (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM). Overrides the
     -nshuffles option.

  -nonstationarity
     perform empirical non-parametric non-stationarity correction

  -skew_nonstationarity value
     specify the skew parameter for empirical statistic calculation (default
     for this command is 1)

  -nshuffles_nonstationarity number
     the number of shuffles to use when precomputing the empirical statistic
     image for non-stationarity correction (default: 5000)

  -permutations_nonstationarity file
     manually define the permutations (relabelling) for computing the emprical
     statistics for non-stationarity correction. The input should be a text
     file defining a m x n matrix, where each relabelling is defined as a
     column vector of size m, and the number of columns, n, defines the number
     of permutations. Can be generated with the palm_quickperms function in
     PALM (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM) Overrides the
     -nshuffles_nonstationarity option.

Options for controlling TFCE behaviour

  -tfce_dh value
     the height increment used in the tfce integration (default: 0.1)

  -tfce_e value
     tfce extent exponent (default: 0.4)

  -tfce_h value
     tfce height exponent (default: 3)

Options related to the General Linear Model (GLM)

  -variance file
     define variance groups for the G-statistic; measurements for which the
     expected variance is equivalent should contain the same index

  -ftests path
     perform F-tests; input text file should contain, for each F-test, a row
     containing ones and zeros, where ones indicate the rows of the contrast
     matrix to be included in the F-test.

  -fonly
     only assess F-tests; do not perform statistical inference on entries in
     the contrast matrix

  -column path  (multiple uses permitted)
     add a column to the design matrix corresponding to subject edge-wise
     values (note that the contrast matrix must include an additional column
     for each use of this option); the text file provided via this option
     should contain a file name for each subject

Additional options for connectomestats

  -threshold value
     the t-statistic value to use in threshold-based clustering algorithms

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If using the NBS algorithm:
     Zalesky, A.; Fornito, A. & Bullmore, E. T. Network-based statistic:
     Identifying differences in brain networks.
     NeuroImage, 2010, 53, 1197-1207

     * If using the TFNBS algorithm:
     Baggio, H.C.; Abos, A.; Segura, B.; Campabadal, A.; Garcia-Diaz, A.;
     Uribe, C.; Compta, Y.; Marti, M.J.; Valldeoriola, F.; Junque, C.
     Statistical inference in brain graphs using threshold-free network-based
     statistics.HBM, 2018, 39, 2289-2302

     * If using the -nonstationary option:
     Salimi-Khorshidi, G.; Smith, S.M. & Nichols, T.E. Adjusting the effect of
     nonstationarity in cluster-based and TFCE inference.
     Neuroimage, 2011, 54(3), 2006-19

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dcminfo

### Tool Description
Output DICOM fields in human-readable format

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dcminfo                         Oct 21 2025

     dcminfo: part of the MRtrix3 package

SYNOPSIS

     Output DICOM fields in human-readable format

USAGE

     dcminfo [ options ] file

        file         the DICOM file to be scanned.


OPTIONS

  -all
     print all DICOM fields.

  -csa
     print all Siemens CSA fields (excluding Phoenix unless requested)

  -phoenix
     print Siemens Phoenix protocol information

  -tag group element  (multiple uses permitted)
     print field specified by the group & element tags supplied. Tags should be
     supplied as Hexadecimal (i.e. as they appear in the -all listing).

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_dcmedit

### Tool Description
Edit DICOM file in-place

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         dcmedit                         Oct 21 2025

     dcmedit: part of the MRtrix3 package

SYNOPSIS

     Edit DICOM file in-place

USAGE

     dcmedit [ options ] file

        file         the DICOM file to be edited.


DESCRIPTION

     Note that this command simply replaces the existing values without
     modifying the DICOM structure in any way. Replacement text will be
     truncated if it is too long to fit inside the existing tag.

     WARNING: this command will modify existing data! It is recommended to run
     this command on a copy of the original data set to avoid loss of data.

OPTIONS

  -anonymise
     remove any identifiable information, by replacing the following tags:
     - any tag with Value Representation PN will be replaced with 'anonymous'
     - tag (0010,0030) PatientBirthDate will be replaced with an empty string
     WARNING: there is no guarantee that this command will remove all
     identiable information, since such information may be contained in any
     number of private vendor-specific tags. You will need to double-check the
     results independently if you need to ensure anonymity.

  -id text
     replace all ID tags with string supplied. This consists of tags (0010,
     0020) PatientID and (0010, 1000) OtherPatientIDs

  -tag group element newvalue  (multiple uses permitted)
     replace specific tag.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_convert_bruker

### Tool Description
Convert Bruker 2dseq data to an MRtrix image. The command prints only a usage line as help.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: convert_bruker 2dseq header.mih
```

## mrtrix3_gen_scheme

### Tool Description
Generate a diffusion gradient table (dw_scheme.txt) with optimally distributed directions

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text

    gen_scheme: part of the MRtrix package

SYNOPSIS

    gen_scheme numPE [ bvalue ndir ]...

       numPE        the number of phase-encoding directions to be included in
                    the scheme (most scanners will only support a single PE
                    direction per sequence, so this will typically be 1).

       bvalue       the b-value of the shell

       ndir         the number of directions to include in the shell


DESCRIPTION

    This script generates a diffusion gradient table according to the
    parameters specified. For most users, something like the following would be
    appropriate:

        gen_scheme 1 0 5 750 20 3000 60

    which will geneate a multi-shell diffusion gradient table with a single
    phase-encode direction, consisting of 5 b=0, 20 b=750, and 60 b=3000
    volumes.

    The gradient table is generated using the following procedure:

    - The directions for each shell are optimally distributed using a bipolar
      electrostatic repulsion model (using the command 'dirgen').

    - These are then split into numPE sets (if numPE != 1) using a brute-force
      random search for the most optimally-distributed subsets (using the command
      'dirsplit').

    - Each of the resulting sets is then rearranged by inversion of individual
      directions through the origin (i.e. direction vector x => -x) using a
      brute-force random search to find the most optimal combination in terms
      of unipolar repulsion: this ensures near-uniform distribution over the
      sphere to avoid biases in terms of eddy-current distortions, as
      recommended for FSL's EDDY command (this step uses the 'dirflip' command).

    - Finally, all the individual subsets are merged (using the 'dirmerge'
      command) into a single gradient table, in such a way as to maintain
      near-uniformity upon truncation (in as much as is possible), in both
      b-value and directional domains. In other words, the approach aims to
      ensure that if the acquisition is cut short, the set of volumes acquired
      nonetheless contains the same relative proportions of b-values as
      specified, with directions that are near-uniformly distributed.

    The primary output of this command is a file called 'dw_scheme.txt',
    consisting of a 5-column table, with one line per volume. Each column
    consists of [ x y z b PE ], where [ x y z ] is the unit direction vector, b
    is the b-value in unit of s/mm², and PE is a integer ID from 1 to numPE.

    The command also retains all of the subsets generated along the way, which
    you can safely delete once the command has completed. Since this can
    consist of quite a few files, it is recommended to run this command within
    its own temporary folder.

    See also the 'dirstat' command to obtain simple metrics of quality for the
    set produced.
```

## mrtrix3_fixelfilter

### Tool Description
Perform filtering operations on fixel-based data

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       fixelfilter                       Oct 21 2025

     fixelfilter: part of the MRtrix3 package

SYNOPSIS

     Perform filtering operations on fixel-based data

USAGE

     fixelfilter [ options ] input filter output

        input        the input: either a fixel data file, or a fixel directory
                     (see Description)

        filter       the filtering operation to perform; options are: connect,
                     smooth

        output       the output: either a fixel data file, or a fixel directory
                     (see Description)


DESCRIPTION

     If the first input to the command is a specific fixel data file, then a
     filtered version of only that file will be generated by the command.
     Alternatively, if the input is the location of a fixel directory, then the
     command will create a duplicate of the fixel directory, and apply the
     specified filter operation to all fixel data files within the directory.

OPTIONS

  -matrix file
     provide a fixel-fixel connectivity matrix for filtering operations that
     require it

Options specific to the "connect" filter

  -threshold_value value
     specify a threshold for the input fixel data file values (default = 0.5)

  -threshold_connectivity value
     specify a fixel-fixel connectivity threshold for connected-component
     analysis (default = 0.10000000000000001)

Options specific to the "smooth" filter

  -fwhm value
     the full-width half-maximum (FWHM) of the spatial component of the
     smoothing filter (default = 10mm)

  -minweight value
     apply a minimum threshold to smoothing weights (default = 0.01)

  -mask image
     only perform smoothing within a specified binary fixel mask

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fixelreorient

### Tool Description
Reorient fixel directions

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      fixelreorient                      Oct 21 2025

     fixelreorient: part of the MRtrix3 package

SYNOPSIS

     Reorient fixel directions

USAGE

     fixelreorient [ options ] fixel_in warp fixel_out

        fixel_in     the input fixel directory

        warp         a 4D deformation field used to perform reorientation.
                     Reorientation is performed by applying the Jacobian affine
                     transform in each voxel in the warp, then re-normalising
                     the vector representing the fixel direction

        fixel_out    the output fixel directory. If the the input and output
                     directories are the same, the existing directions file
                     will be replaced (providing the -force option is
                     supplied). If a new directory is supplied then the fixel
                     directions and all other fixel data will be copied to the
                     new directory.


DESCRIPTION

     Reorientation is performed by transforming the vector representing the
     fixel direction with the Jacobian (local affine transform) computed at
     each voxel in the warp, then re-normalising the vector.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fod2dec

### Tool Description
Generate FOD-based DEC maps, with optional panchromatic sharpening and/or luminance/perception correction

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         fod2dec                         Oct 21 2025

     fod2dec: part of the MRtrix3 package

SYNOPSIS

     Generate FOD-based DEC maps, with optional panchromatic sharpening and/or
     luminance/perception correction

USAGE

     fod2dec [ options ] input output

        input        The input FOD image (spherical harmonic coefficients).

        output       The output DEC image (weighted RGB triplets).


DESCRIPTION

     By default, the FOD-based DEC is weighted by the integral of the FOD. To
     weight by another scalar map, use the -contrast option. This option can
     also be used for panchromatic sharpening, e.g., by supplying a T1 (or
     other sensible) anatomical volume with a higher spatial resolution.

OPTIONS

  -mask image
     Only perform DEC computation within the specified mask image.

  -contrast image
     Weight the computed DEC map by the provided image contrast. If the
     contrast has a different image grid, the DEC map is first resliced and
     renormalised. To achieve panchromatic sharpening, provide an image with a
     higher spatial resolution than the input FOD image; e.g., a T1 anatomical
     volume. Only the DEC is subject to the mask, so as to allow for partial
     colouring of the contrast image.
     Default when this option is *not* provided: integral of input FOD, subject
     to the same mask/threshold as used for DEC computation.

  -lum
     Correct for luminance/perception, using default values Cr,Cg,Cb =
     0.3,0.5,0.2 and gamma = 2.2 (*not* correcting is the theoretical
     equivalent of Cr,Cg,Cb = 1,1,1 and gamma = 2).

  -lum_coefs values
     The coefficients Cr,Cg,Cb to correct for luminance/perception.
     Note: this implicitly switches on luminance/perception correction, using a
     default gamma = 2.2 unless specified otherwise.

  -lum_gamma value
     The gamma value to correct for luminance/perception.
     Note: this implicitly switches on luminance/perception correction, using a
     default Cr,Cg,Cb = 0.3,0.5,0.2 unless specified otherwise.

  -threshold value
     FOD amplitudes below the threshold value are considered zero.

  -no_weight
     Do not weight the DEC map; just output the unweighted colours. Reslicing
     and renormalising of colours will still happen when providing the
     -contrast option as a template.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Thijs Dhollander (thijs.dhollander@gmail.com)

COPYRIGHT
     Copyright (C) 2014 The Florey Institute of Neuroscience and Mental Health,
     Melbourne, Australia. This is free software; see the source for copying
     conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS
     FOR A PARTICULAR PURPOSE.

REFERENCES
     Dhollander T, Smith RE, Tournier JD, Jeurissen B, Connelly A. Time to move
     on: an FOD-based DEC map to replace DTI's trademark DEC FA. Proc Intl Soc
     Mag Reson Med, 2015, 23, 1027

     Dhollander T, Raffelt D, Smith RE, Connelly A. Panchromatic sharpening of
     FOD-based DEC maps by structural T1 information. Proc Intl Soc Mag Reson
     Med, 2015, 23, 566

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_fod2fixel

### Tool Description
Perform segmentation of continuous Fibre Orientation Distributions (FODs) to produce discrete fixels

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        fod2fixel                        Oct 21 2025

     fod2fixel: part of the MRtrix3 package

SYNOPSIS

     Perform segmentation of continuous Fibre Orientation Distributions (FODs)
     to produce discrete fixels

USAGE

     fod2fixel [ options ] fod fixel_directory

        fod          the input fod image.

        fixel_directory  the output fixel directory


Metric values for fixel-based sparse output images

  -afd image
     output the total Apparent Fibre Density per fixel (integral of FOD lobe)

  -peak_amp image
     output the amplitude of the FOD at the maximal peak per fixel

  -disp image
     output a measure of dispersion per fixel as the ratio between FOD lobe
     integral and maximal peak amplitude

FOD FMLS segmenter options

  -fmls_integral value
     threshold absolute numerical integral of positive FOD lobes. Any lobe for
     which the integral is smaller than this threshold will be discarded.
     Default: 0.

  -fmls_peak_value value
     threshold peak amplitude of positive FOD lobes. Any lobe for which the
     maximal peak amplitude is smaller than this threshold will be discarded.
     Default: 0.1.

  -fmls_no_thresholds
     disable all FOD lobe thresholding; every lobe where the FOD is positive
     will be retained.

  -fmls_lobe_merge_ratio value
     Specify the ratio between a given FOD amplitude sample between two lobes,
     and the smallest peak amplitude of the adjacent lobes, above which those
     lobes will be merged. This is the amplitude of the FOD at the 'bridge'
     point between the two lobes, divided by the peak amplitude of the smaller
     of the two adjoining lobes. A value of 1.0 will never merge two lobes into
     one; a value of 0.0 will always merge lobes unless they are bisected by a
     zero-valued crossing. Default: 1.

Other options for fod2fixel

  -mask image
     only perform computation within the specified binary brain mask image.

  -maxnum number
     maximum number of fixels to output for any particular voxel (default: no
     limit)

  -nii
     output the directions and index file in nii format (instead of the default
     mif)

  -dirpeak
     define the fixel direction as that of the lobe's maximal peak as opposed
     to its weighted mean direction (the default)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * Reference for the FOD segmentation method:
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. SIFT:
     Spherical-deconvolution informed filtering of tractograms. NeuroImage,
     2013, 67, 298-312 (Appendix 2)

     * Reference for Apparent Fibre Density (AFD):
     Raffelt, D.; Tournier, J.-D.; Rose, S.; Ridgway, G.R.; Henderson, R.;
     Crozier, S.; Salvado, O.; Connelly, A. Apparent Fibre Density: a novel
     measure for the analysis of diffusion-weighted magnetic resonance
     images.Neuroimage, 2012, 15;59(4), 3976-94

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_for_each

### Tool Description
Perform some arbitrary processing step for each of a set of inputs

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        for_each

     for_each: part of the MRtrix3 package

SYNOPSIS

     Perform some arbitrary processing step for each of a set of inputs

USAGE

     for_each [ options ] inputs colon command

        inputs       Each of the inputs for which processing should be run

        colon        Colon symbol (":") delimiting the for_each inputs &
                     command-line options from the actual command to be executed

        command      The command string to run for each input, containing any
                     number of substitutions listed in the Description section

DESCRIPTION

     This script greatly simplifies various forms of batch processing by
     enabling the execution of a command (or set of commands) independently for
     each of a set of inputs. Part of the way that this is achieved is by
     providing basic text substitutions, which simplify the formation of valid
     command strings based on the unique components of the input strings on
     which the script is instructed to execute. The available substitutions are
     listed below (note that the -test command-line option can be used to ensure
     correct command string formation prior to actually executing the commands):

        - IN:   The full matching pattern, including leading folders. For
     example, if the target list contains a file "folder/image.mif", any
     occurrence of "IN" will be substituted with "folder/image.mif".

        - NAME: The basename of the matching pattern. For example, if the target
     list contains a file "folder/image.mif", any occurrence of "NAME" will be
     substituted with "image.mif".

        - PRE:  The prefix of the input pattern (the basename stripped of its
     extension). For example, if the target list contains a file
     "folder/my.image.mif.gz", any occurrence of "PRE" will be substituted with
     "my.image".

        - UNI:  The unique part of the input after removing any common prefix
     and common suffix. For example, if the target list contains files:
     "folder/001dwi.mif", "folder/002dwi.mif", "folder/003dwi.mif", any
     occurrence of "UNI" will be substituted with "001", "002", "003".

     Note that due to a limitation of the Python "argparse" module, any command-
     line OPTIONS that the user intends to provide specifically to the for_each
     script must appear BEFORE providing the list of inputs on which for_each is
     intended to operate. While command-line options provided as such will be
     interpreted specifically by the for_each script, any command-line options
     that are provided AFTER the COLON separator will form part of the executed
     COMMAND, and will therefore be interpreted as command-line options having
     been provided to that underlying command.

EXAMPLE USAGES

     Demonstration_of_basic_usage_syntax:
       $ for_each folder/*.mif : mrinfo IN
     This will run the "mrinfo" command for every .mif file present in
     "folder/". Note that the compulsory colon symbol is used to separate the
     list of items on which for_each is being instructed to operate, from the
     command that is intended to be run for each input.

     Multi-threaded_use_of_for_each:
       $ for_each -nthreads 4 freesurfer/subjects/* : recon-all -subjid NAME -all
     In this example, for_each is instructed to run the FreeSurfer command
     'recon-all' for all subjects within the 'subjects' directory, with four
     subjects being processed in parallel at any one time. Whenever processing
     of one subject is completed, processing for a new unprocessed subject will
     commence. This technique is useful for improving the efficiency of running
     single-threaded commands on multi-core systems, as long as the system
     possesses enough memory to support such parallel processing. Note that in
     the case of multi-threaded commands (which includes many MRtrix3 commands),
     it is generally preferable to permit multi-threaded execution of the
     command on a single input at a time, rather than processing multiple inputs
     in parallel.

     Excluding_specific_inputs_from_execution:
       $ for_each *.nii -exclude 001.nii : mrconvert IN PRE.mif
     Particularly when a wildcard is used to define the list of inputs for
     for_each, it is possible in some instances that this list will include one
     or more strings for which execution should in fact not be performed; for
     instance, if a command has already been executed for one or more files, and
     then for_each is being used to execute the same command for all other
     files. In this case, the -exclude option can be used to effectively remove
     an item from the list of inputs that would otherwise be included due to the
     use of a wildcard (and can be used more than once to exclude more than one
     string). In this particular example, mrconvert is instructed to perform
     conversions from NIfTI to MRtrix image formats, for all except the first
     image in the directory. Note that any usages of this option must appear
     AFTER the list of inputs. Note also that the argument following the
     -exclude option can alternatively be a regular expression, in which case
     any inputs for which a match to the expression is found will be excluded
     from processing.

     Testing_the_command_string_substitution:
       $ for_each -test * : mrconvert IN PRE.mif
     By specifying the -test option, the script will print to the terminal the
     results of text substitutions for all of the specified inputs, but will not
     actually execute those commands. It can therefore be used to verify that
     the script is receiving the intended set of inputs, and that the text
     substitutions on those inputs lead to the intended command strings.

     Utilising_shell_operators_within_the_command_substitution:
       $ for_each * : tensor2metric IN/dwi.mif - "|" tensor2metric - -fa IN/fa.mif
     In this example, if the double-quotes were NOT placed around the pipe
     operator, then the shell would take the sum total output of the for_each
     script and pipe that to a single invocation of the tensor2metric command.
     Since in this example it is instead desired for the pipe operator to be a
     part of the command string that is executed multiple times by the for_each
     script, it must be escaped using double-quotes.

OPTIONS

  -exclude "regex"  (multiple uses permitted)
     Exclude one specific input string / all strings matching a regular
     expression from being processed (see Example Usage)

  -test
     Test the operation of the for_each script, by printing the command strings
     following string substitution but not actually executing them

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and David Raffelt
     (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_label2colour

### Tool Description
Convert a parcellated image (where values are node indices) into a colour image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      label2colour                       Oct 21 2025

     label2colour: part of the MRtrix3 package

SYNOPSIS

     Convert a parcellated image (where values are node indices) into a colour
     image

USAGE

     label2colour [ options ] nodes_in colour_out

        nodes_in     the input node parcellation image

        colour_out   the output colour image


DESCRIPTION

     Many software packages handle this colouring internally within their
     viewer program; this binary explicitly converts a parcellation image into
     a colour image that should be viewable in any software.

OPTIONS

  -lut file
     Provide the relevant colour lookup table (if not provided, nodes will be
     coloured randomly)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_label2mesh

### Tool Description
Generate meshes from a label image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       label2mesh                        Oct 21 2025

     label2mesh: part of the MRtrix3 package

SYNOPSIS

     Generate meshes from a label image

USAGE

     label2mesh [ options ] nodes_in mesh_out

        nodes_in     the input node parcellation image

        mesh_out     the output mesh file


OPTIONS

  -blocky
     generate 'blocky' meshes with precise delineation of voxel edges, rather
     than the default Marching Cubes approach

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_labelconvert

### Tool Description
Convert a connectome node image from one lookup table to another

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                      labelconvert                       Oct 21 2025

     labelconvert: part of the MRtrix3 package

SYNOPSIS

     Convert a connectome node image from one lookup table to another

USAGE

     labelconvert [ options ] path_in lut_in lut_out image_out

        path_in      the input image

        lut_in       the connectome lookup table corresponding to the input
                     image

        lut_out      the target connectome lookup table for the output image

        image_out    the output image


DESCRIPTION

     Typical usage is to convert a parcellation image provided by some other
     software, based on the lookup table provided by that software, to conform
     to a new lookup table, particularly one where the node indices increment
     from 1, in preparation for connectome construction; examples of such
     target lookup table files are provided in share//mrtrix3//labelconvert//,
     but can be created by the user to provide the desired node set // ordering
     // colours.

EXAMPLE USAGES

     Convert_a_Desikan-Killiany_parcellation_image_as_provided_by_FreeSurfer_to_
     have_nodes_incrementing_from_1:
       $ labelconvert aparc+aseg.mgz FreeSurferColorLUT.txt mrtrix3//share//mrtrix3//labelconvert//fs_default.txt nodes.mif
     Paths to the files in the example above would need to be revised according
     to their locations on the user's system.

OPTIONS

  -spine image
     provide a manually-defined segmentation of the base of the spine where the
     streamlines terminate, so that this can become a node in the connection
     matrix.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_labelstats

### Tool Description
Compute statistics of parcels within a label image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       labelstats                        Oct 21 2025

     labelstats: part of the MRtrix3 package

SYNOPSIS

     Compute statistics of parcels within a label image

USAGE

     labelstats [ options ] input

        input        the input label image


OPTIONS

  -output choice
     output only the field specified; options are: mass,centre

  -voxelspace
     report parcel centres of mass in voxel space rather than scanner space

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_maskdump

### Tool Description
Print out the locations of all non-zero voxels in a mask image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        maskdump                         Oct 21 2025

     maskdump: part of the MRtrix3 package

SYNOPSIS

     Print out the locations of all non-zero voxels in a mask image

USAGE

     maskdump [ options ] input [ output ]

        input        the input image.

        output       the (optional) output text file.


DESCRIPTION

     If no destination file is specified, the voxel locations will be printed
     to stdout.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_maskfilter

### Tool Description
Perform filtering operations on 3D / 4D mask images

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       maskfilter                        Oct 21 2025

     maskfilter: part of the MRtrix3 package

SYNOPSIS

     Perform filtering operations on 3D / 4D mask images

USAGE

     maskfilter [ options ] input filter output

        input        the input image.

        filter       the type of filter to be applied (clean, connect, dilate,
                     erode, median)

        output       the output image.


DESCRIPTION

     The available filters are: clean, connect, dilate, erode, median.

     Each filter has its own unique set of optional parameters.

Options for mask cleaning filter

  -scale value
     the maximum scale used to cut bridges. A certain maximum scale cuts
     bridges up to a width (in voxels) of 2x the provided scale. (Default: 2)

Options for connected-component filter

  -axes axes
     specify which axes should be included in the connected components. By
     default only the first 3 axes are included. The axes should be provided as
     a comma-separated list of values.

  -largest
     only retain the largest connected component

  -connectivity
     use 26-voxel-neighbourhood connectivity (Default: 6)

Options for dilate / erode filters

  -npass value
     the number of times to repeatedly apply the filter

Options for median filter

  -extent voxels
     specify the extent (width) of kernel size in voxels. This can be specified
     either as a single value to be used for all axes, or as a comma-separated
     list of the extent for each axis. The default is 3x3x3.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au), David Raffelt
     (david.raffelt@florey.edu.au), Thijs Dhollander
     (thijs.dhollander@gmail.com) and J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mesh2voxel

### Tool Description
Convert a mesh surface to a partial volume estimation image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mesh2voxel                        Oct 21 2025

     mesh2voxel: part of the MRtrix3 package

SYNOPSIS

     Convert a mesh surface to a partial volume estimation image

USAGE

     mesh2voxel [ options ] source template output

        source       the mesh file; note vertices must be defined in realspace
                     coordinates

        template     the template image

        output       the output image


Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A.
     Anatomically-constrained tractography: Improved diffusion MRI streamlines
     tractography through effective use of anatomical information. NeuroImage,
     2012, 62, 1924-1938

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_meshconvert

### Tool Description
Convert meshes between different formats, and apply transformations

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       meshconvert                       Oct 21 2025

     meshconvert: part of the MRtrix3 package

SYNOPSIS

     Convert meshes between different formats, and apply transformations

USAGE

     meshconvert [ options ] input output

        input        the input mesh file

        output       the output mesh file


OPTIONS

  -binary
     write the output mesh file in binary format (if supported)

  -transform mode image
     transform vertices from one coordinate space to another, based on a
     template image; options are: first2real, real2first, voxel2real,
     real2voxel, fs2real

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_meshfilter

### Tool Description
Apply filter operations to meshes

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       meshfilter                        Oct 21 2025

     meshfilter: part of the MRtrix3 package

SYNOPSIS

     Apply filter operations to meshes

USAGE

     meshfilter [ options ] input filter output

        input        the input mesh file

        filter       the filter to apply.Options are: smooth

        output       the output mesh file


DESCRIPTION

     While this command has only one filter operation currently available, it
     nevertheless presents with a comparable interface to the MRtrix3 commands
     maskfilter and mrfilter commands.

EXAMPLE USAGES

     Apply_a_mesh_smoothing_filter_(currently_the_only_filter_available:
       $ meshfilter input.vtk smooth output.vtk
     The usage of this command may cause confusion due to the generic interface
     despite only one filtering operation being currently available. This
     simple example usage is therefore provided for clarity.

Options for mesh smoothing filter

  -smooth_spatial value
     spatial extent of smoothing (default: 10mm)

  -smooth_influence value
     influence factor for smoothing (default: 10)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mraverageheader

### Tool Description
Calculate the average (unbiased) coordinate space of all input images

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     mraverageheader                     Oct 21 2025

     mraverageheader: part of the MRtrix3 package

SYNOPSIS

     Calculate the average (unbiased) coordinate space of all input images

USAGE

     mraverageheader [ options ] input [ input ... ] output

        input        the input image(s).

        output       the output image


OPTIONS

  -padding value
      boundary box padding in voxels. Default: 0

  -resolution type
      subsampling of template compared to smallest voxel size in any input
     image. Valid options are 'mean': unbiased but loss of resolution for
     individual images possible, and 'max': smallest voxel size of any input
     image defines the resolution. Default: mean

  -fill
      set the intensity in the first volume of the average space to 1

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Maximilian Pietsch (maximilian.pietsch@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrcalc

### Tool Description
Apply generic voxel-wise mathematical operations to images

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         mrcalc                          Oct 21 2025

     mrcalc: part of the MRtrix3 package

SYNOPSIS

     Apply generic voxel-wise mathematical operations to images

USAGE

     mrcalc [ options ] operand [ operand ... ]

        operand      an input image, intensity value, or the special keywords
                     'rand' (random number between 0 and 1) or 'randn' (random
                     number from unit std.dev. normal distribution) or the
                     mathematical constants 'e' and 'pi'.


DESCRIPTION

     This command will only compute per-voxel operations. Use 'mrmath' to
     compute summary statistics across images or along image axes.

     This command uses a stack-based syntax, with operators (specified using
     options) operating on the top-most entries (i.e. images or values) in the
     stack. Operands (values or images) are pushed onto the stack in the order
     they appear (as arguments) on the command-line, and operators (specified
     as options) operate on and consume the top-most entries in the stack, and
     push their output as a new entry on the stack.

     As an additional feature, this command will allow images with different
     dimensions to be processed, provided they satisfy the following
     conditions: for each axis, the dimensions match if they are the same size,
     or one of them has size one. In the latter case, the entire image will be
     replicated along that axis. This allows for example a 4D image of size [ X
     Y Z N ] to be added to a 3D image of size [ X Y Z ], as if it consisted of
     N copies of the 3D image along the 4th axis (the missing dimension is
     assumed to have size 1). Another example would a single-voxel 4D image of
     size [ 1 1 1 N ], multiplied by a 3D image of size [ X Y Z ], which would
     allow the creation of a 4D image where each volume consists of the 3D
     image scaled by the corresponding value for that volume in the
     single-voxel image.

EXAMPLE USAGES

     Double_the_value_stored_in_every_voxel:
       $ mrcalc a.mif 2 -mult r.mif
     This performs the operation: r = 2*a  for every voxel a,r in images a.mif
     and r.mif respectively.

     A_more_complex_example:
       $ mrcalc a.mif -neg b.mif -div -exp 9.3 -mult r.mif
     This performs the operation: r = 9.3*exp(-a/b)

     Another_complex_example:
       $ mrcalc a.mif b.mif -add c.mif d.mif -mult 4.2 -add -div r.mif
     This performs: r = (a+b)/(c*d+4.2).

     Rescale_the_densities_in_a_SH_l=0_image:
       $ mrcalc ODF_CSF.mif 4 pi -mult -sqrt -div ODF_CSF_scaled.mif
     This applies the spherical harmonic basis scaling factor: 1.0/sqrt(4*pi),
     such that a single-tissue voxel containing the same intensities as the
     response function of that tissue should contain the value 1.0.

     Produce_a_complex_datatype_image_from_Siemens_magnitude_&_phase_series:
       $ mrcalc DWI_MAG/ DWI_PHASE/ pi 4096 -div -mult -polar dwi_complex.mif
     Phase images from Siemens scanners are typically not provided in Radians
     units, but rather contain values in the range [-4096, +4094]. This command
     usage pre-multiplies these phase values by (pi/4096) to get them into
     units of Radians, prior to using the -polar option that combines magnitude
     & phase components at its input to produce complex data.

basic operations

  -abs  (multiple uses permitted)
     |%1| : return absolute value (magnitude) of real or complex number

  -neg  (multiple uses permitted)
     -%1 : negative value

  -add  (multiple uses permitted)
     (%1 + %2) : add values

  -subtract  (multiple uses permitted)
     (%1 - %2) : subtract nth operand from (n-1)th

  -multiply  (multiple uses permitted)
     (%1 * %2) : multiply values

  -divide  (multiple uses permitted)
     (%1 / %2) : divide (n-1)th operand by nth

  -min  (multiple uses permitted)
     min (%1, %2) : smallest of last two operands

  -max  (multiple uses permitted)
     max (%1, %2) : greatest of last two operands

comparison operators

  -lt  (multiple uses permitted)
     (%1 < %2) : less-than operator (true=1, false=0)

  -gt  (multiple uses permitted)
     (%1 > %2) : greater-than operator (true=1, false=0)

  -le  (multiple uses permitted)
     (%1 <= %2) : less-than-or-equal-to operator (true=1, false=0)

  -ge  (multiple uses permitted)
     (%1 >= %2) : greater-than-or-equal-to operator (true=1, false=0)

  -eq  (multiple uses permitted)
     (%1 == %2) : equal-to operator (true=1, false=0)

  -neq  (multiple uses permitted)
     (%1 != %2) : not-equal-to operator (true=1, false=0)

conditional operators

  -if  (multiple uses permitted)
     (%1 ? %2 : %3) : if first operand is true (non-zero), return second
     operand, otherwise return third operand

  -replace  (multiple uses permitted)
     (%1, %2 -> %3) : Wherever first operand is equal to the second operand,
     replace with third operand

power functions

  -sqrt  (multiple uses permitted)
     sqrt (%1) : square root

  -pow  (multiple uses permitted)
     %1^%2 : raise (n-1)th operand to nth power

nearest integer operations

  -round  (multiple uses permitted)
     round (%1) : round to nearest integer

  -ceil  (multiple uses permitted)
     ceil (%1) : round up to nearest integer

  -floor  (multiple uses permitted)
     floor (%1) : round down to nearest integer

logical operators

  -not  (multiple uses permitted)
     !%1 : NOT operator: true (1) if operand is false (i.e. zero)

  -and  (multiple uses permitted)
     (%1 && %2) : AND operator: true (1) if both operands are true (i.e.
     non-zero)

  -or  (multiple uses permitted)
     (%1 || %2) : OR operator: true (1) if either operand is true (i.e.
     non-zero)

  -xor  (multiple uses permitted)
     (%1 ^^ %2) : XOR operator: true (1) if only one of the operands is true
     (i.e. non-zero)

classification functions

  -isnan  (multiple uses permitted)
     isnan (%1) : true (1) if operand is not-a-number (NaN)

  -isinf  (multiple uses permitted)
     isinf (%1) : true (1) if operand is infinite (Inf)

  -finite  (multiple uses permitted)
     finite (%1) : true (1) if operand is finite (i.e. not NaN or Inf)

complex numbers

  -complex  (multiple uses permitted)
     (%1 + %2 i) : create complex number using the last two operands as
     real,imaginary components

  -polar  (multiple uses permitted)
     (%1 /_ %2) : create complex number using the last two operands as
     magnitude,phase components (phase in radians)

  -real  (multiple uses permitted)
     real (%1) : real part of complex number

  -imag  (multiple uses permitted)
     imag (%1) : imaginary part of complex number

  -phase  (multiple uses permitted)
     phase (%1) : phase of complex number (use -abs for magnitude)

  -conj  (multiple uses permitted)
     conj (%1) : complex conjugate

  -proj  (multiple uses permitted)
     proj (%1) : projection onto the Riemann sphere

exponential functions

  -exp  (multiple uses permitted)
     exp (%1) : exponential function

  -log  (multiple uses permitted)
     log (%1) : natural logarithm

  -log10  (multiple uses permitted)
     log10 (%1) : common logarithm

trigonometric functions

  -cos  (multiple uses permitted)
     cos (%1) : cosine

  -sin  (multiple uses permitted)
     sin (%1) : sine

  -tan  (multiple uses permitted)
     tan (%1) : tangent

  -acos  (multiple uses permitted)
     acos (%1) : inverse cosine

  -asin  (multiple uses permitted)
     asin (%1) : inverse sine

  -atan  (multiple uses permitted)
     atan (%1) : inverse tangent

hyperbolic functions

  -cosh  (multiple uses permitted)
     cosh (%1) : hyperbolic cosine

  -sinh  (multiple uses permitted)
     sinh (%1) : hyperbolic sine

  -tanh  (multiple uses permitted)
     tanh (%1) : hyperbolic tangent

  -acosh  (multiple uses permitted)
     acosh (%1) : inverse hyperbolic cosine

  -asinh  (multiple uses permitted)
     asinh (%1) : inverse hyperbolic sine

  -atanh  (multiple uses permitted)
     atanh (%1) : inverse hyperbolic tangent

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrcat

### Tool Description
Concatenate several images into one

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                          mrcat                          Oct 21 2025

     mrcat: part of the MRtrix3 package

SYNOPSIS

     Concatenate several images into one

USAGE

     mrcat [ options ] image1 image2 [ image2 ... ] output

        image1       the first input image.

        image2       additional input image(s).

        output       the output image.


EXAMPLE USAGES

     Concatenate_individual_3D_volumes_into_a_single_4D_image_series:
       $ mrcat volume*.mif series.mif
     The wildcard characters will find all images in the current working
     directory with names that begin with "volume" and end with ".mif"; the
     mrcat command will receive these as a list of input file names, from which
     it will produce a 4D image where the input volumes have been concatenated
     along axis 3 (the fourth axis; the spatial axes are 0, 1 & 2).

OPTIONS

  -axis axis
     specify axis along which concatenation should be performed. By default,
     the program will use the last non-singleton, non-spatial axis of any of
     the input images - in other words axis 3 or whichever axis (greater than
     3) of the input images has size greater than one.

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrcentroid

### Tool Description
Determine the centre of mass / centre of gravity of an image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mrcentroid                        Oct 21 2025

     mrcentroid: part of the MRtrix3 package

SYNOPSIS

     Determine the centre of mass / centre of gravity of an image

USAGE

     mrcentroid [ options ] input

        input        the input image


OPTIONS

  -mask image
     only include voxels within a mask in the calculation

  -voxelspace
     report image centre of mass in voxel space rather than scanner space

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrcheckerboardmask

### Tool Description
Create bitwise checkerboard image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                   mrcheckerboardmask                    Oct 21 2025

     mrcheckerboardmask: part of the MRtrix3 package

SYNOPSIS

     Create bitwise checkerboard image

USAGE

     mrcheckerboardmask [ options ] input output

        input        the input image to be used as a template.

        output       the output binary image mask.


OPTIONS

  -tiles value
     specify the number of tiles in any direction

  -invert
     invert output binary mask.

  -nan
     use NaN as the output zero value.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Max Pietsch (maximilian.pietsch@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrcolour

### Tool Description
Apply a colour map to an image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        mrcolour                         Oct 21 2025

     mrcolour: part of the MRtrix3 package

SYNOPSIS

     Apply a colour map to an image

USAGE

     mrcolour [ options ] input map output

        input        the input image

        map          the colourmap to apply; choices are:
                     gray,hot,cool,jet,inferno,viridis,pet,colour,rgb

        output       the output image


DESCRIPTION

     Under typical usage, this command will receive as input ad 3D greyscale
     image, and output a 4D image with 3 volumes corresponding to
     red-green-blue components; other use cases are possible, and are described
     in more detail below.

     By default, the command will automatically determine the maximum and
     minimum intensities of the input image, and use that information to set
     the upper and lower bounds of the applied colourmap. This behaviour can be
     overridden by manually specifying these bounds using the -upper and -lower
     options respectively.

OPTIONS

  -upper value
     manually set the upper intensity of the colour mapping

  -lower value
     manually set the lower intensity of the colour mapping

  -colour values
     set the target colour for use of the 'colour' map (three comma-separated
     floating-point values)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrconvert

### Tool Description
Perform conversion between different file types and optionally extract a subset of the input image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        mrconvert                        Oct 21 2025

     mrconvert: part of the MRtrix3 package

SYNOPSIS

     Perform conversion between different file types and optionally extract a
     subset of the input image

USAGE

     mrconvert [ options ] input output

        input        the input image.

        output       the output image.


DESCRIPTION

     If used correctly, this program can be a very useful workhorse. In
     addition to converting images between different formats, it can be used to
     extract specific studies from a data set, extract a specific region of
     interest, or flip the images. Some of the possible operations are
     described in more detail below.

     Note that for both the -coord and -axes options, indexing starts from 0
     rather than 1. E.g. -coord 3 <#> selects volumes (the fourth dimension)
     from the series; -axes 0,1,2 includes only the three spatial axes in the
     output image.

     Additionally, for the second input to the -coord option and the -axes
     option, you can use any valid number sequence in the selection, as well as
     the 'end' keyword (see the main documentation for details); this can be
     particularly useful to select multiple coordinates.

     The -vox option is used to change the size of the voxels in the output
     image as reported in the image header; note however that this does not
     re-sample the image based on a new voxel size (that is done using the
     mrgrid command).

     By default, the intensity scaling parameters in the input image header are
     passed through to the output image header when writing to an integer
     image, and reset to 0,1 (i.e. no scaling) for floating-point and binary
     images. Note that the -scaling option will therefore have no effect for
     floating-point or binary output images.

     The -axes option specifies which axes from the input image will be used to
     form the output image. This allows the permutation, omission, or addition
     of axes into the output image. The axes should be supplied as a
     comma-separated list of axis indices. If an axis from the input image is
     to be omitted from the output image, it must either already have a size of
     1, or a single coordinate along that axis must be selected by the user by
     using the -coord option. Examples are provided further below.

     The -bvalue_scaling option controls an aspect of the import of diffusion
     gradient tables. When the input diffusion-weighting direction vectors have
     norms that differ substantially from unity, the b-values will be scaled by
     the square of their corresponding vector norm (this is how multi-shell
     acquisitions are frequently achieved on scanner platforms). However in
     some rare instances, the b-values may be correct, despite the vectors not
     being of unit norm (or conversely, the b-values may need to be rescaled
     even though the vectors are close to unit norm). This option allows the
     user to control this operation and override MRrtix3's automatic detection.

EXAMPLE USAGES

     Extract_the_first_volume_from_a_4D_image,_and_make_the_output_a_3D_image:
       $ mrconvert in.mif -coord 3 0 -axes 0,1,2 out.mif
     The -coord 3 0 option extracts, from axis number 3 (which is the fourth
     axis since counting begins from 0; this is the axis that steps across
     image volumes), only coordinate number 0 (i.e. the first volume). The
     -axes 0,1,2 ensures that only the first three axes (i.e. the spatial axes)
     are retained; if this option were not used in this example, then image
     out.mif would be a 4D image, but it would only consist of a single volume,
     and mrinfo would report its size along the fourth axis as 1.

     Extract_slice_number_24_along_the_AP_direction:
       $ mrconvert volume.mif slice.mif -coord 1 24
     MRtrix3 uses a RAS (Right-Anterior-Superior) axis convention, and
     internally reorients images upon loading in order to conform to this as
     far as possible. So for non-exotic data, axis 1 should correspond
     (approximately) to the anterior-posterior direction.

     Extract_only_every_other_volume_from_a_4D_image:
       $ mrconvert all.mif every_other.mif -coord 3 1:2:end
     This example demonstrates two features: Use of the colon syntax to
     conveniently specify a number sequence (in the format 'start:step:stop');
     and use of the 'end' keyword to generate this sequence up to the size of
     the input image along that axis (i.e. the number of volumes).

     Alter_the_image_header_to_report_a_new_isotropic_voxel_size:
       $ mrconvert in.mif isotropic.mif -vox 1.25
     By providing a single value to the -vox option only, the specified value
     is used to set the voxel size in mm for all three spatial axes in the
     output image.

     Alter_the_image_header_to_report_a_new_anisotropic_voxel_size:
       $ mrconvert in.mif anisotropic.mif -vox 1,,3.5
     This example will change the reported voxel size along the first and third
     axes (ideally left-right and inferior-superior) to 1.0mm and 3.5mm
     respectively, and leave the voxel size along the second axis (ideally
     anterior-posterior) unchanged.

     Turn_a_single-volume_4D_image_into_a_3D_image:
       $ mrconvert 4D.mif 3D.mif -axes 0,1,2
     Sometimes in the process of extracting or calculating a single 3D volume
     from a 4D image series, the size of the image reported by mrinfo will be
     "X x Y x Z x 1", indicating that the resulting image is in fact also 4D,
     it just happens to contain only one volume. This example demonstrates how
     to convert this into a genuine 3D image (i.e. mrinfo will report the size
     as "X x Y x Z".

     Insert_an_axis_of_size_1_into_the_image:
       $ mrconvert XYZD.mif XYZ1D.mif -axes 0,1,2,-1,3
     This example uses the value -1 as a flag to indicate to mrconvert where a
     new axis of unity size is to be inserted. In this particular example, the
     input image has four axes: the spatial axes X, Y and Z, and some form of
     data D is stored across the fourth axis (i.e. volumes). Due to insertion
     of a new axis, the output image is 5D: the three spatial axes (XYZ), a
     single volume (the size of the output image along the fourth axis will be
     1), and data D will be stored as volume groups along the fifth axis of the
     image.

     Manually_reset_the_data_scaling_parameters_stored_within_the_image_header_
     to_defaults:
       $ mrconvert with_scaling.mif without_scaling.mif -scaling 0.0,1.0
     This command-line option alters the parameters stored within the image
     header that provide a linear mapping from raw intensity values stored in
     the image data to some other scale. Where the raw data stored in a
     particular voxel is I, the value within that voxel is interpreted as:
     value = offset + (scale x I).  To adjust this scaling, the relevant
     parameters must be provided as a comma-separated 2-vector of
     floating-point values, in the format "offset,scale" (no quotation marks).
     This particular example sets the offset to zero and the scale to one,
     which equates to no rescaling of the raw intensity data.

Options for manipulating fundamental image properties

  -coord axis selection  (multiple uses permitted)
     retain data from the input image only at the coordinates specified in the
     selection along the specified axis. The selection argument expects a
     number sequence, which can also include the 'end' keyword.

  -vox sizes
     change the voxel dimensions reported in the output image header

  -axes axes
     specify the axes from the input image that will be used to form the output
     image

  -scaling values
     specify the data scaling parameters used to rescale the intensity values

Options for handling JSON (JavaScript Object Notation) files

  -json_import file
     import data from a JSON file into header key-value pairs

  -json_export file
     export data from an image header key-value pairs into a JSON file

Options to modify generic header entries

  -clear_property key  (multiple uses permitted)
     remove the specified key from the image header altogether.

  -set_property key value  (multiple uses permitted)
     set the value of the specified key in the image header.

  -append_property key value  (multiple uses permitted)
     append the given value to the specified key in the image header (this adds
     the value specified as a new line in the header value).

  -copy_properties source
     clear all generic properties and replace with the properties from the
     image / file specified.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

  -bvalue_scaling mode
     enable or disable scaling of diffusion b-values by the square of the
     corresponding DW gradient norm (see Desciption). Valid choices are yes/no,
     true/false, 0/1 (default: automatic).

DW gradient table export options

  -export_grad_mrtrix path
     export the diffusion-weighted gradient table to file in MRtrix format

  -export_grad_fsl bvecs_path bvals_path
     export the diffusion-weighted gradient table to files in FSL (bvecs /
     bvals) format

Options for importing phase-encode tables

  -import_pe_table file
     import a phase-encoding table from file

  -import_pe_topup file
     import a phase-encoding table intended for FSL TOPUP from file

  -import_pe_eddy config indices
     import phase-encoding information from an EDDY-style config / index file
     pair

Options for exporting phase-encode tables

  -export_pe_table file
     export phase-encoding table to file

  -export_pe_topup file
     export phase-encoding table to a file intended for FSL topup

  -export_pe_eddy config indices
     export phase-encoding information to an EDDY-style config / index file
     pair

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrdegibbs

### Tool Description
Remove Gibbs Ringing Artifacts

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        mrdegibbs                        Oct 21 2025

     mrdegibbs: part of the MRtrix3 package

SYNOPSIS

     Remove Gibbs Ringing Artifacts

USAGE

     mrdegibbs [ options ] in out

        in           the input image.

        out          the output image.


DESCRIPTION

     This application attempts to remove Gibbs ringing artefacts from MRI
     images using the method of local subvoxel-shifts proposed by Kellner et
     al. (see reference below for details).

     This command is designed to run on data directly after it has been
     reconstructed by the scanner, before any interpolation of any kind has
     taken place. You should not run this command after any form of motion
     correction (e.g. not after dwifslpreproc). Similarly, if you intend
     running dwidenoise, you should run denoising before this command to not
     alter the noise structure, which would impact on dwidenoise's performance.

     For best results, any form of filtering performed by the scanner should be
     disabled, whether performed in the image domain or k-space. This includes
     elliptic filtering and other filters that are often applied to reduce
     Gibbs ringing artifacts. While this method can still safely be applied to
     such data, some residual ringing artefacts may still be present in the
     output.

     Note that this method is designed to work on images acquired with full
     k-space coverage. If this method is executed on data acquired with partial
     Fourier (eg. "half-scan") acceleration, it may not fully remove all
     ringing artifacts, and you may observe residuals of the original artifact
     in the partial Fourier direction. Nonetheless, application of the method
     is still considered safe and worthwhile. Users are however encouraged to
     acquired full-Fourier data where possible.

OPTIONS

  -axes list
     select the slice axes (default: 0,1 - i.e. x-y).

  -nshifts value
     discretization of subpixel spacing (default: 20).

  -minW value
     left border of window used for TV computation (default: 1).

  -maxW value
     right border of window used for TV computation (default: 3).

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Ben Jeurissen (ben.jeurissen@uantwerpen.be) & J-Donald Tournier
     (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Kellner, E; Dhital, B; Kiselev, V.G & Reisert, M. Gibbs-ringing artifact
     removal based on local subvoxel-shifts. Magnetic Resonance in Medicine,
     2016, 76, 1574–1581.

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrdump

### Tool Description
Print out the values within an image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         mrdump                          Oct 21 2025

     mrdump: part of the MRtrix3 package

SYNOPSIS

     Print out the values within an image

USAGE

     mrdump [ options ] input [ output ]

        input        the input image.

        output       the (optional) output text file.


DESCRIPTION

     If no destination file is specified, the voxel locations will be printed
     to stdout.

OPTIONS

  -mask image
     only write the image values within voxels specified by a mask image

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mredit

### Tool Description
Directly edit the intensities within an image from the command-line

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         mredit                          Oct 21 2025

     mredit: part of the MRtrix3 package

SYNOPSIS

     Directly edit the intensities within an image from the command-line

USAGE

     mredit [ options ] input [ output ]

        input        the input image

        output       the (optional) output image


DESCRIPTION

     A range of options are provided to enable direct editing of voxel
     intensities based on voxel / real-space coordinates. If only one image
     path is provided, the image will be edited in-place (use at own risk); if
     input and output image paths are provided, the output will contain the
     edited image, and the original image will not be modified in any way.

OPTIONS

  -plane axis coord value  (multiple uses permitted)
     fill one or more planes on a particular image axis

  -sphere position radius value  (multiple uses permitted)
     draw a sphere with radius in mm

  -voxel position value  (multiple uses permitted)
     change the image value within a single voxel

  -scanner
     indicate that coordinates are specified in scanner space, rather than as
     voxel coordinates

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrfilter

### Tool Description
Perform filtering operations on 3D / 4D MR images

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        mrfilter                         Oct 21 2025

     mrfilter: part of the MRtrix3 package

SYNOPSIS

     Perform filtering operations on 3D / 4D MR images

USAGE

     mrfilter [ options ] input filter output

        input        the input image.

        filter       the type of filter to be applied

        output       the output image.


DESCRIPTION

     The available filters are: fft, gradient, median, smooth, normalise,
     zclean.

     Each filter has its own unique set of optional parameters.

     For 4D images, each 3D volume is processed independently.

Options for FFT filter

  -axes list
     the axes along which to apply the Fourier Transform. By default, the
     transform is applied along the three spatial axes. Provide as a
     comma-separate list of axis indices.

  -inverse
     apply the inverse FFT

  -magnitude
     output a magnitude image rather than a complex-valued image

  -centre_zero
     re-arrange the FFT results so that the zero-frequency component appears in
     the centre of the image, rather than at the edges

Options for gradient filter

  -stdev sigma
     the standard deviation of the Gaussian kernel used to smooth the input
     image (in mm). The image is smoothed to reduced large spurious gradients
     caused by noise. Use this option to override the default stdev of 1 voxel.
     This can be specified either as a single value to be used for all 3 axes,
     or as a comma-separated list of 3 values, one for each axis.

  -magnitude
     output the gradient magnitude, rather than the default x,y,z components

  -scanner
     define the gradient with respect to the scanner coordinate frame of
     reference.

Options for median filter

  -extent size
     specify extent of median filtering neighbourhood in voxels. This can be
     specified either as a single value to be used for all 3 axes, or as a
     comma-separated list of 3 values, one for each axis (default: 3x3x3).

Options for normalisation filter

  -extent size
     specify extent of normalisation filtering neighbourhood in voxels. This
     can be specified either as a single value to be used for all 3 axes, or as
     a comma-separated list of 3 values, one for each axis (default: 3x3x3).

Options for smooth filter

  -stdev mm
     apply Gaussian smoothing with the specified standard deviation. The
     standard deviation is defined in mm (Default 1 voxel). This can be
     specified either as a single value to be used for all axes, or as a
     comma-separated list of the stdev for each axis.

  -fwhm mm
     apply Gaussian smoothing with the specified full-width half maximum. The
     FWHM is defined in mm (Default 1 voxel * 2.3548). This can be specified
     either as a single value to be used for all axes, or as a comma-separated
     list of the FWHM for each axis.

  -extent voxels
     specify the extent (width) of kernel size in voxels. This can be specified
     either as a single value to be used for all axes, or as a comma-separated
     list of the extent for each axis. The default extent is 2 * ceil(2.5 *
     stdev / voxel_size) - 1.

Options for zclean filter

  -zupper num
     define high intensity outliers: default: 2.5

  -zlower num
     define low intensity outliers: default: 2.5

  -bridge num
     number of voxels to gap to fill holes in mask: default: 4

  -maskin image
     initial mask that defines the maximum spatial extent and the region from
     which to smaple the intensity range.

  -maskout image
     Output a refined mask based on a spatially coherent region with normal
     intensity range.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au), David Raffelt
     (david.raffelt@florey.edu.au) and J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrgrid

### Tool Description
Modify the grid of an image without interpolation (cropping or padding) or by regridding to an image grid with modified orientation, location and or resolution. The image content remains in place in real world coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         mrgrid                          Oct 21 2025

     mrgrid: part of the MRtrix3 package

SYNOPSIS

     Modify the grid of an image without interpolation (cropping or padding) or
     by regridding to an image grid with modified orientation, location and or
     resolution. The image content remains in place in real world coordinates.

USAGE

     mrgrid [ options ] input operation output

        input        input image to be regridded.

        operation    the operation to be performed, one of: regrid, crop, pad.

        output       the output image.


DESCRIPTION

     - regrid: This operation performs changes of the voxel grid that require
     interpolation of the image such as changing the resolution or location and
     orientation of the voxel grid. If the image is down-sampled, the
     appropriate smoothing is automatically applied using Gaussian smoothing
     unless nearest neighbour interpolation is selected or oversample is
     changed explicitly. The resolution can only be changed for spatial
     dimensions.

     - crop: The image extent after cropping, can be specified either manually
     for each axis dimensions, or via a mask or reference image. The image can
     be cropped to the extent of a mask. This is useful for axially-acquired
     brain images, where the image size can be reduced by a factor of 2 by
     removing the empty space on either side of the brain. Note that cropping
     does not extend the image beyond the original FOV unless explicitly
     specified (via -crop_unbound or negative -axis extent).

     - pad: Analogously to cropping, padding increases the FOV of an image
     without image interpolation. Pad and crop can be performed simultaneously
     by specifying signed specifier argument values to the -axis option.

     This command encapsulates and extends the functionality of the superseded
     commands 'mrpad', 'mrcrop' and 'mrresize'. Note the difference in -axis
     convention used for 'mrcrop' and 'mrpad' (see -axis option description).

EXAMPLE USAGES

     Crop_and_pad_the_first_axis:
       $ mrgrid in.mif crop -axis 0 10,-5 out.mif
     This removes 10 voxels on the lower and pads with 5 on the upper bound,
     which is equivalent to padding with the negated specifier (mrgrid in.mif
     pad -axis 0 -10,5 out.mif).

     Right-pad_the_image_to_the_number_of_voxels_of_a_reference_image:
       $ mrgrid in.mif pad -as ref.mif -all_axes -axis 3 0,0 out.mif -fill nan
     This pads the image on the upper bound of all axes except for the volume
     dimension. The headers of in.mif and ref.mif are ignored and the output
     image uses NAN values to fill in voxels outside the original range of
     in.mif.

     Regrid_and_interpolate_to_match_the_voxel_grid_of_a_reference_image:
       $ mrgrid in.mif regrid -template ref.mif -scale 1,1,0.5 out.mif -fill nan
     The -template instructs to regrid in.mif to match the voxel grid of
     ref.mif (voxel size, grid orientation and voxel centres). The -scale
     option overwrites the voxel scaling factor yielding voxel sizes in the
     third dimension that are twice as coarse as those of the template image.

Regridding options (involves image interpolation, applied to spatial axes only)

  -template image
     match the input image grid (voxel spacing, image size, header
     transformation) to that of a reference image. The image resolution
     relative to the template image can be changed with one of -size, -voxel,
     -scale.

  -size dims
     define the size (number of voxels) in each spatial dimension for the
     output image. This should be specified as a comma-separated list.

  -voxel size
     define the new voxel size for the output image. This can be specified
     either as a single value to be used for all spatial dimensions, or as a
     comma-separated list of the size for each voxel dimension.

  -scale factor
     scale the image resolution by the supplied factor. This can be specified
     either as a single value to be used for all dimensions, or as a
     comma-separated list of scale factors for each dimension.

  -interp method
     set the interpolation method to use when reslicing (choices: nearest,
     linear, cubic, sinc. Default: cubic).

  -oversample factor
     set the amount of over-sampling (in the target space) to perform when
     regridding. This is particularly relevant when downsamping a
     high-resolution image to a low-resolution image, to avoid aliasing
     artefacts. This can consist of a single integer, or a comma-separated list
     of 3 integers if different oversampling factors are desired along the
     different axes. Default is determined from ratio of voxel dimensions
     (disabled for nearest-neighbour interpolation).

Pad and crop options (no image interpolation is performed, header transformation is adjusted)

  -as reference_image
     pad or crop the input image on the upper bound to match the specified
     reference image grid. This operation ignores differences in image
     transformation between input and reference image.

  -uniform number
     pad or crop the input image by a uniform number of voxels on all sides

  -mask image
     crop the input image according to the spatial extent of a mask image. The
     mask must share a common voxel grid with the input image but differences
     in image transformations are ignored. Note that even though only 3
     dimensions are cropped when using a mask, the bounds are computed by
     checking the extent for all dimensions. Note that by default a gap of 1
     voxel is left at all edges of the image to allow valid trilinear
     interpolation. This gap can be modified with the -uniform option but by
     default it does not extend beyond the FOV unless -crop_unbound is used.

  -crop_unbound
     Allow padding beyond the original FOV when cropping.

  -axis index spec  (multiple uses permitted)
     pad or crop the input image along the provided axis (defined by index).
     The specifier argument defines the number of voxels added or removed on
     the lower or upper end of the axis (-axis index delta_lower,delta_upper)
     or acts as a voxel selection range (-axis index start:stop). In both
     modes, values are relative to the input image (overriding all other
     extent-specifying options). Negative delta specifier values trigger the
     inverse operation (pad instead of crop and vice versa) and negative range
     specifier trigger padding. Note that the deprecated commands 'mrcrop' and
     'mrpad' used range-based and delta-based -axis indices, respectively.

  -all_axes
     Crop or pad all, not just spatial axes.

General options

  -fill number
     Use number as the out of bounds value. nan, inf and -inf are valid
     arguments. (Default: 0.0)

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Max Pietsch (maximilian.pietsch@kcl.ac.uk) & David Raffelt
     (david.raffelt@florey.edu.au) & Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrhistogram

### Tool Description
Generate a histogram of image intensities

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mrhistogram                       Oct 21 2025

     mrhistogram: part of the MRtrix3 package

SYNOPSIS

     Generate a histogram of image intensities

USAGE

     mrhistogram [ options ] image hist

        image        the input image from which the histogram will be computed

        hist         the output histogram file


Histogram generation options

  -bins num
     Manually set the number of bins to use to generate the histogram.

  -template file
     Use an existing histogram file as the template for histogram formation

  -mask image
     Calculate the histogram only within a mask image.

  -ignorezero
     ignore zero-valued data during histogram construction.

Additional options for mrhistogram

  -allvolumes
     generate one histogram across all image volumes, rather than one per image
     volume

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrinfo

### Tool Description
Display image header information, or extract specific information from the header

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         mrinfo                          Oct 21 2025

     mrinfo: part of the MRtrix3 package

SYNOPSIS

     Display image header information, or extract specific information from the
     header

USAGE

     mrinfo [ options ] image [ image ... ]

        image        the input image(s).


DESCRIPTION

     By default, all information contained in each image header will be printed
     to the console in a reader-friendly format.

     Alternatively, command-line options may be used to extract specific
     details from the header(s); these are printed to the console in a format
     more appropriate for scripting purposes or piping to file. If multiple
     options and/or images are provided, the requested header fields will be
     printed in the order in which they appear in the help page, with all
     requested details from each input image in sequence printed before the
     next image is processed.

     The command can also write the diffusion gradient table from a single
     input image to file; either in the MRtrix or FSL format (bvecs/bvals file
     pair; includes appropriate diffusion gradient vector reorientation)

     The -dwgrad, -export_* and -shell_* options provide (information about)
     the diffusion weighting gradient table after it has been processed by the
     MRtrix3 back-end (vectors normalised, b-values scaled by the square of the
     vector norm, depending on the -bvalue_scaling option). To see the raw
     gradient table information as stored in the image header, i.e. without
     MRtrix3 back-end processing, use "-property dw_scheme".

     The -bvalue_scaling option controls an aspect of the import of diffusion
     gradient tables. When the input diffusion-weighting direction vectors have
     norms that differ substantially from unity, the b-values will be scaled by
     the square of their corresponding vector norm (this is how multi-shell
     acquisitions are frequently achieved on scanner platforms). However in
     some rare instances, the b-values may be correct, despite the vectors not
     being of unit norm (or conversely, the b-values may need to be rescaled
     even though the vectors are close to unit norm). This option allows the
     user to control this operation and override MRrtix3's automatic detection.

OPTIONS

  -all
     print all properties, rather than the first and last 2 of each.

  -name
     print the file system path of the image

  -format
     image file format

  -ndim
     number of image dimensions

  -size
     image size along each axis

  -spacing
     voxel spacing along each image dimension

  -datatype
     data type used for image data storage

  -strides
     data strides i.e. order and direction of axes data layout

  -offset
     image intensity offset

  -multiplier
     image intensity multiplier

  -transform
     the transformation from image coordinates [mm] to scanner / real world
     coordinates [mm]

Options for exporting image header fields

  -property key  (multiple uses permitted)
     any text properties embedded in the image header under the specified key
     (use 'all' to list all keys found)

  -json_keyval file
     export header key/value entries to a JSON file

  -json_all file
     export all header contents to a JSON file

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

  -bvalue_scaling mode
     enable or disable scaling of diffusion b-values by the square of the
     corresponding DW gradient norm (see Desciption). Valid choices are yes/no,
     true/false, 0/1 (default: automatic).

DW gradient table export options

  -export_grad_mrtrix path
     export the diffusion-weighted gradient table to file in MRtrix format

  -export_grad_fsl bvecs_path bvals_path
     export the diffusion-weighted gradient table to files in FSL (bvecs /
     bvals) format

  -dwgrad
     the diffusion-weighting gradient table, as interpreted by MRtrix3

  -shell_bvalues
     list the average b-value of each shell

  -shell_sizes
     list the number of volumes in each shell

  -shell_indices
     list the image volumes attributed to each b-value shell

Options for exporting phase-encode tables

  -export_pe_table file
     export phase-encoding table to file

  -export_pe_topup file
     export phase-encoding table to a file intended for FSL topup

  -export_pe_eddy config indices
     export phase-encoding information to an EDDY-style config / index file
     pair

  -petable
     print the phase encoding table

Handling of piped images

  -nodelete
     don't delete temporary images or images passed to mrinfo via Unix pipes

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com) and Robert E. Smith
     (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrmath

### Tool Description
Compute summary statistic on image intensities either across images, or along a specified axis of a single image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         mrmath                          Oct 21 2025

     mrmath: part of the MRtrix3 package

SYNOPSIS

     Compute summary statistic on image intensities either across images, or
     along a specified axis of a single image

USAGE

     mrmath [ options ] input [ input ... ] operation output

        input        the input image(s).

        operation    the operation to apply, one of: mean, median, sum,
                     product, rms, norm, var, std, min, max, absmax, magmax.

        output       the output image.


DESCRIPTION

     Supported operations are:

     mean, median, sum, product, rms (root-mean-square value), norm (vector
     2-norm), var (unbiased variance), std (unbiased standard deviation), min,
     max, absmax (maximum absolute value), magmax (value with maximum absolute
     value, preserving its sign).

     This command is used to traverse either along an image axis, or across a
     set of input images, calculating some statistic from the values along each
     traversal. If you are seeking to instead perform mathematical calculations
     that are done independently for each voxel, pleaase see the 'mrcalc'
     command.

EXAMPLE USAGES

     Calculate_a_3D_volume_representing_the_mean_intensity_across_a_4D_image_
     series:
       $ mrmath 4D.mif mean 3D_mean.mif -axis 3
     This is a common operation for calculating e.g. the mean value within a
     specific DWI b-value. Note that axis indices start from 0; thus, axes 0, 1
     & 2 are the three spatial axes, and axis 3 operates across volumes.

     Generate_a_Maximum_Intensity_Projection_(MIP)_along_the_inferior-superior_
     direction:
       $ mrmath input.mif max MIP.mif -axis 2
     Since a MIP is literally the maximal value along a specific projection
     direction, axis-aligned MIPs can be generated easily using mrmath with the
     'max' operation.

OPTIONS

  -axis index
     perform operation along a specified axis of a single input image

  -keep_unary_axes
     Keep unary axes in input images prior to calculating the stats. The
     default is to wipe axes with single elements.

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrstats

### Tool Description
Compute images statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                         mrstats                         Oct 21 2025

     mrstats: part of the MRtrix3 package

SYNOPSIS

     Compute images statistics

USAGE

     mrstats [ options ] image

        image        the input image from which statistics will be computed.


Statistics options

  -output field  (multiple uses permitted)
     output only the field specified. Multiple such options can be supplied if
     required. Choices are: mean, median, std, std_rv, min, max, count. Useful
     for use in scripts. Both std options refer to the unbiased (sample)
     standard deviation. For complex data, min, max and std are calculated
     separately for real and imaginary parts, std_rv is based on the real
     valued variance (equals sqrt of sum of variances of imaginary and real
     parts).

  -mask image
     only perform computation within the specified binary mask image.

  -ignorezero
     ignore zero values during statistics calculation

Additional options for mrstats

  -allvolumes
     generate statistics across all image volumes, rather than one set of
     statistics per image volume

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrthreshold

### Tool Description
Create bitwise image by thresholding image intensity

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mrthreshold                       Oct 21 2025

     mrthreshold: part of the MRtrix3 package

SYNOPSIS

     Create bitwise image by thresholding image intensity

USAGE

     mrthreshold [ options ] input [ output ]

        input        the input image to be thresholded

        output       the (optional) output binary image mask


DESCRIPTION

     The threshold value to be applied can be determined in one of a number of
     ways:

     - If no relevant command-line option is used, the command will
     automatically determine an optimal threshold;

     - The -abs option provides the threshold value explicitly;

     - The -percentile, -top and -bottom options enable more fine-grained
     control over how the threshold value is determined.

     The -mask option only influences those image values that contribute toward
     the determination of the threshold value; once the threshold is
     determined, it is applied to the entire image, irrespective of use of the
     -mask option. If you wish for the voxels outside of the specified mask to
     additionally be excluded from the output mask, this can be achieved by
     providing the -out_masked option.

     The four operators available through the "-comparison" option ("lt", "le",
     "ge" and "gt") correspond to "less-than" (<), "less-than-or-equal" (<=),
     "greater-than-or-equal" (>=) and "greater-than" (>). This offers
     fine-grained control over how the thresholding operation will behave in
     the presence of values equivalent to the threshold. By default, the
     command will select voxels with values greater than or equal to the
     determined threshold ("ge"); unless the -bottom option is used, in which
     case after a threshold is determined from the relevant lowest-valued image
     voxels, those voxels with values less than or equal to that threshold
     ("le") are selected. This provides more fine-grained control than the
     -invert option; the latter is provided for backwards compatibility, but is
     equivalent to selection of the opposite comparison within this selection.

     If no output image path is specified, the command will instead write to
     standard output the determined threshold value.

Threshold determination mechanisms

  -abs value
     specify threshold value as absolute intensity

  -percentile value
     determine threshold based on some percentile of the image intensity
     distribution

  -top count
     determine threshold that will result in selection of some number of
     top-valued voxels

  -bottom count
     determine & apply threshold resulting in selection of some number of
     bottom-valued voxels (note: implies threshold application operator of "le"
     unless otherwise specified)

Threshold determination modifiers

  -allvolumes
     compute a single threshold for all image volumes, rather than an
     individual threshold per volume

  -ignorezero
     ignore zero-valued input values during threshold determination

  -mask image
     compute the threshold based only on values within an input mask image

Threshold application modifiers

  -comparison choice
     comparison operator to use when applying the threshold; options are:
     lt,le,ge,gt (default = "le" for -bottom; "ge" otherwise)

  -invert
     invert the output binary mask (equivalent to flipping the operator;
     provided for backwards compatibility)

  -out_masked
     mask the output image based on the provided input mask image

  -nan
     set voxels that fail the threshold to NaN rather than zero (output image
     will be floating-point rather than binary)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au) and J-Donald Tournier
     (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If not using any explicit thresholding mechanism:
     Ridgway, G. R.; Omar, R.; Ourselin, S.; Hill, D. L.; Warren, J. D. & Fox,
     N. C. Issues with threshold masking in voxel-based morphometry of
     atrophied brains. NeuroImage, 2009, 44, 99-111

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrtransform

### Tool Description
Apply spatial transformations to an image

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mrtransform                       Oct 21 2025

     mrtransform: part of the MRtrix3 package

SYNOPSIS

     Apply spatial transformations to an image

USAGE

     mrtransform [ options ] input output

        input        input image to be transformed.

        output       the output image.


DESCRIPTION

     If a linear transform is applied without a template image the command will
     modify the image header transform matrix

     FOD reorientation (with apodised point spread functions) can be performed
     if the number of volumes in the 4th dimension equals the number of
     coefficients in an antipodally symmetric spherical harmonic series (e.g.
     6, 15, 28 etc). For such data, the -reorient_fod yes/no option must be
     used to specify if reorientation is required.

     The output image intensity can be modulated using the (local or global)
     volume change if a linear or nonlinear transformation is applied. 'FOD'
     modulation preserves the apparent fibre density across the fibre bundle
     width and can only be applied if FOD reorientation is used. Alternatively,
     non-directional scaling by the Jacobian determinant can be applied to any
     image type.

     If a DW scheme is contained in the header (or specified separately), and
     the number of directions matches the number of volumes in the images, any
     transformation applied using the -linear option will also be applied to
     the directions.

     When the -template option is used to specify the target image grid, the
     image provided via this option will not influence the axis data strides of
     the output image; these are determined based on the input image, or the
     input to the -strides option.

Affine transformation options

  -linear transform
     specify a linear transform to apply, in the form of a 3x4 or 4x4 ascii
     file. Note the standard 'reverse' convention is used, where the transform
     maps points in the template image to the moving image. Note that the
     reverse convention is still assumed even if no -template image is supplied

  -flip axes
     flip the specified axes, provided as a comma-separated list of indices
     (0:x, 1:y, 2:z).

  -inverse
     apply the inverse transformation

  -half
     apply the matrix square root of the transformation. This can be combined
     with the inverse option.

  -replace file
     replace the linear transform of the original image by that specified,
     rather than applying it to the original image. The specified transform can
     be either a template image, or a 3x4 or 4x4 ascii file.

  -identity
     set the header transform of the image to the identity matrix

Regridding options

  -template image
     reslice the input image to match the specified template image grid.

  -midway_space
     reslice the input image to the midway space. Requires either the -template
     or -warp option. If used with -template and -linear option the input image
     will be resliced onto the grid halfway between the input and template. If
     used with the -warp option the input will be warped to the midway space
     defined by the grid of the input warp (i.e. half way between image1 and
     image2)

  -interp method
     set the interpolation method to use when reslicing (choices: nearest,
     linear, cubic, sinc. Default: cubic).

  -oversample factor
     set the amount of over-sampling (in the target space) to perform when
     regridding. This is particularly relevant when downsamping a
     high-resolution image to a low-resolution image, to avoid aliasing
     artefacts. This can consist of a single integer, or a comma-separated list
     of 3 integers if different oversampling factors are desired along the
     different axes. Default is determined from ratio of voxel dimensions
     (disabled for nearest-neighbour interpolation).

Non-linear transformation options

  -warp image
     apply a non-linear 4D deformation field to warp the input image. Each
     voxel in the deformation field must define the scanner space position that
     will be used to interpolate the input image during warping (i.e.
     pull-back/reverse warp convention). If the -template image is also
     supplied the deformation field will be resliced first to the template
     image grid. If no -template option is supplied then the output image will
     have the same image grid as the deformation field. This option can be used
     in combination with the -affine option, in which case the affine will be
     applied first)

  -warp_full image
     warp the input image using a 5D warp file output from mrregister. Any
     linear transforms in the warp image header will also be applied. The
     -warp_full option must be used in combination with either the -template
     option or the -midway_space option. If a -template image is supplied then
     the full warp will be used. By default the image1->image2 transform will
     be applied, however the -from 2 option can be used to apply the
     image2->image1 transform. Use the -midway_space option to warp the input
     image to the midway space. The -from option can also be used to define
     which warp to use when transforming to midway space

  -from image
     used to define which space the input image is when using the -warp_mid
     option. Use -from 1 to warp from image1 or -from 2 to warp from image2

Fibre orientation distribution handling options

  -modulate intensity modulation method
     Valid choices are: fod and jac.
     fod: modulate FODs during reorientation to preserve the apparent fibre
     density across fibre bundle widths before and after the transformation.
     jac: modulate the image intensity with the determinant of the Jacobian of
     the warp of linear transformation to preserve the total intensity before
     and after the transformation.

  -directions file
     directions defining the number and orientation of the apodised point
     spread functions used in FOD reorientation (Default: 300 directions)

  -reorient_fod boolean
     specify whether to perform FOD reorientation. This is required if the
     number of volumes in the 4th dimension corresponds to the number of
     coefficients in an antipodally symmetric spherical harmonic series with
     lmax >= 2 (i.e. 6, 15, 28, 45, 66 volumes).

DW gradient table import options

  -grad file
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     a text file. This should be supplied as a 4xN text file with each line is
     in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the
     applied gradient, and b gives the b-value in units of s/mm^2. If a
     diffusion gradient scheme is present in the input image header, the data
     provided with this option will be instead used.

  -fslgrad bvecs bvals
     Provide the diffusion-weighted gradient scheme used in the acquisition in
     FSL bvecs/bvals format files. If a diffusion gradient scheme is present in
     the input image header, the data provided with this option will be instead
     used.

DW gradient table export options

  -export_grad_mrtrix path
     export the diffusion-weighted gradient table to file in MRtrix format

  -export_grad_fsl bvecs_path bvals_path
     export the diffusion-weighted gradient table to files in FSL (bvecs /
     bvals) format

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Stride options

  -strides spec
     specify the strides of the output data in memory; either as a
     comma-separated list of (signed) integers, or as a template image from
     which the strides shall be extracted and used. The actual strides produced
     will depend on whether the output image format can support it.

Additional generic options for mrtransform

  -nan
     Use NaN as the out of bounds value (Default: 0.0)

  -no_reorientation
     deprecated, use -reorient_fod instead

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     J-Donald Tournier (jdtournier@gmail.com) and David Raffelt
     (david.raffelt@florey.edu.au) and Max Pietsch
     (maximilian.pietsch@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If FOD reorientation is being performed:
     Raffelt, D.; Tournier, J.-D.; Crozier, S.; Connelly, A. & Salvado, O.
     Reorientation of fiber orientation distributions using apodized point
     spread functions. Magnetic Resonance in Medicine, 2012, 67, 844-855

     * If FOD modulation is being performed:
     Raffelt, D.; Tournier, J.-D.; Rose, S.; Ridgway, G.R.; Henderson, R.;
     Crozier, S.; Salvado, O.; Connelly, A.; Apparent Fibre Density: a novel
     measure for the analysis of diffusion-weighted magnetic resonance images.
     NeuroImage, 2012, 15;59(4), 3976-94

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mtnormalise

### Tool Description
Multi-tissue informed log-domain intensity normalisation

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mtnormalise                       Oct 21 2025

     mtnormalise: part of the MRtrix3 package

SYNOPSIS

     Multi-tissue informed log-domain intensity normalisation

USAGE

     mtnormalise [ options ] input output [ input output ... ]

        input output  list of all input and output tissue compartment files
                     (see example usage).


DESCRIPTION

     This command takes as input any number of tissue components (e.g. from
     multi-tissue CSD) and outputs corresponding normalised tissue components
     corrected for the effects of (residual) intensity inhomogeneities.
     Intensity normalisation is performed by optimising the voxel-wise sum of
     all tissue compartments towards a constant value, under constraints of
     spatial smoothness (polynomial basis of a given order). Different to the
     Raffelt et al. 2017 abstract, this algorithm performs this task in the
     log-domain instead, with added gradual outlier rejection, different
     handling of the balancing factors between tissue compartments and a
     different iteration structure.

     The -mask option is mandatory and is optimally provided with a brain mask
     (such as the one obtained from dwi2mask earlier in the processing
     pipeline). Outlier areas with exceptionally low or high combined tissue
     contributions are accounted for and reoptimised as the intensity
     inhomogeneity estimation becomes more accurate.

EXAMPLE USAGES

     Default_usage_(for_3-tissue_CSD_compartments):
       $ mtnormalise wmfod.mif wmfod_norm.mif gm.mif gm_norm.mif csf.mif csf_norm.mif -mask mask.mif
     Note how for each tissue compartment, the input and output images are
     provided as a consecutive pair.

OPTIONS

  -mask image
     the mask defines the data used to compute the intensity normalisation.
     This option is mandatory.

  -order number
     the maximum order of the polynomial basis used to fit the normalisation
     field in the log-domain. An order of 0 is equivalent to not allowing
     spatial variance of the intensity normalisation factor. (default: 3)

  -niter number
     set the number of iterations. The first (and potentially only) entry
     applies to the main loop. If supplied as a comma-separated list of
     integers, the second entry applies to the inner loop to update the balance
     factors (default: 15,7).

  -reference number
     specify the (positive) reference value to which the summed tissue
     compartments will be normalised. (default: 0.282095, SH DC term for unit
     angular integral)

  -balanced
     incorporate the per-tissue balancing factors into scaling of the output
     images (NOTE: use of this option has critical consequences for AFD
     intensity normalisation; should not be used unless these consequences are
     fully understood)

Debugging options

  -check_norm image
     output the final estimated spatially varying intensity level that is used
     for normalisation.

  -check_mask image
     output the final mask used to compute the normalisation. This mask
     excludes regions identified as outliers by the optimisation process.

  -check_factors file
     output the tissue balance factors computed during normalisation.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Thijs Dhollander (thijs.dhollander@gmail.com), Rami Tabbara
     (rami.tabbara@florey.edu.au), David Raffelt (david.raffelt@florey.edu.au),
     Jonas Rosnarho-Tornstrand (jonas.rosnarho-tornstrand@kcl.ac.uk) and
     J-Donald Tournier (jdtournier@gmail.com)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Raffelt, D.; Dhollander, T.; Tournier, J.-D.; Tabbara, R.; Smith, R. E.;
     Pierre, E. & Connelly, A. Bias Field Correction and Intensity
     Normalisation for Quantitative Analysis of Apparent Fibre Density. In
     Proc. ISMRM, 2017, 26, 3541

     Dhollander, T.; Tabbara, R.; Rosnarho-Tornstrand, J.; Tournier, J.-D.;
     Raffelt, D. & Connelly, A. Multi-tissue log-domain intensity and
     inhomogeneity normalisation for quantitative apparent fibre density. In
     Proc. ISMRM, 2021, 29, 2472

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrclusterstats

### Tool Description
Voxel-based analysis using permutation testing and threshold-free cluster enhancement

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     mrclusterstats                      Oct 21 2025

     mrclusterstats: part of the MRtrix3 package

SYNOPSIS

     Voxel-based analysis using permutation testing and threshold-free cluster
     enhancement

USAGE

     mrclusterstats [ options ] input design contrast mask output

        input        a text file containing the file names of the input images,
                     one file per line

        design       the design matrix

        contrast     the contrast matrix

        mask         a mask used to define voxels included in the analysis.

        output       the filename prefix for all output.


DESCRIPTION

     In some software packages, a column of ones is automatically added to the
     GLM design matrix; the purpose of this column is to estimate the "global
     intercept", which is the predicted value of the observed variable if all
     explanatory variables were to be zero. However there are rare situations
     where including such a column would not be appropriate for a particular
     experimental design. Hence, in MRtrix3 statistical inference commands, it
     is up to the user to determine whether or not this column of ones should
     be included in their design matrix, and add it explicitly if necessary.
     The contrast matrix must also reflect the presence of this additional
     column.

Options relating to shuffling of data for nonparametric statistical inference

  -notest
     don't perform statistical inference; only output population statistics
     (effect size, stdev etc)

  -errors spec
     specify nature of errors for shuffling; options are: ee,ise,both (default:
     ee)

  -exchange_within file
     specify blocks of observations within each of which data may undergo
     restricted exchange

  -exchange_whole file
     specify blocks of observations that may be exchanged with one another (for
     independent and symmetric errors, sign-flipping will occur block-wise)

  -strong
     use strong familywise error control across multiple hypotheses

  -nshuffles number
     the number of shuffles (default: 5000)

  -permutations file
     manually define the permutations (relabelling). The input should be a text
     file defining a m x n matrix, where each relabelling is defined as a
     column vector of size m, and the number of columns, n, defines the number
     of permutations. Can be generated with the palm_quickperms function in
     PALM (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM). Overrides the
     -nshuffles option.

  -nonstationarity
     perform empirical non-parametric non-stationarity correction

  -skew_nonstationarity value
     specify the skew parameter for empirical statistic calculation (default
     for this command is 1)

  -nshuffles_nonstationarity number
     the number of shuffles to use when precomputing the empirical statistic
     image for non-stationarity correction (default: 5000)

  -permutations_nonstationarity file
     manually define the permutations (relabelling) for computing the emprical
     statistics for non-stationarity correction. The input should be a text
     file defining a m x n matrix, where each relabelling is defined as a
     column vector of size m, and the number of columns, n, defines the number
     of permutations. Can be generated with the palm_quickperms function in
     PALM (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM) Overrides the
     -nshuffles_nonstationarity option.

Options for controlling TFCE behaviour

  -tfce_dh value
     the height increment used in the tfce integration (default: 0.1)

  -tfce_e value
     tfce extent exponent (default: 0.5)

  -tfce_h value
     tfce height exponent (default: 2)

Options related to the General Linear Model (GLM)

  -variance file
     define variance groups for the G-statistic; measurements for which the
     expected variance is equivalent should contain the same index

  -ftests path
     perform F-tests; input text file should contain, for each F-test, a row
     containing ones and zeros, where ones indicate the rows of the contrast
     matrix to be included in the F-test.

  -fonly
     only assess F-tests; do not perform statistical inference on entries in
     the contrast matrix

  -column path  (multiple uses permitted)
     add a column to the design matrix corresponding to subject voxel-wise
     values (note that the contrast matrix must include an additional column
     for each use of this option); the text file provided via this option
     should contain a file name for each subject

Additional options for mrclusterstats

  -threshold value
     the cluster-forming threshold to use for a standard cluster-based
     analysis. This disables TFCE, which is the default otherwise.

  -connectivity
     use 26-voxel-neighbourhood connectivity (Default: 6)

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If not using the -threshold command-line option:
     Smith, S. M. & Nichols, T. E. Threshold-free cluster enhancement:
     Addressing problems of smoothing, threshold dependence and localisation in
     cluster inference. NeuroImage, 2009, 44, 83-98

     * If using the -nonstationary option:
     Salimi-Khorshidi, G. Smith, S.M. Nichols, T.E. Adjusting the effect of
     nonstationarity in cluster-based and TFCE inference. Neuroimage, 2011,
     54(3), 2006-19

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrhistmatch

### Tool Description
Modify the intensities of one image to match the histogram of another

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mrhistmatch                       Oct 21 2025

     mrhistmatch: part of the MRtrix3 package

SYNOPSIS

     Modify the intensities of one image to match the histogram of another

USAGE

     mrhistmatch [ options ] type input target output

        type         type of histogram matching to perform; options are:
                     scale,linear,nonlinear

        input        the input image to be modified

        target       the input image from which to derive the target histogram

        output       the output image


Image masking options

  -mask_input image
     only generate input histogram based on a specified binary mask image

  -mask_target image
     only generate target histogram based on a specified binary mask image

Non-linear histogram matching options

  -bins num
     the number of bins to use to generate the histograms

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If using inverse contrast normalization for inter-modal (DWI - T1)
     registration:
     Bhushan, C.; Haldar, J. P.; Choi, S.; Joshi, A. A.; Shattuck, D. W. &
     Leahy, R. M. Co-registration and distortion correction of diffusion and
     anatomical images based on inverse contrast normalization. NeuroImage,
     2015, 115, 269-280

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrmetric

### Tool Description
Computes a dissimilarity metric between two images

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                        mrmetric                         Oct 21 2025

     mrmetric: part of the MRtrix3 package

SYNOPSIS

     Computes a dissimilarity metric between two images

USAGE

     mrmetric [ options ] image1 image2

        image1       the first input image.

        image2       the second input image.


DESCRIPTION

     Currently only the mean squared difference is fully implemented.

OPTIONS

  -space iteration method
     voxel (default): per voxel image1: scanner space of image 1 image2:
     scanner space of image 2 average: scanner space of the average affine
     transformation of image 1 and 2

  -interp method
     set the interpolation method to use when reslicing (choices: nearest,
     linear, cubic, sinc. Default: linear).

  -metric method
     define the dissimilarity metric used to calculate the cost. Choices: diff
     (squared differences), cc (non-normalised negative cross correlation aka
     negative cross covariance). Default: diff). cc is only implemented for
     -space average and -interp linear and cubic.

  -mask1 image
     mask for image 1

  -mask2 image
     mask for image 2

  -nonormalisation
     do not normalise the dissimilarity metric to the number of voxels.

  -overlap
     output number of voxels that were used.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) and Max Pietsch
     (maximilian.pietsch@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrregister

### Tool Description
Register two images together using a symmetric rigid, affine or non-linear transformation model

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       mrregister                        Oct 21 2025

     mrregister: part of the MRtrix3 package

SYNOPSIS

     Register two images together using a symmetric rigid, affine or non-linear
     transformation model

USAGE

     mrregister [ options ] image1 image2 [ contrast1 contrast2 ... ]

        image1 image2  input image 1 ('moving') and input image 2 ('template')

        contrast1 contrast2  optional list of additional input images used as
                     additional contrasts. Can be used multiple times.
                     contrastX and imageX must share the same coordinate
                     system.


DESCRIPTION

     By default this application will perform an affine, followed by non-linear
     registration.

     FOD registration (with apodised point spread reorientation) will be
     performed by default if the number of volumes in the 4th dimension equals
     the number of coefficients in an antipodally symmetric spherical harmonic
     series (e.g. 6, 15, 28 etc). The -no_reorientation option can be used to
     force reorientation off if required.

     Non-linear registration computes warps to map from both image1->image2 and
     image2->image1. Similar to Avants (2008) Med Image Anal. 12(1): 26–41,
     registration is performed by matching both the image1 and image2 in a
     'midway space'. Warps can be saved as two deformation fields that map
     directly between image1->image2 and image2->image1, or if using
     -nl_warp_full as a single 5D file that stores all 4 warps
     image1->mid->image2, and image2->mid->image1. The 5D warp format stores
     x,y,z deformations in the 4th dimension, and uses the 5th dimension to
     index the 4 warps. The affine transforms estimated (to midway space) are
     also stored as comments in the image header. The 5D warp file can be used
     to reinitialise subsequent registrations, in addition to transforming
     images to midway space (e.g. for intra-subject alignment in a 2-time-point
     longitudinal analysis).

OPTIONS

  -type choice
     the registration type. Valid choices are: rigid, affine, nonlinear,
     rigid_affine, rigid_nonlinear, affine_nonlinear, rigid_affine_nonlinear
     (Default: affine_nonlinear)

  -transformed image  (multiple uses permitted)
     image1 after registration transformed and regridded to the space of
     image2. Note that -transformed needs to be repeated for each contrast if
     multi-contrast registration is used.

  -transformed_midway image1_transformed image2_transformed  (multiple uses permitted)
     image1 and image2 after registration transformed and regridded to the
     midway space. Note that -transformed_midway needs to be repeated for each
     contrast if multi-contrast registration is used.

  -mask1 filename
     a mask to define the region of image1 to use for optimisation.

  -mask2 filename
     a mask to define the region of image2 to use for optimisation.

  -nan
     use NaN as out of bounds value. (Default: 0.0)

Rigid registration options

  -rigid file
     the output text file containing the rigid transformation as a 4x4 matrix

  -rigid_1tomidway file
     the output text file containing the rigid transformation that aligns
     image1 to image2 in their common midway space as a 4x4 matrix

  -rigid_2tomidway file
     the output text file containing the rigid transformation that aligns
     image2 to image1 in their common midway space as a 4x4 matrix

  -rigid_init_translation type
     initialise the translation and centre of rotation
     Valid choices are:
     mass (aligns the centers of mass of both images, default),
     geometric (aligns geometric image centres) and none.

  -rigid_init_rotation type
     initialise the rotation Valid choices are:
     search (search for the best rotation using mean squared residuals),
     moments (rotation based on directions of intensity variance with respect
     to centre of mass),
     none (default).

  -rigid_init_matrix file
     initialise either the rigid, affine, or syn registration with the supplied
     rigid transformation (as a 4x4 matrix in scanner coordinates). Note that
     this overrides rigid_init_translation and rigid_init_rotation
     initialisation

  -rigid_scale factor
     use a multi-resolution scheme by defining a scale factor for each level
     using comma separated values (Default: 0.25,0.5,1.0)

  -rigid_niter num
     the maximum number of gradient descent iterations per stage. This can be
     specified either as a single number for all multi-resolution levels, or a
     single value for each level. (Default: 1000)

  -rigid_metric type
     valid choices are: diff (intensity differences), Default: diff

  -rigid_metric.diff.estimator type
     Valid choices are: l1 (least absolute: |x|), l2 (ordinary least squares),
     lp (least powers: |x|^1.2), Default: l2

  -rigid_lmax num
     explicitly set the lmax to be used per scale factor in rigid FOD
     registration. By default FOD registration will use lmax 0,2,4 with default
     scale factors 0.25,0.5,1.0 respectively. Note that no reorientation will
     be performed with lmax = 0.

  -rigid_log file
     write gradient descent parameter evolution to log file

Affine registration options

  -affine file
     the output text file containing the affine transformation as a 4x4 matrix

  -affine_1tomidway file
     the output text file containing the affine transformation that aligns
     image1 to image2 in their common midway space as a 4x4 matrix

  -affine_2tomidway file
     the output text file containing the affine transformation that aligns
     image2 to image1 in their common midway space as a 4x4 matrix

  -affine_init_translation type
     initialise the translation and centre of rotation
     Valid choices are:
     mass (aligns the centers of mass of both images),
     geometric (aligns geometric image centres) and none. (Default: mass)

  -affine_init_rotation type
     initialise the rotation Valid choices are:
     search (search for the best rotation using mean squared residuals),
     moments (rotation based on directions of intensity variance with respect
     to centre of mass),
     none (Default: none).

  -affine_init_matrix file
     initialise either the affine, or syn registration with the supplied affine
     transformation (as a 4x4 matrix in scanner coordinates). Note that this
     overrides affine_init_translation and affine_init_rotation initialisation

  -affine_scale factor
     use a multi-resolution scheme by defining a scale factor for each level
     using comma separated values (Default: 0.25,0.5,1.0)

  -affine_niter num
     the maximum number of gradient descent iterations per stage. This can be
     specified either as a single number for all multi-resolution levels, or a
     single value for each level. (Default: 1000)

  -affine_metric type
     valid choices are: diff (intensity differences), Default: diff

  -affine_metric.diff.estimator type
     Valid choices are: l1 (least absolute: |x|), l2 (ordinary least squares),
     lp (least powers: |x|^1.2), Default: l2

  -affine_lmax num
     explicitly set the lmax to be used per scale factor in affine FOD
     registration. By default FOD registration will use lmax 0,2,4 with default
     scale factors 0.25,0.5,1.0 respectively. Note that no reorientation will
     be performed with lmax = 0.

  -affine_log file
     write gradient descent parameter evolution to log file

Advanced linear transformation initialisation options

  -init_translation.unmasked1
     disregard mask1 for the translation initialisation (affects 'mass')

  -init_translation.unmasked2
     disregard mask2 for the translation initialisation (affects 'mass')

  -init_rotation.unmasked1
     disregard mask1 for the rotation initialisation (affects 'search' and
     'moments')

  -init_rotation.unmasked2
     disregard mask2 for the rotation initialisation (affects 'search' and
     'moments')

  -init_rotation.search.angles angles
     rotation angles for the local search in degrees between 0 and 180.
     (Default: 2,5,10,15,20)

  -init_rotation.search.scale scale
     relative size of the images used for the rotation search. (Default: 0.15)

  -init_rotation.search.directions num
     number of rotation axis for local search. (Default: 250)

  -init_rotation.search.run_global
     perform a global search. (Default: local)

  -init_rotation.search.global.iterations num
     number of rotations to investigate (Default: 10000)

Advanced linear registration stage options

  -linstage.iterations num or comma separated list
     number of iterations for each registration stage, not to be confused with
     -rigid_niter or -affine_niter. This can be used to generate intermediate
     diagnostics images (-linstage.diagnostics.prefix) or to change the cost
     function optimiser during registration (without the need to repeatedly
     resize the images). (Default: 1 == no repetition)

  -linstage.optimiser.first algorithm
     Cost function optimisation algorithm to use at first iteration of all
     stages. Valid choices: bbgd (Barzilai-Borwein gradient descent) or gd
     (simple gradient descent). (Default: bbgd)

  -linstage.optimiser.last algorithm
     Cost function optimisation algorithm to use at last iteration of all
     stages (if there are more than one). Valid choices: bbgd (Barzilai-Borwein
     gradient descent) or gd (simple gradient descent). (Default: bbgd)

  -linstage.optimiser.default algorithm
     Cost function optimisation algorithm to use at any stage iteration other
     than first or last iteration. Valid choices: bbgd (Barzilai-Borwein
     gradient descent) or gd (simple gradient descent). (Default: bbgd)

  -linstage.diagnostics.prefix file prefix
     generate diagnostics images after every registration stage

Non-linear registration options

  -nl_warp warp1 warp2
     the non-linear warp output defined as two deformation fields, where warp1
     can be used to transform image1->image2 and warp2 to transform
     image2->image1. The deformation fields also encapsulate any linear
     transformation estimated prior to non-linear registration.

  -nl_warp_full image
     output all warps used during registration. This saves four different warps
     that map each image to a midway space and their inverses in a single 5D
     image file. The 4th image dimension indexes the x,y,z component of the
     deformation vector and the 5th dimension indexes the field in this order:
     image1->midway, midway->image1, image2->midway, midway->image2. Where
     image1->midway defines the field that maps image1 onto the midway space
     using the reverse convention When linear registration is performed first,
     the estimated linear transform will be included in the comments of the
     image header, and therefore the entire linear and non-linear transform can
     be applied (in either direction) using this output warp file with
     mrtransform

  -nl_init image
     initialise the non-linear registration with the supplied warp image. The
     supplied warp must be in the same format as output using the -nl_warp_full
     option (i.e. have 4 deformation fields with the linear transforms in the
     image header)

  -nl_scale factor
     use a multi-resolution scheme by defining a scale factor for each level
     using comma separated values (Default: 0.25,0.5,1.0)

  -nl_niter num
     the maximum number of iterations. This can be specified either as a single
     number for all multi-resolution levels, or a single value for each level.
     (Default: 50)

  -nl_update_smooth stdev
     regularise the gradient update field with Gaussian smoothing (standard
     deviation in voxel units, Default 2.0)

  -nl_disp_smooth stdev
     regularise the displacement field with Gaussian smoothing (standard
     deviation in voxel units, Default 1.0)

  -nl_grad_step num
     the gradient step size for non-linear registration (Default: 0.5)

  -nl_lmax num
     explicitly set the lmax to be used per scale factor in non-linear FOD
     registration. By default FOD registration will use lmax 0,2,4 with default
     scale factors 0.25,0.5,1.0 respectively. Note that no reorientation will
     be performed with lmax = 0.

  -diagnostics_image path
     write intermediate images for diagnostics purposes

FOD registration options

  -directions file
     the directions used for FOD reorientation using apodised point spread
     functions (Default: 60 directions)

  -noreorientation
     turn off FOD reorientation. Reorientation is on by default if the number
     of volumes in the 4th dimension corresponds to the number of coefficients
     in an antipodally symmetric spherical harmonic series (i.e. 6, 15, 28, 45,
     66 etc)

Multi-contrast options

  -mc_weights weights
     relative weight of images used for multi-contrast registration. Default:
     1.0 (equal weighting)

Data type options

  -datatype spec
     specify output image data type. Valid choices are: float32, float32le,
     float32be, float64, float64le, float64be, int64, uint64, int64le,
     uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be,
     uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32,
     cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8,
     bit.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status; alternatively,
     this can be achieved by setting the MRTRIX_QUIET environment variable to a
     non-empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files (caution: using the same file as input and
     output might cause unexpected behaviour).

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     David Raffelt (david.raffelt@florey.edu.au) & Max Pietsch
     (maximilian.pietsch@kcl.ac.uk)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.
     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at http://mozilla.org/MPL/2.0/.
     Covered Software is provided under this License on an "as is"
     basis, without warranty of any kind, either expressed, implied, or
     statutory, including, without limitation, warranties that the
     Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing.
     See the Mozilla Public License v. 2.0 for more details.
     For more details, see http://www.mrtrix.org/.

REFERENCES
     * If FOD registration is being performed:
     Raffelt, D.; Tournier, J.-D.; Fripp, J; Crozier, S.; Connelly, A. &
     Salvado, O. Symmetric diffeomorphic registration of fibre orientation
     distributions. NeuroImage, 2011, 56(3), 1171-1180

     Raffelt, D.; Tournier, J.-D.; Crozier, S.; Connelly, A. & Salvado, O.
     Reorientation of fiber orientation distributions using apodized point
     spread functions. Magnetic Resonance in Medicine, 2012, 67, 844-855

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_mrtrix_cleanup

### Tool Description
Clean up residual temporary files & scratch directories from MRtrix3 commands

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                     mrtrix_cleanup

     mrtrix_cleanup: part of the MRtrix3 package

SYNOPSIS

     Clean up residual temporary files & scratch directories from MRtrix3
     commands

USAGE

     mrtrix_cleanup [ options ] path

        path         Path from which to commence filesystem search

DESCRIPTION

     This script will search the file system at the specified location (and in
     sub-directories thereof) for any temporary files or directories that have
     been left behind by failed or terminated MRtrix3 commands, and attempt to
     delete them.

     Note that the script's search for temporary items will not extend beyond
     the user-specified filesystem location. This means that any built-in or
     user-specified default location for MRtrix3 piped data and scripts will not
     be automatically searched. Cleanup of such locations should instead be
     performed explicitly: e.g. "mrtrix_cleanup /tmp/" to remove residual piped
     images from /tmp/.

     This script should not be run while other MRtrix3 commands are being
     executed: it may delete temporary items during operation that may lead to
     unexpected behaviour.

OPTIONS

  -test
     Run script in test mode: will list identified files / directories, but not
     attempt to delete them

  -failed file
     Write list of items that the script failed to delete to a text file

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## mrtrix3_labelsgmfix

### Tool Description
In a FreeSurfer parcellation image, replace the sub-cortical grey matter structure delineations using FSL FIRST

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS

### Original Help Text
```text
MRtrix 3.0.8                       labelsgmfix

     labelsgmfix: part of the MRtrix3 package

SYNOPSIS

     In a FreeSurfer parcellation image, replace the sub-cortical grey matter
     structure delineations using FSL FIRST

USAGE

     labelsgmfix [ options ] parc t1 lut output

        parc         The input FreeSurfer parcellation image

        t1           The T1 image to be provided to FIRST

        lut          The lookup table file that the parcellated image is based
                     on

        output       The output parcellation image

OPTIONS

  -premasked
     Indicate that brain masking has been applied to the T1 input image

  -sgm_amyg_hipp
     Consider the amygdalae and hippocampi as sub-cortical grey matter
     structures, and also replace their estimates with those from FIRST

Additional standard options for Python scripts

  -nocleanup
     do not delete intermediate files during script execution, and do not delete
     scratch directory at script completion.

  -scratch /path/to/scratch/
     manually specify the path in which to generate the scratch directory.

  -continue <ScratchDir> <LastFile>
     continue the script from a previous execution; must provide the scratch
     directory path, and the name of the last successfully-generated file.

Standard options

  -info
     display information messages.

  -quiet
     do not display information messages or progress status. Alternatively, this
     can be achieved by setting the MRTRIX_QUIET environment variable to a non-
     empty string.

  -debug
     display debugging messages.

  -force
     force overwrite of output files.

  -nthreads number
     use this number of threads in multi-threaded applications (set to 0 to
     disable multi-threading).

  -config key value  (multiple uses permitted)
     temporarily set the value of an MRtrix config file entry.

  -help
     display this information page and exit.

  -version
     display version information and exit.

AUTHOR
     Robert E. Smith (robert.smith@florey.edu.au)

COPYRIGHT
     Copyright (c) 2008-2025 the MRtrix3 contributors.  This Source Code Form is
     subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
     the MPL was not distributed with this file, You can obtain one at
     http://mozilla.org/MPL/2.0/.  Covered Software is provided under this
     License on an "as is" basis, without warranty of any kind, either
     expressed, implied, or statutory, including, without limitation, warranties
     that the Covered Software is free of defects, merchantable, fit for a
     particular purpose or non-infringing. See the Mozilla Public License v. 2.0
     for more details.  For more details, see http://www.mrtrix.org/.

REFERENCES

     Patenaude, B.; Smith, S. M.; Kennedy, D. N. & Jenkinson, M. A Bayesian
     model of shape and appearance for subcortical brain segmentation.
     NeuroImage, 2011, 56, 907-922

     Smith, S. M.; Jenkinson, M.; Woolrich, M. W.; Beckmann, C. F.; Behrens, T.
     E.; Johansen-Berg, H.; Bannister, P. R.; De Luca, M.; Drobnjak, I.;
     Flitney, D. E.; Niazy, R. K.; Saunders, J.; Vickers, J.; Zhang, Y.; De
     Stefano, N.; Brady, J. M. & Matthews, P. M. Advances in functional and
     structural MR image analysis and implementation as FSL. NeuroImage, 2004,
     23, S208-S219

     Smith, R. E.; Tournier, J.-D.; Calamante, F. & Connelly, A. The effects of
     SIFT on the reproducibility and biological accuracy of the structural
     connectome. NeuroImage, 2015, 104, 253-265

     Tournier, J.-D.; Smith, R. E.; Raffelt, D.; Tabbara, R.; Dhollander, T.;
     Pietsch, M.; Christiaens, D.; Jeurissen, B.; Yeh, C.-H. & Connelly, A.
     MRtrix3: A fast, flexible and open software framework for medical image
     processing and visualisation. NeuroImage, 2019, 202, 116137
```

## Metadata
- **Skill**: generated

## mrtrix3_fixelcfestats

### Tool Description
Statistical analysis of fixel-based data using Connectivity-based Fixel Enhancement (CFE).

### Metadata
- **Docker Image**: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
- **Homepage**: https://www.mrtrix.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mrtrix3/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3166636788: no space left on device
```

