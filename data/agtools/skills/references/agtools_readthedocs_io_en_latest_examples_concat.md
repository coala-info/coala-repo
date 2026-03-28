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
  + Concatenating multiple graphs
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
* Concatenating multiple graphs
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/examples/concat.md)

---

## Concatenating multiple assembly graphs

*agtools* can concatenate multiple GFA files. This can be useful for downstream analysis of assemblies with multiple samples. You can use the `concat` subcommand provided through the command-line interface. Please refer to the [CLI reference](../../cli/) for further details on the `concat` subcommand.

Note

The `concat` subcommand will NOT merge similar segments. It simply concatenates the segments and other elements in the GFA files.

You can run the following command to concatenate multiple GFA files. Make sure to provide each GFA file using `-g`.

```
agtools concat -g test_graph_1.gfa -g test_graph_2.gfa -g test_graph_3.gfa -o ./
```

The lines with different tags `H`, `S`, `L`, `J`, `C`, `P` and `W` will be grouped together from the GFA files and written together.

Tip

If two GFA files have the same segment ID, path ID or walk ID, the run will fail. If you have duplicate IDs, please make sure to run the `rename` subcommand before concatenating.

[Previous](../rename/ "Renaming elements")
[Next](../filter/ "Filtering segments")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).