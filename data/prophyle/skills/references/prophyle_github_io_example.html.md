* [Home](index.html)
* [Get it](install.html)
* [Docs](contents.html)
* [Extend/Develop](http://github.com/prophyle/prophyle)

[ProPhyle

DNA sequence classification](index.html)

### Navigation

* [index](genindex.html "General Index")
* [next](requirements.html "2. Requirements") |
* [previous](contents.html "ProPhyle documentation contents") |
* [ProPhyle home](index.html) |
* [Documentation](contents.html) »
* 1. Quick example

#### Previous topic

[ProPhyle documentation contents](contents.html "previous chapter")

#### Next topic

[2. Requirements](requirements.html "next chapter")

### This Page

* [Show Source](_sources/example.rst.txt)

### Quick search

# 1. Quick example[¶](#quick-example "Link to this heading")

1. Install ProPhyle using [Bioconda](https://bioconda.github.io/):

   > ```
   > conda config --add channels defaults
   > conda config --add channels conda-forge
   > conda config --add channels bioconda
   > conda install prophyle
   > ```
2. Download the [RefSeq](https://www.ncbi.nlm.nih.gov/refseq/) bacterial database:

   > ```
   > prophyle download bacteria
   > ```
3. Build an index for randomly selected 10% genomes from the E.coli subtree (taxid 561 in the NCBI taxonomy), with k-mer size 25:

   > ```
   > prophyle index -s 0.10 -k 25 ~/prophyle/bacteria.nw@561 _index_ecoli
   > ```
4. Classify your reads:

   > ```
   > prophyle classify _index_ecoli reads.fq > result.sam
   > ```

### Navigation

* [index](genindex.html "General Index")
* [next](requirements.html "2. Requirements") |
* [previous](contents.html "ProPhyle documentation contents") |
* [ProPhyle home](index.html) |
* [Documentation](contents.html) »
* 1. Quick example

© Copyright 2015-2024, Karel Břinda, Kamil Salikhov, Simone Pignotti, Gregory Kucherov.
Created using [Sphinx](https://www.sphinx-doc.org/) 8.0.2.