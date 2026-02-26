# bart CWL Generation Report

## bart_avg

### Tool Description
Calculates (weighted) average along dimensions specified by bitmask.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tomdstanton/bart
- **Stars**: N/A
### Original Help Text
```text
Usage: avg [-w] <bitmask> <input> <output>

Calculates (weighted) average along dimensions specified by bitmask.

-w		weighted average
-h		help
```


## bart_bench

### Tool Description
Performs a series of micro-benchmarks.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bench [-T] [-S] [-s d] [<output>]

Performs a series of micro-benchmarks.

-T		varying number of threads
-S		varying problem size
-s flags      	select benchmarks
-h		help
```


## bart_bitmask

### Tool Description
Convert between a bitmask and set of dimensions.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bitmask [-b] -b <bitmask> | <dim1> ... <dimN>

Convert between a bitmask and set of dimensions.

-b		dimensions from bitmask
-h		help
```


## bart_cabs

### Tool Description
Usage: cabs <input> <output>

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cabs <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_caldir

### Tool Description
Estimates coil sensitivities from the k-space center using a direct method (McKenzie et al.). The size of the fully-sampled calibration region is automatically determined but limited by {cal_size} (e.g. in the readout direction).

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: caldir cal_size <input> <output>

Estimates coil sensitivities from the k-space center using
a direct method (McKenzie et al.). The size of the fully-sampled
calibration region is automatically determined but limited by
{cal_size} (e.g. in the readout direction).

-h		help
```


## bart_calmat

### Tool Description
Compute calibration matrix.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: calmat [-k ...] [-r ...] <kspace> <calibration matrix>

Compute calibration matrix.

-k ksize      	kernel size
-r cal_size      	Limits the size of the calibration region.
-h		help
```


## bart_carg

### Tool Description
Processes input and output files.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: carg <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_casorati

### Tool Description
Casorati matrix with kernel (kern1, ..., kernn) along dimensions (dim1, ..., dimn).

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: casorati dim1 kern1 dim2 kern2 ... dimn kernn <input> <output>

Casorati matrix with kernel (kern1, ..., kernn) along dimensions (dim1, ..., dimn).


-h		help
```


## bart_cc

### Tool Description
Performs coil compression.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cc [-p d] [-M] [-r ...] [-A] [-S ...] [-G ...] [-E ...] <kspace> <coeff>|<proj_kspace>

Performs coil compression.

-p N      	perform compression to N virtual channels
-M		output compression matrix
-r S      	size of calibration region
-A		use all data to compute coefficients
-S		type: SVD
-G		type: Geometric
-E		type: ESPIRiT
-h		help
```


## bart_ccapply

### Tool Description
Apply coil compression forward/inverse operation.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ccapply [-p d] [-u] [-t] [-S ...] [-G ...] [-E ...] <kspace> <cc_matrix> <proj_kspace>

Apply coil compression forward/inverse operation.

-p N      	perform compression to N virtual channels
-u		apply inverse operation
-t		don't apply FFT in readout
-S		type: SVD
-G		type: Geometric
-E		type: ESPIRiT
-h		help
```


## bart_cdf97

### Tool Description
Perform a wavelet (cdf97) transform.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cdf97 [-i] bitmask <input> <output>

Perform a wavelet (cdf97) transform.


-i		inverse
-h		help
```


## bart_circshift

### Tool Description
Perform circular shift along {dim} by {shift} elements.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: circshift dim shift <input> <output>

Perform circular shift along {dim} by {shift} elements.

-h		help
```


## bart_conj

### Tool Description
Concatenate files.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: conj <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_conv

### Tool Description
Performs a convolution along selected dimensions.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: conv bitmask <input> <kernel> <output>

Performs a convolution along selected dimensions.

-h		help
```


## bart_copy

### Tool Description
Copy an array (to a given position in the output file - which then must exist).

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: copy [dim1 pos1 ... dimn posn] <input> <output>

Copy an array (to a given position in the output file - which then must exist).

-h		help
```


## bart_cpyphs

### Tool Description
Copies a file

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cpyphs <input> <output
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_creal

### Tool Description
Input and output files for creal

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: creal <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_crop

### Tool Description
Extracts a sub-array corresponding to the central part of {size} along {dimension}

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: crop dimension size <input> <output>

Extracts a sub-array corresponding to the central part of {size} along {dimension}

-h		help
```


## bart_delta

### Tool Description
Calculates the delta between two images.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: delta dims flags size out
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_ecalib

### Tool Description
Estimate coil sensitivities using ESPIRiT calibration.
Optionally outputs the eigenvalue maps.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ecalib [-t f] [-c f] [-k ...] [-r ...] [-m d] [-S] [-W] [-I] [-1] [-P] [-v f] [-a] [-d d] <kspace> <sensitivites> [<ev-maps>]

Estimate coil sensitivities using ESPIRiT calibration.
Optionally outputs the eigenvalue maps.

-t threshold      	This determined the size of the null-space.
-c crop_value      	Crop the sensitivities if the eigenvalue is smaller than {crop_value}.
-k ksize      	kernel size
-r cal_size      	Limits the size of the calibration region.
-m maps      	Number of maps to compute.
-S		create maps with smooth transitions (Soft-SENSE).
-W		soft-weighting of the singular vectors.
-I		intensity correction
-1		perform only first part of the calibration
-P		Do not rotate the phase with respect to the first principal component
-v variance      	Variance of noise in data.
-a		Automatically pick thresholds.
-d level      	Debug level
-h		help
```


## bart_ecaltwo

### Tool Description
Second part of ESPIRiT calibration. Optionally outputs the eigenvalue maps.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ecaltwo [-c f] [-m d] [-S] x y z <input> <sensitivities> [<ev_maps>]

Second part of ESPIRiT calibration.
Optionally outputs the eigenvalue maps.

-c crop_value      	Crop the sensitivities if the eigenvalue is smaller than {crop_value}.
-m maps      	Number of maps to compute.
-S		Create maps with smooth transitions (Soft-SENSE).
-h		help
```


## bart_estdelay

### Tool Description
Estimate gradient delays from radial data.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: estdelay [-R] [-p d] [-n d] [-r f] <trajectory> <data>

Estimate gradient delays from radial data.

-R		RING method
-p p      	[RING] Padding
-n n      	[RING] Number of intersecting spokes
-r r      	[RING] Central region size
-h		help
```


## bart_estdims

### Tool Description
Estimate image dimension from non-Cartesian trajectory.
Assume trajectory scaled to -DIM/2 to DIM/2 (ie dk=1/FOV=1)

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: estdims <traj>

Estimate image dimension from non-Cartesian trajectory.
Assume trajectory scaled to -DIM/2 to DIM/2 (ie dk=1/FOV=1)

-h		help
```


## bart_estshift

### Tool Description
Estimate shift in spectral data

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: estshift flags <arg1> <arg2>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_estvar

### Tool Description
Estimate the noise variance assuming white Gaussian noise.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: estvar [-k ...] [-r ...] <kspace>

Estimate the noise variance assuming white Gaussian noise.

-k ksize      	kernel size
-r cal_size      	Limits the size of the calibration region.
-h		help
```


## bart_extract

### Tool Description
Extracts a sub-array along {dim} from index {start} to (not including) {end}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: extract dimension start end <input> <output>

Extracts a sub-array along {dim} from index {start} to (not including) {end}.

-h		help
```


## bart_fakeksp

### Tool Description
Recreate k-space from image and sensitivities.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fakeksp [-r] <image> <kspace> <sens> <output>

Recreate k-space from image and sensitivities.

-r		replace measured samples with original values
-h		help
```


## bart_fft

### Tool Description
Performs a fast Fourier transform (FFT) along selected dimensions.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fft [-u] [-i] [-n] bitmask <input> <output>

Performs a fast Fourier transform (FFT) along selected dimensions.

-u		unitary
-i		inverse
-n		un-centered
-h		help
```


## bart_fftmod

### Tool Description
Apply 1 -1 modulation along dimensions selected by the {bitmask}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fftmod [-i] bitmask <input> <output>

Apply 1 -1 modulation along dimensions selected by the {bitmask}.


-i		inverse
-h		help
```


## bart_fftshift

### Tool Description
Apply fftshift along dimensions selected by the {bitmask}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fftshift bitmask <input> <output>

Apply fftshift along dimensions selected by the {bitmask}.

-h		help
```


## bart_filter

### Tool Description
Apply filter.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: filter [-m d] [-l d] <input> <output>

Apply filter.


-m dim      	median filter along dimension dim
-l len      	length of filter
-h		help
```


## bart_flatten

### Tool Description
Flattens a nested structure.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: flatten <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_flip

### Tool Description
Flip (reverse) dimensions specified by the {bitmask}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: flip bitmask <input> <output>

Flip (reverse) dimensions specified by the {bitmask}.

-h		help
```


## bart_fmac

### Tool Description
Multiply <input1> and <input2> and accumulate in <output>. If <input2> is not specified, assume all-ones.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fmac [-A] [-C] [-s d] <input1> [<input2>] <output>

Multiply <input1> and <input2> and accumulate in <output>.
If <input2> is not specified, assume all-ones.

-A		add to existing output (instead of overwriting)
-C		conjugate input2
-s b      	squash dimensions selected by bitmask b
-h		help
```


## bart_homodyne

### Tool Description
Perform homodyne reconstruction along dimension dim.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: homodyne [-r f] [-I] [-C] [-P <string>] [-n] dim fraction <input> <output>

Perform homodyne reconstruction along dimension dim.

-r alpha      	Offset of ramp filter, between 0 and 1. alpha=0 is a full ramp, alpha=1 is a horizontal line
-I		Input is in image domain
-C		Clear unacquired portion of kspace
-P phase_ref>      	Use <phase_ref> as phase reference
-n		use uncentered ffts
-h		help
```


## bart_index

### Tool Description
Create an array counting from 0 to {size-1} in dimensions {dim}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: index dim size name

Create an array counting from 0 to {size-1} in dimensions {dim}.

-h		help
```


## bart_invert

### Tool Description
Invert array (1 / <input>). The output is set to zero in case of divide by zero.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: invert <input> <output>

Invert array (1 / <input>). The output is set to zero in case of divide by zero.

-h		help
```


## bart_itsense

### Tool Description
A simplified implementation of iterative sense reconstruction
with l2-regularization.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: itsense alpha <sensitivities> <kspace> <pattern> <image>

A simplified implementation of iterative sense reconstruction
with l2-regularization.

-h		help
```


## bart_join

### Tool Description
Join input files along {dimensions}. All other dimensions must have the same size.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: join [-a] dimension <input1> ... <inputn> <output>

Join input files along {dimensions}. All other dimensions must have the same size.
	 Example 1: join 0 slice_001 slice_002 slice_003 full_data
	 Example 2: join 0 `seq -f "slice_%%03g" 0 255` full_data


-a		append - only works for cfl files!
-h		help
```


## bart_lrmatrix

### Tool Description
Perform (multi-scale) low rank matrix completion

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lrmatrix [-d] [-i d] [-m d] [-f d] [-j d] [-k d] [-N] [-s] [-l d] [-o <string>] <input> <output>

Perform (multi-scale) low rank matrix completion

-d		perform decomposition instead, ie fully sampled
-i iter      	maximum iterations.
-m flags      	which dimensions are reshaped to matrix columns.
-f flags      	which dimensions to perform multi-scale partition.
-j scale      	block size scaling from one scale to the next one.
-k size      	smallest block size
-N		add noise scale to account for Gaussian noise.
-s		perform low rank + sparse matrix completion.
-l size      	perform locally low rank soft thresholding with specified block size.
-o out2      	summed over all non-noise scales to create a denoised output.
-h		help
```


## bart_mandelbrot

### Tool Description
Compute mandelbrot set.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mandelbrot [-s d] [-n d] [-t f] [-z f] [-r f] [-i f] output

Compute mandelbrot set.


-s size      	image size
-n #      	nr. of iterations
-t t      	threshold for divergence
-z z      	zoom
-r r      	offset real
-i i      	offset imag
-h		help
```


## bart_mip

### Tool Description
Maximum (minimum) intensity projection (MIP) along dimensions specified by bitmask.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mip [-m] [-a] bitmask <input> <output>

Maximum (minimum) intensity projection (MIP) along dimensions specified by bitmask.


-m		minimum
-a		do absolute value first
-h		help
```


## bart_nlinv

### Tool Description
Jointly estimate image and sensitivities with nonlinear inversion using {iter} iteration steps. Optionally outputs the sensitivities.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nlinv [-i d] [-d d] [-c] [-N] [-m d] [-U] [-f f] [-p <string>] [-I <string>] [-g] [-S] <kspace> <output> [<sensitivities>]

Jointly estimate image and sensitivities with nonlinear
inversion using {iter} iteration steps. Optionally outputs
the sensitivities.

-i iter      	Number of Newton steps
-d level      	Debug level
-c		Real-value constraint
-N		Do not normalize image with coil sensitivities
-m nmaps      	Number of ENLIVE maps to use in reconsctruction
-U		Do not combine ENLIVE maps in output
-f FOV      	
-p PSF      	
-I file      	File for initialization
-g		use gpu
-S		Re-scale image after reconstruction
-h		help
```


## bart_noise

### Tool Description
Add noise with selected variance to input.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: noise [-s d] [-r] [-n f] <input> <output>

Add noise with selected variance to input.

-s random seed initialization
-r		real-valued input
-n variance      	DEFAULT: 1.0
-h		help
```


## bart_normalize

### Tool Description
Normalize input data

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: normalize flags <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_nrmse

### Tool Description
Output normalized root mean square error (NRMSE), i.e. norm(input - ref) / norm(ref)

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nrmse [-t f] [-s] <reference> <input>

Output normalized root mean square error (NRMSE),
i.e. norm(input - ref) / norm(ref)

-t eps      	compare to eps
-s		automatic (complex) scaling
-h		help
```


## bart_nufft

### Tool Description
Perform non-uniform Fast Fourier Transform.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nufft [-a] [-i] [-d ...] [-t] [-r] [-c] [-l f] [-P] [-s] [-g] <traj> <input> <output>

Perform non-uniform Fast Fourier Transform.

-a		adjoint
-i		inverse
-d x:y:z      	dimensions
-t		Toeplitz embedding for inverse NUFFT
-r		turn-off Toeplitz embedding for inverse NUFFT
-c		Preconditioning for inverse NUFFT
-l lambda      	l2 regularization
-P		periodic k-space
-s		DFT
-g		GPU (only inverse)
-h		help
```


## bart_ones

### Tool Description
Create an array filled with ones with {dims} dimensions of size {dim1} to {dimn}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ones dims dim1 ... dimn name

Create an array filled with ones with {dims} dimensions of size {dim1} to {dimn}.

-h		help
```


## bart_pattern

### Tool Description
Compute sampling pattern from kspace

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pattern [-s d] <kspace> <pattern>

Compute sampling pattern from kspace


-s bitmask      	Squash dimensions selected by bitmask
-h		help
```


## bart_phantom

### Tool Description
Image and k-space domain phantoms.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phantom [-s d] [-S d] [-k] [-t <string>] [-x d] [-G d] [-3] <output>

Image and k-space domain phantoms.

-s nc      	nc sensitivities
-S Output nc sensitivities
-k		k-space
-t file      	trajectory
-x n      	dimensions in y and z
-G n=1,2      	Geometric object phantom
-3		3D
-h		help
```


## bart_pics

### Tool Description
Parallel-imaging compressed-sensing reconstruction.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pics [-l ...] [-r f] [-R ...] [-c] [-s f] [-i d] [-t <string>] [-n] [-N] [-g] [-G d] [-p <string>] [-I ...] [-b d] [-e] [-T <string>] [-W <string>] [-d d] [-O d] [-o f] [-u f] [-C d] [-q f] [-f f] [-m ...] [-w f] [-S] [-L d] [-K] [-B <string>] [-P f] [-a ...] [-M] <kspace> <sensitivities> <output>

Parallel-imaging compressed-sensing reconstruction.

-l1/-l2		toggle l1-wavelet or l2 regularization.
-r lambda      	regularization parameter
-R <T>:A:B:C	generalized regularization options (-Rh for help)
-c		real-value constraint
-s step      	iteration stepsize
-i iter      	max. number of iterations
-t file      	k-space trajectory
-n		disable random wavelet cycle spinning
-N		do fully overlapping LLR blocks
-g		use GPU
-G gpun      	use GPU device gpun
-p file      	pattern or weights
-I		select IST
-b blk      	Lowrank block size
-e		Scale stepsize based on max. eigenvalue
-T file      	(truth file)
-W <img>      	Warm start with <img>
-d level      	Debug level
-O rwiter      	(reweighting)
-o gamma      	(reweighting)
-u rho      	ADMM rho
-C iter      	ADMM max. CG iterations
-q cclambda      	(cclambda)
-f rfov      	restrict FOV
-m		select ADMM
-w val      	inverse scaling of the data
-S		re-scale the image after reconstruction
-L flags      	batch-mode
-K		randshift for NUFFT
-B file      	temporal (or other) basis
-P eps      	Basis Pursuit formulation, || y- Ax ||_2 <= eps
-a		select Primal Dual
-M		Simultaneous Multi-Slice reconstruction
-h		help
```


## bart_pocsense

### Tool Description
Perform POCSENSE reconstruction.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pocsense [-i d] [-r f] [-l d] <kspace> <sensitivities> <output>

Perform POCSENSE reconstruction.

-i iter      	max. number of iterations
-r alpha      	regularization parameter
-l 1/-l2      	toggle l1-wavelet or l2 regularization
-h		help
```


## bart_poisson

### Tool Description
Computes Poisson-disc sampling pattern.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: poisson [-Y d] [-Z d] [-y f] [-z f] [-C d] [-v] [-e] [-s d] <outfile>

Computes Poisson-disc sampling pattern.

-Y size      	size dimension 1
-Z size      	size dimension 2
-y acc      	acceleration dim 1
-z acc      	acceleration dim 2
-C size      	size of calibration region
-v		variable density
-e		elliptical scanning
-s seed      	random seed
-h		help
```


## bart_poly

### Tool Description
Evaluate polynomial p(x) = a_0 + a_1 x + a_2 x^2 ... a_N x^N at x = {0, 1, ... , L - 1} where a_i are floats.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: poly L N a_0 a_1 ... a_N output

Evaluate polynomial p(x) = a_0 + a_1 x + a_2 x^2 ... a_N x^N at x = {0, 1, ... , L - 1} where a_i are floats.

-h		help
```


## bart_repmat

### Tool Description
Repeat input array multiple times along a certain dimension.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: repmat dimension repetitions <input> <output>

Repeat input array multiple times along a certain dimension.

-h		help
```


## bart_reshape

### Tool Description
Reshapes an array to new dimensions.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: reshape flags dim1 ... dimN <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_resize

### Tool Description
Resizes an array along dimensions to sizes by truncating or zero-padding.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: resize [-c] dim1 size1 ... dimn sizen <input> <output>

Resizes an array along dimensions to sizes by truncating or zero-padding.

-c		center
-h		help
```


## bart_rof

### Tool Description
Perform total variation denoising along dims <flags>.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rof <lambda> <flags> <input> <output>

Perform total variation denoising along dims <flags>.

-h		help
```


## bart_rss

### Tool Description
Calculates root of sum of squares along selected dimensions.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rss bitmask <input> <output>

Calculates root of sum of squares along selected dimensions.

-h		help
```


## bart_sake

### Tool Description
Use SAKE algorithm to recover a full k-space from undersampled data using low-rank matrix completion.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sake [-i d] [-s f] <kspace> <output>

Use SAKE algorithm to recover a full k-space from undersampled
data using low-rank matrix completion.

-i iter      	tnumber of iterations
-s size      	rel. size of the signal subspace
-h		help
```


## bart_saxpy

### Tool Description
Multiply input1 with scale factor and add input2.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: saxpy scale <input1> <input2> <output>

Multiply input1 with scale factor and add input2.

-h		help
```


## bart_scale

### Tool Description
Scale array by {factor}. The scale factor can be a complex number.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scale factor <input> <output>

Scale array by {factor}. The scale factor can be a complex number.

-h		help
```


## bart_sdot

### Tool Description
Compute dot product along selected dimensions.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sdot <input1> <input2>

Compute dot product along selected dimensions.

-h		help
```


## bart_show

### Tool Description
Outputs values or meta data.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: show [-m] [-d d] [-s <string>] [-f <string>] <input>

Outputs values or meta data.

-m		show meta data
-d dim      	show size of dimension
-s sep      	use <sep> as the separator
-f format      	use <format> as the format. Default: "%+e%+ei"
-h		help
```


## bart_slice

### Tool Description
Extracts a slice from {position} along {dimension}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: slice dimension position <input> <output>

Extracts a slice from {position} along {dimension}.

-h		help
```


## bart_spow

### Tool Description
Raise array to the power of {exponent}. The exponent can be a complex number.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: spow exponent <input> <output>

Raise array to the power of {exponent}. The exponent can be a complex number.

-h		help
```


## bart_sqpics

### Tool Description
Parallel-imaging compressed-sensing reconstruction.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sqpics [-l ...] [-r f] [-R ...] [-s f] [-i d] [-t <string>] [-n] [-g] [-p <string>] [-b d] [-e] [-T <string>] [-W <string>] [-d d] [-u f] [-C d] [-f f] [-m ...] [-w f] [-S] <kspace> <sensitivities> <output>

Parallel-imaging compressed-sensing reconstruction.

-l1/-l2		toggle l1-wavelet or l2 regularization.
-r lambda      	regularization parameter
-R <T>:A:B:C	generalized regularization options (-Rh for help)
-s step      	iteration stepsize
-i iter      	max. number of iterations
-t file      	k-space trajectory
-n		disable random wavelet cycle spinning
-g		use GPU
-p file      	pattern or weights
-b blk      	Lowrank block size
-e		Scale stepsize based on max. eigenvalue
-T file      	(truth file)
-W <img>      	Warm start with <img>
-d level      	Debug level
-u rho      	ADMM rho
-C iter      	ADMM max. CG iterations
-f rfov      	restrict FOV
-m		Select ADMM
-w val      	scaling
-S		Re-scale the image after reconstruction
-h		help
```


## bart_squeeze

### Tool Description
Squeezes a BART file.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: squeeze <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_std

### Tool Description
Compute standard deviation along selected dimensions specified by the {bitmask}

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: std bitmask <input> <output>

Compute standard deviation along selected dimensions specified by the {bitmask}

-h		help
```


## bart_svd

### Tool Description
Compute singular-value-decomposition (SVD).

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: svd [-e] <input> <U> <S> <VH>

Compute singular-value-decomposition (SVD).


-e		econ
-h		help
```


## bart_threshold

### Tool Description
Perform (soft) thresholding with parameter lambda.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: threshold [-H ...] [-W ...] [-L ...] [-D ...] [-j d] [-b d] lambda <input> <output>

Perform (soft) thresholding with parameter lambda.

-H		hard thresholding
-W		daubechies wavelet soft-thresholding
-L		locally low rank soft-thresholding
-D		divergence-free wavelet soft-thresholding
-j bitmask      	joint soft-thresholding
-b blocksize      	locally low rank block size
-h		help
```


## bart_toimg

### Tool Description
Create magnitude images as png or proto-dicom.
The first two non-singleton dimensions will
be used for the image, and the other dimensions
will be looped over.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: toimg [-g f] [-c f] [-w f] [-d] [-m] [-W] [-h] <input> <output_prefix>

Create magnitude images as png or proto-dicom.
The first two non-singleton dimensions will
be used for the image, and the other dimensions
will be looped over.


-g gamma      	gamma level
-c contrast      	contrast level
-w window      	window level
-d		write to dicom format (deprecated, use extension .dcm)
-m		re-scale each image
-W		use dynamic windowing
-h		help
```


## bart_traj

### Tool Description
Computes k-space trajectories.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: traj [-x d] [-y d] [-a d] [-t d] [-m d] [-l] [-g] [-r] [-G] [-H] [-D] [-q ...] [-Q ...] [-O] [-3] [-c] <output>

Computes k-space trajectories.

-x x      	readout samples
-y y      	phase encoding lines
-a a      	acceleration
-t t      	turns
-m mb      	SMS multiband factor
-l		aligned partition angle
-g		golden angle in partition direction
-r		radial
-G		golden-ratio sampling
-H		halfCircle golden-ratio sampling
-D		double base angle
-q delays      	gradient delays: x, y, xy
-Q delays      	(gradient delays: z, xz, yz)
-O		correct transverse gradient error for radial tajectories
-3		3D
-c		Asymmetric trajectory [DC sampled]
-h		help
```


## bart_transpose

### Tool Description
Transpose a 3D array.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: transpose dim1 dim2 <input> <output>
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_twixread

### Tool Description
Read data from Siemens twix (.dat) files.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: twixread [-x d] [-y d] [-z d] [-s d] [-v d] [-c d] [-n d] [-a d] [-A] [-L] [-P] <dat file> <output>

Read data from Siemens twix (.dat) files.

-x X      	number of samples (read-out)
-y Y      	phase encoding steps
-z Z      	partition encoding steps
-s S      	number of slices
-v V      	number of averages
-c C      	number of channels
-n N      	number of repetitions
-a A      	total number of ADCs
-A		automatic [guess dimensions]
-L		use linectr offset
-P		use partctr offset
-h		help
```


## bart_var

### Tool Description
Compute variance along selected dimensions specified by the {bitmask}

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: var bitmask <input> <output>

Compute variance along selected dimensions specified by the {bitmask}

-h		help
```


## bart_vec

### Tool Description
vec val1 val2 ... valN name

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vec val1 val2 ... valN name
[31mERROR: cmdline: too few or too many arguments
[0m
```


## bart_walsh

### Tool Description
Estimate coil sensitivities using walsh method (use with ecaltwo).

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: walsh [-r ...] [-b ...] <input> <output>

Estimate coil sensitivities using walsh method (use with ecaltwo).

-r cal_size      	Limits the size of the calibration region.
-b block_size      	Block size.
-h		help
```


## bart_wave

### Tool Description
Perform a wave-caipi reconstruction.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wave [-r f] [-i d] [-s f] [-c f] [-t f] [-e f] [-g d] [-f] [-H] [-w] [-v] <maps> <wave> <kspace> <output>

Perform a wave-caipi reconstruction.

Conventions:
  * (sx, sy, sz) - Spatial dimensions.
  * wx           - Extended FOV in READ_DIM due to
                   wave's voxel spreading.
  * (nc, md)     - Number of channels and ESPIRiT's 
                   extended-SENSE model operator
                   dimensions (or # of maps).
Expected dimensions:
  * maps    - (   sx, sy, sz, nc, md)
  * wave    - (   wx, sy, sz,  1,  1)
  * phi     - (    1,  1,  1,  1,  1)
  * output  - (   sx, sy, sz,  1, md)
  * reorder - (    n,  3,  1,  1,  1)
  * table   - (   wx, nc,  n,  1,  1)

-r lambda      	Soft threshold lambda for wavelet or locally low rank.
-i mxiter      	Maximum number of iterations.
-s stepsz      	Step size for iterative method.
-c cntnu      	Continuation value for IST/FISTA.
-t toler      	Tolerance convergence condition for iterative method.
-e eigvl      	Maximum eigenvalue of normal operator, if known.
-g gpunm      	GPU device number.
-f		Reconstruct using FISTA instead of IST.
-H		Use hogwild in IST/FISTA.
-w		Use wavelet.
-v		Apply real valued constraint on coefficients.
-h		help
```


## bart_wavelet

### Tool Description
Perform wavelet transform.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wavelet [-a] flags [dims] <input> <output>

Perform wavelet transform.

-a		adjoint (specify dims)
-h		help
```


## bart_wavepsf

### Tool Description
Generate a wave PSF in hybrid space.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wavepsf [-c] [-x d] [-y d] [-r f] [-a d] [-t f] [-g f] [-s f] [-n d] <output>

Generate a wave PSF in hybrid space.
- Assumes the first dimension is the readout dimension.
- Only generates a 2 dimensional PSF.
- Use reshape and fmac to generate a 3D PSF.

3D PSF Example:
bart wavepsf		-x 768 -y 128 -r 0.1 -a 3000 -t 0.00001 -g 0.8 -s 17000 -n 6 wY
bart wavepsf -c -x 768 -y 128 -r 0.1 -a 3000 -t 0.00001 -g 0.8 -s 17000 -n 6 wZ
bart reshape 7 wZ 768 1 128 wZ wZ
bart fmac wY wZ wYZ

-c		Set to use a cosine gradient wave
-x RO_dim      	Number of readout points
-y PE_dim      	Number of phase encode points
-r PE_res      	Resolution of phase encode in cm
-a ADC_T      	Readout duration in microseconds.
-t ADC_dt      	ADC sampling rate in seconds
-g gMax      	Maximum gradient amplitude in Gauss/cm
-s sMax      	Maximum gradient slew rate in Gauss/cm/second
-n ncyc      	Number of cycles in the gradient wave
-h		help
```


## bart_whiten

### Tool Description
Apply multi-channel noise pre-whitening on <input> using noise data <ndata>. Optionally output whitening matrix and noise covariance matrix

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: whiten [-o <string>] [-c <string>] [-n] <input> <ndata> <output> [<optmat_out>] [<covar_out>]

Apply multi-channel noise pre-whitening on <input> using noise data <ndata>.
Optionally output whitening matrix and noise covariance matrix

-o <optmat_in>      	use external whitening matrix <optmat_in>
-c <covar_in>      	use external noise covariance matrix <covar_in>
-n		normalize variance to 1 using noise data <ndata>
-h		help
```


## bart_window

### Tool Description
Apply Hamming (Hann) window to <input> along dimensions specified by flags

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: window [-H] flags <input> <output>

Apply Hamming (Hann) window to <input> along dimensions specified by flags

-H		Hann window
-h		help
```


## bart_wshfl

### Tool Description
Perform a wave-shuffling reconstruction.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: wshfl [-r f] [-b d] [-i d] [-s f] [-c f] [-t f] [-e f] [-F <string>] [-O <string>] [-g d] [-f] [-H] [-w] [-l] [-v] <maps> <wave> <phi> <reorder> <table> <output>

Perform a wave-shuffling reconstruction.

Conventions:
  * (sx, sy, sz) - Spatial dimensions.
  * wx           - Extended FOV in READ_DIM due to
                   wave's voxel spreading.
  * (nc, md)     - Number of channels and ESPIRiT's 
                   extended-SENSE model operator
                   dimensions (or # of maps).
  * (tf, tk)     - Turbo-factor and the rank
                   of the temporal basis used in
                   shuffling.
  * ntr          - Number of TRs, or the number of
                   (ky, kz) points acquired of one
                   echo image.
  * n            - Total number of (ky, kz) points
                   acquired. This is equal to the
                   product of ntr and tf.

Descriptions:
  * reorder is an (n by 3) index matrix such that
    [ky, kz, t] = reorder(i, :) represents the
    (ky, kz) kspace position of the readout line
    acquired at echo number (t), and 0 <= ky < sy,
    0 <= kz < sz, 0 <= t < tf).
  * table is a (wx by nc by n) matrix such that
    table(:, :, k) represents the kth multichannel
    kspace line.

Expected dimensions:
  * maps    - (   sx, sy, sz, nc, md,  1,  1)
  * wave    - (   wx, sy, sz,  1,  1,  1,  1)
  * phi     - (    1,  1,  1,  1,  1, tf, tk)
  * output  - (   sx, sy, sz,  1, md,  1, tk)
  * reorder - (    n,  3,  1,  1,  1,  1,  1)
  * table   - (   wx, nc,  n,  1,  1,  1,  1)

-r lambda      	Soft threshold lambda for wavelet or locally low rank.
-b blkdim      	Block size for locally low rank.
-i mxiter      	Maximum number of iterations.
-s stepsz      	Step size for iterative method.
-c cntnu      	Continuation value for IST/FISTA.
-t toler      	Tolerance convergence condition for iterative method.
-e eigvl      	Maximum eigenvalue of normal operator, if known.
-F frwrd      	Go from shfl-coeffs to data-table. Pass in coeffs path.
-O initl      	Initialize reconstruction with guess.
-g gpunm      	GPU device number.
-f		Reconstruct using FISTA instead of IST.
-H		Use hogwild in IST/FISTA.
-w		Use wavelet.
-l		Use locally low rank.
-v		Apply real valued constraint on coefficients.
-h		help
```


## bart_zeros

### Tool Description
Create a zero-filled array with {dims} dimensions of size {dim1} to {dimn}.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: zeros dims dim1 ... dimn name

Create a zero-filled array with {dims} dimensions of size {dim1} to {dimn}.

-h		help
```


## bart_zexp

### Tool Description
Point-wise complex exponential.

### Metadata
- **Docker Image**: biocontainers/bart:v0.4.04-2-deb_cv1
- **Homepage**: https://github.com/tomdstanton/bart
- **Package**: https://anaconda.org/channels/bioconda/packages/bart/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: zexp [-i] <input> <output>

Point-wise complex exponential.


-i		imaginary
-h		help
```

