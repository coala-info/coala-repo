[![HMMER](images/hmmer_title.png)

# HMMER](/)

* [Download](download.html)
* [Documentation](documentation.html)
* [Search](http://www.ebi.ac.uk/Tools/hmmer/)
* [Blog](http://cryptogenomicon.org/category/hmmer.html)

## HMMER: biosequence analysis using profile hidden Markov models

Get the latest version

v3.4

[Download source](http://eddylab.org/software/hmmer/hmmer.tar.gz)

[(archived older versions)](download.html)

HMMER is used for searching sequence databases for sequence homologs,
and for making sequence alignments. It
implements methods using probabilistic models called profile hidden
Markov models (profile HMMs).

HMMER is often used together with a profile database, such as
[Pfam](http://pfam.xfam.org/) or many of the databases
that participate in [Interpro](http://www.ebi.ac.uk/interpro/).
But HMMER can also work with query *sequences*, not just profiles,
just like BLAST. For example, you can search a protein query sequence against
a database with **phmmer**, or do an iterative search with
**jackhmmer**.

HMMER is designed to detect remote homologs as
sensitively as possible, relying on the strength of its
underlying probability models. In the past, this strength
came at significant computational expense, but as of the new
HMMER3 project, HMMER is now essentially as fast as BLAST.

HMMER can be downloaded and installed as a command line tool on your own hardware,
and now it is also more widely accessible to the scientific community via
[new search servers](http://www.ebi.ac.uk/Tools/hmmer/) at the European
Bioinformatics Institute.

### Perform a Search

An online interactive [search](http://www.ebi.ac.uk/Tools/hmmer/) service is available at the European Bioinformatics Institute. Go there to [search](http://www.ebi.ac.uk/Tools/hmmer/) against the latest Uniprot databases.

### [Documentation](documentation.html)

The HMMER User's Guide: [[PDF]](http://eddylab.org/software/hmmer/Userguide.pdf).

### News

See the blog [Cryptogenomicon](http://cryptogenomicon.org/category/hmmer.html) for more information and discussion about HMMER3.