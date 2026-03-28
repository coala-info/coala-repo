Note

relion is distributed under a GPLv2 license, i.e. it is completely free, open-source software for both academia and industry.

# Installation[¶](#installation "Link to this heading")

The sections below explain how to download and install relion on your computer.

Note that relion depends on and uses several external programs and libraries.

C++ compiler:
:   RELION 5.0.1 requires a C++ compiler that fully supports the C++17 standard.
    For GCC, this means [version 5.0 or later](https://gcc.gnu.org/projects/cxx-status.html#cxx14).
    Note that GCC 4.8, which comes with RedHat Enterprise Linux / Cent OS 7.x, is too old.
    You can obtain newer GCC via devtoolset or use free Intel compiler that comes with oneAPI toolkit (see below).

MPI:
:   Your system will need [MPI](https://en.wikipedia.org/wiki/Message_Passing_Interface) runtime (most flavours will do).
    If you don’t have an MPI installation already on your system, we recommend installing [OpenMPI](http://www.open-mpi.org/).

CMake:
:   RELION uses [CMake](https://cmake.org/) for compilation.
    As of RELION 5.0.1, you need **CMake earlier than 3.27**.
    We will fix [this issue](https://github.com/3dem/relion/pull/1077) in future.

CUDA, HIP/ROCm, SYCL or oneAPI intel compilers:
:   If you have GPUs from nvidia, AMD or Intel, you can accelerate many jobs considerably.

    By default, relion will build with GPU-acceleration support, for which you’ll need cuda.
    Download it from [NVIDIA website](https://developer.nvidia.com/cuda-downloads).
    Note that CUDA toolkits support only a limited range of C compilers.
    Also note that a newer CUDA toolkit requires a newer GPU driver.
    Carefully read the release note and make sure you have a compatible set of GPU driver, C compiler and CUDA toolkit.
    **Importantly, CUDA >= 13.0 no longer supports Pascal GPUs (e.g. 1080 Ti, P100).**
    Please use CUDA 12.x if you use them.
    As of RELION 5.0.1, we test RELION builds with CUDA 11 to 13.

    If you want to compile with HIP/ROCm, you will need
    :   * [AMD ROCm](https://docs.amd.com/en/docs-5.7.1/deploy/linux/index.html)

    If you want to compile with SYCL, you will need
    :   * [Intel oneAPI Base Toolkit and HPC Toolkit](https://www.intel.com/content/www/us/en/developer/tools/oneapi/toolkits.html) (All components recommended; this is also recommended if you want to build the CPU acceleration path, see below)
        * [Intel software for general purpose GPU capabilities](https://dgpu-docs.intel.com)
        * [Intel CPU Runtime for OpenCL(TM) Applications](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-cpu-runtime-for-opencl-applications-with-sycl-support.html) (optional)
        * [Codeplay oneAPI for NVIDIA GPU](https://developer.codeplay.com/products/oneapi/nvidia) (optional)
        * [Codeplay oneAPI for AMD GPU](https://developer.codeplay.com/products/oneapi/amd) (optional)

CTFFIND-4.1:
:   CTF estimation is not part of relion.
    Instead, relion provides a wrapper to Alexis Rohou and Niko Grigorieff’s ctffind 4 [[RG15](Reference/Bibliography.html#id17)].
    Please obtain CTFFIND 4.1.x from [their Web site](https://grigoriefflab.umassmed.edu/ctf_estimation_ctffind_ctftilt).
    Note that CTFFIND 5.x is not supported.

Ghostscript:
:   RELION uses [Ghostscript](https://www.ghostscript.com/) to generate PDF files.

FLTK (only for GUI):
:   RELION uses [FLTK](https://www.fltk.org/) as a GUI tool kit.
    This will be installed automatically (see below).

X Window system libraries (only for GUI):
:   RELION needs basic X11 libraries together with [Xft](https://www.freedesktop.org/wiki/Software/Xft/) for the GUI.
    Most Linux distributions have packages called `libxft-dev` or `libXft-devel` and `libX11-devel`.
    Note that you need developer packages if you build your own FLTK.

FFT libraries:
:   RELION needs an FFT library.
    The default is [FFTW](https://www.fftw.org/).
    This will be installed automatically (see below).
    Depending on your CPU, [Intel MKL FFT](https://software.intel.com/mkl) or [AMD optimised FFTW](https://developer.amd.com/amd-aocl/fftw/) might run faster.
    See below how to use them.

libtiff:
:   RELION needs [libtiff](http://www.libtiff.org/) version >= 4.0.
    Most Linux distributions have packages called `libtiff-dev` or `libtiff-devel`.
    Note that you need a developer package.

libpng:
:   RELION needs [libpng](http://www.libpng.org/pub/png/libpng.html).
    Most Linux distributions have packages called `libpng-dev` or `libpng-devel`.
    Note that you need a developer package.

pbzip2, xz, zstd:
:   RELION needs these commands in the `PATH` to read MRC movies compressed by bzip2, xz or ZStandard, respectively.
    Note that RELION uses `pbzip2`, not `bzip2`.
    Most Linux distributions provide packages for these utilities.

UCSF MotionCor2 (optional):
:   relion implements its own (CPU-only) implementation of the UCSF motioncor2 algorithm for whole-frame micrograph movie-alignment [[ZPA+17](Reference/Bibliography.html#id12)].
    If you want, you can still use the (GPU-accelerated) UCSF program.
    You can download it from [David Agard’s page](http://msg.ucsf.edu/em/software/motioncor2.html) and follow his installation instructions.
    Note that using the UCSF program does not make full advantage of the opportunities provided in Bayesian polishing.

ResMap (optional):
:   Local-resolution estimation may be performed inside relion’s own postprocessing program.
    Alternatively, one can also use Alp Kucukelbir’s resmap [[KST14](Reference/Bibliography.html#id18)].
    Download it from [Alp’s ResMap website](http://resmap.sourceforge.net/) and follow his installation instructions.

In practice, most of these dependencies can be installed by system’s package manager if you have the root priviledge.

In Debian or Ubuntu:

```
sudo apt install cmake git build-essential mpi-default-bin mpi-default-dev libfftw3-dev libtiff-dev libpng-dev ghostscript libxft-dev
```

In RHEL, Cent OS, Scientific Linux:

```
sudo yum install cmake git gcc gcc-c++ openmpi-devel fftw-devel libtiff-devel libpng-devel ghostscript libXft-devel libX11-devel
```

## Download RELION[¶](#download-relion "Link to this heading")

We store the public release versions of relion on [GitHub](https://github.com/3dem/relion), a site that provides code-development with version control and issue tracking through the use of `git`.
We will not describe the use of git in general, as you will not need more than very basic features.
Below we outline the few commands needed on a UNIX-system, please refer to general git descriptions and tutorials to suit your system.
To get the code, you clone or download the repository.
We recommend cloning, because it allows you very easily update the code when new versions are released.
To do so, use the shell command-line:

```
git clone https://github.com/3dem/relion.git
```

This will create a local Git repository.
All subsequent git-commands should be run inside this directory.

To get access to the latest updates for (stable) release of RELION 5.0x, type:

```
git checkout ver5.0
```

The code will be intermittently updated to amend issues.
To incorporate these changes, use the command-line:

```
git pull
```

inside you local repository (the source-code directory downloaded).
If you have changed the code in some way, this will force you to commit a local merge.
You are free to do so, but we will assume you have not changed the code.
Refer to external instructions regarding git and merging so-called conflicts if you have changed the code an need to keep those changes.

## Setup a conda environment[¶](#setup-a-conda-environment "Link to this heading")

To add support for Python modules (e.g. Blush, ModelAngelo and DynaMight) you will have to setup a Python environment with dependencies.
We recommend installing via [Miniforge](https://github.com/conda-forge/miniforge) to avoid inadvertently installing packages from the restrictively licensed “default” conda repository.

Once you have conda setup, you can install all the RELION Python dependencies into a new environment by running:

```
conda env create -f environment.yml
```

Also code in this environment will be updated intermittently. You can incorporate the latest changes by running:

```
conda env update -f environment.yml
```

If you suspect an update is not applied properly, you can delete an existing RELION environment before recreating:

```
conda remove -n relion-5.0 --all
```

If you are using NVIDIA GPUs of the Blackwell generation (50x0) or newer, please use `environment_blackwell.yml` instead.

Warning

You should **NOT** activate this `relion-5.0` conda environment when compiling and using RELION;
RELION activates it automatically only when necessary.
Otherwise, system-wide installation of compilers/libraries/MPI runtime might get mixed up with those provided by conda, leading to compilation failures or runtime errors.
The same applies to other software packages that provide their own libraries/MPI runtime, such as CCPEM, CCP4, EMAN2, DIALS, PHENIX.

The `cmake` command should automatically detect the `relion-5.0` conda environment created above.
If it does not, you can specify `-DPYTHON_EXE_PATH=path/to/your/conda/python`.
Additionally, if you intend to make use of automatically downloaded pretrained model weights (used in e.g. Blush, ModelAngelo and class\_ranker), it is recommended to explicitly set the destination directory (`TORCH_HOME`) by including the flag `-DTORCH_HOME_PATH=path/to/torch/home`.
You have to create this directory before running `cmake`.
Otherwise, it will be downloaded to the default location (usually `~/.cache/torch`).

At the moment, the model weights for Blush are stored on MRC-LMB’s FTP server.
If your network blocks FTP, please follow [instructions here](https://github.com/3dem/relion/issues/1003#issuecomment-1786280151).

## Compilation[¶](#compilation "Link to this heading")

relion has an installation procedure which relies on `cmake`.
You will need to have this program installed, but most UNIX-systems have this by default.
You will need to make a build-directory in which the code will be compiled.
This can be placed inside the repository:

```
cd relion
mkdir build
cd build
```

You then invoke `cmake` inside the build-directoy, but point to the source-directoy to configure the installation.
This will not install relion, just configure the build:

```
cmake ..
```

The output will notify you of what was detected and what type of build will be installed.
Because relion is rich in terms of the possible configurations, it is important to check this output.
For instance:

* The path to the MPI library.
* GPU-capability will only be included if a CUDA SDK is detected.
  If not, the program will install, but without support for GPUs.
* The path to the Python interpreter.
* If FFTW is not detected, instructions are included to download and install it in a local directory known to the relion installation.
* As above, regarding FLTK (required for GUI).
  If a GUI is not desired, this can be escaped as explained in the following section.

The MPI library must be the one you intend to use relion with.
Compiling relion with one version of MPI and running the resulting binary with `mpirun` from another version can cause crash.
Note that some software packages (e.g. CCPEM, crYOLO, EMAN2) come with their own MPI runtime.
Sourcing/activating their environment might update `PATH` and `LD_LIBRARY_PATH` environmental variables and put their MPI runtime into the highest priority.

The MPI C++ compiler (`mpicxx`) and CUDA compiler (`nvcc`) internally calls a C++ compiler.
This must match the compiler `cmake` picked up.
Otherwise, the compilation might fail at the linking step.

Following the completion of cmake-configuration without errors, `make` is used to install the program:

```
make -j N
```

, where `N` is the number of processes to use during installation.
Using a higher number simply means that it will compile faster.

Take note of any warnings or errors reported.
relion will be installed in the `build` directory’s sub-directory called `bin`.
To make the installation system-wide, see below.

Wherever you install relion, make sure your `PATH` environmental variable points to the directory containing relion binaries.
Launching relion with a path like `/path/to/relion` is not the right way;
this starts the right GUI, but the GUI might invoke other versions of relion in the `PATH`.

## General configuration[¶](#general-configuration "Link to this heading")

[CMake](https://cmake.org/) allows configuration of many aspects of the installation, some of which are outlined here.
Note that by default, relion is configured to build with CUA acceleration on NVidia GPUs. Instructions for building with CPU, HIP/Rocm (AMD) SYCL (Intel et al) acceleration are given in the next section below.

Most options can be set by adding options to the `cmake` configuration.
Under the below subheadings, some example replacement commands are given to substitute the original configuration command.
It is also recommended to clean or purge your build-directory between builds, since CMake caches some of previous configurations:

```
cd build
rm -fr *
```

And of course, any of the below options can be combined.

Omitting the GUI:
:   `cmake -DGUI=OFF ..` (default is ON)

    With this option, GUI programs (e.g. `relion`, `relion_manualpick`, `relion_display`) are not be built and FLTK becomes unnecessary.

Using single-precision on the CPU:
:   `cmake -DDoublePrec_CPU=OFF ..` (default is ON)

    This will reduce (CPU but not GPU) memory consumption to about half.
    This is useful when memory hungry tasks such as motion correction and Polishing run out of memory.
    This is safe in most cases but please use the default double precision build if CtfRefine produces NaNs.

Using double-precision on the GPU:
:   `cmake -DDoublePrec_GPU=ON ..` (default is OFF)

    This will slow down GPU-execution considerably, while this does *NOT* improve the resolution.
    Thus, this option is not recommended.

Compiling NVIDIA GPU codes for your architecture:
:   `cmake -DCUDA_ARCH=52 ..` (default is 35, meaning compute capability 3.5, which is the lowest supported by relion)

    CUDA-capable NVIDIA devices have a so-called compute capability, which code can be compiled against for optimal performance.
    The compute capability of your card can be looked up at [the table in NVIDIA website](https://developer.nvidia.com/cuda-gpus).
    WARNING: If you use a wrong number, compilation might succeed but the resulting binary can fail at the runtime.

Forcing build and use of local FFTW:
:   `cmake -DFORCE_OWN_FFTW=ON ..`

    This will download, verify and install FFTW during the installation process.

Forcing build and use of AMD optimized FFTW:
:   `cmake -DFORCE_OWN_FFTW=ON -DAMDFFTW=ON ..`

    This will download, verify and inst