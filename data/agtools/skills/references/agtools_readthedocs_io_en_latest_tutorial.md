[agtools](..)

Home

* [Introduction](..)

Getting Started

* [Installation](../install/)
* [Quick Start](../quickstart/)

Guides

* CLI Examples
  + [Obtaining stats](../examples/stats/)
  + [Renaming elements](../examples/rename/)
  + [Concatenating multiple graphs](../examples/concat/)
  + [Filtering segments](../examples/filter/)
  + [Cleaning a graph file](../examples/clean/)
  + [Get component of a segment](../examples/component/)
  + [Format conversion](../examples/formatconv/)
* API Tutorial
  + [Importing agtools](#importing-agtools)
  + [Loading a GFA file](#loading-a-gfa-file)
  + [Loading contig graphs](#loading-contig-graphs)
    - [Loading a SPAdes graph](#loading-a-spades-graph)
    - [Loading a MEGAHIT graph](#loading-a-megahit-graph)
    - [Loading a Flye graph](#loading-a-flye-graph)
    - [Loading a myloasm graph](#loading-a-myloasm-graph)
  + [Querying contig graphs](#querying-contig-graphs)
* [Assembler examples](../assemblerexamples/)
* [More examples](../moreexamples/)
* [Applications](../exampleapplications/)

Reference

* [CLI Commands](../cli/)
* [API Documentation](../api/)
* [File Formats](../fileformats/)

Support

* [FAQ](../faq/)
* [Changelog](../changelog/)

[agtools](..)

* Guides
* API Tutorial
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/tutorial.md)

---

# API Tutorial

This page is a detailed tutorial of *agtools*' API. If you want to get a quick idea on how the *agtools* API works, do check out the [Quick Start Guide](../quickstart/). If you have not installed *agtools* yet, refer to [Installing *agtools*](../install/).

## Importing *agtools*

You can import *agtools* within a Python environment.

```
% python
Python 3.13.5 | packaged by Anaconda, Inc. | (main, Jun 12 2025, 11:23:37) [Clang 14.0.6 ] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import agtools
>>> print(agtools.__version__)
1.0.2
```

*agtools* provides two graph classes: `UnitigGraph` and `ContigGraph`. You can import them as follows.

```
>>> from agtools.core.unitig_graph import UnitigGraph
>>> from agtools.core.contig_graph import ContigGraph
```

Note

`UnitigGraph` and `ContigGraph` have slightly different implementations. If you want to just load a GFA file use the `UnitigGraph` class. Functions to load assembler-specific contig graphs are provided separately.

## Loading a GFA file

You can load a GFA file using the `from_gfa` method of the `UnitigGraph` class. Let's load an example [GFA file](https://github.com/Vini2/agtools/tree/main/tests/data/ESC).

```
ug = UnitigGraph.from_gfa("assembly_graph_with_scaffolds.gfa")
```

This will load the original segments (denoted by `S` tags) as vertices and links (denoted by `L` tags) as edges. If you are not familiar with the GFA format please refer to the [GFA Format Specification](https://gfa-spec.github.io/GFA-spec/GFA1.html).

You can view the different attributes of the graph.

```
>>> ug.file_path
'assembly_graph_with_scaffolds.gfa'
>>> ug.vcount   # number of vertices (segments) in the graph
982
>>> ug.ecount   # number of edges in the graph
1265
>>> ug.lcount   # number of lines starting with tag 'L'
1318
>>> ug.pcount   # number of lines starting with tag 'P'
190
```

You can call different functions to calculate graph and sequence based statistics.

```
>>> ug.calculate_average_node_degree()
2.576374745417515
>>> ug.calculate_average_segment_length()
8490.319755600814
>>> ug.calculate_n50_l50()
(60706, 36)
```

You can retrieve a sequence given the segment ID as follows. A `Bio.Seq.Seq` object will be returned.

```
>>> seq = ug.get_segment_sequence("3042")
>>> seq
Seq('TGATTTTCGCGCGATTACTACGATGATTTCAAACGATTCCTCTGATTATTTCACGC')
>>> seq.reverse_complement()
Seq('GCGTGAAATAATCAGAGGAATCGTTTGAAATCATCGTAGTAATCGCGCGAAAATCA')
```

Note

Assembly graphs can be huge (10-100 GB in size). Hence, segment sequences are not loaded in to memory when creating the graph object. Instead, file pointers are kept for quick retrieval of sequences when needed.

## Loading contig graphs

Different assemblers have different ways of representing assembly graphs. Some assemblers generated a unitig graph and resolved contigs from it where as some assemblers directly generate a contig graph. *agtools* currently supports the following short-read and long-read assemblers.

* [SPAdes](https://github.com/ablab/spades)
* [MEGAHIT](https://github.com/voutcn/megahit)
* [Flye](https://github.com/mikolmogorov/Flye)
* [myloasm](https://github.com/bluenote-1577/myloasm)

Please refer to the [assembler-specific examples](../assemblerexamples/) for further details on the graph representations and more details examples.

### Loading a SPAdes graph

SPAdes generates a unitig graph and resolves longer paths as contigs. You will need three files to load a SPAdes contig graph.

* `assembly_graph_with_scaffolds.gfa`
* `contigs.fasta`
* `contigs.paths`

You can load a SPAdes contig graph as follows.

```
>>> from agtools.assemblers import spades
>>> graph_file = "tests/data/ESC/assembly_graph_with_scaffolds.gfa"
>>> contigs_file = "tests/data/ESC/contigs.fasta"
>>> contig_paths_file = "tests/data/ESC/contigs.paths"
>>> cg = spades.get_contig_graph(graph_file, contigs_file, contig_paths_file)
```

Note

If you want to load the SPAdes unitig graph, you can load it as

```
unitig_graph = UnitigGraph.from_gfa("tests/data/ESC/assembly_graph_with_scaffolds.gfa")
```

### Loading a MEGAHIT graph

Note

By default, MEGAHIT will not generate the assembly graph. You have to run `megahit_core` to get the assembly graph which will be in the FASTG format. Please refer to [MEGAHIT basic usage](https://github.com/voutcn/megahit?tab=readme-ov-file#basic-usage).

```
megahit_core contig2fastg 141 out/intermediate_contigs/final.contigs.fa > final.fastg
```

Then you can use the *agtools* CLI command `fastg2gfa` to convert it to GFA format. Please refer to the [CLI reference](../cli/) for further details on the `fastg2gfa` subcommand.

Once you have the GFA file of the assembly graph and the contigs file, you can load the contig graph as follows.

```
>>> from agtools.assemblers import megahit
>>> graph_file = "tests/data/5G/final.gfa"
>>> contig_file = "tests/data/5G/final.contigs.fa"
>>> cg = megahit.get_contig_graph(graph_file, contig_file)
```

### Loading a Flye graph

Similar to SPAdes, Flye also generates a unitig graph and resolves longer paths as contigs. You will need three files to load a Flye contig graph.

* `assembly_graph.gfa`
* `assembly.fasta`
* `assembly_info.txt`

You can load a Flye contig graph as follows.

```
>>> from agtools.assemblers import flye
>>> graph_file = "tests/data/1Y3B/assembly_graph.gfa"
>>> contigs_file = "tests/data/1Y3B/assembly.fasta"
>>> contig_paths_file = "tests/data/1Y3B/assembly_info.txt"
>>> cg = flye.get_contig_graph(graph_file, contigs_file, contig_paths_file)
```

Warning

Please note that the sequences in the final Flye contig assembly may not be same as those derived from the GFA file due to post-polishing steps and the way Flye builds contigs (see [Flye/issues/610](https://github.com/mikolmogorov/Flye/issues/610)).

Note

If you want to load the Flye unitig graph, you can load it as

```
unitig_graph = UnitigGraph.from_gfa("tests/data/1Y3B/assembly_graph.gfa")
```

### Loading a myloasm graph

Myloasm generates an assembly graph in GFA format with contigs. However, not all the contigs that appear in the graph will appear in the FASTA file.

Note

Note that some contigs present in the myloasm assembly graph may not be included in the corresponding FASTA file. In such cases, you can use the *agtools* CLI command `clean` to GFA the file with contigs from the FASTA file. Please refer to the [CLI reference](../cli/) for further details on the `clean` subcommand.

You can load a myloasm contig graph as follows.

```
>>> from agtools.assemblers import myloasm
>>> graph_file = "tests/data/myloasm/final_contig_graph.gfa"
>>> contigs_file = "tests/data/myloasm/assembly_primary.fa"
>>> cg = myloasm.get_contig_graph(graph_file, contigs_file)
```

## Querying contig graphs

You can view the different attributes of the contig graphs obtained using the assembler-specific modules as follows.

```
>>> cg.file_path
'tests/data/ESC/assembly_graph_with_scaffolds.gfa'
>>> cg.vcount
189
>>> cg.ecount
394
>>> cg.lcount
1318
```

You can get the list of contig names as follows.

```
>>> cg.contig_names
['NODE_1_length_488682_cov_86.190505', 'NODE_2_length_472233_cov_17.669606', 'NODE_3_length_354360_cov_17.661738', ...]
```

You can get the mapping of the internal node ID to the contig names as follows.

```
>>> cg.contig_name_to_id
{'NODE_1_length_488682_cov_86.190505': 0, 'NODE_2_length_472233_cov_17.669606': 1, 'NODE_3_length_354360_cov_17.661738': 2, ...}
```

Note

The internal ID starting from 0 is used to index the nodes in the `igraph` object. The internal ID of each contig can be obtained from `contig_name_to_id`. The corresponding contig name can be obtained from `contig_names`. These mappings are useful when traversing nodes using the `igraph` object.

You can call different functions to calculate graph and sequence based statistics.

```
>>> cg.calculate_average_node_degree()
4.169312169312169
>>> cg.calculate_total_length()
8341464
>>> cg.calculate_average_contig_length()
44134.730158730155
>>> cg.calculate_n50_l50()
(220639, 14)
>>> cg.get_gc_content()
0.4350709899365387
```

You can retrieve a sequence given the segment ID as follows. A Bio.Seq.Seq object will be returned.

```
>>> cg.get_contig_sequence("NODE_189_length_56_cov_33.000000")
Seq('TGGCTCTTCAGGATCCAGGGTGTAGTCGGGGTCTGAATCCTCCGGTCTCCAGGAGG')
```

You can get the neighbours of a contig as follows.

```
>>> cg.get_neighbors("NODE_1_length_488682_cov_86.190505")
['NODE_4_length_346431_cov_86.228266', 'NODE_9_length_265823_cov_88.260370', 'NODE_14_length_220639_cov_88.091915', 'NODE_19_length_193605_cov_88.758791', 'NODE_21_length_158927_cov_87.573997', 'NODE_23_length_117248_cov_87.447902', 'NODE_29_length_97556_cov_86.828022', 'NODE_33_length_87414_cov_86.098490', 'NODE_42_length_49567_cov_91.112902', 'NODE_44_length_45842_cov_86.030074', 'NODE_46_length_42994_cov_88.472018', 'NODE_47_length_42793_cov_92.771094', 'NODE_50_length_41992_cov_86.797863', 'NODE_63_length_17530_cov_92.904492', 'NODE_89_length_395_cov_158.788235', 'NODE_95_length_284_cov_84.877729', 'NODE_108_length_160_cov_106.523810', 'NODE_118_length_129_cov_90.905405', 'NODE_136_length_114_cov_87.813559', 'NODE_139_length_111_cov_73.875000', 'NODE_146_length_99_cov_86.818182', 'NODE_148_length_98_cov_74.906977', 'NODE_154_length_88_cov_148.030303', 'NODE_156_length_85_cov_89.700000', 'NODE_164_length_65_cov_81.100000', 'NODE_167_length_63_cov_149.000000']
```

You can check if two contigs are connected by a path as follows.

```
>>> cg.is_connected("NODE_1_length_488682_cov_86.190505", "NODE_146_length_99_cov_86.818182")
True
```

[Previous](../examples/formatconv/ "Format conversion")
[Next](../assemblerexamples/ "Assembler examples")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).