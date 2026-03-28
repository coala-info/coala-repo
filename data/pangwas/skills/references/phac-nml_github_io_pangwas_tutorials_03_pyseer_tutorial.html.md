[panGWAS](../index.html)

* [Home](../index.html)
* [Tutorials](../tutorials/tutorials.html)
* [Manual](../manual/table_of_contents.html)
* [Pipeline](../pipeline/pipeline.html)
* [Code Coverage](../coverage/index.html)
* [Developers](../developers/developers.html)

## On this page

* [Tutorial 03 - Pyseer Tutorial](#tutorial-03---pyseer-tutorial)

# Tutorial 03 - Pyseer Tutorial

This tutorial automates and reproduces the results from the [penicillin resistance GWAS](https://pyseer.readthedocs.io/en/master/tutorial.html) written by the `pyseer` authors.

1. Download the tutorial data.

   ```
   git clone --depth 1 https://github.com/phac-nml/pangwas.git
   cd pangwas
   ```
2. Decompress the data.

   ```
   gunzip data/tutorial_core/snps.Rtab.gz
   gunzip data/tutorial_pangenome/variants.Rtab.gz
   gunzip data/tutorial_pangenome/clusters.tsv.gz
   ```
3. Run the core genome GWAS on pencillin resistance.

   ```
   nextflow run phac-nml/pangwas -profile tutorial_core
   ```
4. Open up the manhattan plot in Edge or Firefox.

   * Path: `results/tutorial_core/manhattan/penicillin/penicillin.plot.svg`
   * Hover your mouse over variants to see contextual information.

   ![](../images/core_manhattan_hovertext.png)
5. Run the pangenome GWAS on penicillin resistance.

   ```
   nextflow run phac-nml/pangwas -profile tutorial_pangenome
   ```

Penicillin resistance is primarily controlled by core genome genes, and we can see that the major genes are identical between a pangenome and core genome GWAS.

The following image was made by importing the raw SVG plots into a vector graphics program (ex. [Affinity](https://affinity.serif.com/en-us/designer)) and adding text and box overlays to highlight the significant variants.

![](..//images/core_vs_pangenome.png)