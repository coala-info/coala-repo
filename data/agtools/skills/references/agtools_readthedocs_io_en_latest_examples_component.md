[agtools](../..)

Home

* [Introduction](../..)

Getting Started

* [Installation](../../install/)
* [Quick Start](../../quickstart/)

Guides

* CLI Examples
  + [Obtaining stats](../stats/)
  + [Renaming elements](../rename/)
  + [Concatenating multiple graphs](../concat/)
  + [Filtering segments](../filter/)
  + [Cleaning a graph file](../clean/)
  + Get component of a segment
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
* Get component of a segment
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/examples/component.md)

---

## Get constituent component of a segment

*agtools* can separate out the constituent component of a given segment and output the GFA file of that component. You can use the `component` subcommand provided through the command-line interface. Please refer to the [CLI reference](../../cli/) for further details on the `component` subcommand.

Here is an [example GFA file](https://github.com/Vini2/agtools/tree/main/docs/data/component_ex_graph.gfa).

```
H   VN:Z:1.0
S   A1  ACGTAC
S   A2  CGTACG
S   A3  GTACGT
S   A4  TACGTA
S   B1  TTGCAA
S   B2  TGCAAG
S   B3  GCAAGT
L   A1  +   A2  +   5M
L   A2  +   A3  +   5M
L   A3  +   A4  +   5M
L   B1  +   B2  +   5M
L   B2  +   B3  +   5M
P   contig_A    A1+,A2+,A3+,A4+ 5M,5M,5M
P   contig_B    B1+,B2+,B3+ 5M,5M
```

The graph will look as follows. It has two connected components.

![](../../images/component_graph.png)

We want to get the component containing segment `A3`. You can run the following command to get the GFA file of the component.

```
agtools component -g test_graph.gfa -s A3 -o ./
```

The GFA file of the extracted component will look as below.

```
H   VN:Z:1.0
S   A1  ACGTAC
S   A2  CGTACG
S   A3  GTACGT
S   A4  TACGTA
L   A1  +   A2  +   5M
L   A2  +   A3  +   5M
L   A3  +   A4  +   5M
P   contig_A    A1+,A2+,A3+,A4+ 5M,5M,5M
```

[Previous](../clean/ "Cleaning a graph file")
[Next](../formatconv/ "Format conversion")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).