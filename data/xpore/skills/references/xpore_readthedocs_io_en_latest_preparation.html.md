[xpore](index.html)

latest

* [Installation](installation.html)
* [Quickstart - Detection of differential RNA modifications](quickstart.html)
* [Output table description](outputtable.html)
* [Configuration file](configuration.html)
* Data preparation from raw reads
* [Data](data.html)
* [Command line arguments](cmd.html)
* [Citing xPore](citing.html)
* [Getting Help](help.html)

[xpore](index.html)

* [Docs](index.html) »
* Data preparation from raw reads
* [Edit on GitHub](https://github.com/GoekeLab/xpore/blob/master/docs/source/preparation.rst)

---

# Data preparation from raw reads[¶](#data-preparation-from-raw-reads "Permalink to this headline")

1. After obtaining fast5 files, the first step is to basecall them. Below is an example script to run Guppy basecaller. You can find more detail about basecalling at [Oxford nanopore Technologies](https://nanoporetech.com):

   ```
   guppy_basecaller -i </PATH/TO/FAST5> -s </PATH/TO/FASTQ> --flowcell <FLOWCELL_ID> --kit <KIT_ID> --device auto -q 0 -r
   ```
2. Align to transcriptome:

   ```
   minimap2 -ax map-ont -uf -t 3 --secondary=no <MMI> <PATH/TO/FASTQ.GZ> > <PATH/TO/SAM> 2>> <PATH/TO/SAM_LOG>
   samtools view -Sb <PATH/TO/SAM> | samtools sort -o <PATH/TO/BAM> - &>> <PATH/TO/BAM_LOG>
   samtools index <PATH/TO/BAM> &>> <PATH/TO/BAM_INDEX_LOG>
   ```
3. Resquiggle using [nanopolish eventalign](https://nanopolish.readthedocs.io/en/latest/quickstart_eventalign.html):

   ```
   nanopolish index -d <PATH/TO/FAST5_DIR> <PATH/TO/FASTQ_FILE>
   nanopolish eventalign --reads <PATH/TO/FASTQ_FILE> \
   --bam <PATH/TO/BAM_FILE> \
   --genome <PATH/TO/FASTA_FILE \
   --signal-index \
   --scale-events \
   --summary <PATH/TO/summary.txt> \
   --threads 32 > <PATH/TO/eventalign.txt>
   ```

[Next](data.html "Data")
 [Previous](configuration.html "Configuration file")

---

© Copyright 2020, Ploy N. Pratanwanich
Revision `3bf7114e`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).