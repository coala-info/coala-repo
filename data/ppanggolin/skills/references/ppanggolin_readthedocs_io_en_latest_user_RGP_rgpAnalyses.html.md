[PPanGGOLiN](../../index.html)

User Guide:

* [Installation](../install.html)
* [Quick usage](../QuickUsage/quickAnalyses.html)
* [Practical information](../practicalInformation.html)
* [Pangenome analyses](../PangenomeAnalyses/pangenomeAnalyses.html)
* Regions of genome plasticity analyses
  + [Purpose](#purpose)
  + [PanRGP](#panrgp)
  + [RGP detection](#rgp-detection)
  + [Spot prediction](#spot-prediction)
  + [RGP outputs](#rgp-outputs)
    - [RGP](#rgp)
    - [RGP to gene families](#rgp-to-gene-families)
    - [Spots](#spots)
    - [Summarize spots](#summarize-spots)
    - [Borders](#borders)
    - [Draw spots](#draw-spots)
  + [RGP clustering](#rgp-clustering)
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

* Regions of genome plasticity analyses
* [View page source](../../_sources/user/RGP/rgpAnalyses.md.txt)

---

# Regions of genome plasticity analyses[](#regions-of-genome-plasticity-analyses "Permalink to this heading")

## Purpose[](#purpose "Permalink to this heading")

Regions of Genome Plasticity (RGPs) are clusters of genes made of shell and cloud genomes in the pangenome graph. Most of them arise from Horizontal gene transfer (HGT) and correspond to Genomic Islands (GIs). RGPs from different genomes can be grouped in spots of insertion based on their conserved flanking persistent genes, rather than their gene content, to find out which are located in the same locations in the genome. The panRGP methods and its subcommands and subsequent output files are made to detect describe as thoroughly as possible those Regions of Genome Plasticity across all genomes of the pangenome.

Those methods were supported by the [panRGP publication](https://doi.org/10.1093/bioinformatics/btaa792) which can be read to have their methodological descriptions and justifications.

## PanRGP[](#panrgp "Permalink to this heading")

This command works exactly like [workflow](../PangenomeAnalyses/pangenomeAnalyses.html#workflow). The difference is that it will run additional analyses to characterize Regions of Genome Plasticity (RGP).

---
title: "Workflow Overview: Steps launched by the panrgp command"
align: center
---
%%{init: {'theme':'default'}}%%
graph LR
i[input genomes] --> a
r:::panrgp
s:::panrgp
subgraph Pangenome creation
a:::workflow
c:::workflow
g:::workflow
p:::workflow
a("annotate") --> c
c(cluster) --> g(graph)
g(graph) --> p(partition)
end
subgraph Region of Genomic Plasticity
p --> r(rgp)
r --> s(spot)
end
p --> f[pangenome.h5]
s --> f[pangenome.h5]
classDef panrgp fill:#84d191
classDef panmodule fill:#d44066
classDef workflow fill:#d4ae40

You can use the `panrgp` with annotation (gff3 or gbff) files with `--anno` option, as such:

```
ppanggolin panrgp --anno genomes.gbff.list
```

For fasta files, you need to use the alternative `--fasta` option, as such:

```
ppanggolin panrgp --fasta genomes.fasta.list
```

Just like [workflow](../PangenomeAnalyses/pangenomeAnalyses.html#workflow), this command will deal with the [annotation](../PangenomeAnalyses/pangenomeAnalyses.html#annotation), [clustering](../PangenomeAnalyses/pangenomeAnalyses.html#compute-pangenome-gene-families), [graph](../PangenomeAnalyses/pangenomeAnalyses.html#graph) and [partition](../PangenomeAnalyses/pangenomeAnalyses.html#partition) commands by itself.
Then, the RGP detection is ran using [rgp](#rgp-detection) after the pangenome partitioning. Once all RGP have been computed, those found in similar genomic contexts in the genomes are gathered into spots of insertion using [spot](#spot-prediction).

If you want to tune the rgp detection, you can use the `rgp` command after the `workflow` command. If you wish to tune the spot detection, you can use the `spot` command after the `rgp` command. Additionally, you have the option to utilize a configuration file to customize each detection within the `panrgp` command.

More detail about RGP detection and the spot of insertion prediction can be found in the [panRGP publication](https://doi.org/10.1093/bioinformatics/btaa792)

## RGP detection[](#rgp-detection "Permalink to this heading")

Once partitions have been computed, you can predict the Regions of Genome Plasticity.
This subcommand’s options are about tuning parameters for the analysis.

You can do it as such:

```
ppanggolin rgp -p pangenome.h5
```

This will predict RGP and store results in the HDF5 file.

This command has 5 options that will directly impact the method’s results. If you are not sure to understand what they do, you should not change their values as they’ll probably behave exactly the way you want them to.
The options `--variable_gain`, `--persistent_penalty` are both linked to each other. They will impact respectively by how much a persistent gene will penalize the prediction of a RGP, and oppositely how a variable gene (shell, cloud, or multigenic persistent) will promote the prediction of a RGP. The `--min_score` is the filter that will classify a genome region as RGP or not.
Users looking to change those 3 parameters should consider reading the Materials and Methods of the [panRGP publication](https://doi.org/10.1093/bioinformatics/btaa792) to fully understand how those values impact the prediction.

The two other options are more straightforward. The `--min_length` will indicate the minimal size in base pair that a RGP should be to be predicted. The `--dup_margin` is a filter used to identify persistent gene families to consider as multigenic. Gene families that have more than one gene in more than `--dup_margin` genomes will be classified as multigenic, and as such considered as “variable” genes.

After this command is executed, a single output file that will list all of the predictions can be written, the [regions\_of\_genomic\_plasticity.tsv](rgpOutputs.html#rgp) file.

## Spot prediction[](#spot-prediction "Permalink to this heading")

To study RGP that are found in the same area in different genomes, we gather them into ‘spots of insertion’. These spots are groups of RGP that do not necessarily have the same gene content but have similar bordering *persistent* genes. We run those analyses to study the dynamic of gene turnover of large regions in bacterial genomes. In this way, spots of the same pangenome can be compared and their dynamic can be established by comparing their different metrics together. Detailed descriptions of these metrics can be found in the [RGP and spot output section](rgpOutputs.html#rgp-outputs).

Spots can be computed once RGP have been predicted. You can do that using:

```
ppanggolin spot -p pangenome.h5
```

This command has 3 options that can change its results:

* `--set_size` defines the number of the bordering *persistent* genes that will be compared. (default: 3)
* `--overlapping_match` defines the minimal number of bordering persistent genes that must be identical and in the same order to consider two RGP borders as being similar. This means that, when comparing two borders, if they overlap by this amount of persistent genes they will be considered similar, even if they start or stop with different genes. (default: 2)
* `--exact_match_size` Defines the minimal number of firstly bordering persistent genes to consider two RGP borders as being similar. If two RGP borders start with this amount of identical persistent gene families, they are considered similar. (default: 1)

The two other options are related to the ‘spot graph’ used to predict spots of insertion.

* `--spot_graph` writes the spot graph once predictions are computed
* `--graph_formats` defines the format in which the spot graph is written. Can be either gexf or graphml. (default: gexf)

You can the use the dedicated subcommand [draw](rgpOutputs.html#draw-spots) to draw interactive figures for any given spot with the python library [bokeh](http://docs.bokeh.org/en/latest/). Those figures can can be visualized and modified directly in the browser. This plot is described [here](rgpOutputs.html#draw-spots)

Multiple files can then be written describing the predicted spots and their linked RGP, such as a [file linking RGPs with their spots](rgpOutputs.html#spots) and a [file showing multiple metrics for each spot](rgpOutputs.html#summarize-spots).

## RGP outputs[](#rgp-outputs "Permalink to this heading")

### RGP[](#rgp "Permalink to this heading")

The `regions_of_genomic_plasticity.tsv` is a tsv file that lists all the detected Regions of Genome Plasticity. This
requires to have run the RGP detection analysis by either using the `panrgp` command or the `rgp` command.

It can be written with the following command:

```
ppanggolin write_pangenome -p pangenome.h5 --regions -o rgp_outputs
```

The file has the following format :

| Column | Description |
| --- | --- |
| region | A unique identifier for the region. This is usually built from the contig it is on, with a number after it. |
| genome | The genome it is in. This is the genome name provided by the user. |
| contig | Name of the contig |
| genes | The number of genes included in the RGP. |
| first\_gene | Name of the first gene of the region |
| last\_gene | Name of the last gene of the region |
| start | The start position of the RGP in the contig. |
| stop | The stop position of the RGP in the contig. |
| length | The length of the RGP in nucleotide |
| coordinates | The coordinates of the region. If the region overlap the contig edges will be right with join coordinates syntax (*i.e* 1523..1758,1..57) |
| score | Score of the RGP. |
| contigBorder | This is a boolean column. If the RGP is on a contig border it will be True, otherwise, it will be False. This often can indicate that, if an RGP is on a contig border it is probably not complete. |
| wholeContig | This is a boolean column. If the RGP is an entire contig, it will be True, and False otherwise. If a RGP is an entire contig it can possibly be a plasmid, a region flanked with repeat sequences or a contaminant. |

### RGP to gene families[](#rgp-to-gene-families "Permalink to this heading")

The `rgp_families.tsv` is a TSV file that maps each RGP to its gene family content.

It can be written with the following command:

```
ppanggolin write_pangenome -p pangenome.h5 --regions_families -o rgp_outputs
```

| Column | Description |
| --- | --- |
| rgp\_id | The RGP identifier (found in ‘region’ column of `regions_of_genomic_plasticity.tsv`). |
| family\_id | The gene family identifier present in the RGP. |

### Spots[](#spots "Permalink to this heading")

The `spots.tsv` is a tsv file that links the spots in `summarize_spots.tsv` with the RGPs
in `regions_of_genomic_plasticity.tsv`.

It can be created with the following command:

```
ppanggolin write_pangenome -p pangenome.h5 --spots -o rgp_outputs
```

| Column | Description |
| --- | --- |
| spot\_id | The spot identifier (found in the ‘spot’ column of `summarize_spots.tsv`). |
| rgp\_id | The RGP identifier (found in ‘region’ column of `regions_of_genomic_plasticity.tsv`). |

### Summarize spots[](#summarize-spots "Permalink to this heading")

The `summarize_spots.tsv` file is a tsv file that will associate each spot with multiple metrics that can indicate the
dynamic of the spot.

It can be created with the following command:

```
ppanggolin write_pangenome -p pangenome.h5 --spots -o rgp_outputs
```

| Column | Description |
| --- | --- |
| spot | The spot identifier. It is unique in the pangenome. |
| nb\_rgp | The number of RGPs present in the spot. |
| nb\_families | The number of different gene families that are found in the spot. |
| nb\_unique\_family\_sets | The number of RGPs with different gene family content. If two RGPs are identical, they will be counted only once. The difference between this number and the one provided in ‘nb\_rgp’ can be a strong indicator on whether their is a high turnover in gene content in this area or not. |
| mean\_nb\_genes | The mean number of genes on RGPs in the spot. |
| stdev\_nb\_genes | The standard deviation of the number of genes in the spot. |
| max\_nb\_genes | The longest RGP in number of genes of the spot. |
| min\_nb\_genes | The shortest RGP in number of genes of the spot. |

### Borders[](#borders "Permalink to this heading")

Each spot has at least one set of gene families bordering them. To write the list of gene families bordering spots, you
can use the `--borders` option as follow:

```
ppanggolin write_pangenome -p pangenome.h5 --borders -o rgp_outputs
```

It will write a .tsv file with 4 columns:

| Column | Description |
| --- | --- |
| spot\_id | The spot identifier. It is unique in the pangenome. |
| number | The number of RGPs present in the spot that have those bordering genes. |
| border1 | Comma-separated list of gene families of the 1st border. |
| border2 | Comma-separated list of gene families of the 2nd border. |

Since there can be some variation in the borders, some spots will have multiple borders and thus multiple lines in this
file.
The sum of the number for each spot\_id should be exactly the number of RGPs in the spot.

In addition, the `--borders` option also generates a file named `border_protein_genes.fasta`, containing protein
sequences corresponding to the gene families of the spot borders.

### Draw spots[](#draw-spots "Permalink to this heading")

The `draw` command with the option `--draw_spots` can draw specific spots of interest, whose ID are provided, or all the
spots if you wish.
It will also write a gexf file, which corresponds to the gene families and their organization within the spots. It is
basically a subgraph of the pangenome, consisting of the spot itself.
The command can be used as such:

```
ppanggolin draw -p pangenome.h5 --draw_spots --spots all
```

This command draws an interactive `.html` figure and a `.gexf` graph file for all the spots.

If you are interested in only a single spot, you can use its identifier to draw it. For example for the `spot_34`:

```
ppanggolin draw -p pangenome.h5 --draw_spots --spots spot_34
```

The interactive figures that are drawn look like this:

![../../_images/drawspot_example.png](../../_images/drawspot_example.png)

The plot represents the different gene organizations that are found in the spot. If there are RGPs with identical gene
organization, the organization is represented only once (the represented RGP is picked at random among all identical
RGPs). The list of RGPs with the same organization is accessible in the file written alongside the figure
called `spot_