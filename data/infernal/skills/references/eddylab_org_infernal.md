|  |  |
| --- | --- |
| ![](infernal-102x149.png) | Infernal: inference of RNA alignments [infernal home](http://eddylab.org/infernal/) | [rfam database](http://rfam.org/) | [eddy lab](http://eddylab.org/) | |

## Overview:

Infernal ("INFERence of RNA ALignment") is for searching DNA sequence
databases for RNA structure and sequence similarities. It is an
implementation of a special case of profile stochastic context-free
grammars called *covariance models* (CMs). A CM is like a sequence profile,
but it scores a combination of sequence consensus and RNA secondary structure
consensus, so in many cases, it is more capable of identifying RNA homologs
that conserve their secondary structure more than their primary sequence.

The latest release of Infernal is
[1.1.5 [7 Sep 2023].](http://eddylab.org/infernal/infernal-1.1.5.tar.gz)

## Documentation:

* User's Guide  [[PDF, 119 pages]](http://eddylab.org/infernal/Userguide.pdf) .* [README](http://eddylab.org/infernal/README.md)
    from the current release.* [Release notes](http://eddylab.org/infernal/RELEASE-1.1.5.md)
      for the current release.

## Reference:

* The recommended citation for using Infernal 1.1 is
  E. P. Nawrocki and S. R. Eddy,
  [Infernal 1.1: 100-fold faster RNA homology searches](http://eddylab.org/publications.html#Nawrocki13c),
  *Bioinformatics* 29:2933-2935 (2013).

## Downloads:

* The current source code:
  [[Infernal 1.1.5 source tarball, 31.3 MB]](http://eddylab.org/infernal/infernal-1.1.5.tar.gz) * Source with binaries:
    [[infernal 1.1.5 with Linux/Intel binaries, 48.4 MB]](http://eddylab.org/infernal/infernal-1.1.5-linux-intel-gcc.tar.gz)
    [[infernal 1.1.5 with MacOSX/Silicon binaries, 45.5 MB]](http://eddylab.org/infernal/infernal-1.1.5-macosx-silicon.tar.gz)
    [[infernal 1.1.5 with MacOSX/Intel binaries, 46.7 MB]](http://eddylab.org/infernal/infernal-1.1.5-macosx-intel.tar.gz)

## Or, install using a package manager:

* [Debian
  package](https://packages.debian.org/search?keywords=infernal), thanks to Michael Crusoe. If you are using Debian, you can install
  with:
   `sudo apt-get install infernal infernal-doc`* [Bioconda package](https://anaconda.org/bioconda/infernal),
    thanks to
    [Björn Grüning](https://github.com/bgruening).
    If you have `conda`, you can install with:
    `conda install -c bioconda infernal`* [Homebrew Science package](https://github.com/Homebrew/homebrew-science).
      With `homebrew`, you can install with
      `brew tap brewsci/bio
      brew install infernal`

Infernal is open source software, freely distributed under the terms
of a standard  [BSD
(Berkeley Software Distribution) license.](http://eddylab.org/infernal/LICENSE).

## Other useful Infernal resources:

* The Infernal [GitHub repository](https://github.com/EddyRivasLab/infernal).* [BioContainer wrapper](https://quay.io/repository/biocontainers/infernal?tab=tags), thanks to
    [Björn Grüning](https://github.com/bgruening).* [Galaxy wrapper](https://toolshed.g2.bx.psu.edu/view/bgruening/infernal/), also thanks to
      [Björn Grüning](https://github.com/bgruening).

## Contact us:

* We welcome bug reports, feature requests, and code contributions. Email us at:
  sean@eddylab.org.

## Internal benchmark:

* The Infernal 1.1 Bioinformatics publication contains results
  from our internal RMARK3 benchmark. Files necessary for
  reproducing that benchmark are available [here](http://eddylab.org/infernal/i1.1-benchmark-rmark3.tar.gz).

## Further reference:

* The
  [Rfam database](http://rfam.xfam.org) of RNA families
  is based on the Infernal software.
  [This article](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6754622) demonstrates how to use the Rfam database and
  website and includes a section on using Infernal for genome
  annotation. Rfam 14 is described in
  [(Kalvari, 2020)](https://academic.oup.com/nar/advance-article/doi/10.1093/nar/gkaa1047/5992291).* [This paper](https://academic.oup.com/nar/article/46/15/7970/4999243) details the discovery of group I introns in archaea
    using Infernal.* [This book chapter](http://eddylab.org/publications.html#Nawrocki13) explains how to use Infernal and Rfam to
      annotate RNAs in genomes.* Infernal-based identification of functional RNAs in metagenomic
        datasets is discussed in [(Nawrocki and Eddy, 2013)](http://eddylab.org/publications.html#Nawrocki13b).* Version 1.0 of Infernal was announced in a 2009 Bioinformatics
          [applications note](http://eddylab.org/publications.html#Nawrocki09).* Several improvements in Infernal 1.0, including techniques used
            to improve speed performance, are described in
            [Eric Nawrocki's 2009 Ph.D. thesis](http://eddylab.org/publications.html#Nawrocki09b).* The trCYK local alignment algorithm is described in
              [(Kolbe and Eddy, 2009)](http://eddylab.org/publications.html#KolbeEddy09).* The QDB query-dependent banded dynamic programming algorithm used
                to increase search speed is described in
                [(Nawrocki and Eddy, 2007)](http://eddylab.org/publications.html#NawrockiEddy07), along with
                mixture Dirichlet priors and entropy weighting.* The
                  [RSEARCH](http://eddylab.org/software.html#rsearch)
                  software for searching with single RNA structures (instead of with
                  profiles built from multiple alignments) is based on Infernal's
                  alignment engines
                  [(Klein and Eddy, 2003)](http://eddylab.org/publications.html#KleinEddy03). RSEARCH also included MPI parallelization
                  and E-value calculations, features that were merged back into
                  Infernal in Infernal 1.0.* The memory-efficient divide-and-conquer CYK alignment algorithm is
                    described in
                    [(Eddy, 2002)](http://eddylab.org/publications.html#Eddy02b). A new implementation, Infernal, replaced COVE.* A chapter of Biological Sequence Analysis
                      [(Durbin et al., 1998)](http://eddylab.org/publications.html#Durbin98) describes CMs in more detail.* The tRNA identification program [tRNAscan-SE](http://eddylab.org/software.html#trnascanse) is based on a tRNA CM and COVE
                        [(Lowe and Eddy, 1997)](http://eddylab.org/publications.html#LoweEddy97).* Covariance models were originally described in
                          [(Eddy and Durbin, 1994)](http://eddylab.org/publications.html#Eddy94). They were first implemented
                          in the
                          [COVE](http://eddylab.org/software.html#cove) software package.

## Archived releases:

For reproducing published results, the following archived older
versions may be of interest:

| Release | Date | Download | Notes |
| --- | --- | --- | --- |
| 1.1.4 | Dec 2020 | [[infernal-1.1.4.tar.gz]](http://eddylab.org/software/infernal/infernal-1.1.4.tar.gz) | Minor update to 1.1.3. "Current" version for nearly three years. |
| 1.1.3 | Nov 2019 | [[infernal-1.1.3.tar.gz]](http://eddylab.org/software/infernal/infernal-1.1.3.tar.gz) | First version where cmscan and cmpress worked for non-calibrated models. |
| 1.1.2 | Jul 2016 | [[infernal-1.1.2.tar.gz]](http://eddylab.org/software/infernal/infernal-1.1.2.tar.gz) | First version with cmscan capable of handling long sequences (e.g. chromosomes). |
| 1.1.1 | Jul 2014 | [[infernal-1.1.1.tar.gz]](http://eddylab.org/software/infernal/infernal-1.1.1.tar.gz) | Version used for the Rfam 12.0 paper: [(Nawrocki, 2015)](http://eddylab.org/publications.html#Nawrocki15) |
| 1.1 | Oct 2013 | [[infernal-1.1.tar.gz]](http://eddylab.org/software/infernal/infernal-1.1.tar.gz) | First stable 1.1 release; the version described in the 2013 Bioinformatics application note: [(Nawrocki and Eddy, 2013)](http://eddylab.org/publications.html#Nawrocki13c) |
| 1.0.2 | Oct 2009 | [[infernal-1.0.2.tar.gz]](http://eddylab.org/software/infernal/infernal-1.0.2.tar.gz) | Last release before the major 1.1 update. This was the "current" version for nearly three years. |
| 1.0.1 | Oct 2009 | [[infernal-1.0.1.tar.gz]](http://eddylab.org/software/infernal/infernal-1.0.1.tar.gz) | Version that reproduces the results in Eric Nawrocki's thesis, [(Nawrocki, 2009)](http://eddylab.org/publications.html#Nawrocki09b) |
| 1.0 | Jan 2009 | [[infernal-1.0.tar.gz]](http://eddylab.org/software/infernal/infernal-1.0.tar.gz) | Version described in the first "official" release paper, [(Nawrocki et al., 2009)](http://eddylab.org/publications.html#Nawrocki09) |
| 0.81 | May 2007 | [[infernal-0.81.tar.gz]](http://eddylab.org/software/infernal/infernal-0.81.tar.gz) | First version with E-values and MPI parallelization. |
| 0.72 | Jan 2007 | [[infernal-0.72.tar.gz]](http://eddylab.org/software/infernal/infernal-0.72.tar.gz) | Version used for the published version of the QDB algorithm paper [(Nawrocki and Eddy, 2007)](http://eddylab.org/publications.html#NawrockiEddy07) |
| 0.71 | Nov 2006 | [[infernal-0.71.tar.gz]](http://eddylab.org/software/infernal/infernal-0.71.tar.gz) | Version used in the submitted version of the QDB algorithm manuscript [(Nawrocki and Eddy, 2007)](http://eddylab.org/publications.html#NawrockiEddy07) |
| 0.7 | Dec 2005 | [[infernal-0.7.tar.gz]](http://eddylab.org/software/infernal/infernal-0.7.tar.gz) | Entropy weighting incorporated. This version was used by Paul Gardner and Eva Freyhult in their [BRaliBaseIII](http://www.binf.ku.dk/~pgardner/bralibase/bralibase3/) benchmark. |
| 0.6 | Nov 2005 | [[infernal-0.6.tar.gz]](http://eddylab.org/software/infernal/infernal-0.6.tar.gz) | Mixture Dirichlets incorporated, under pressure from Paul Gardner and Eva Freyhult's ongoing benchmarking work. |
| 0.55 | Apr 2003 | [[infernal-0.55.tar.gz]](http://eddylab.org/software/infernal/infernal-0.55.tar.gz) | First version with documentation. Rfam 2.0 through Rfam 7.0 are based on 0.5x code [(Griffiths-Jones et al, 2005)](http://eddylab.org/publications.html#Griffiths-Jones05) |
| 0.4 | Aug 2002 | [[infernal-0.4.tar.gz]](http://eddylab.org/software/infernal/infernal-0.4.tar.gz) | cmalign first appears, and was used for final work on Rfam 1.0. |
| 0.3 | Jul 2002 | [[infernal-0.3.tar.gz]](http://eddylab.org/software/infernal/infernal-0.3.tar.gz) | Version used for the first Rfam release [(Griffiths-Jones et al, 2003)](http://eddylab.org/publications.html#Griffiths-Jones03) |
| 0.1 | Apr 2002 | [[infernal-0.1.tar.gz]](http://eddylab.org/software/infernal/infernal-0.1.tar.gz) | Version used in the divide and conquer algorithm paper [(Eddy, 2002)](http://eddylab.org/publications.html#Eddy02b) |

---

|  |
| --- |
| [Eddy/Rivas Laboratory](http://eddylab.org/)  Last modified: Thu Sep 7 18:09:14 2023 |