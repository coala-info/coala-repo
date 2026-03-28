* Home
* [Docs](docs.html)
* [GitHub](https://github.com/t-neumann/slamdunk)

![](images/slamdunk_logo_light.png)

### **Streamlining SLAMseq analysis with ultra-high sensitivity**

SlamDunk is a novel, fully automated software tool for automated, robust, scalable and reproducible SLAMseq data analysis.
Diagnostic plotting features and our MultiQC plugin will make your SLAMseq data ready for immediate QA and interpretation.

[GitHub](https://www.github.com/t-neumann/slamdunk)

[PyPI](https://pypi.python.org/pypi/slamdunk)

[Docker](https://hub.docker.com/r/tobneu/slamdunk)

[Docs](docs.html)

## SLAMseq

#### **SLAMseq**

SLAMseq is a novel sequencing protocol that directly uncovers 4-thiouridine incorporation events in RNA by high-throughput sequencing. When combined with metabolic labeling protocols, SLAM-seq allows to study the intracellular RNA dynamics, from transcription, RNA processing to RNA stability.

**Workflow of SLAMseq**

[![rna-seq](images/slam.png)](https://www.nature.com/articles/nmeth.4435/figures/2)

Original publication: [Herzog VA et al., Nature Methods, 2017; doi:10.1038/nmeth.4435](https://www.nature.com/articles/nmeth.4435)

---

## Quickstart

#### **Install**

##### **pip**

```
pip install slamdunk
```

##### **conda**

```
conda create --name myenv -c bioconda slamdunk
```

---

#### **Run SlamDunk**

```
slamdunk all -r <reference fasta> -b <bed file> -o <output directory> -5 12 -n 100
             -t <threads> -m -rl <maximum read length> --skip-sam files [files ...]
```

This runs *slamdunk* with its default parameters.

| Parameter | Description |
| --- | --- |
| **-r** | The reference fasta file. |
| **-b** | BED-file containing coordinates for 3’ UTRs. |
| **-o** | The output directory where all output files of this dunk will be placed. |
| **-t** | The number of threads to use for this dunk. NextGenMap runs multi-threaded, so it is recommended to use more threads than available samples (default: 1). |
| **files** | Samplesheet (see [*Sample file format*](docs.html#sample-file) ) or a list of all sample BAM/FASTA(gz)/FASTQ(gz) files (wildcard \* accepted). |

#### **Relevant results:**

* Folder *count* : Tab-separated *tcount* files containing the SLAM-Seq statistics per UTR (see [*Tcount file format*](docs.html#tcount-file) )
* Folder *filter* : BAM-files with the final mapped reads for visualization and further processing

---

#### **Check results**

If you want to have a very quick sanity check whether your desired conversion rates have been achieved, use this *alleyoop* command to plot the UTR conversion rates in your sample:

```
alleyoop utrrates -o <output directory> -r <reference fasta> -t <threads>
                  -b <bed file> -l <maximum read length> bam [bam ...]
```

| Parameter | Description |
| --- | --- |
| **-o** | The output directory where the plots will be placed. |
| **-r** | The reference fasta file. |
| **-t** | The number of threads to use. All tools run single-threaded, so it is recommended to use as many threads as available samples. |
| **-b** | BED-file containing coordinates for 3’ UTRs. |
| **-l** | Maximum read length in all samples. |
| **bam** | BAM file(s) containing the final filtered reads from the *filter* folder (wildcard \* accepted). |

## SlamDunk

SlamDunk consists of 4 core modules to process SLAMeq data:

* **map**
* + Map reads to genome
* **filter**
* + Filter alignments for low quality
* **snp**
* + Call variants on data to filter false-positives
* **count**
* + Quantify conversion rate per 3'UTR

![](images/slamdunk_flow.png)

![](images/ngm.png)

### T>C aware alignment

Using adapted scoring schemes for [NextGenMap](http://cibiv.github.io/NextGenMap/) - a highly sensitive and fast read mapping program - we are able confidently map reads with any reasonable number of T>C conversions to the genome.

![](images/multimappers.png)

### Multimapper reconciliation

We devised a reference guided approach to utilize multimapper information in 3'UTR regions of low complexity using efficient data structures.

![](images/variant.png)

### Variant exclusion

Using [Varscan2](http://dkoboldt.github.io/varscan/) we can separate true T>C conversions from false-positives caused by variants.

![](images/conversionrates.png)

### Conversion rate quantification

We devised a conversion counting method normalizing for T-content and coverage in individual 3'UTRs for unbiased comparison of transcripts.

## Installation

### **Dependencies**

#### **SlamDunk**

### ***slamdunk*** will fetch all dependencies **automatically** in its install phase. There is no need to have the requirements installed before installing *slamdunk*.

*slamdunk* depends on several python packages listed in the *requirements.txt* file.

In addition, *slamdunk* uses the following external software for its analysis:

* **[NextGenMap](http://cibiv.github.io/NextGenMap/)**
* **[Samtools](http://cibiv.github.io/NextGenMap/)** ≥ 1.3.1
* **[VarScan2](http://dkoboldt.github.io/varscan/)** (requires **Java**)
* **[R](https://www.r-project.org//)** 3.2.2

#### **Alleyoop / Splash**

Both *alleyoop* and *splash* require **[R (v3.2.2)](https://www.r-project.org/)**. All R package dependencies are resolved automatically from [CRAN](https://cran.r-project.org) during installation.

#### **Installation**

[pip](#pip) [conda](#conda) [development version](#dev)

SlamDunk is hosted as Python package on the [Python Package Index](https://pypi.python.org/pypi). You can install it with a single command using [pip](https://pypi.python.org/pypi/pip).

```
# Root
pip install slamdunk

# Local user
pip install --user slamdunk
```

SlamDunk is hosted as [conda](https://conda.io/docs/) package on [Bioconda](https://bioconda.github.io/recipes/slamdunk/README.html). You can install it with a single command into an environment of your choice.

```
conda create --name myenv -c bioconda slamdunk
```

The latest source of SlamDunk is hosted in our [GitHub repository](https://github.com/t-neumann/slamdunk). You can install it directly from there using [pip](https://pypi.python.org/pypi/pip).

```
# Grab source and install
pip install git+https://github.com/t-neumann/slamdunk.git
```

If you want to install all modules and dependencies manually from source, we have all install scripts in place.

**Note:** The recommended way to install python package dependencies is still using [pip](https://pypi.python.org/pypi/pip).

```
git clone https://github.com/t-neumann/slamdunk.git
cd slamdunk

# Root
pip install -r requirements.txt

# Local user
pip install --user -r requirements.txt

cd slamdunk/contrib

# Build dependencies
./build-ngm.sh
./build-varscan.sh
./build-samtools.sh
./build-rnaseqreadsimulator.sh

cd slamdunk/bin

# Run from directory
./slamdunk --help

# Put it in your $PATH to run it from anywherel
export PATH=$(pwd):$PATH

slamdunk --help
```

For maximum convenience, you might also consider running slamdunk using our [Docker](https://hub.docker.com/r/tobneu/slamdunk/) image.

## MultiQC

**[MultiQC](http://multiqc.info)** is a popular tool to aggregate results from bioinformatics analyses across many samples into a single report.

We implemented a MultiQC module which was released with **MultiQC v0.9** to support integration of SlamDunk QC plots and statistics into your MultiQC reports.

Currently we support integration of the *summary*, *rates*, *utrrates*, *tcperreadpos* and *tcperutrpos* modules.

You can download this report and / or the logs used to generate it, to try running MultiQC yourself.

[Download report](multiqc_example/slamdunk_report.zip)  [Download logs](multiqc_example/slamdunk_logs.zip)

MultiQC Example Reports

* [SlamDunk](multiqc_example/multiqc_report.html)

Many thanks to [Phil Ewels](https://github.com/ewels) for his support!

<

## Publications using SlamDunk

![](images/slamseq_workflow.png)

### Thiol-linked alkylation of RNA to assess expression dynamics

Veronika A. Herzog, Brian Reichholf, Tobias Neumann, Philipp Rescheneder, Pooja Bhat, Thomas R. Burkard, Wiebke Wlotzka, Arndt von Haeseler, Johannes Zuber & Stefan L. Ameres.

***Nature Methods***, 2017, [http://doi.org/10.1038/nmeth.4435](https://www.nature.com/articles/nmeth.4435)

![](images/SLAMseq_watch.jpg)

### SLAM-seq defines direct gene-regulatory functions of the BRD4-MYC axis

Matthias Muhar, Anja Ebert, Tobias Neumann, Christian Umkehrer, Julian Jude, Corinna Wieshofer, Philipp Rescheneder, Jesse J. Lipp, Veronika A. Herzog, Brian Reichholf, David A. Cisneros, Thomas Hoffmann, Moritz F. Schlapansky, Pooja Bhat, Arndt von Haeseler, Thomas Köcher, Anna C. Obenauf, Johannes Popow, Stefan L. Ameres & Johannes Zuber.

***Science***, 2018, [http://doi.org/10.1126/science.aao2793](http://science.sciencemag.org/content/360/6390/800)

![](images/slamitseq.png)

### SLAM-ITseq: Sequencing cell type-specific transcriptomes without cell sorting

Wayo Matsushima, Veronika A. Herzog, Tobias Neumann, Katharina Gapp, Johannes Zuber, Stefan L. Ameres, Eric A. Miska.

***Development***, 2018, [http://doi.org/10.1242/dev.164640](http://dev.biologists.org/content/145/13/dev164640)

## Citation

Neumann, T., Herzog, V. A., Muhar, M., Haeseler, von, A., Zuber, J., Ameres, S. L., & Rescheneder, P. (2019). **Quantification of experimentally induced nucleotide conversions in high-throughput sequencing datasets**. BMC Bioinformatics, 20(1), 258. <http://doi.org/10.1186/s12859-019-2849-7>

### Authors and Contributors

SlamDunk is developed by Tobias Neumann and Philipp Rescheneder.

[t-neumann](https://github.com/t-neumann) |  [philres](https://github.com/philres)

© Tobias Neumann.
Page template: [HTML5 UP](http://html5up.net)