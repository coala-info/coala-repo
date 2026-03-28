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
* [Prediction of Genomic Context](genomicContext.html)
* [Multiple Sequence Alignment](MSA.html)
* Metadata and Pangenome
  + [Associating Metadata to Pangenome Elements](#associating-metadata-to-pangenome-elements)
    - [Metadata Format](#metadata-format)
    - [Command Specific Option Details](#command-specific-option-details)
      * [`--metadata`](#metadata)
      * [`--source`](#source)
      * [`--assign`](#assign)
      * [`--omit`](#omit)
  + [Checking Metadata Associated with the Pangenome](#checking-metadata-associated-with-the-pangenome)
  + [Exporting Metadata to TSV Files](#exporting-metadata-to-tsv-files)

Developper Guide:

* [How to Contribute ✨](../dev/contribute.html)
* [Building the Documentation](../dev/buildDoc.html)
* [API Reference](../api/api_ref.html)

[PPanGGOLiN](../index.html)

* Metadata and Pangenome
* [View page source](../_sources/user/metadata.md.txt)

---

# Metadata and Pangenome[](#metadata-and-pangenome "Permalink to this heading")

## Associating Metadata to Pangenome Elements[](#associating-metadata-to-pangenome-elements "Permalink to this heading")

The `metadata` command allows the addition of metadata linked to various pangenome elements. Metadata can be associated with genes, genomes, families, RGPs, spots, and modules using a simple TSV file.

To add metadata to your pangenome, execute the command as shown below:

```
ppanggolin metadata -p PANGENOME --metadata METADATA.TSV --source SOURCE --assign ASSIGN
```

* The `--source` argument corresponds to the metadata’s origin and will serve as the storage key in the pangenome.
* `--assign` allows you to specify the pangenome elements to which you want to add metadata from the following list: {families, genomes, genes, RGPs, spots, modules}.

The associated metadata can then be exported in various output files of PPanGGOLiN such as GFF, PROKSEE JSON Map and Table output for genomes (see [here](writeGenomes.html#incorporating-metadata-into-tables-gff-and-proksee-files) for more details) and in the gexf graph file of the pangenome as well as in the graph resulting in the RGP clustering.

The metadata linked to pangenome elements can be exported to various output file formats within PPanGGOLiN, including GFF, PROKSEE JSON Map, and Table outputs of the `write_genomes` command (see [here](writeGenomes.html#incorporating-metadata-into-tables-gff-and-proksee-files) for more details). Additionally, the metadata can also be included in the gexf graph file representing the pangenome and in the RGP clustering graph.

Note

Certain information (such as species, strain, and dbx\_ref) is extracted from genome annotation files (GBFF, GFF) during the annotation step and added to the pangenome as metadata under the source ‘annotation\_files’. These metadata can be extracted using the `write_metadata` command.

### Metadata Format[](#metadata-format "Permalink to this heading")

PPanGGOLiN offers a highly flexible metadata file format. Only one column name is mandatory, and it aligns with the assignment argument chosen by the user (ie. families, RGPS…).

For instance, the TSV file used to assign metadata to gene families for functional annotation might resemble the following:

| families | Accession | Function | Description |
| --- | --- | --- | --- |
| GF\_1 | Acc\_1 | Fn\_1 | Desc\_1 |
| GF\_2 | Acc\_2 | Fn\_2 | Desc\_2 |
| GF\_2 | Acc\_3 | Fn\_3 | Desc\_3 |
| … | … | … | … |
| GF\_n | Acc\_n | Fn\_n | Desc\_n |

Note

As you can see in the above table, one element (here GF\_2) can be associated with with multiple metadata entries.

### Command Specific Option Details[](#command-specific-option-details "Permalink to this heading")

#### `--metadata`[](#metadata "Permalink to this heading")

PPanGGOLiN enables to give one TSV at a time to add metadata.

#### `--source`[](#source "Permalink to this heading")

The source serves as the key for accessing metadata within the pangenome. If the source name already exists in the pangenome, it can be overwritten using the `--force` option. This system facilitates the utilization of multiple metadata sources, accessible and usable within PPanGGOLiN. In the context of annotation, the source typically represents the name of the annotation database used during the annotation process.

#### `--assign`[](#assign "Permalink to this heading")

PPanGGOLiN enables the addition of metadata to various pangenome elements, including families, genomes, genes, RGPs, spots, and modules. However, the user can provide only one metadata file at a time, thereby specifying a single source and one type of pangenome element.

#### `--omit`[](#omit "Permalink to this heading")

This option allows you to bypass errors resulting from an unfound ID in the pangenome. It can be beneficial when utilizing a general TSV with elements not present in the pangenome. This argument should be used carefully.

## Checking Metadata Associated with the Pangenome[](#checking-metadata-associated-with-the-pangenome "Permalink to this heading")

You can inspect which pangenome elements have associated metadata and their respective sources using the `ppanggolin info` command. For more details on this command, refer to the [info command documentation](PangenomeAnalyses/pangenomeInfo.html).

To check the metadata, execute the following command:

```
ppanggolin info -p PANGENOME --metadata
```

## Exporting Metadata to TSV Files[](#exporting-metadata-to-tsv-files "Permalink to this heading")

The `write_metadata` command allows you to export metadata to TSV files. It creates one file per source of pangenome element metadata.

For example, if families have metadata from sources `hmmer` and `dbcan`, and genomes have metadata from the source `gtdb`, the command will create three files:

* `families_metadata_from_hmmer.tsv`
* `families_metadata_from_dbcan.tsv`
* `genomes_metadata_from_gtdb.tsv`

To export metadata from your pangenome, execute the following command:

```
ppanggolin write_metadata -p PANGENOME --output metadata_tsv_files
```

[Previous](MSA.html "Multiple Sequence Alignment")
[Next](../dev/contribute.html "How to Contribute ✨")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).