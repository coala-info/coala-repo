# [tandemtwister](https://lionward.github.io/tandemtwister/)

![grafik](logo_tandemtwister.svg)

TandemTwister is a fast tool for tandem repeat genotyping!

[![Conda Version](https://img.shields.io/conda/vn/bioconda/tandemtwister?label=conda%20%7C%20bioconda&logo=anaconda)](https://anaconda.org/bioconda/tandemtwister)

·
[Report Bug](https://github.com/Lionward/TandemTwister/issues)
·
[Request Feature](https://github.com/Lionward/TandemTwister/pulls)

## Table of Contents

* [Introducing TandemTwister](#introducing-tandemtwister)
* [Key features](#key-features)
* [Visualization Tool: ProleTRact](#visualization-tool-proletract)
* [Tandem Repeat Catalogs](#tandem-repeat-catalogs)
* [Installation](#Installation)
* [Usage](#usage)
  + [Required Input](#required-input)
  + [Global Options](#global-options)
  + [Dynamic Programming Alignment Parameters](#dynamic-programming-alignment-parameters)
  + [Germline & Somatic Analysis Options](#germline--somatic-analysis-options)
  + [Help](#help)
  + [Example](#example)
* [VCF INFO and FORMAT Field Descriptions](#vcf-info-and-format-field-descriptions)
* [Example Output](#example-output)
* [Test data](#test-data)
* [Contributions](#contributions)
* [Upcoming Features](#upcomingfeatures)
* [Acknowledgements](#acknowledgements)

## Introducing TandemTwister

TandemTwister is a user-friendly tool for genotyping tandem repeats that can handle
long-read data from various technologies — like **CLR**, **CCS**,
and ONT — as well as **Somatic** and **aligned genomes** as input.

## Key features

1. Versatile Compatibility: TandemTwister supports long-read sequencing data from CLR, CCS, and ONT technologies, ensuring adaptability to diverse genomic datasets.
2. Phasing Capabilities: The tool incorporates phasing algorithm, by leveraging distinctive features within TR regions.
3. Noise Correction for Short Motifs: TandemTwister includes specialized correction mechanisms for short motifs (≤3) in CLR and ONT reads, ensuring robust and accurate genotyping results in the presence of noisy data.
4. Speed and Scalability: Optimized for efficiency, TandemTwister supports multi-processing and can complete genotyping analyses for approximately 1.2 Mio regions in under 20 minutes using 32 threads.

   ## Visualization Tool: ProleTRact

TandemTwister comes with a companion visualization tool, [**ProleTRact**](https://github.com/Lionward/ProleTRact), which enables interactive exploration and visualization of genotyped tandem repeats. After running TandemTwister, you can use PRoleTRact to visulize the regions you’re analyzing.

* For more information and usage instructions, visit the [ProleTRact repository](https://github.com/Lionward/ProleTRact).

## Tandem Repeat Catalogs

For comprehensive tandem repeat analyses, the following resources provide curated TR catalogs and annotations:

1. **[TRcompDB v1.0](https://zenodo.org/records/13263615)**: A global reference of tandem repeat variation with motif sets and TR annotations from 360 long-read assemblies. Available for GRCh38 and T2T-CHM13 reference genomes in VCF and TSV formats.
2. **[STRchive](https://strchive.org/loci/)**: A catalog of 75 disease-associated tandem repeat loci with detailed annotations including motif sequences, genomic positions, and disease associations. Compatible with multiple TR genotyping tools and available for hg19, hg38, and T2T-CHM13.
3. **[Project Adotto Tandem-Repeat Regions](https://zenodo.org/records/13987414)**: A catalog of tandem-repeat regions in human genomes, provided as BED format files with annotations for tandem repeat analysis.

## Installation

**TandemTwister** can be installed via conda/bioconda (recommended) or built from source.

### Option 1: Install via Conda/Bioconda (Recommended)

The easiest way to install TandemTwister is through conda/bioconda:

```
mamba install bioconda::tandemtwister
```

### Option 2: Build from Source

Follow these steps to build **TandemTwister** from source.

### 1. Clone the repository

```
git clone https://github.com/Lionward/TandemTwist.git
cd TandemTwister
```

### 2. Create and activate a Conda (recommended: Mamba) environment

```
mamba create -n TandemTwist
mamba activate TandemTwist
```

### 3. Install dependencies

Please ensure that you have these tools installed and available in your PATH before proceeding with the build process.

> **Tip:** All dependencies can be installed using *mamba* for speed, but regular *conda* also works.

> **Note:**
> Before building TandemTwister, please ensure all required tools are installed and available in your`PATH`.
>
> ```
> mamba install -c conda-forge libdeflate=1.21
> mamba install bioconda::htslib=1.22.1
> mamba install mlpack=4.5.0
> mamba install make=4.4.1
> mamba install gxx=14.3.0
> mamba install cereal=1.3.2
> mamba install spdlog=1.15.3
> ```

### 4. Build and install TandemTwister

To install TandemTwister in `/usr/local/bin`:

```
make install
```

If you only want to build the executable in the current directory, just use:

```
make
```

## Usage

Run `tandemtwister` from an activated environment using the command-first interface:

```
./tandemtwister [global options] <command> [command options]
```

**Commands**

* `germline` – Genotype germline tandem repeats from long-read alignments.
* `somatic` – Profile somatic tandem-repeat expansions from long-read alignments.
* `assembly` – Genotype tandem repeats from aligned genome or assembly input.

### Required Input

1. **Command**
   * `germline` / `somatic` / `assembly`: Selects the analysis workflow.
   * ⚠️ **Warning:** *Somatic mode is still experimental and has not been fully tested. Use with caution.*
2. **Arguments**
   * `-b, --bam`   Path to the BAM file of the aligned reads to the reference genome.
   * `-r, --ref`   Path to the input reference file (e.g., .fa/.fna).
   * `-m, --motif_file`   Path to the file containing reference coordinates and motif sequence (BED/TSV/CSV).
   * `-o, --output_file`   Output file containing region, motif, hap1 and hap2 copy numbers.
   * `-s, --sex`   Sample sex (0 = female, 1 = male).
   * `-sn, --sample`   Name of the sample.
   * `-rt, --reads_type`   Type of reads (Default: CCS).
   * `-bt, --bam_type`   Type of BAM file (e.g., reads or assembly).
   * `-t, --threads`: Number of threads to use (Default: 1)

### Global Options

* `-v, --verbose`   Verbosity level (0 = error, 1 = critical, 2 = info, 3 = debug).
* `-h, --help`   Display global help (or command-specific help when issued after a command).
* `--version`   Print version information and exit.

### Dynamic Programming Alignment Parameters

* `-mml, --min_match_ratio_l`: Minimum match ratio for long motifs (Default: 0.5)

### Germline & Somatic Analysis Options

#### Read Extraction Parameters

* `-pad, --padding`: Padding around the STR region to extract reads (Default: 0)
* `-kcr, --keepCutReads`: Keep cut reads (Default: false)
* `-minR, --minReadsInRegion`: Minimum number of reads that should span the region (Default: 2)
* `-btg, --bamIsTagged`: Reads in BAM are phased (Default: false)
* `-qs, --quality_score`: Minimum quality score for a read to be considered (Default: 10, Max: 60)

#### Correction Parameters

**Read-based Correction Parameters**

* `-cor, --correct`: Perform genotype calling correction based on the interval-based consensus from sequencing reads (CCS Default: false, CLR/ONT Default: true)
* `-crs, --consensus_ratio_str`: Minimum fraction of reads in a cluster required for a consensus call in STR regions (Default: 0.3)
* `-crv, --consensus_ratio_vntr`: Minimum fraction of reads in a cluster required for a consensus call in VNTR regions (Default: 0.3)
* `-roz, --removeOutliersZscore`: Remove outlier reads for phasing based on Z-score (Default: false)

**Reference-based Correction Parameters**

* `-rtr, --refineTrRegions`: Refine the coordinates of tandem repeat regions using the reference genome (Default: false)
* `-tanCon, --tandem_run_threshold`: Maximum number of bases for merging tandem-repeat runs during reference-based refinement (Default: 2 × motif size)

#### Clustering Parameters

* `-seps, --start_eps_str`: Start radian for clustering in STR regions (Default: 0.2)
* `-sepv, --start_eps_vntr`: Start radian for clustering in VNTR regions (Default: 0.2)
* `-minPF, --minPts_frac`: Min fraction of reads that should be in one cluster (Default: 0.12)
* `-nls, --noise_limit_str`: Noise limit for clustering in STR regions (Default: 0.2)
* `-nlv, --noise_limit_vntr`: Noise limit for clustering in VNTR regions (Default: 0.35)
* `-ci, --cluster_iter`: Number of iterations for clustering (Default: 20)

### Help

* `tandemtwister --help`: Show the global overview with available commands and options.
* `tandemtwister <command> --help`: Show command-specific options (e.g., `tandemtwister germline --help`).

### Example

```
tandemtwister germline \
  -b sample.bam \
  -m motifs.bed \
  -r reference.fna \
  -o output.txt \
  -s 1 \
  -sn SampleName \
  -rt CCS \
  -t 4
```

## VCF INFO and FORMAT Field Descriptions

| Field | Type | Description |
| --- | --- | --- |
| `REF_SPAN` | INFO | Span intervals of the tandem repeat (TR) on the reference sequence. |
| `MOTIF_IDs_REF` | INFO | Motif IDs for the reference sequence, representing identifiers for each unique motif in the reference. |
| `CN_ref` | INFO | Number of repeat units (copy number) for the tandem repeat region in the reference sequence. |
| `CN` | FORMAT | Copy number of the TR for each called allele in the sample. |
| `MI` | FORMAT | Motif IDs for the haplotype(s) of each allele in the sample. |
| `SP` | FORMAT | Span of the TR for each allele. |
| `DP` | FORMAT | Number of reads supporting each allele. |
| `GT` | FORMAT | Genotype; indicates which alleles are present for this sample (e.g., `0/1`). |

## Example Output

Below is an example of the output in VCF format:

```
chr1    60637   chr1:60636-60665        ATTGTAAAGTCAAACAATTATAAGTCAAAC  ATTGTAAAGTCAAACAATTATAAGTCAAAC,ATTGTAAAGTCAAACAATTATAAGTCAAAC   1       PASS    TR_type=VNTR;MOTIFS=AATTATAAGTCAAA,AATTATAAGTCAAAC,AATTGTAAGTCAAAC,ATTGTAAAGTCAAAC,TTGTAAAGTCAAAC;UNIT_LENGTH_AVG=14;MOTIF_IDs_REF=3_1;REF_SPAN=(1-15)_(16-30);CN_ref=2 GT:CN:MI:DP:SP  0/0:2,2:3_1:31:(1-15)_(16-30)
```

## Test data

The test data is available in the test\_data folder. The test data is in the form of a bam file, a reference file, and a motif file. The motif file is in the form of a bed file. The test data can be used to test the TandemTwister tool.

Run the following command to test the tool:

```
make test
```

## Contributions

We welcome contributions from the community! If you find any issues or have suggestions for improvement, please [open an issue](https://github.com/Lionward/tandemtwister/issues) or create a pull request.

## Citation

If you use TandemTwister in your research or analysis, please cite our work as follows:

> **TandemTwister: Scalable genotyping and advanced visualization of tandem repeats**
> Al Raei LW, Ghareghani M, Moeinzadeh H, Vingron M
> bioRxiv 2026.01.28.702315; doi: <https://doi.org/10.64898/2026.01.28.702315>
> [Preprint](https://www.biorxiv.org/content/10.64898/2026.01.28.702315v1) | [GitHub Repository](https://github.com/Lionward/tandemtwister)

Thank you for acknowledging TandemTwister in your work!

## Upcoming Features

1. **Implementation of a Lookup Table for ONT Input Acceleration:** Integrate a lookup table for ONT input to enhance processing speed, optimizing the tool’s performance.
2. **Inclusion of Methylation Information:** Integrate methylation information into the analysis, providing users with additional insights into the epigenetic characteristics of the tandem repeats.
3. **Add Trio-analysis mode** for better genotyping results in Trio samples.

## Acknowledgements

We would like to express our appreciation to the IT team at Max Planck Institute for Molecular Genetics for their support with technical aspects related to this project.

This site is open source. [Improve this page](https://github.com/Lionward/tandemtwister/edit/main/README.md).