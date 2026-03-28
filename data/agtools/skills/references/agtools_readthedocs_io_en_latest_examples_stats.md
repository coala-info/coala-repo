[agtools](../..)

Home

* [Introduction](../..)

Getting Started

* [Installation](../../install/)
* [Quick Start](../../quickstart/)

Guides

* CLI Examples
  + Obtaining stats
  + [Renaming elements](../rename/)
  + [Concatenating multiple graphs](../concat/)
  + [Filtering segments](../filter/)
  + [Cleaning a graph file](../clean/)
  + [Get component of a segment](../component/)
  + [Format conversion](../formatconv/)
* [API Tutorial](../../tutorial/)
* [Assembler examples](../../assemblerexamples/)
* [More examples](../../moreexamples/)
* [Applications](../../exampleapplications/)

Reference

* [CLI Commands](../../cli/)
* [API Documentation](../../api/)
* [File Formats](../../fileformats/)

Support

* [FAQ](../../faq/)
* [Changelog](../../changelog/)

[agtools](../..)

* Guides
* CLI Examples
* Obtaining stats
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/examples/stats.md)

---

## Obtaining stats of an assembly graph

*agtools* can generate basic graph and sequence-based statistics for an assembly graph. You can use the `stats` subcommand provided through the command-line interface. Please refer to the [CLI reference](../../cli/) for further details on the `stats` subcommand.

```
agtools stats -g assembly_graph_with_scaffolds.gfa -o ./
```

A text file with the following details will be generated.

```
Basic graph statistics for tests/data/ESC/assembly_graph_with_scaffolds.gfa:
Number of segments: 982
Number of links: 1265
Number of self-loops: 1
Number of connected components: 4
Average node degree: 2

Sequence-based statistics for tests/data/ESC/assembly_graph_with_scaffolds.gfa:
Total length of segments: 8337494 bp
Average segment length: 8490 bp
N50: 60706 bp
L50: 36 segment(s)
GC content: 43.52%
```

[Previous](../../quickstart/ "Quick Start")
[Next](../rename/ "Renaming elements")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).