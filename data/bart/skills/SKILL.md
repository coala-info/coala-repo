---
name: bart
description: bart performs high-throughput bacterial sequence typing and antimicrobial resistance gene detection from raw sequencing data. Use when user asks to identify sequence types, screen for AMR genes, or update MLST schemes and resistance databases.
homepage: https://github.com/tomdstanton/bart
---


# bart

## Overview

bart (Bacterial Read Typer) is a specialized bioinformatics tool designed for high-throughput bacterial typing. It streamlines the workflow from raw sequencing data to actionable genomic insights by using heuristics to automatically select the most appropriate MLST scheme for a given sample. Beyond sequence typing, it integrates AMR gene detection using the NCBI AMRFinderPlus database, making it a versatile tool for clinical microbiology and public health surveillance.

## Core CLI Usage

### MLST Analysis
The primary function of bart is to identify the Sequence Type (ST) of bacterial reads.

*   **Standard Paired-End:**
    `bart sample_R1.fq.gz sample_R2.fq.gz -r pe > output.tab`
*   **Nanopore/Long Reads:**
    `bart sample.fq.gz -r ont > output.tab`
*   **Forcing a Specific Scheme:**
    If the species is known, bypass heuristics to save time:
    `bart sample.fq.gz -s Staphylococcus_aureus > output.tab`

### AMR Gene Screening
Use the `-amr` flag to switch from MLST typing to resistance gene detection.
`bart sample.fq.gz -amr > amr_results.tab`

### Database Management
Use `bart-update` to maintain the local database of schemes and genes.

*   **List Available Schemes:** `bart-update -s`
*   **Update pubMLST Schemes:** `bart-update -p`
*   **Add Custom Scheme:** `bart-update -a custom_alleles.fasta custom_profiles.tab`
*   **Update AMR Index:** `bart-update -amr`

## Expert Tips and Best Practices

*   **Output Interpretation:**
    *   `gene(allele)`: Perfect match.
    *   `?`: Non-perfect hit (check identity/coverage).
    *   `~`: Potential novel hit.
    *   `-`: No hit found.
*   **Increasing Detail:** Use `-v` to see top hit alleles if they differ from the profile, or `-vv` ("verboser") to output specific mapping metrics including %identity, %coverage, and depth.
*   **Performance:** Always specify threads with `-t` (default is 4) to speed up the mapping process on multi-core systems.
*   **Alternative Hits:** Use the `-a` or `--alt` flag if you suspect a sample might contain multiple strains or if you want bart to consider alternative allele hits when assigning an ST.
*   **Manual Lookup:** Use the interactive `bart-profile [scheme]` command to manually check which ST corresponds to a specific combination of allele numbers.



## Subcommands

| Command | Description |
|---------|-------------|
| alpha | A simplified implementation of iterative sense reconstruction with l2-regularization. |
| avg | Calculates (weighted) average along dimensions specified by bitmask. |
| bart_casorati | Casorati matrix with kernel (kern1, ..., kernn) along dimensions (dim1, ..., dimn). |
| bart_crop | Extracts a sub-array corresponding to the central part of {size} along {dimension} |
| bart_estshift | Estimate shift in spectral data |
| bart_extract | Extracts a sub-array along {dim} from index {start} to (not including) {end}. |
| bart_flip | Flip (reverse) dimensions specified by the {bitmask}. |
| bart_index | Create an array counting from 0 to {size-1} in dimensions {dim}. |
| bart_ones | Create an array filled with ones with {dims} dimensions of size {dim1} to {dimn}. |
| bart_reshape | Reshapes an array to new dimensions. |
| bart_rss | Calculates root of sum of squares along selected dimensions. |
| bart_scale | Scale array by {factor}. The scale factor can be a complex number. |
| bart_slice | Extracts a slice from {position} along {dimension}. |
| bart_std | Compute standard deviation along selected dimensions specified by the {bitmask} |
| bart_transpose | Transpose a 3D array. |
| bart_var | Compute variance along selected dimensions specified by the {bitmask} |
| bart_vec | vec val1 val2 ... valN name |
| bart_wavepsf | Generate a wave PSF in hybrid space. |
| bart_zeros | Create a zero-filled array with {dims} dimensions of size {dim1} to {dimn}. |
| bench | Performs a series of micro-benchmarks. |
| bitmask | Convert between a bitmask and set of dimensions. |
| cabs | Usage: cabs <input> <output> |
| caldir | Estimates coil sensitivities from the k-space center using a direct method (McKenzie et al.). The size of the fully-sampled calibration region is automatically determined but limited by {cal_size} (e.g. in the readout direction). |
| calmat | Compute calibration matrix. |
| carg | Processes input and output files. |
| cc | Performs coil compression. |
| ccapply | Apply coil compression forward/inverse operation. |
| cdf97 | Perform a wavelet (cdf97) transform. |
| circshift | Perform circular shift along {dim} by {shift} elements. |
| conj | Concatenate files. |
| conv | Performs a convolution along selected dimensions. |
| copy | Copy an array (to a given position in the output file - which then must exist). |
| cpyphs | Copies a file |
| creal | Input and output files for creal |
| delta | Calculates the delta between two images. |
| ecalib | Estimate coil sensitivities using ESPIRiT calibration. Optionally outputs the eigenvalue maps. |
| ecaltwo | Second part of ESPIRiT calibration. Optionally outputs the eigenvalue maps. |
| estdelay | Estimate gradient delays from radial data. |
| estdims | Estimate image dimension from non-Cartesian trajectory. Assume trajectory scaled to -DIM/2 to DIM/2 (ie dk=1/FOV=1) |
| estvar | Estimate the noise variance assuming white Gaussian noise. |
| fakeksp | Recreate k-space from image and sensitivities. |
| fft | Performs a fast Fourier transform (FFT) along selected dimensions. |
| fftmod | Apply 1 -1 modulation along dimensions selected by the {bitmask}. |
| fftshift | Apply fftshift along dimensions selected by the {bitmask}. |
| filter | Apply filter. |
| flatten | Flattens a nested structure. |
| fmac | Multiply <input1> and <input2> and accumulate in <output>. If <input2> is not specified, assume all-ones. |
| homodyne | Perform homodyne reconstruction along dimension dim. |
| invert | Invert array (1 / <input>). The output is set to zero in case of divide by zero. |
| join | Join input files along {dimensions}. All other dimensions must have the same size. |
| lrmatrix | Perform (multi-scale) low rank matrix completion |
| mandelbrot | Compute mandelbrot set. |
| mip | Maximum (minimum) intensity projection (MIP) along dimensions specified by bitmask. |
| nlinv | Jointly estimate image and sensitivities with nonlinear inversion using {iter} iteration steps. Optionally outputs the sensitivities. |
| noise | Add noise with selected variance to input. |
| normalize | Normalize input data |
| nrmse | Output normalized root mean square error (NRMSE), i.e. norm(input - ref) / norm(ref) |
| nufft | Perform non-uniform Fast Fourier Transform. |
| pattern | Compute sampling pattern from kspace |
| phantom | Image and k-space domain phantoms. |
| pics | Parallel-imaging compressed-sensing reconstruction. |
| pocsense | Perform POCSENSE reconstruction. |
| poisson | Computes Poisson-disc sampling pattern. |
| poly | Evaluate polynomial p(x) = a_0 + a_1 x + a_2 x^2 ... a_N x^N at x = {0, 1, ... , L - 1} where a_i are floats. |
| repmat | Repeat input array multiple times along a certain dimension. |
| resize | Resizes an array along dimensions to sizes by truncating or zero-padding. |
| rof | Perform total variation denoising along dims <flags>. |
| sake | Use SAKE algorithm to recover a full k-space from undersampled data using low-rank matrix completion. |
| saxpy | Multiply input1 with scale factor and add input2. |
| sdot | Compute dot product along selected dimensions. |
| show | Outputs values or meta data. |
| spow | Raise array to the power of {exponent}. The exponent can be a complex number. |
| sqpics | Parallel-imaging compressed-sensing reconstruction. |
| squeeze | Squeezes a BART file. |
| svd | Compute singular-value-decomposition (SVD). |
| threshold | Perform (soft) thresholding with parameter lambda. |
| toimg | Create magnitude images as png or proto-dicom. The first two non-singleton dimensions will be used for the image, and the other dimensions will be looped over. |
| traj | Computes k-space trajectories. |
| twixread | Read data from Siemens twix (.dat) files. |
| walsh | Estimate coil sensitivities using walsh method (use with ecaltwo). |
| wave | Perform a wave-caipi reconstruction. |
| wavelet | Perform wavelet transform. |
| whiten | Apply multi-channel noise pre-whitening on <input> using noise data <ndata>. Optionally output whitening matrix and noise covariance matrix |
| window | Apply Hamming (Hann) window to <input> along dimensions specified by flags |
| wshfl | Perform a wave-shuffling reconstruction. |
| zexp | Point-wise complex exponential. |

## Reference documentation
- [bart README and Usage Guide](./references/github_com_tomdstanton_bart_blob_master_README.md)
- [bart Installation and Metadata](./references/github_com_tomdstanton_bart_blob_master_setup.py.md)