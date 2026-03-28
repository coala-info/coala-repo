[Segway](index.html)

3.0.4

* [Quickstart Guide](quick.html)
* Segway 3.0.4 Overview
  + [Installation](#installation)
    - [Standalone configuration](#standalone-configuration)
    - [Cluster configuration](#cluster-configuration)
  + [The workflow](#the-workflow)
    - [Technical description](#technical-description)
  + [Data selection](#data-selection)
    - [Tracks](#tracks)
    - [Positions](#positions)
    - [Resolution](#resolution)
  + [Model generation](#model-generation)
    - [Virtual Evidence](#virtual-evidence)
    - [Model Customization](#model-customization)
    - [Segment duration model](#segment-duration-model)
      * [Hard length constraints](#hard-length-constraints)
      * [Soft length prior](#soft-length-prior)
  + [Task selection](#task-selection)
  + [Train task](#train-task)
    - [Unsupervised training](#unsupervised-training)
    - [Semisupervised training](#semisupervised-training)
    - [General options](#general-options)
      * [Seeding](#seeding)
    - [Recovery](#recovery)
  + [Annotate task](#annotate-task)
    - [Recovery](#id6)
    - [Creating layered output](#creating-layered-output)
  + [Posterior task](#posterior-task)
    - [Recovery](#id7)
  + [SegRNA](#segrna)
  + [Modular interface](#modular-interface)
  + [Python interface](#python-interface)
  + [Command-line usage summary](#command-line-usage-summary)
    - [Utilities](#utilities)
  + [Environment Variables](#environment-variables)
  + [Running Segway for large jobs](#running-segway-for-large-jobs)
  + [Helpful commands](#helpful-commands)
* [Technical matters](technical.html)
* [Frequently Asked Questions](faq.html)
* [Troubleshooting](troubleshooting.html)
* [Support](support.html)

[Segway](index.html)

* »
* Segway 3.0.4 Overview
* [View page source](_sources/segway.rst.txt)

---

# Segway 3.0.4 Overview[¶](#segway-version-overview "Permalink to this headline")

## Installation[¶](#installation "Permalink to this headline")

With the [Conda](https://conda.io/docs/) environment manager and the additional [Bioconda](https://bioconda.github.io/) channel,
Segway can be installed with the command:

```
conda install segway
```

Alternatively without Bioconda, the following prerequisites must be
installed for Segway:

You need Python 2.7, or Python 3.6 or later versions.

You need Graphical Models Toolkit (GMTK), which you can get at
<<https://github.com/melodi-lab/gmtk/releases>>.

You need the HDF5 serial library and tools. The following packages are
necessary for the OS you are running:

Ubuntu/Debian:

```
sudo apt-get install libhdf5-serial-dev hdf5-tools
```

CentOS/RHEL/Fedora:

```
sudo yum -y install hdf5 hdf5-devel
```

OpenSUSE:

```
sudo zypper in hdf5 hdf5-devel libhdf5
```

Afterwards Segway can be installed automatically with the command `pip install
segway`.

Note

Segway may not install with older versions of pip (< 6.0) due to some of its dependencies
requiring the newer version. To upgrade your pip version run pip install pip –upgrade.

### Standalone configuration[¶](#standalone-configuration "Permalink to this headline")

Segway can be run without any cluster system. This will automatically be
used when Segway fails to access any cluster system. You can force it by
setting the [`SEGWAY_CLUSTER`](#envvar-SEGWAY_CLUSTER) environment variable to local. For example,
if you are using bash as your shell, you can run:

> SEGWAY\_CLUSTER=local segway

By default, Segway will use up to 32 concurrent processes when running in
standalone mode. To change this, set the [`SEGWAY_NUM_LOCAL_JOBS`](#envvar-SEGWAY_NUM_LOCAL_JOBS) environment
variable to the appropriate number.

### Cluster configuration[¶](#cluster-configuration "Permalink to this headline")

If you want to use Segway with your cluster, you will need the
`drmaa>=0.4a3` Python package.

You need either Sun Grid Engine (SGE; now called Oracle Grid Engine),
Platform Load Sharing Facility (LSF) and FedStage DRMAA for LSF, Slurm workload
manager, or Torque/PBS/PBS Pro (experimental).

If FedStage DRMAA for LSF is installed, Segway should be ready to go
on LSF out of the box.

If you are using the Slurm workload manager with versions past 18, it is
recommended you install a DRMAA driver based on an updated fork since the
original implementation is no longer updated or maintained. We currently test
our Slurm support using <https://github.com/natefoo/slurm-drmaa>.

If you are using SGE, someone with cluster manager privileges on your
cluster must have Segway installed within their PYTHONPATH or
systemwide and then run `python -m segway.cluster.sge_setup`. This
sets up a consumable mem\_requested attribute for every host on your
cluster for more efficient memory use.

## The workflow[¶](#the-workflow "Permalink to this headline")

Segway accomplishes four major tasks from a single command-line. It–

> 1. **generates** an unsupervised segmentation model and initial
>    parameters appropriate for this data;
> 2. **trains** parameters of the model starting with the initial
>    parameters; and
> 3. **identifies or annotates** segments in this data with the model.
> 4. calculates **posterior** probability for each possible segment
>    label at each position.

Note

The verbs “identify” and “annotate” are synonyms when using Segway. They
both describe the same task and may be used interchangably.

### Technical description[¶](#technical-description "Permalink to this headline")

More specifically, Segway performs the following steps:

> 1. Acquires data in `genomedata` format
> 2. Generates an appropriate model for unsupervised
>    segmentation (`segway.str`, `segway.inc`) for use by GMTK
> 3. Generates appropriate initial parameters (`input.master`
>    or `input.*.master`) for use by GMTK
> 4. Writes the data in a format usable by GMTK
> 5. Call GMTK to perform expectation maximization (EM) training,
>    resulting in a parameter file (`params.params`)
> 6. Call GMTK to perform Viterbi decoding of the observations
>    using the generated model and discovered parameters
> 7. Convert the GMTK Viterbi results into BED format
>    (`segway.bed.gz`) for use in a genome browser, or by
>    Segtools <<http://pmgenomics.ca/hoffmanlab/proj/segtools/>>, or other tools
> 8. Call GMTK to perform posterior decoding of the observations
>    using the generated model and discovered parameters
> 9. Convert the GMTK posterior results into bedGraph format
>    (`posterior.seg*.bedGraph.gz`) for use in a genome browser or
>    other tools
> 10. Use a distributed computing system to parallelize all of the
>     GMTK tasks listed above, and track and predict their resource
>     consumption to maximize efficiency
> 11. Generate reports on the established likelihood at each round of
>     training (`likelihood.*.tab`)

The **identify** and **posterior** tasks can run simultaneously, as
they depend only on the results of **train**, and not each other.

## Data selection[¶](#data-selection "Permalink to this headline")

Segway accepts data only in the Genomedata format. The Genomedata
package includes utilities to convert from BED, wiggle, and bedGraph
formats. By default, Segway uses all the continuous data tracks in a
Genomedata archive. Multiple Genomedata archives can be specified to be used in
data selection as long as each archive refers to the same sequence and do not
have overlapping track names.

Note

Segway does not allow mulitple genomedata archives to contain equivalent
tracks names. However if your archives have tracks with matching track
names, you may explictly specify to Segway the track names that do not
overlap in other genomedata archives and Segway will run as normal.

### Tracks[¶](#tracks "Permalink to this headline")

You may specify a subset of tracks using the `--track` option
which may be repeated. For example:

```
segway --track dnasei --track h3k36me3
```

will include the two tracks `dnasei` and `h3k36me3` and no others.

You can run a concatenated segmentation by separating tracks with a
comma. For example:

```
segway --track dnasei.liver,dnasei.blood --track h3k36me3.liver,h3k36me3.blood
```

### Positions[¶](#positions "Permalink to this headline")

By default, Segway runs analyses on the whole genome. This can be
incredibly time-consuming, especially for training. In reality,
training (and even identification) on a smaller proportion of the
genome is often sufficient. There are also regions as the genome such
as those containing many repetitive sequences, which can cause
artifacts in the training process. The `--exclude-coords`=*file* and `--include-coords`=*file* options specify BED
files with regions that should be excluded or included respectively.
If both are specified, then inclusions are processed first and the
exclusions are then taken out of the included regions.

Note

BED format uses zero-based half-open coordinates, just like
Python. This means that the first nucleotide on chromosome 1 is
specified as:

```
chr1    0    1
```

The UCSC Genome Browser and Ensembl web interfaces, as well as the
wiggle formats use the one-based fully-closed convention, where it is
called *chr1:1-1*.

For example, the ENCODE Data Coordination Center at University of
California Santa Cruz keeps the coordinates of the ENCODE pilot
regions in this format for
[`(GRCh37/hg19) http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/referenceSequences/encodePilotRegions.hg19.bed`\_](#id10)

> and

[`(NCBI36/hg18) http://hgdownload.cse.ucsc.edu/goldenPath/hg18/database/encodeRegions.txt.gz`\_](#id12).
For human whole-genome studies, these regions have nice
properties since they mark 1 percent of the genome, and were carefully
picked to include a variety of different gene densities, and a number
of more limited studies provide data just for these regions. All
coordinates are in terms of the GRCh37 assembly of the human reference
genome (also called `hg19` by UCSC).

After reading in data from a Genomedata archive, and selecting a
smaller subset with `--exclude-coords` and
`--include-coords`, the final included regions are referred to
as *windows*, and are supplied to GMTK for inference. There is no
direction connection between the data in different windows during any
inference process–the windows are treated independently.

An alternative way to speed up training is to use the
`--minibatch-fraction`=*frac* option, which will cause Segway to use
a fraction *frac* or more of genomic positions, chosen randomly at each
training iteration. The `--exclude-coords`=*file* and
`--include-coords`=*file* options still apply when using minibatch.
The fraction will only apply to the resulting chosen coordinates. For example,
using `--minibatch-fraction=0.01` will use a different random one percent of
the genome for each training round. This will allow training to have access to
the whole genome for training while maintaining fast iterations. Using this
option will select on the basis of windows, so the fraction of the genome
chosen will be closer to the specified fraction if the windows are small (but
the chosen fraction will always be at least as large as specified). Therefore,
it is best to combine –minibatch-fraction with –split-sequences. The
likelihood-based training stopping criterion is no longer valid with minibatch
training, so training will always run to –max-train-rounds (100, by default)
if –minibatch-fraction is set.

An alternative way to choose the winning set of parameters
is available through the `--validation-fraction`=*frac* or
`--validation-coords` options. Specifying a fraction *frac* to
`--validation-fraction` will cause Segway to choose a fraction *frac*
or more of genomic positions as a held-out validation set.
`--validation-coords`=*file* allows one to explicitly specify genomic
coordinates in a BED-format file, to be used as a validation set. When
using either of these options, Segway will evaluate the model after each
training iteration on the validation set and will choose the winning set
of parameters based on whichever set gives the best validation set likelihood
across all instances.

Note

`--exclude-coords` is applied to `--validation-coords` but
`--include-coords` is not. This allows the user to easily specify
regions of the genome that should not be considered by Segway overall, while
also allowing them to specify a set of validation coordinates in a
straightforward manner.

### Resolution[¶](#resolution "Permalink to this headline")

In order to speed up the inference process, you may downsample the
data to a different resolution using the `--resolution`=*res* option. This means that Segway will partition the input
observations into fixed windows of size *res* and perform inference on
the mean of the observation averaged along the fixed window. This can
result in a large speedup at the cost of losing the highest possible
precision. However, if you are considering data that is only generated
at a low resolution to start with, this can be an appealing option.

Warning

You must use the same resolution for *both* training and
identification.

In semi-supervised mode, with the resolution option enabled, the
supervision labels are also downsampled to a lower resolution, but
by a different method. In particular, segway will partition the
input supervision labels into fixed windows of size *res* and use
a modified ‘mode’ to choose which label will represent that
window during training. This modified ‘mode’ works according to
the following rules:

1. In general, segway takes the highest-count nonzero label in
   a given resolution-sized window to be the mode for that window.
2. In the case of ties, segway takes the lowest nonzero label.
3. Segway takes the mode to be 0 (no label) if and only if all
   elements of the window are 0.

## Model generation[¶](#model-generation "Permalink to this headline")

Segway generates a model (`segway.str`) and initial parameters
(`input.master`) appropriate to a dataset using the GMTKL
specification language and the GMTK master parameter file format. Both
of these are described more fully in the GMTK documentation (cite),
and the default structure and starting parameters are described more
fully in the Segway article.

The starting parameters are generated using data from the whole
genome, which can be quickly found in the Genomedata archive. Even if
you are training on a subset of the genome, this information is not
used.

You can tell Segway just to generate these files and not to perform
any inference using the `--dry-run` option.

Using `--num-instances`=*starts* will generate multiple copies of the
`input.master` file, named `input.0.master`, `input.1.master`,
and so on, with different randomly picked initial parameters. Segway
training results can be quite dependent on the initial parameters
selected, so it is a good idea to try more than one. I usually use
–num-instances=10`.

Using `--mixture-components` will set the number of Gaussian
mixture components per label to use in the model (default 1).

Usi