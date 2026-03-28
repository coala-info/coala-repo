[PPanGGOLiN](../../index.html)

User Guide:

* [Installation](../install.html)
* [Quick usage](../QuickUsage/quickAnalyses.html)
* [Practical information](../practicalInformation.html)
* [Pangenome analyses](../PangenomeAnalyses/pangenomeAnalyses.html)
* [Regions of genome plasticity analyses](../RGP/rgpAnalyses.html)
* Conserved module prediction
  + [The panModule workflow](#the-panmodule-workflow)
  + [Predict conserved module](#predict-conserved-module)
  + [Module outputs](#module-outputs)
    - [Descriptive Tables for Predicted Modules](#descriptive-tables-for-predicted-modules)
      * [1. Gene Family to Module Mapping Table](#gene-family-to-module-mapping-table)
      * [2. Genome-wise Module Composition](#genome-wise-module-composition)
      * [3. modules summary](#modules-summary)
    - [Mapping Modules with Spots and Regions of Genomic Plasticity (RGPs)](#mapping-modules-with-spots-and-regions-of-genomic-plasticity-rgps)
      * [1. Associating Modules and Spots](#associating-modules-and-spots)
      * [2. Associating Modules and RGPs](#associating-modules-and-rgps)
    - [Module Information](#module-information)
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

* Conserved module prediction
* [View page source](../../_sources/user/Modules/moduleAnalyses.md.txt)

---

# Conserved module prediction[](#conserved-module-prediction "Permalink to this heading")

PPanGGOLiN can predict and work with conserved modules, which are groups of genes that are part of the variable genome, and often found together across the genomes of the pangenome. These conserved modules may also be potential functional modules.

---
title: "Workflow Overview: Steps launched by the panmodule command"
align: center
---
%%{init: {'theme':'default'}}%%
graph LR
i[input genomes] --> a
m:::panmodule
subgraph Pangenome creation
a:::workflow
c:::workflow
g:::workflow
p:::workflow
a("annotate") --> c
c(cluster) --> g(graph)
g(graph) --> p(partition)
end
subgraph Functional module
p --> m(module)
end
p --> f[pangenome.h5]
m --> f
classDef panrgp fill:#4066d4
classDef panmodule fill:#d44066
classDef workflow fill:#d4ae40

Further details can be found in the [panModule preprint](https://doi.org/10.1101/2021.12.06.471380)

## The panModule workflow[](#the-panmodule-workflow "Permalink to this heading")

The panModule workflow facilitates the generation of a pangenome with predicted conserved modules from a specified set of genomes. This command extends the functionality of the `workflow` command by detecting conserved modules. Additionally, it generates descriptive tsv files detailing the predicted modules, whose format are detailed [here](moduleOutputs.html).

To execute the panModule workflow, use the following command:

```
ppanggolin panmodule --fasta GENOME_LIST_FILE
```

Replace `GENOME_LIST_FILE` with a tab-separated file listing the genome names, and the fasta file path of their genomic sequences as described [here](../PangenomeAnalyses/pangenomeAnnotation.html#annotate-from-fasta-files). Alternatively, you can provide a list of GFF/GBFF files as input by using the `--anno` parameter, similar to how it is used in the workflow and annotate commands.

The panmodule workflow predicts modules using default parameters. To fine-tune the detection, you can use the `module` command on a partitioned pangenome acquired through the `workflow` for example or use a configuration file, as described [here](../practicalInformation.html#configuration-file).

## Predict conserved module[](#predict-conserved-module "Permalink to this heading")

The `module` command predicts conserved modules on an partitioned pangenome. The command has several options for tuning the prediction. Details about each parameter are available in the related [preprint](https://www.biorxiv.org/content/10.1101/2021.12.06.471380v1).

The command can be used simply as such:

```
ppanggolin module -p pangenome.h5
```

This will predict modules and store the results in the HDF5 pangenome file. If you wish to have descriptive tsv files, whose format is detailed [here](moduleOutputs.html), you can use the `write_pangenome` command with the flag `--modules`:

```
ppanggolin write_pangenome -p pangenome.h5 --modules --output MYOUTPUTDIR
```

If spots of insertion have been predicted in you pangenome using the `spot` command (or inside the `panrgp` or `all` workflow commands), you can also list the associations between the predicted spots and the predicted modules as such:

```
ppanggolin write_pangenome -p pangenome.h5 --spot_modules --output MYOUTPUTDIR
```

The format of each file is given [here](moduleOutputs.html)

## Module outputs[](#module-outputs "Permalink to this heading")

### Descriptive Tables for Predicted Modules[](#descriptive-tables-for-predicted-modules "Permalink to this heading")

To describe predicted modules, various files can be generated, each describing different characteristics of these modules.

To generate these tables, use the `write_pangenome` command with the `--module` :

```
ppanggolin write_pangenome -p pangenome.h5 --modules -o my_output_dir
```

This command generates three tables: `functional_modules.tsv`, `modules_in_genomes.tsv`, and `modules_summary.tsv` described below:

#### 1. Gene Family to Module Mapping Table[](#gene-family-to-module-mapping-table "Permalink to this heading")

The `functional_modules.tsv` file lists modules with their corresponding gene families. Each line establishes a mapping between a gene family and its respective module.

It follows the following format:

| Column | Description |
| --- | --- |
| module\_id | Identifier for the module |
| family\_id | Identifier for the family |

#### 2. Genome-wise Module Composition[](#genome-wise-module-composition "Permalink to this heading")

The `modules_in_genomes.tsv` file provides a comprehensive overview of the modules present in each genome, detailing their completeness levels. Due to potential variability in module predictions, some modules might exhibit partial completeness in specific genomes where they are detected.

The structure of the `modules_in_genomes.tsv` file is outlined as follows:

| Column | Description |
| --- | --- |
| module\_id | Identifier for the module |
| genome | Genome in which the indicated module is found |
| completion | Indicates the level of completeness (0.0 to 1.0) of the module in the   specified genome based on gene family representation |

#### 3. modules summary[](#modules-summary "Permalink to this heading")

The `modules_summary.tsv` file lists characteristics for each detected module, with one line for each module.

The format is as follows:

| column | description |
| --- | --- |
| module\_id | The module identifier |
| nb\_families | The number of families which are included in the module The families   themselves are listed in the ‘functional\_modules.tsv’ file. |
| nb\_genomes | The number of genomes in which the module is found. Those genomes are   listed in the ‘modules\_in\_genomes.tsv’ file. |
| partition | The average partition of the families in the module. |
| mean\_number\_of\_occurrence | the mean number of time a module is present in each genome.   The expected value is around one, but it can be more if it is a module   often repeated in the genomes (like a phage). |

### Mapping Modules with Spots and Regions of Genomic Plasticity (RGPs)[](#mapping-modules-with-spots-and-regions-of-genomic-plasticity-rgps "Permalink to this heading")

Predicted modules can be associated with Spots of insertion and Regions of Genomic Plasticity (RGPs) using the `write_pangenome` command with the `--spot_modules` flag as follows:

```
ppanggolin write_pangenome -p pangenome.h5 --spot_modules -o my_output_dir
```

This command generates two tables: `modules_spots.tsv` and `modules_RGP_lists.tsv`, described below.

Note

These outputs are available only if modules, spots, and RGPs have been computed in your pangenome (see the command [`all`](../QuickUsage/quickWorkflow.html#ppanggolin-complete-workflow-analyses) or the commands [`spot`](../RGP/rgpPrediction.html#spot-prediction), [`rgp`](../RGP/rgpPrediction.html#rgp-detection), and [`module`](modulePrediction.html#conserved-module-prediction) for that).

Moreover, this information can be visualized through figures using the command `ppanggolin draw --spots` (refer to [Spot plots](../RGP/rgpOutputs.html#draw-spots), which can display modules).

#### 1. Associating Modules and Spots[](#associating-modules-and-spots "Permalink to this heading")

The `modules_spots.tsv` file indicates which modules are present in each spot.

Its format is as follows:

| Column | Description |
| --- | --- |
| module\_id | Module identifier |
| spot\_id | Spot identifier |

#### 2. Associating Modules and RGPs[](#associating-modules-and-rgps "Permalink to this heading")

The `modules_RGP_lists.tsv` file lists RGPs that contain the same modules. These RGPs may have different gene families, but they will not include any other modules apart from those indicated. The format of `modules_RGP_lists.tsv` is as follows:

| Column | Description |
| --- | --- |
| representative\_RGP | An RGP considered representative for the group, serving as a randomly chosen   ‘group of RGP IDs’ |
| nb\_spots | The number of spots where the RGPs containing the listed modules are observed |
| mod\_list | A list of modules present in the indicated RGPs |
| RGP\_list | A list of RGPs that specifically includes the previously listed modules |

### Module Information[](#module-information "Permalink to this heading")

Once module have been predicted, the `info` command can present overall statistics regarding the predicted modules, including details about the families found within the modules and their distribution across various partitions.

```
ppanggolin info -p pangenome.h5 --content
```

The command output provides the following details about modules:

```
[...]
Modules:
	Number_of_modules: 380
	Families_in_Modules: 2242
	Partition_composition:
		Persistent: 0.27
		Shell: 37.69
		Cloud: 62.04
	Number_of_Families_per_Modules:
		min: 3
		max: 65
		sd: 5.84
		mean: 5.9
```

[Previous](../RGP/rgpAnalyses.html "Regions of genome plasticity analyses")
[Next](../writeGenomes.html "Write genomes")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).