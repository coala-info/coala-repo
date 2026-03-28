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
* [Preprocess](../graphbin_preprocess/)
* [Usage](../graphbin_usage/)

GraphBin2

* [Introduction](../graphbin2_intro/)
* Preprocess
  + [Assembling and initial binning](#assembling-and-initial-binning)
  + [Formatting the initial binning result](#formatting-the-initial-binning-result)
  + [Obtain the coverage of contigs (abundance.tsv)](#obtain-the-coverage-of-contigs-abundancetsv)
* [Usage](../graphbin2_usage/)

Processing

* [Prepare](../prepare/)
* [Visualise](../visualise/)
* [Evaluate](../evaluate/)

[GraphBin-Tk](..)

* GraphBin2
* Preprocess
* [Edit on GitHub](https://github.com/Vini2/gbintk/edit/master/docs/graphbin2_preprocess.md)

---

# Preprocessing for GraphBin2

## Assembling and initial binning

Before running GraphBin2, you have to assemble your read data into contigs and bin the contigs. Please refer to [assembly instructions](https://gbintk.readthedocs.io/en/latest/metacoag_preprocess/) and [obtaining the binning result](https://gbintk.readthedocs.io/en/latest/metacoag_usage/) provided under MetaCoAG.

Alternatively, you can use other binning tools such as such as [MaxBin2](https://sourceforge.net/projects/maxbin2/), [CONCOCT](https://concoct.readthedocs.io/en/latest/), [MetaBAT2](https://bitbucket.org/berkeleylab/metabat) or [VAMB](https://github.com/RasmussenLab/vamb) to get the initial binning results for your data.

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

## Obtain the coverage of contigs (`abundance.tsv`)

You can use [CoverM](https://github.com/wwood/CoverM) to get the coverage of contigs. You can run the following commands to get the `abundance.tsv` file. Please make sure that there are **no headers** in the `abundance.tsv` file.

```
coverm contig -1 reads_1.fastq -2 reads_2.fastq -r contigs.fasta -o abundance.tsv -t 8
sed -i '1d' abundance.tsv   # remove the header of the file
```

The resulting `abundance.tsv` file can be directly used in GraphBin2.

Now we are all set to run GraphBin2.

[Previous](../graphbin2_intro/ "Introduction")
[Next](../graphbin2_usage/ "Usage")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).