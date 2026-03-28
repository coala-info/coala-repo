1. [Captus](/captus.docs/) >
2. [Basics](/captus.docs/basics/) >
3. Installation

* + [Using conda/mamba (recommended)](#using-condamamba-recommended)
  + [Manual installation](#manual-installation)

# Installation

### Using conda/mamba (recommended)

`Captus` is available as a [conda package](https://anaconda.org/bioconda/captus). If you have `conda`  or `mamba`  installed, you can easily create a new environment and install `Captus` with all dependencies using the following command:

##### Linux:

```
conda create -n captus -c bioconda -c conda-forge captus
```

or

```
mamba create -n captus -c bioconda -c conda-forge captus
```

##### Mac computers with Intel processors:

```
conda create -n captus -c bioconda -c conda-forge captus megahit=1.2.9=hfbae3c0_0
```

or

```
mamba create -n captus -c bioconda -c conda-forge captus megahit=1.2.9=hfbae3c0_0
```

##### Mac computers with Apple silicon (M processors):

```
conda create --platform osx-64 -n captus -c bioconda -c conda-forge captus megahit=1.2.9=hfbae3c0_0 mmseqs2=16.747c6
```

or

```
mamba create --platform osx-64 -n captus -c bioconda -c conda-forge captus megahit=1.2.9=hfbae3c0_0 mmseqs2=16.747c6
```

Then check that `Captus` was correctly installed:

```
conda activate captus
captus -h
```

If the program was correctly installed, you will see the following help message:

```
usage: captus command [options]

Captus 1.3.3: Assembly of Phylogenomic Datasets from High-Throughput Sequencing data

Captus-assembly commands:
  command     Program commands (in typical order of execution)
                clean = Trim adaptors and quality filter reads with BBTools,
                        run FastQC on the raw and cleaned reads
                assemble = Perform de novo assembly with MEGAHIT and estimate
                           contig depth of coverage with Salmon: Assembling
                           reads that were cleaned with the 'clean' command is
                           recommended, but reads cleaned elsewhere are also
                           allowed
                extract = Recover targeted markers with BLAT and Scipio:
                          Extracting markers from the assembly obtained with
                          the 'assemble' command is recommended, but any other
                          assemblies in FASTA format are also allowed
                align = Align extracted markers across samples with MAFFT or
                        MUSCLE: Marker alignment depends on the directory
                        structure created by the 'extract' command. This step
                        also performs paralog filtering and alignment trimming
                        using TAPER and ClipKIT

Help:
  -h, --help  Show this help message and exit
  --version   Show Captus' version number

For help on a particular command: captus_assembly command -h
```

---

### Manual installation

If you are unable to use `conda`/`mamba` for any reason, you will need to manually install all the dependencies listed below:

| Dependency | Version | URL |
| --- | --- | --- |
| `Python` | >=3.6 | <https://www.python.org> |
| `BBTools` |  | <https://jgi.doe.gov/data-and-tools/bbtools> |
| `BioPerl` |  | <https://bioperl.org> |
| `ClipKIT` | >=1.3.0 | <https://github.com/JLSteenwyk/ClipKIT> |
| `Falco` | >=0.3.0 | <https://github.com/smithlabcode/falco> |
| `FastQC` |  | <https://www.bioinformatics.babraham.ac.uk/projects/fastqc> |
| `MAFFT` |  | <https://mafft.cbrc.jp/alignment/software> |
| `MEGAHIT` | 1.2.9 | <https://github.com/voutcn/megahit> |
| `MMseqs2` |  | <https://github.com/soedinglab/MMseqs2> |
| `MUSCLE` | >=5.1 | <https://www.drive5.com/muscle> |
| `pandas` | >=2.1.0 | <https://pandas.pydata.org> |
| `Plotly` |  | <https://github.com/plotly/plotly.py> |
| `pigz` |  | <https://zlib.net/pigz> |
| `Salmon` | >=1.10.0 | <https://github.com/COMBINE-lab/salmon> |
| `tqdm` |  | <https://github.com/tqdm/tqdm> |
| `VSEARCH` |  | <https://github.com/torognes/vsearch> |
| `YAML` |  | <https://metacpan.org/pod/YAML> |

**\*** The following two dependencies are bundled with `Captus`, so no additional installation is required.

| Dependency | Version | URL |
| --- | --- | --- |
| `BLAT` | 37x1 | <http://hgdownload.soe.ucsc.edu/admin/exe> |
| `Scipio` | 1.4.1 | <https://www.webscipio.org> |

Once you have all the dependencies installed, you can proceed to clone the repository and install `Captus` as follows:

```
git clone https://github.com/edgardomortiz/Captus.git
cd Captus
pip install .
captus -h
```

Alternatively, you can run `Captus` using the wrapper script `captus_assembly-runner.py` as follows:

```
git clone https://github.com/edgardomortiz/Captus.git
./Captus/captus_assembly-runner.py -h
```

---

Created by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (06.08.2021)
Last modified by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (09.04.2025)

[![](/captus.docs/images/logo.svg)](/)

Search

* [Home](/captus.docs/)

* [x] Submenu Basics[Basics](/captus.docs/basics/)
  + [Overview](/captus.docs/basics/overview/)
  + [Installation](/captus.docs/basics/installation/)
  + [Parallelization](/captus.docs/basics/parallelization/)
* [ ] Submenu Assembly[Assembly](/captus.docs/assembly/)
  + [x] Submenu Clean[**1.** Clean](/captus.docs/assembly/clean/)
    - [Input Preparation](/captus.docs/assembly/clean/preparation/)
    - [Options](/captus.docs/assembly/clean/options/)
    - [Output Files](/captus.docs/assembly/clean/output/)
    - [HTML Report](/captus.docs/assembly/clean/report/)
  + [x] Submenu Assemble[**2.** Assemble](/captus.docs/assembly/assemble/)
    - [Input Preparation](/captus.docs/assembly/assemble/preparation/)
    - [Options](/captus.docs/assembly/assemble/options/)
    - [Output Files](/captus.docs/assembly/assemble/output/)
    - [HTML Report](/captus.docs/assembly/assemble/report/)
  + [x] Submenu Extract[**3.** Extract](/captus.docs/assembly/extract/)
    - [Input Preparation](/captus.docs/assembly/extract/preparation/)
    - [Options](/captus.docs/assembly/extract/options/)
    - [Output Files](/captus.docs/assembly/extract/output/)
    - [HTML Report](/captus.docs/assembly/extract/report/)
  + [x] Submenu Align[**4.** Align](/captus.docs/assembly/align/)
    - [Options](/captus.docs/assembly/align/options/)
    - [Output Files](/captus.docs/assembly/align/output/)
    - [HTML Report](/captus.docs/assembly/align/report/)
* [Design](/captus.docs/design/)
* [ ] Submenu Tutorials[Tutorials](/captus.docs/tutorials/)
  + [Basic](/captus.docs/tutorials/basic/)
  + [Advanced](/captus.docs/tutorials/advanced/)

More

* [GitHub repo](https://github.com/edgardomortiz/Captus)
* [Credits](/captus.docs/more/credits)

---

* Language
* Theme

  Green
* Clear History

[Download](https://github.com/edgardomortiz/Captus/archive/master.zip)
[Star](https://github.com/edgardomortiz/Captus)
[Fork](https://github.com/edgardomortiz/Captus/fork)

Built with  by [Hugo](https://gohugo.io/)