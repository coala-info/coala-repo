[Autometa](index.html)

latest

* [Getting Started](getting-started.html)
* 🍏 Nextflow Workflow 🍏
  + [Why nextflow?](#why-nextflow)
  + [System Requirements](#system-requirements)
  + [Data Preparation](#data-preparation)
    - [Metagenome Assembly](#metagenome-assembly)
    - [Preparing a Sample Sheet](#preparing-a-sample-sheet)
      * [Supported Assemblers for `cov_from_assembly`](#supported-assemblers-for-cov-from-assembly)
      * [Example `sample_sheet.csv`](#example-sample-sheet-csv)
  + [Quick Start](#quick-start)
    - [Installation](#installation)
    - [Configuring a scheduler](#configuring-a-scheduler)
    - [Running Autometa](#running-autometa)
      * [Choose a version](#choose-a-version)
      * [Choose nf-core interface](#choose-nf-core-interface)
      * [General nextflow parameters](#general-nextflow-parameters)
      * [Input and Output](#input-and-output)
      * [Binning parameters](#binning-parameters)
      * [Additional Autometa options](#additional-autometa-options)
      * [Computational parameters](#computational-parameters)
      * [Do you want to run the nextflow command now?](#do-you-want-to-run-the-nextflow-command-now)
  + [Basic](#basic)
    - [Installing Nextflow and nf-core tools with mamba](#installing-nextflow-and-nf-core-tools-with-mamba)
    - [Using nf-core](#using-nf-core)
    - [Setting parameters with a web-based GUI](#setting-parameters-with-a-web-based-gui)
    - [Required parameters](#required-parameters)
    - [Running the pipeline](#running-the-pipeline)
  + [Advanced](#advanced)
    - [Parallel computing and computer resource allotment](#parallel-computing-and-computer-resource-allotment)
    - [Databases](#databases)
    - [CPUs, Memory, Disk](#cpus-memory-disk)
    - [Additional Autometa parameters](#additional-autometa-parameters)
    - [Customizing Autometa’s Scripts](#customizing-autometa-s-scripts)
    - [Useful options](#useful-options)
    - [Resuming the workflow](#resuming-the-workflow)
    - [Execution Report](#execution-report)
      * [Visualizing the Workflow](#visualizing-the-workflow)
    - [Configuring your process executor](#configuring-your-process-executor)
      * [SLURM](#slurm)
    - [Docker image selection](#docker-image-selection)
* [🐚 Bash Workflow 🐚](bash-workflow.html)
* [📓 Bash Step by Step Tutorial 📓](bash-step-by-step-tutorial.html)
* [Databases](databases.html)
* [Examining Results](examining-results.html)
* [Benchmarking](benchmarking.html)
* [Installation](installation.html)
* [Autometa Python API](autometa-python-api.html)
* [Usage](scripts/usage.html)
* [How to contribute](how-to-contribute.html)
* [Autometa modules](Autometa_modules/modules.html)
* [Legacy Autometa](legacy-autometa.html)
* [License](license.html)

[Autometa](index.html)

* 🍏 Nextflow Workflow 🍏
* [Edit on GitHub](https://github.com/KwanLab/Autometa/blob/main/docs/source/nextflow-workflow.rst)

---

# 🍏 Nextflow Workflow 🍏[](#nextflow-workflow "Permalink to this heading")

## Why nextflow?[](#why-nextflow "Permalink to this heading")

Nextflow helps Autometa produce reproducible results while allowing the pipeline to scale across different platforms and hardware.

## System Requirements[](#system-requirements "Permalink to this heading")

Currently the nextflow pipeline requires Docker 🐳 so it must be installed on your system.
If you don’t have Docker installed you can install it from [docs.docker.com/get-docker](https://docs.docker.com/get-docker).
We plan on removing this dependency in future versions, so that other dependency managers
(e.g. Conda, Mamba, Singularity, etc) can be used.

Nextflow runs on any Posix compatible system. Detailed system requirements
can be found in the [nextflow documentation](https://www.nextflow.io/docs/latest/getstarted.html#requirements)

Nextflow (required) and nf-core tools (optional but highly recommended) installation will be discussed in [Installing Nextflow and nf-core tools with mamba](#install-nextflow-nfcore-with-mamba).

## Data Preparation[](#data-preparation "Permalink to this heading")

1. [Metagenome Assembly](#metagenome-assembly)
2. [Preparing a Sample Sheet](#sample-sheet-preparation)

### Metagenome Assembly[](#metagenome-assembly "Permalink to this heading")

You will first need to assemble your shotgun metagenome, to provide to Autometa as input.

The following is a typical workflow for metagenome assembly:

1. Trim adapter sequences from the reads

   * We usually use [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic).
2. Quality check the trimmed reads to ensure the adapters have been removed

   * We usually use [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).
3. Assemble the trimmed reads

   * We usually use MetaSPAdes which is a part of the [SPAdes](http://cab.spbu.ru/software/spades/) package.
4. Check the quality of your assembly (Optional)

   * We usually use [metaQuast](http://quast.sourceforge.net/metaquast) for this (use `--min-contig 1` option to get an accurate N50).
   > This tool can compute a variety of assembly statistics one of which is N50.
   > This can often be useful for selecting an appropriate length cutoff value for pre-processing the metagenome.

### Preparing a Sample Sheet[](#preparing-a-sample-sheet "Permalink to this heading")

An example sample sheet for three possible ways to provide a sample as an input is provided below. The first example
provides a metagenome with paired-end read information, such that contig coverages may be determined using a read-based alignment
sub-workflow. The second example uses pre-calculated coverage information by providing a coverage table *with* the input metagenome assembly.
The third example retrieves coverage information from the assembly contig headers (Currently, this is only available with metagenomes assembled using SPAdes)

Note

If you have paired-end read information, you can supply these file paths within the sample sheet and the coverage
table will be computed for you (See `example_1` in the example sheet below).

If you have used any other assembler, then you may also provide a coverage table (See `example_2` in the example sheet below).
Fortunately, Autometa can construct this table for you with: `autometa-coverage`.
Use `--help` to get the complete usage or for a few examples see [2. Coverage calculation](bash-step-by-step-tutorial.html#coverage-calculation).

If you use SPAdes then Autometa can use the k-mer coverage information in the contig names (`example_3` in the example sample sheet below).

| sample | assembly | fastq\_1 | fastq\_2 | coverage\_tab | cov\_from\_assembly |
| --- | --- | --- | --- | --- | --- |
| example\_1 | /path/to/example/1/metagenome.fna.gz | /path/to/paired-end/fwd\_reads.fastq.gz | /path/to/paired-end/rev\_reads.fastq.gz |  | 0 |
| example\_2 | /path/to/example/2/metagenome.fna.gz |  |  | /path/to/coverage.tsv | 0 |
| example\_3 | /path/to/example/3/metagenome.fna.gz |  |  |  | spades |

Note

To retrieve coverage information from a sample’s contig headers, provide the `assembler` used for the sample value in the row under the `cov_from_assembly` column.
Using a `0` will designate to the workflow to try to retrieve coverage information from the coverage table (if it is provided)
or coverage information will be calculated by read alignments using the provided paired-end reads. If both paired-end reads and a coverage table are provided,
the pipeline will prioritize the coverage table.

If you are providing a coverage table to `coverage_tab` with your input metagenome, it must be tab-delimited and contain *at least* the header columns, `contig` and `coverage`.

#### Supported Assemblers for `cov_from_assembly`[](#supported-assemblers-for-cov-from-assembly "Permalink to this heading")

| Assembler | Supported (Y/N) | `cov_from_assembly` |
| --- | --- | --- |
| [meta]SPAdes | Y | `spades` |
| Unicycler | N | `unicycler` |
| Megahit | N | `megahit` |

You may copy the below table as a csv and paste it into a file to begin your sample sheet. You will need to update your input parameters, accordingly.

#### Example `sample_sheet.csv`[](#example-sample-sheet-csv "Permalink to this heading")

```
sample,assembly,fastq_1,fastq_2,coverage_tab,cov_from_assembly
example_1,/path/to/example/1/metagenome.fna.gz,/path/to/paired-end/fwd_reads.fastq.gz,/path/to/paired-end/rev_reads.fastq.gz,,0
example_2,/path/to/example/2/metagenome.fna.gz,,,/path/to/coverage.tsv,0
example_3,/path/to/example/3/metagenome.fna.gz,,,,spades
```

Caution

Paths to any of the file inputs **must be absolute file paths**.

| Incorrect | Correct | Description |
| --- | --- | --- |
| `$HOME/Autometa/tests/data/metagenome.fna.gz` | `/home/user/Autometa/tests/data/metagenome.fna.gz` | Replacing any instance of the `$HOME` variable with the real path |
| `tests/data/metagenome.fna.gz` | `/home/user/Autometa/tests/data/metagenome.fna.gz` | Using the entire file path of the input |

## Quick Start[](#quick-start "Permalink to this heading")

The following is a condensed summary of steps required to get Autometa installed, configured and running.
There are links throughout to the appropriate documentation sections that can provide more detail if required.

### Installation[](#installation "Permalink to this heading")

For full installation instructions, please see the [Installation](installation.html#installation-page) section

If you would like to install Autometa via mamba (I’d recommend it, its almost foolproof!),
you’ll need to first download the [Mambaforge](https://github.com/conda-forge/miniforge#mambaforge) installer on your system. You can do this in a few easy steps:

1. Type in the following and then hit enter. This will download the Mambaforge installer to your home directory.

```
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh" -O "$HOME/Mambaforge-$(uname)-$(uname -m).sh"
```

Note

`$HOME` is synonymous with `/home/user` and in my case is `/home/sam`

2. Now let’s run the installer. Type in the following and hit enter:

```
bash $HOME/Mambaforge-$(uname)-$(uname -m).sh
# On my machine this was /home/sam/Mambaforge-latest-Linux-x86_64.sh
```

3. Follow all of the prompts. Keep pressing enter until it asks you to accept. Then type yes and enter. Say yes to everything.

Note

If for whatever reason, you accidentally said no to the initialization, do not fear.
We can fix this by running the initialization with the following command:

```
$HOME/mambaforge/bin/mamba init
```

1. Finally, for the changes to take effect, you’ll need to run the following line of code which effectively acts as a “refresh”

```
source $HOME/.bashrc
```

Now that you have mamba up and running, its time to install the Autometa mamba environment. Run the following code:

```
mamba env create --file=https://raw.githubusercontent.com/KwanLab/Autometa/main/nextflow-env.yml
```

Attention

You will only need to run the installation (code above) once. The installation does NOT need to be performed every time you wish to use Autometa.
Once installation is complete, the mamba environment (which holds all the tools that Autometa needs) will live on your server/computer
much like any other program you install.

Anytime you would like to run Autometa, you’ll need to activate the mamba environment. To activate the environment you’ll need to run the following command:

```
mamba activate autometa-nf
```

### Configuring a scheduler[](#configuring-a-scheduler "Permalink to this heading")

For full details on how to configure your scheduler, please see the [Configuring your process executor](#configuring-your-process-executor) section.

If you are using a Slurm scheduler, you will need to create a configuration file. If you do not have a scheduler, skip ahead to [Running Autometa](#running-autometa)

First you will need to know the name of your slurm partition. Run `sinfo` to find this. In the example below, the partition name is “agrp”.

![_images/slurm_partitions_quickstart.png](_images/slurm_partitions_quickstart.png)

Next, generate a new file called `slurm_nextflow.config` via nano:

```
nano slurm_nextflow.config
```

Then copy the following code block into that new file (“agrp” is the slurm partition to use in our case):

```
profiles {
        slurm {
            process.executor       = "slurm"
            process.queue          = "agrp" // <<-- change this to whatever your partition is called
            docker.enabled         = true
            docker.userEmulation   = true
            singularity.enabled    = false
            podman.enabled         = false
            shifter.enabled        = false
            charliecloud.enabled   = false
            executor {
                queueSize = 8
            }
        }
    }
```

Keep this file somewhere central to you. For the sake of this example I will be keeping it in a folder called “Useful scripts” in my home directory
because that is a central point for me where I know I can easily find the file and it won’t be moved e.g.
`/home/sam/Useful_scripts/slurm_nextflow.config`

Save your new file with Ctrl+O and then exit nano with Ctrl+O.

Installation and set up is now complete. 🎉 🥳

### Running Autometa[](#running-autometa "Permalink to this heading")

For a comprehensive list of features and options and how to use them please see [Running the pipeline](#running-the-pipeline)

Autometa can bin one or several metagenomic datasets in one run. Regardless of the number of metagenomes you
want to process, you will need to provide a sample sheet which specifies the name of your sample, the full path to
where that data is found and how to retrieve the sample’s contig coverage information.

If the metagenome was assembled via SPAdes, Autometa can extract coverage and contig length information from the sequence headers.

If you used a different assembler you will need to provide either raw reads or a table containing contig/scaffold coverage information.
Full details for data preparation may be found under [Preparing a Sample Sheet](#sample-sheet-preparation)

First ensure that your Autometa mamba environment is activated. You can activate your environment by running:

```
mamba activate autometa-nf
```

Run the following code to launch Autometa:

```
nf-core launch KwanLab/Autometa
```

Note

You may want to note where you have saved your input sample sheet prior to running the launch command.
It is much easier (and less error prone) to copy/paste the sample sheet file path when specifying the input (We’ll get to this later in [Input and Output](#quickstart-menu-4)).

You will now use the arrow keys to move up and down between your options and hit your “Enter” or “Return” key to make your choice.

**KwanLab/Autometa nf-core parameter settings:**

1. [Choose a version](#quickstart-menu-1)
2. [Choose nf-core interface](#quickstart-menu-2)
3. [General nextflow parameters](#quickstart-menu-3)
4. [Input and Output](#quickstart-