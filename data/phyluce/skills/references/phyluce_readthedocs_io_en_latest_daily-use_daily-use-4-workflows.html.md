[phyluce](../index.html)

Contents:

* [Purpose](../purpose.html)
* [Installation](../installation.html)
* [Phyluce Tutorials](../tutorials/index.html)
* [Phyluce in Daily Use](index.html)
  + [Quality Control](daily-use-1-quality-control.html)
  + [Assembly](daily-use-2-assembly.html)
  + [UCE Processing for Phylogenomics](daily-use-3-uce-processing.html)
  + Workflows
    - [What’s Different](#what-s-different)
    - [Workflow Location](#workflow-location)
    - [Workflow Configuration](#workflow-configuration)
    - [Different Workflows](#different-workflows)
      * [Mapping](#mapping)
      * [Phasing](#phasing)
      * [Correction](#correction)
  + [List of Phyluce Programs](list-of-programs.html)

* [Citing](../citing.html)
* [License](../license.html)
* [Attributions](../attributions.html)
* [Funding](../funding.html)
* [Acknowledgements](../ack.html)

[phyluce](../index.html)

* [Phyluce in Daily Use](index.html)
* Workflows
* [View page source](../_sources/daily-use/daily-use-4-workflows.rst.txt)

---

# Workflows[](#workflows "Link to this heading")

As of [phyluce](https://github.com/faircloth-lab/phyluce) 1.7.0, there is new functionality that uses “workflows” to perform different actions. Key among these are things like computing coverage across UCE loci and phasing SNPs within UCE loci. These workflows use [Snakemake](https://snakemake.readthedocs.io/en/stable/), internally, and they are pretty easily portable and/or easy to modify, if desired.

## What’s Different[](#what-s-different "Link to this heading")

Previously, [phyluce](https://github.com/faircloth-lab/phyluce) used its own, internal pipeline code to run multi-step, bioinformatic workflows. These have now been moved into “workflows”, which accomplish the same general steps but are much easier to maintain and run using [Snakemake](https://snakemake.readthedocs.io/en/stable/).

## Workflow Location[](#workflow-location "Link to this heading")

The workflow [Snakemake](https://snakemake.readthedocs.io/en/stable/) files should be packaged into your [conda](http://docs.continuum.io/conda/) installation, in case you are interested in modifying them for any reason. To most easily find their location, activate the `phyluce` environment, then run:

```
# get location of python in our conda environment
which python

# this returns something like:
/Users/bcf/miniconda3/envs/phyluce/bin/python
```

This means that the `workflow` [Snakemake](https://snakemake.readthedocs.io/en/stable/) files will be located at `/Users/bcf/miniconda3/envs/phyluce/phyluce/workflows`. Individual workflows can be run directly by [Snakemake](https://snakemake.readthedocs.io/en/stable/) from this directory, or they can be copied elsewhere, modified, and run by [Snakemake](https://snakemake.readthedocs.io/en/stable/). You can also run these workflows within [phyluce](https://github.com/faircloth-lab/phyluce) (see below).

## Workflow Configuration[](#workflow-configuration "Link to this heading")

The workflow configuration files are detailed below, but it’s important to note that they use a **different** configuration format than other [phyluce](https://github.com/faircloth-lab/phyluce) configuration files. Instead of [Windows INI](https://en.wikipedia.org/wiki/INI_file) based format, the new workflows (and [Snakemake](https://snakemake.readthedocs.io/en/stable/), in general) use [YAML syntax](https://en.wikipedia.org/wiki/YAML). See examples below.

## Different Workflows[](#different-workflows "Link to this heading")

### Mapping[](#mapping "Link to this heading")

Right now, the “mapping” workflow precedes all other workflows and is responsible for mapping reads to contigs, marking duplicates, computing coverage, and outputting BAM files representing the mapped reads. In order to run this new workflow, create a YAML-formatted configuration file that contains the names and paths (relative or absolute) to your contigs and your trimmed reads:

```
reads:
    alligator-mississippiensis: ../../phyluce/tests/test-expected/raw-reads/alligator-mississippiensis/
    gallus-gallus: ../../phyluce/tests/test-expected/raw-reads/gallus-gallus
    peromyscus-maniculatus: ../../phyluce/tests/test-expected/raw-reads/peromyscus-maniculatus
    rana-sphenocephafa: ../../phyluce/tests/test-expected/raw-reads/rana-sphenocephafa

contigs:
    alligator-mississippiensis: ../../phyluce/tests/test-expected/spades/contigs/alligator_mississippiensis.contigs.fasta
    gallus-gallus: ../../phyluce/tests/test-expected/spades/contigs/gallus_gallus.contigs.fasta
    peromyscus-maniculatus: ../../phyluce/tests/test-expected/spades/contigs/peromyscus_maniculatus.contigs.fasta
    rana-sphenocephafa: ../../phyluce/tests/test-expected/spades/contigs/rana_sphenocephafa.contigs.fasta
```

The first section of the file gives the name and path to a folder of raw-reads for each sample (this folder is what results from [illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/)). The second section gives the name and path to the contigs assembled for each organism.

To map these reads to the assembled contigs, run:

```
phyluce_workflow --config <path to your config file> \
    --output <path to some output folder name> \
    --workflow mapping \
    --cores 1
```

This will run the workflow, and your results will end up in the output folder specified. The structure of the output folder will look something like the following:

```
.
├── coverage
│   ├── all-taxon.summary.csv
│   ├── alligator-mississippiensis.samtools.cov.tdt
│   ├── alligator-mississippiensis.summary.csv
│   ├── gallus-gallus.samtools.cov.tdt
│   ├── gallus-gallus.summary.csv
│   ├── peromyscus-maniculatus.samtools.cov.tdt
│   ├── peromyscus-maniculatus.summary.csv
│   ├── rana-sphenocephafa.samtools.cov.tdt
│   └── rana-sphenocephafa.summary.csv
├── mapped_reads
│   ├── alligator-mississippiensis.fxm.sorted.md.bam
│   ├── alligator-mississippiensis.fxm.sorted.md.bam.flagstats.txt
│   ├── gallus-gallus.fxm.sorted.md.bam
│   ├── gallus-gallus.fxm.sorted.md.bam.flagstats.txt
│   ├── peromyscus-maniculatus.fxm.sorted.md.bam
│   ├── peromyscus-maniculatus.fxm.sorted.md.bam.flagstats.txt
│   ├── rana-sphenocephafa.fxm.sorted.md.bam
│   └── rana-sphenocephafa.fxm.sorted.md.bam.flagstats.txt
└── references
    ├── alligator-mississippiensis.contigs.fasta
    ├── alligator-mississippiensis.contigs.fasta.amb
    ├── alligator-mississippiensis.contigs.fasta.ann
    ├── alligator-mississippiensis.contigs.fasta.bwt
    ├── alligator-mississippiensis.contigs.fasta.pac
    ├── alligator-mississippiensis.contigs.fasta.sa
    ├── gallus-gallus.contigs.fasta
    ├── gallus-gallus.contigs.fasta.amb
    ├── gallus-gallus.contigs.fasta.ann
    ├── gallus-gallus.contigs.fasta.bwt
    ├── gallus-gallus.contigs.fasta.pac
    ├── gallus-gallus.contigs.fasta.sa
    ├── peromyscus-maniculatus.contigs.fasta
    ├── peromyscus-maniculatus.contigs.fasta.amb
    ├── peromyscus-maniculatus.contigs.fasta.ann
    ├── peromyscus-maniculatus.contigs.fasta.bwt
    ├── peromyscus-maniculatus.contigs.fasta.pac
    ├── peromyscus-maniculatus.contigs.fasta.sa
    ├── rana-sphenocephafa.contigs.fasta
    ├── rana-sphenocephafa.contigs.fasta.amb
    ├── rana-sphenocephafa.contigs.fasta.ann
    ├── rana-sphenocephafa.contigs.fasta.bwt
    ├── rana-sphenocephafa.contigs.fasta.pac
    └── rana-sphenocephafa.contigs.fasta.sa
```

Within the `coverage` directory are outputs on a per-sample and overall basis. For example, `alligator-mississippiensis.summary.csv` will contain summary info on coverage for the `alligator-mississippiensis` contigs - one line for each contig. Overall summary statistics (by taxon) will be in `all-taxon.summary.csv`. BAM files resulting from the mapping are in the `mapped-reads` directory, along with the output of [samtools](http://www.htslib.org/) `flagstats` for each BAM. The `references` directory contains the FASTA-formatted contigs you started with and their [bwa](http://bio-bwa.sourceforge.net/) indexes.

Attention

If you want to compute coverage on UCE contigs (only) versus
all contigs that were assembled, run the probe/bait to contig matching,
create a monolithic FASTA for whatever samples you want, explode that
FASTA `--by-taxon`, then use the path to those files for each taxon
in the `contig` section of the workflow config file, described above.

You can also perform a dry-run of the software by adding the `--dry-run` parameter, like so:

```
phyluce_workflow --config <path to your config file> \
    --output <path to some output folder name> \
    --workflow mapping \
    --cores 1 \
    --dry-run
```

This will show you what should happen, without performing the analysis. Log files from the [Snakemake](https://snakemake.readthedocs.io/en/stable/) run will be present in a hidden directory in your output folder named `.snakemake`. Like so:

```
.
├── .snakemake
│   ├── auxiliary
│   ├── conda
│   ├── conda-archive
│   ├── incomplete
│   ├── locks
│   ├── log
│   │   └── 2021-03-01T150829.811458.snakemake.log
│   ├── metadata
│   ├── scripts
│   ├── shadow
│   └── singularity
├── coverage
├── mapped_reads
└── references
```

### Phasing[](#phasing "Link to this heading")

The phasing workflow is a re-implementation of the approach that we used in Andermann et al. 2018 that uses mapping information (generated above), along with [samtools](http://www.htslib.org/) and [pilon\_](#id2) to output the phased contigs. The goal of reimplmentation was to make this pipeline more robust. You run the pipeline by (1) running the `mapping` workflow, above. Then, (2) you create a second configuration file that looks like the following:

```
bams:
    alligator-mississippiensis: ../tests/test-data/bams/alligator-mississippiensis.fxm.sorted.md.bam
    gallus-gallus: ../tests/test-data/bams/gallus-gallus.fxm.sorted.md.bam
    peromyscus-maniculatus: ../tests/test-data/bams/peromyscus-maniculatus.fxm.sorted.md.bam
    rana-sphenocephafa: ../tests/test-data/bams/rana-sphenocephafa.fxm.sorted.md.bam

contigs:
    alligator-mississippiensis: ../tests/test-data/contigs/alligator_mississippiensis.contigs.fasta
    gallus-gallus: ../tests/test-data/contigs/gallus_gallus.contigs.fasta
    peromyscus-maniculatus: ../tests/test-data/contigs/peromyscus_maniculatus.contigs.fasta
    rana-sphenocephafa: ../tests/test-data/contigs/rana_sphenocephafa.contigs.fasta
```

This contains a section pointing to the location of the BAM files created during `mapping`, and you can copy over the `contigs` section of the `mapping` config file. Finally, (3) you run the workflow with:

```
phyluce_workflow --config <path to your config file> \
    --output <path to some output folder name> \
    --workflow phasing \
    --cores 1
```

This produces a folder of output containing BAMs and FASTAs for each haplotye that looks like the following (here, only showing the results for `gallus-gallus` versus all 4 taxa in the configuration file:

```
.
├── bams
│   ├── gallus-gallus.0.bam
│   ├── gallus-gallus.0.bam.bai
│   ├── gallus-gallus.1.bam
│   ├── gallus-gallus.1.bam.bai
│   └── gallus-gallus.chimera.bam
└── fastas
    ├── gallus-gallus.0.changes
    ├── gallus-gallus.0.fasta
    ├── gallus-gallus.0.vcf
    ├── gallus-gallus.1.changes
    ├── gallus-gallus.1.fasta
    └── gallus-gallus.1.vcf
```

Right now, what you do with these files is left up to you (e.g. in terms of merging their contents and getting the data aligned). You can essentially group all the `*.0.fasta` and `*.1.fasta` files for all taxa together as new “assemblies” of data and start the [phyluce](https://github.com/faircloth-lab/phyluce) analysis process over from `phyluce_assembly_match_contigs_to_probes`.

### Correction[](#correction "Link to this heading")

This is a new workflow that we’ve put together that helps account for sequencing depth and base-calling quality in assembled contigs. Essentially, you can think of this “correction” process as a filter that helps remove low-depth, low-quality base calls from your assembly data generated by [phyluce](https://github.com/faircloth-lab/phyluce). We are using this, in particular, with UCE data collected from toepads.

To run the workflow, (1) first run the mapping workflow above and (2) create a configuration file that looks like:

```
bams:
    alligator-mississippiensis: ../tests/test-data/bams/alligator-mississippiensis.fxm.sorted.md.bam
    gallus-gallus: ../tests/test-data/bams/gallus-gallus.fxm.sorted.md.bam
    peromyscus-maniculatus: ../tests/test-data/bams/peromyscus-maniculatus.fxm.sorted.md.bam
    rana-sphenocephafa: ../tests/test-data/bams/rana-sphenocephafa.fxm.sorted.md.bam

contigs:
    alligator-mississippiensis: ../tests/test-data/contigs/alligator_mississippiensis.contigs.fasta
    gallus-gallus: ../tests/test-data/contigs/gallus_gallus.contigs.fasta
    peromyscus-maniculatus: ../tests/test-data/contigs/peromyscus_maniculatus.contigs.fasta
    rana-sphenocephafa: ../tests/test-data/contigs/rana_sphenocephafa.contigs.fasta
```

This contains a section pointing to the location of the BAM files created during `mapping`, and you can copy over the `contigs` section of the `mapping` config file. Finally, (3) you run the workflow with:

```
phyluce_workflow --config <path to your config file> \
    --output <path to some output folder name> \
    --workflow correction \
    --cores 1
```

This produces a folder of output that looks like the following. Within this directory as a set of “consensus” contigs, where variant bases have been hard-masked that have `QUAL<20 | DP<5 | AN>2`:

```
.
├── consensus
│   ├── alligator-mississippiensis.consensus.filt.fasta
│   ├── gallus-gallus.consensus.filt.fasta
│   ├── peromyscus-maniculatus.consensus.filt.fasta
│   └── rana-sphenocephafa.consensus.filt.fasta
└── filtered_norm_pileups
    ├── alligator-mississippiensis.norm.flt-indels.Q20.DP10.bcf
    ├── alligator-mississippiensis.norm.flt-indels.Q20.DP10.bcf.csi
    ├── gallus-gallus.norm.flt-indels.Q20.DP10.bcf
    ├── gallus-gallus.norm.flt-indels.Q20.DP10.bcf.csi
    ├── peromyscus-maniculatus.norm.flt-indels.Q20.DP10.bcf
    ├── peromyscus-maniculatus.norm.flt-indels.Q20.DP10.bcf.csi
    ├── rana-sphenocephafa.norm.flt-indels.Q20.DP10.bcf
    └── rana-sphenocephafa.norm.flt-indels.Q20.DP10.bcf.csi
```

Once the “correction” process has been run, you can re-input the corrected contigs to the [phyluce](https://github.com/faircloth-lab/phyluce) analysis process from the `phyluce_assembly_match_contigs_to_probes` program.

[Previous](daily-use-3-uce-processing.html "UCE Processing for Phylogenomics")
[Next](list-of-programs.html "List of Phyluce Programs")

---

© Copyright 2012-2024, Brant C. Faircloth.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).