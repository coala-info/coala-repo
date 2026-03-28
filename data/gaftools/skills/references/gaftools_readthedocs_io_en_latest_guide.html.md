[gaftools](index.html)

* [Installation](installation.html)
* User Guide
  + [Requirement Summary by Subcommands](#requirement-summary-by-subcommands)
  + [gaftools find\_path](#gaftools-find-path)
    - [Usage](#usage)
  + [gaftools gfa2rgfa](#gaftools-gfa2rgfa)
    - [Minimum Requirements](#minimum-requirements)
    - [Format of seqfile](#format-of-seqfile)
    - [Usage](#id4)
  + [gaftools index](#gaftools-index)
    - [View Index Structure](#view-index-structure)
    - [Usage](#id6)
  + [gaftools order\_gfa](#gaftools-order-gfa)
    - [Non-linear scaffold graphs:](#non-linear-scaffold-graphs)
    - [Usage](#id8)
  + [gaftools phase](#gaftools-phase)
    - [Usage](#id10)
  + [gaftools realign](#gaftools-realign)
    - [Usage](#id12)
  + [gaftools sort](#gaftools-sort)
    - [Sort Index Structure](#sort-index-structure)
    - [Usage](#id14)
  + [gaftools stat](#gaftools-stat)
    - [Usage](#id16)
  + [gaftools view](#gaftools-view)
    - [Usage](#id18)
* [Developing](develop.html)
* [Changes](changes.html)

[gaftools](index.html)

* User Guide
* [View page source](_sources/guide.rst.txt)

---

# User Guide[](#user-guide "Link to this heading")

The following subcommands are available in gaftools

* [find\_path](#gaftools-find-path) - Extracting base sequencing from node path.
* [gfa2rgfa](#gaftools-gfa2rgfa) - Converting GFA to rGFA using W lines.
* [index](#gaftools-index) - Indexing a GAF file for the view command.
* [order\_gfa](#gaftools-order-gfa) - Ordering GFA file using BO and NO tags.
* [phase](#gaftools-phase) - Adding phase information of the reads from a haplotag TSV.
* [realign](#gaftools-realign) - Realigning GAF alignments using wavefront alignment.
* [sort](#gaftools-sort) - Sorting GAF alignments using BO and NO tags of the corresponding graph.
* [stat](#gaftools-stat) - Basic statistics of the GAF file.
* [view](#gaftools-view) - Viewing and subsetting the GAF file.

To get help for all the subcommands, please use:

```
gaftools <subcommand> --help
```

Links to related resources:

* [rGFA and GAF documentation](https://github.com/lh3/gfatools/blob/master/doc/rGFA.md)
* [GFA v1.0 documentation](https://github.com/GFA-spec/GFA-spec/blob/master/GFA1.md)
* [GFA v2.0 documentation](https://github.com/GFA-spec/GFA-spec/blob/master/GFA2.md)

Some of the tags used in GAF files are derieved from `minimap2` defined [here](https://lh3.github.io/minimap2/minimap2.html)

## Requirement Summary by Subcommands[](#requirement-summary-by-subcommands "Link to this heading")

| Subcommands | rGFA Required? | Ordering Required? |
| --- | --- | --- |
| find\_path | No | No |
| gfa2rgfa | No | No |
| index | Yes | No |
| order\_gfa | No | No |
| phase | No | No |
| realign | No | No |
| sort | Yes | Yes |
| stat | No | No |
| view | Yes | No |

## gaftools find\_path[](#gaftools-find-path "Link to this heading")

This subcommand retrieves the base seqeunce of paths in the given GFA.

### Usage[](#usage "Link to this heading")

The `find_path` subcommand takes 2 obligatory inputs, a GFA file and either a node path `-p, --path` (e.g., `">s82312<s82313"` (with the quotes))
or file path which has node paths each on a separate line with `--paths_file`.
It returns the sequence of the path(s) by default but using the `--fasta` flag, the sequences will be returned as a FASTA file.

If one of the paths does not exist, the process will terminate, the user can use `-k, --keep-going` to skip the paths that do not exist and continue with the next path if available.

find\_path arguments[](#id19 "Link to this code")

```
  usage: gaftools find_path [-h] [-p PATH] [--paths_file PATHS_FILE] [-k] [-o OUTPUT] [-f] GFA

  Find the genomic sequence of a given connected GFA path.

  positional arguments:
    GFA                   GFA file (can be bgzip-compressed)

  options:
    -h, --help            show this help message and exit
    -p PATH, --path PATH  GFA node path to retrieve the sequence (e.g., ">s82312<s82313") with the quotes
    --paths_file PATHS_FILE
                          File containing the paths to retrieve the sequences for, each path on new line
    -k, --keep-going      Keep going after instead of stopping when a path does not exist
    -o OUTPUT, --output OUTPUT
                          Output file. If omitted, use standard output.
    -f, --fasta           Flag to output the sequence as a FASTA file with the seqeunce named seq_<node path>
  gaftools error: the following arguments are required: GFA
```

## gaftools gfa2rgfa[](#gaftools-gfa2rgfa "Link to this heading")

This subcommand creates rGFA equivalent of GFA files using the W lines present in the GFA.

For creating the rGFA tags for all the reference nodes, the minimum requirements (as specified below) should be given. We assume that the pangenome graph is based on a pangenome reference (as is the case with minigraph-based graph constructions methods).

For further tagging the non-reference nodes coming from assemblies added to the reference assembly, the `seqfile` can be provided and corresponding W lines should be available in the GFA (refer to ‘Format of seqfile’).
If the `seqfile` is not provided, then the order in which walks are given in the GFA will be used to tag the non-reference nodes. Users can provide their own order of assemblies in the seqfile, and the coordinates will be generated accordingly.

**Note**: If the proper `seqfile` is not provided, the tagging will not show the coordinates intended by the graph creator since the order of assemblies might be different.

Any node not found in the W lines will be tagged with the `SN` tag as unknown, the `SO` tag as 0, and the `SN` tag as -1.

If the GFA already has the reference nodes tagged (as is the case of the GFA generated by minigraph-cactus), then the `--reference-tagged` flag can be provided and they will not be retagged.

### Minimum Requirements[](#minimum-requirements "Link to this heading")

* The GFA should have a W line corresponding to the reference name provided as part of the command (using `--reference-name`).
* The reference path described by the W line should be cycle-free and oriented in the forward direction (path of the format `>node_1>node_2....>node_N`)

Note: From the Human Pangenome Reference Consortium, the graphs generated using minigraph-cactus follow these requirements. The PGGB graphs do not.

### Format of seqfile[](#format-of-seqfile "Link to this heading")

The seqfile asked by the subcommand has two columns separated by a tab: `<assembly name> <tab> <path to the assembly>`.
This file is part of the minigraph-cactus graph generation pipeline (in case the user is attempting to convert the GFA of that pipeline).

The assembly names should be of the form `<sample name>.<assembly number>` which should correspond to W lines starting with `W <tab> <sample name> <tab> <assembly name> ...`

In the case that the assembly is not based on a sample (as is the case of the chm13-minigraph-cactus graph which has a W line for GRCh38 added later and vice-versa for the grch38-minigraph-catus graph), the seqfile should contain a line for `GRCh38` and GFA should have a corresponding W line of format `W <tab> GRCh38 <tab> 0 ...`

Users can provide their own order of assemblies and the coordinates will be generated accordingly. The reference path should be cycle-free.

**Note**: The code does not require the actual assemblies. So the assemblies provided in the seqfile do not need to be downloaded.

### Usage[](#id4 "Link to this heading")

The `gfa2rgfa` subcommand takes 1 obligatory input, a GFA file. It creates a rGFA file with appropriate tags.

gfa2rgfa arguments[](#id20 "Link to this code")

```
usage: gaftools gfa2rgfa [-h] [--reference-name REFERENCE NAME] [--reference-tagged] [--seqfile SEQFILE] [--output GFA] GFA

Converting a GFA file to rGFA format using the W-lines and the acyclic reference path. (e.g., minigraph-based graphs).

positional arguments:
  GFA                   GFA file (can be bgzip-compressed). This GFA should have a W-line corresponding to the reference genome or the
                        reference nodes have to be tagged already.

options:
  -h, --help            show this help message and exit
  --reference-name REFERENCE NAME
                        The name of the reference genome given in the W-line. Default: CHM13
  --reference-tagged    Flag to denote reference nodes are already tagged in the GFA.
  --seqfile SEQFILE     File containing the sequence in which assemblies were given. Provide the seqfile given as part of running minigraph-cactus (only the first column is required). It has the format: <assembly_name><tab><assembly_path>. If not provided, the order of assemblies will be taken from the GFA file. User-defined order of assemblies can also be given. There should be W lines for each assembly in the GFA.
  --output rGFA         Output rGFA (bgzipped if the file ends with .gz). If omitted, use standard output.
```

## gaftools index[](#gaftools-index "Link to this heading")

This subcommand creates a index file with the extension `.gvi` which is used by the `view` command to subset alignments.

### View Index Structure[](#view-index-structure "Link to this heading")

The index is a reverse look-up table with the keys being nodes in the graph and the values being the location of the alignments which have the nodes.
The index is stored as a Python dictionary with the node IDs (as strings) as keys and a list of offset values (as integers) as values for the key.
This dictionary is written to memory using the `pickle` module.

view index structure[](#id21 "Link to this code")

```
{
    "node_1": [offset_1, offset_2, ...],
    "node_2": [offset_3, offset_4, ...],
    ...
}
```

### Usage[](#id6 "Link to this heading")

The `index` subcommand takes 2 obligatory inputs, a GAF alignment file and its corresponding rGFA graph. It creates an viewing index file with the
extension `.gvi` which is required by the `view` command.

index arguments[](#id22 "Link to this code")

```
usage: gaftools index [-h] [-o OUTPUT] GAF rGFA

positional arguments:
  GAF                   Input GAF file (can be bgzip-compressed)
  rGFA                  Reference rGFA file

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Path to the output Indexed GAF file. If omitted, use <GAF File>.gvi
```

## gaftools order\_gfa[](#gaftools-order-gfa "Link to this heading")

This subcommand establishes an order to the graph based on the “bubbles” in the graph.
Here, we define the bubbles as biconnected components, i.e. not the strict definition of a bubble found in other papers.

The graph input here has to be an [rGFA](https://github.com/lh3/gfatools/blob/master/doc/rGFA.md), with SN and SO tags.

The basic idea here is that we first detect all biconnected components (bubbles), and collapse the detected bubbles into one node,
which should result in a line graph made from scaffold nodes that belong to the reference and the collapsed bubbles inbetween. We then
order this line graph in ascending order based on the coordinates in the SO tag. Each node in this ordered line graph
gets an ascending BO tag from 1 to N (N being the number of nodes in the line graph). For the nodes that represent a collapsed
bubbles, all the nodes in that bubble will get the same BO tag (Figure 1). As for the NO tag, the nodes in a bubble get an ascending
number from 1 to M (M being the number of nodes in a bubble). However, the NO tag inside a bubble is assigned based on the node id order, i.e.
in a lexicographic order of the node IDs.
In the graph shown below, which is a part of a longer graph, when the bubbles collapsed,
this will result in a line graph of 9 nodes.

Below we see a chain of 4 bubbles (biconnected components) and 5 scaffold nodes, where the nodes inside
the bubbles are colored blue and the scaffold nodes are colored yellow. The numbers of the node is the
BO tag, where it increases by 1 starting from the first scaffold node on the left (19 to 27), and we see that
all the nodes in a bubble have the same BO tag

[![_images/bo_tags.png](_images/bo_tags.png)](_images/bo_tags.png)

In this figure, we see the same graph but with the NO tags marked on the nodes. Scaffold nodes always
have a NO tag of 0, and the nodes inside a bubble are marked with an increasing order of the NO tag.

[![_images/no_tags.png](_images/no_tags.png)](_images/no_tags.png)

Note: The `order_gfa` subcommand does not change the name of the nodes and only adds the BO and NO tags as additional information.

### Non-linear scaffold graphs:[](#non-linear-scaffold-graphs "Link to this heading")

In the cases where after collapsing the bi-connected component, the scaffold graph is not a line graph, the user can use
`--ignore-branching` to enforce an ordering where only the linear traversals in the scaffold graph where the articulation points
have an SN tag matching the reference will be ordered and branches that belong to other haplotypes will be ignored, i.e., give BO and NO tag of -1.

### Usage[](#id8 "Link to this heading")

The `order_gfa` subcommand takes an rGFA as an obligatory input to order.
Optionally, the user can specify the order/subset of the chromosomes in the output GFA using the `--chromosome-order` option.
By default, the chromosomes are ordered in a lexicographic order of the component names.
With the `--by-chrom` flag, all the chromosomal graphs are output separately.
Users can also specify an output directory.

The outputs of `order_gfa` are separate rGFA graphs for each chromosome and a graph for all chromosomes both ordered by S lines first then L lines, and the S lines are ordered by
their BO tag then NO tag, also will output a CSV file with node colors similar to the figure above that works with Bandage.

order\_gfa arguments[](#id23 "Link to this code")

```
  usage: gaftools order_gfa [-h] [--chromosome-order CHROMOSOME_ORDER] [--without-sequence] [--outdir OUTDIR] [--by-chrom] [--ignore-branching] [--output_scaffold] GRAPH

  Order bubbles in the GFA by adding BO and NO tags.

  The BO (Bubble Order) tags order bubbles in the GFA.
  The NO (Node Order) tags order the nodes in a bubble (in a lexicographic order).

  positional arguments:
    GRAPH                 Input rGFA file

  options:
    -h, --help            show this help message and exit
    --chromosome-order CHROMOSOME_ORDER
                          Order in which to arrange chromosomes in terms of BO sorting. By default, it is arranged in the lexicographic order of identified component names. Expecting comma-separated list. Example: 'chr1,chr2,chr3'
    --without-sequence    Strip sequences from the output graph (for less memory usage and easier visualization). Default = False
    --outdir OUTDIR       Output Directory to store all the GFA and CSV files. Default location is a "out" folder from the directory of execution.
    --by-chrom        