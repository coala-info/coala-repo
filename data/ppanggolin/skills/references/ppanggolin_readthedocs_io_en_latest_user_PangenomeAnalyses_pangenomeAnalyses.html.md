[PPanGGOLiN](../../index.html)

User Guide:

* [Installation](../install.html)
* [Quick usage](../QuickUsage/quickAnalyses.html)
* [Practical information](../practicalInformation.html)
* Pangenome analyses
  + [Workflow](#workflow)
  + [Annotation](#annotation)
    - [Annotate from fasta files](#annotate-from-fasta-files)
      * [Use a different genetic code in my annotation step](#use-a-different-genetic-code-in-my-annotation-step)
      * [Force the Prodigal procedure](#force-the-prodigal-procedure)
      * [Customize the RNA annotation](#customize-the-rna-annotation)
    - [Use annotation files for your pangenome](#use-annotation-files-for-your-pangenome)
      * [How to deal with annotation files without sequences](#how-to-deal-with-annotation-files-without-sequences)
      * [Take the pseudogenes into account for pangenome analyses](#take-the-pseudogenes-into-account-for-pangenome-analyses)
  + [Compute pangenome gene families](#compute-pangenome-gene-families)
    - [Cluster genes into gene families](#cluster-genes-into-gene-families)
      * [How to customize MMSeqs2 clustering](#how-to-customize-mmseqs2-clustering)
    - [Providing your gene families](#providing-your-gene-families)
      * [Assume the representative gene](#assume-the-representative-gene)
      * [Specify the representative gene](#specify-the-representative-gene)
      * [Indicate fragmented gene](#indicate-fragmented-gene)
    - [Defragmentation](#defragmentation)
  + [Graph](#graph)
  + [Partition](#partition)
  + [Pangenome outputs](#pangenome-outputs)
    - [Pangenome statistics](#pangenome-statistics)
      * [Genome statistics table](#genome-statistics-table)
      * [Mean Persistent Duplication](#mean-persistent-duplication)
      * [Gene Presence-Absence Matrix](#gene-presence-absence-matrix)
      * [Matrix File](#matrix-file)
      * [Partitions Files](#partitions-files)
      * [Gene Families to Gene Associations](#gene-families-to-gene-associations)
    - [Pangenome figures output](#pangenome-figures-output)
      * [U-shape plot](#u-shape-plot)
      * [Tile plot](#tile-plot)
      * [Rarefaction curve](#rarefaction-curve)
    - [Pangenome graph output](#pangenome-graph-output)
      * [JSON](#json)
  + [Pangenome metrics](#pangenome-metrics)
    - [Genomic fluidity](#genomic-fluidity)
  + [Pangenome info](#pangenome-info)
    - [Overview of `info --content` Output](#overview-of-info-content-output)
    - [Overview of `info --parameters` Output](#overview-of-info-parameters-output)
    - [Overview of `info --status` Output](#overview-of-info-status-output)
    - [Overview of `info --metadata` Output](#overview-of-info-metadata-output)
* [Regions of genome plasticity analyses](../RGP/rgpAnalyses.html)
* [Conserved module prediction](../Modules/moduleAnalyses.html)
* [Write genomes](../writeGenomes.html)
* [Write pangenome sequences](../writeFasta.html)
* [Align external genes to a pangenome](../align.html)
* [Projection](../projection.html)
* [Prediction of Genomic Context](../genomicContext.html)
* [Multiple Sequence Alignment](../MSA.html)
* [Metadata and Pangenome](../metadata.html)

Developper Guide:

* [How to Contribute ✨](../../dev/contribute.html)
* [Building the Documentation](../../dev/buildDoc.html)
* [API Reference](../../api/api_ref.html)

[PPanGGOLiN](../../index.html)

* Pangenome analyses
* [View page source](../../_sources/user/PangenomeAnalyses/pangenomeAnalyses.md.txt)

---

# Pangenome analyses[](#pangenome-analyses "Permalink to this heading")

## Workflow[](#workflow "Permalink to this heading")

PPanGGOLiN was created with the idea to make it both easy to use for beginners, and fully customizable for experts.
Ease of use has been achieved by incorporating a workflow command that allows the construction and partitioning of a pangenome using genomic data.
The command has only one mandatory option, and predefined parameters adapted to pangenomes at the scale of a bacterial species.
This command launches the [annotation](#annotation), [clustering](pangenomeCluster.html#cluster-genes-into-gene-families), [graph](#graph) and [partition](#partition) commands described below.

---
title: "Workflow Overview: Steps launched by the workflow command"
align: center
---
%%{init: {'theme':'default'}}%%
graph LR
i[input genomes] --> a
subgraph Pangenome creation
a:::workflow
c:::workflow
g:::workflow
p:::workflow
a("annotate") --> c
c(cluster) --> g(graph)
g(graph) --> p(partition)
end
p --> f[pangenome.h5]
classDef panrgp fill:#4066d4
classDef panmodule fill:#d44066
classDef workflow fill:#d4ae40

To use this command, you need to provide a tab-separated list of either annotation files (gff3 or gbff) or fasta files. The expected format is detailed [in the annotation section](#annotation)

You can use the workflow with annotation files as such:

```
ppanggolin workflow --anno genomes.gbff.list
```

For fasta files, you have to change for:

```
ppanggolin workflow --fasta genomes.fasta.list
```

Moreover, as detailed [in the section about providing your gene families](#read-clustering),
if you wish to use different gene clustering methods than those provided by PPanGGOLiN,
it is also possible to provide your own clustering results with the workflow command as such:

```
ppanggolin workflow --anno genomes.gbff.list --clusters clusters.tsv
```

All the workflow parameters are obtained from the commands explained below, except for the `--no_flat_files` option, which solely pertains to it. This option prevents the automatic generation of the output files listed and described [in the pangenome output section](#pangenome-outputs).
If you are unfamiliar with the output available in PPanGGOLiN, we recommend that you do not use this option, so that all results are automatically generated, even though this may take some time.

Tip

In the workflow CLI, it is not possible to tune all the options available in all the steps.
For a fully optimized analysis, you can either launch the subcommands one by one as described below, or you can use the configuration file as described [here](../practicalInformation.html#configuration-file)

## Annotation[](#annotation "Permalink to this heading")

### Annotate from fasta files[](#annotate-from-fasta-files "Permalink to this heading")

As an input file, you can provide a list of .fasta files.
If you do so, the provided genomes will be annotated using the following tools:

* [Pyrodigal](https://pyrodigal.readthedocs.io/en/stable/index.html), which is based on Prodigal, to annotate CDSs
* [ARAGORN](http://www.ansikte.se/ARAGORN/) to annotate tRNAs
* [Infernal](http://eddylab.org/infernal/) coupled with HMM of the bacterial and archaeal rRNAs downloaded from [RFAM](https://rfam.xfam.org/) to annotate rRNAs.

To proceed with this stage of the pipeline, you need to create an **genomes.fasta.list** file.
This file should be tab-separated with each line depicting an individual genome and
its pertinent information with the following organization (only the first two columns are mandatory):

* The first column contains a unique genome name
* The second column contains the path to the associated FASTA file
* The following columns contain Contig identifiers present in the associated FASTA file that should be analyzed as being circular.
  For the ‘circular contig identifiers,’ if you do not have access to this information, you can safely ignore this part as it does not have a big impact on the resulting pangenome.

You can check [this example input file](https://github.com/labgem/PPanGGOLiN/blob/master/testingDataset/genomes.fasta.list).

To run the annotation part, you can use this minimal command:

```
ppanggolin annotate --fasta genomes.fasta.list
```

#### Use a different genetic code in my annotation step[](#use-a-different-genetic-code-in-my-annotation-step "Permalink to this heading")

To annotate the genomes, you can easily change the translation table (or genetic code) used by Pyrodigal just by giving the corresponding number as described [here](https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi).

#### Force the Prodigal procedure[](#force-the-prodigal-procedure "Permalink to this heading")

Prodigal can predict gene in [single/normal mode](https://github.com/hyattpd/prodigal/wiki/gene-prediction-modes#normal-mode)
that includes a training step on your genomes or in [meta/anonymous mode](https://github.com/hyattpd/prodigal/wiki/gene-prediction-modes#anonymous-mode),
which uses pre-calculated training files.
As recommended in the Prodigal documentation: “Anonymous mode should be used on metagenomic data sets, or on sequences too short to provide good training data.”

By default, PPanGGOLiN will determine the best mode based on the contig length.
The procedure can be overridden with the option `-p, --prodigal_procedure`.
The option only accepts **single** or **meta** keywords, corresponding to the Prodigal procedure name.

#### Customize the RNA annotation[](#customize-the-rna-annotation "Permalink to this heading")

If you do not want to predict the RNA (and thus not use Infernal and Aragorn), you can add the `--norna` option to your command.
Otherwise, by default, any CDS overlapping RNA genes will be deleted as they are often false positive calls.
You can prevent this filtering by using the `--allow_overlap` option.

Additionally, the `--kingdom archaea` option can be utilized when working with archaea genomes
to specify Infernal’s RNA annotation model.

### Use annotation files for your pangenome[](#use-annotation-files-for-your-pangenome "Permalink to this heading")

You can provide annotation files in either gff3 files or .gbk/.gbff files, or a mix of them. They should be provided through as a list in a tab-separated file that follows the same format as described for the fasta files. You can check [this example input file](https://github.com/labgem/PPanGGOLiN/blob/master/testingDataset/genomes.gbff.list).

Note

Use your own annotation for your genome is highly recommended, particularly if you already
have functional annotations, as they can be added to the pangenome.

You can provide them using the following command:

```
ppanggolin annotate --anno genomes.gbff.list
```

#### How to deal with annotation files without sequences[](#how-to-deal-with-annotation-files-without-sequences "Permalink to this heading")

If your annotation files do not contain the genome sequence,
you can use both options simultaneously to obtain the gene annotations and gene sequences, as follows:

```
ppanggolin annotate --anno genomes.gbff.list --fasta genomes.fasta.list
```

#### Take the pseudogenes into account for pangenome analyses[](#take-the-pseudogenes-into-account-for-pangenome-analyses "Permalink to this heading")

By default, PPanGGOLiN will not take pseudogenes into account.
However, they could be worth keeping in certain contexts.
It is possible to include pseudogenes in the pangenome by using the `--use_pseudo`option.

## Compute pangenome gene families[](#compute-pangenome-gene-families "Permalink to this heading")

### Cluster genes into gene families[](#cluster-genes-into-gene-families "Permalink to this heading")

After annotating genomes, their genes will be compared to determine similarities and build gene families using this
information.

If .fasta files or annotation files containing gene sequences were provided, clustering can be executed by using the
generated .h5 file, as such:

```
ppanggolin cluster -p pangenome.h5
```

#### How to customize MMSeqs2 clustering[](#how-to-customize-mmseqs2-clustering "Permalink to this heading")

Warning

Not all MMSeqs2 options are available in PPanGGOLiN.
For a comprehensive overview of MMSeqs2 options, please refer to their documentation.
To provide your own custom clustering from MMSeqs2 or another tool, please follow the instructions detailed in the [dedicated section](#read-clustering).

PPanGGOLiN will run [MMseqs2](https://github.com/soedinglab/MMseqs2) to perform clustering on all the protein sequences
by searching for connected components for the clustering step.

##### How to set the identity and coverage parameters[](#how-to-set-the-identity-and-coverage-parameters "Permalink to this heading")

PPanGGOLiN enables the setting of two essential parameters for gene clustering: **identity** and **coverage**. These
parameters can be easily adjusted using `--identity` (default: 0.8) and `--coverage` (default: 0.8). The default values
were selected as they are empirically effective parameters for aligning and clustering sequences at the species level.

Be aware that if you decrease identity and/or coverage, more genes will be clustered together in the same family.
This will ultimately decrease the number of families and affect all subsequent steps.

Note

The chosen coverage mode in PPanGGOLiN requires both protein sequences to be covered by at least the proportion specified by –coverage, though this is modified afterwards by the [defragmentation step](#defragmentation).

##### How to set the clustering mode[](#how-to-set-the-clustering-mode "Permalink to this heading")

MMSeqs provides 3 different [clustering modes](https://github.com/soedinglab/MMseqs2/wiki#clustering-modes).
By default, the clustering mode used is the *single linkage* (or *connected component*) algorithm.

Another option is the *set cover* algorithm, which can be employed using `--mode 1`.

Additionally, the clustering algorithms of MMseqs, similar to CD-Hit,
can be selected with `--mode 2` or its low-memory version through `--mode 3`.

### Providing your gene families[](#providing-your-gene-families "Permalink to this heading")

It’s possible to provide your own clusters (or gene families); you must have provided the annotations in the first step.
For gff3 files, the expected gene identifier is the ‘ID’ field in the 9th column. In the case of gbff or gbk
files, use ‘locus\_tag’ as a gene identifier unless you are working with files from MaGe/MicroScope or SEED, where the id
in the ‘db\_xref’ field is used instead.

You can give your clustering result in TSV file with a single gene identifier per line. This file consist of 2 to 4
columns in function of the information you want to give. See next part to have more information about expected format.

You can do this from the command line:

`ppanggolin cluster -p pangenome.h5 --clusters clusters.tsv`

If one of the gene in the pangenome is missing in your clustering, PPanGGOLiN will raise an error. To assert the gene into its own cluster (singleton) you can use the `--infer_singleton` option as such:

`ppanggolin cluster -p pangenome.h5 --clusters clusters.tsv --infer_singleton`

Note

When you provide your clustering, *PPanGGOLiN* will translate the representative gene sequence of each family and write it in the HDF5 file.

#### Assume the representative gene[](#assume-the-representative-gene "Permalink to this heading")

The minimum information required is the gene family name (first column) and the constituent gen