* [Atlas Documentation](./)
* [ATLAS and the ATLAS-pipeline](/)
* [**1** Getting started](/getting_started)
  + [**1.1** Installation using Conda](/installation-using-conda)
  + [**1.2** Installation from source](/installation-from-source)
  + [**1.3** Running ATLAS](/running-atlas)
  + [**1.4** Quickstart](/quickstart)
* [**2** Workflows](/workflows)
  + [**2.1** Low-depth sequencing](/low-depth-sequencing)
  + [**2.2** Ancient DNA](/ancient-dna)
* [**3** Tutorial](/tutorial)
  + [**3.1** Data from a Single Individual](/data-from-a-single-individual)
  + [**3.2** Data from One Population](/data-from-one-population)
  + [**3.3** Data from many Populations](/data-from-many-populations)
* [**4** Read tasks](/read-tasks)
  + [**4.1** assessSoftClipping](/assesssoftclipping)
  + [**4.2** BAMDiagnostics](/bamdiagnostics)
  + [**4.3** downsample](/downsample)
  + [**4.4** filterBAM](/filterbam)
  + [**4.5** mergeOverlappingReads](/mergeoverlappingreads)
  + [**4.6** mergeRG](/mergerg)
  + [**4.7** PMDS](/pmds)
  + [**4.8** qualityTransformation](/qualitytransformation)
* [**5** Site tasks](/site-tasks)
  + [**5.1** allelicDepth](/allelicdepth)
  + [**5.2** call](/call)
  + [**5.3** createMask](/createmask)
  + [**5.4** estimateErrors](/estimateerrors)
  + [**5.5** GLF](/glf)
  + [**5.6** summaryStats](/summarystats)
  + [**5.7** mutationLoad](/mutationload)
  + [**5.8** pileup](/pileup)
  + [**5.9** pileupToBed](/pileuptobed)
  + [**5.10** PSMC](/psmc)
  + [**5.11** thetaRatio](/thetaratio)
* [**6** Population tasks](/population-tasks)
  + [**6.1** alleleCounts](/allelecounts)
  + [**6.2** alleleFreq](/allelefreq)
  + [**6.3** ancestralAlleles](/ancestralalleles)
  + [**6.4** calculateF2](/calculatef2)
  + [**6.5** geneticDist](/geneticdist)
  + [**6.6** inbreeding](/inbreeding)
  + [**6.7** majorMinor](/majorminor)
  + [**6.8** printGLF](/printglf)
  + [**6.9** saf](/saf)
* [**7** VCF Tasks](/vcf-tasks)
  + [**7.1** convertVCF](/convertvcf)
  + [**7.2** testHardyWeinberg](/stesthardyweinberg)
  + [**7.3** VCFCompare](/vcfcompare)
  + [**7.4** VCFDiagnostics](/vcfdiagnostics)
* [**8** Simulation Tasks](/simulation-tasks)
  + [**8.1** simulate](/simulate)
* [**9** File Formats](/fileformats)
  + [**9.1** Beagle](/beagle)
  + [**9.2** geno](/geno)
  + [**9.3** LFMM](/lfmm)
  + [**9.4** posfile](/posfile)
  + [**9.5** genfile](/genfile)
* [**10** Filter parameters](/filter)
  + [**10.1** Filter parameters for Reads](/filter-parameters-for-reads)
  + [**10.2** Filter parameters for bases](/filter-parameters-for-bases)
  + [**10.3** Filter parameters for Parsing window settings](/filter-parameters-for-parsing-window-settings)
* [**11** Engine parameters](/engine)
* [**12** ATLAS-Pipeline](/atlas-pipeline)
  + [**12.1** Getting started](/getting-started)
  + [**12.2** Gaia](/gaia)
  + [**12.3** Rhea](/rhea)
  + [**12.4** Perses](/perses)
  + [**12.5** Pallas](/pallas)
  + [**12.6** Troubleshooting](/troubleshooting)
* [Published with bookdown](https://github.com/rstudio/bookdown)

# [Welcome to ATLAS, your guide to the world of low-depth and ancient DNA!](./)

## 1.2 Installation from source

### 1.2.1 Requirements

ATLAS requires the following programs/libraries to be pre-installed. If you do not have root access, you can install them locally.

* A compiler which is compatible with C++17 or higher.
  We recommend [gcc](https://gcc.gnu.org/) (version 9 or higher) or [clang](https://clang.llvm.org/) (version 5 or higher).
  You can check the pre-existing version on your system with `gcc --version` or `clang --version`.
* [cmake](https://cmake.org/install/), version 3.14 or higher.
  You can check the pre-existing version on your system with `cmake --version`.

### 1.2.2 Platforms

* On [Linux](https://kernel.org/) computers, you should be able to install atlas witout any difficulties.
* On Windows computers, use the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install).
* On Mac computers, use [Homebrew](https://brew.sh/) to install samtools, cmake, autoconf and automake:

```
brew install samtools cmake autoconf automake
```

* On most computing clusters, you can load recent cmake and gcc versions using [modules](https://modules.sourceforge.net/).
* You can also install the required build-tools and libraries using conda, however, it’s probably easier to just install atlas directly using conda (see above)

### 1.2.3 Download

ATLAS is hosted on bitbucket and can be downloaded with the command:

`git clone --depth 1 https://bitbucket.org/WegmannLab/atlas.git`

### 1.2.4 Compile

After cloning, navigate into the atlas folder (`cd atlas`) and execute the following commands:

```
mkdir -p build
cd build
cmake ..
make
```

If your platform has multiple cores, you can speed up the compilation using `make -j<N>`,
where N is the number of physical cores.

If the [ninja](https://ninja-build.org/) build-system is installed on your platform,
you can alternatively build using ninja instead of make, which will speed up the compilation:

```
mkdir -p build
cd build
cmake .. -GNinja
ninja
```

### 1.2.5 Compile using conda

As an alternative to using a locally installed compiler, you can also compile atlas using a conda environment:

```
conda env create -f conda.yml
conda activate atlas
mkdir -p build
cd build
```

As cmake and conda do not play together nicely, you need to tell cmake where conda puts its binnaries and libraries:

```
cmake .. -GNinja -DCONDA=ON -DCMAKE_C_COMPILER=$(which gcc) -DCMAKE_CXX_COMPILER=$(which g++) -DCMAKE_LIBRARY_PATH=$CONDA_PREFIX/lib -DCMAKE_INCLUDE_PATH=$CONDA_PREFIX/include
ninja
```

### 1.2.6 Update

ATLAS is under active construction. Obtain the newest version by pulling and compiling again:

```
cd atlas/build
git pull
make
```