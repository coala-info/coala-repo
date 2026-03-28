[GraphBin-Tk](..)

Home

* [Introduction](..)
* [Citation](../citation/)
* [Install](../install/)

MetaCoAG

* [Introduction](../metacoag_intro/)
* [Preprocess](../metacoag_preprocess/)
* [Usage](../metacoag_usage/)

GraphBin

* [Introduction](../graphbin_intro/)
* Preprocess
  + [Assembling and initial binning](#assembling-and-initial-binning)
  + [Formatting the initial binning result](#formatting-the-initial-binning-result)
* [Usage](../graphbin_usage/)

GraphBin2

* [Introduction](../graphbin2_intro/)
* [Preprocess](../graphbin2_preprocess/)
* [Usage](../graphbin2_usage/)

Processing

* [Prepare](../prepare/)
* [Visualise](../visualise/)
* [Evaluate](../evaluate/)

[GraphBin-Tk](..)

* GraphBin
* Preprocess
* [Edit on GitHub](https://github.com/Vini2/gbintk/edit/master/docs/graphbin_preprocess.md)

---

# Preprocessing for GraphBin

## Assembling and initial binning

Before running GraphBin, you have to assemble your read data into contigs and bin the contigs. Please refer to [assembly instructions](https://gbintk.readthedocs.io/en/latest/metacoag_preprocess/) and [obtaining the binning result](https://gbintk.readthedocs.io/en/latest/metacoag_usage/) provided under MetaCoAG.

Alternatively, you can use other binning tools such as [MaxBin2](https://sourceforge.net/projects/maxbin2/), [CONCOCT](https://concoct.readthedocs.io/en/latest/), [MetaBAT2](https://bitbucket.org/berkeleylab/metabat) or [VAMB](https://github.com/RasmussenLab/vamb) to get the initial binning results for your data.

## Formatting the initial binning result

You can use the `prepare` subcommand to format an initial binning result in to the `.csv` format (by default) with contig identifiers and bin ID. Contigs are named according to their original identifier and bins are numbered according to the fasta file name. You can run the `prepare` subcommand as follows.

```
# For SPAdes data available in tests/data/
gbintk prepare --assembler spades --resfolder tests/data/5G_metaSPAdes/initial_bins --output tests/data/5G_metaSPAdes/prepare_results

# For MEGAHIT data available in tests/data/
gbintk prepare --assembler megahit --resfolder tests/data/5G_MEGAHIT/initial_bins --output tests/data/5G_MEGAHIT/prepare_results

# For Flye data available in tests/data/
gbintk prepare --assembler flye --resfolder tests/data/1Y3B_Flye/initial_bins --output tests/data/1Y3B_Flye/prepare_results
```

More details on the `prepare` subcommand can be found in the [Prepare](https://gbintk.readthedocs.io/en/latest/prepare/) section of this documentation.

Formatted binning result will be stored in a file named `initial_contig_bins.csv` in the output folder provided.

Now we are all set to run GraphBin.

[Previous](../graphbin_intro/ "Introduction")
[Next](../graphbin_usage/ "Usage")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).