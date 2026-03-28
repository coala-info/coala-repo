[PPanGGOLiN](../index.html)

User Guide:

* [Installation](install.html)
* [Quick usage](QuickUsage/quickAnalyses.html)
* [Practical information](practicalInformation.html)
* [Pangenome analyses](PangenomeAnalyses/pangenomeAnalyses.html)
* [Regions of genome plasticity analyses](RGP/rgpAnalyses.html)
* [Conserved module prediction](Modules/moduleAnalyses.html)
* [Write genomes](writeGenomes.html)
* [Write pangenome sequences](writeFasta.html)
* [Align external genes to a pangenome](align.html)
* [Projection](projection.html)
* Prediction of Genomic Context
  + [Search Genomic context with sequences](#search-genomic-context-with-sequences)
  + [Search with gene family ID.](#search-with-gene-family-id)
  + [Output format](#output-format)
  + [Detailed options](#detailed-options)
* [Multiple Sequence Alignment](MSA.html)
* [Metadata and Pangenome](metadata.html)

Developper Guide:

* [How to Contribute ✨](../dev/contribute.html)
* [Building the Documentation](../dev/buildDoc.html)
* [API Reference](../api/api_ref.html)

[PPanGGOLiN](../index.html)

* Prediction of Genomic Context
* [View page source](../_sources/user/genomicContext.md.txt)

---

# Prediction of Genomic Context[](#prediction-of-genomic-context "Permalink to this heading")

The PPanGGOLiN `context` command enables the identification of genomic contexts for query proteins. These contexts consist of genes commonly found in proximity to the proteins of interest in the different genomes.

The analysis can be run on a formerly computed pangenomes and users can query one or multiple genes at once. The search can be conducted either directly with gene/protein sequences in a FASTA file or by utilizing a list of gene family IDs. Both methods are seamlessly integrated within the `context` subcommand.

## Search Genomic context with sequences[](#search-genomic-context-with-sequences "Permalink to this heading")

To search your genomic context, you can use a FASTA file containing genes or proteins. The command can be launched as such:

`ppanggolin context -p pangenome.h5 --sequences protein.fasta`

To utilize this subcommand, ensure that your pangenome contains sequences associated with gene family representatives. This is the case with a pangenome computed with an external clustering (see the [cluster](PangenomeAnalyses/pangenomeCluster.html) subcommand).

## Search with gene family ID.[](#search-with-gene-family-id "Permalink to this heading")

Another possibility is to give a list of gene families ID used to compute the pangenome. You can run the subcommand like this:

`ppanggolin context -p pangenome.h5 --family families.txt`

In this scenario, you can give a pangenome without gene families representatives sequences. This option is compatible with a pangenome computed with an external clustering (see the [cluster](PangenomeAnalyses/pangenomeCluster.html) subcommand).

## Output format[](#output-format "Permalink to this heading")

If you are using families IDs, the only output you will receive is the `gene_context.tsv` file. If you use sequences, you will have another output file that report the alignment between sequences and pangenome families (see detail in [align subcommand](align.html#align-external-genes-to-a-pangenome)).

There are 6 columns in `gene_context.tsv`.

1. **geneContext\_ID**: Identifier of the found context. It is incrementally generated, beginning with 1
2. **Gene\_family\_name**: Identifier of the gene family, from the pangenome, correspond to the found context
3. **Sequence\_ID**: Identifier of the searched sequence in the pangenome
4. **Nb\_Genomes**: Number of genomes where the genomic context is found
5. **Partition**: Partition of the gene family corresponding to the found context
6. **Target\_family**: Whether the family is a target family, meaning it matches an input sequence, or a family provided as input.

Note

In **sequence\_ID**, it is possible to find a NA value. This corresponds to cases where a gene family other than the one specified by the user is found in the context.

## Detailed options[](#detailed-options "Permalink to this heading")

| option name | Description |
| --- | --- |
| –fast | Use representative sequences of gene families for input gene alignment. This option is recommended for faster processing but may be less sensitive. By default, all pangenome genes are used for alignment. This argument makes sense only when –sequence is provided. (default: False) |
| –no\_defrag | Do not use the defragmentation step, to align sequences with MMseqs2 (default: False) |
| –identity | Minimum identity percentage threshold (default: 0.8) |
| –coverage | Minimum coverage percentage threshold (default: 0.8) |
| -t, –transitive | Size of the transitive closure used to build the graph. This indicates the number of non-related genes allowed in-between two related genes. Increasing it will improve precision but lower sensitivity a little. (default: 4) |
| -s, –jaccard | Minimum jaccard similarity used to filter edges between gene families. Increasing it will improve precision but lower sensitivity a lot. (default: 0.85) |
| -w, –window\_size | Number of neighboring genes that are considered on each side of a gene of interest when searching for conserved genomic contexts. (default: 5) |

[Previous](projection.html "Projection")
[Next](MSA.html "Multiple Sequence Alignment")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).