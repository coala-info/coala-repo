[AMPtk](index.html)

latest

* [AMPtk Overview](overview.html)
* [AMPtk Quick Start](quick-start.html)
* [AMPtk file formats](file-formats.html)
* [AMPtk Pre-Processing](pre-processing.html)
* [AMPtk Clustering](clustering.html)
* [AMPtk OTU Table Filtering](filtering.html)
* [AMPtk Taxonomy](taxonomy.html)
* [AMPtk Commands](commands.html)
* AMPtk Downstream Tools
  + [AMPtk to Phyloseq](#amptk-to-phyloseq)
  + [AMPtk to QIIME](#amptk-to-qiime)
  + [AMPtk to Online Tools](#amptk-to-online-tools)

[AMPtk](index.html)

* AMPtk Downstream Tools
* [Edit on GitHub](https://github.com/nextgenusfs/amptk/blob/master/docs/downstream.rst)

---

# AMPtk Downstream Tools[¶](#amptk-downstream-tools "Link to this heading")

## AMPtk to Phyloseq[¶](#amptk-to-phyloseq "Link to this heading")

Importing a BIOM table from AMPtk into Phyloseq is relatively straightforward:

```
#load in biom and tree file
physeq <- import_biom('mydata.biom', 'mydata.tree.phy')

#rename taxonomy headings
colnames(tax_table(physeq)) <- c("Kingdom", "Phylum", "Class",
  "Order", "Family", "Genus", "Species")

#print the sample variables
sample_variables(physeq)
```

## AMPtk to QIIME[¶](#amptk-to-qiime "Link to this heading")

The BIOM file produced by `amptk taxonomy` is compatible directly with QIIME community ecology scripts, assuming that you have a QIIME compatible mapping file:

```
summarize_taxa_through_plots.py -i otu_table.biom -o taxa_summary -m mapping_file.txt
```

## AMPtk to Online Tools[¶](#amptk-to-online-tools "Link to this heading")

The BIOM output is also compatible with [Phinch](http://phinch.org) web based visualization as well as [MetaCoMET](https://probes.pw.usda.gov/MetaCoMET/).

[Previous](commands.html "AMPtk Commands")

---

© Copyright 2017, Jon Palmer.
Revision `15f497c3`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).