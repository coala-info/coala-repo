## Wise2 Package

The Wise2 package is now a rather stately bioinformatics
package that has be around for a while. Its key programs
are *genewise*, a program for aligning proteins
or protein HMMs to DNA, and *dynamite* a rather
cranky "macro language" which automates the production
of dynamic programming.

Wise2 is maintained by Ewan Birney. I had thought that
most of Wise2 development would have stopped around
3 years ago due to the developed of Guy Slater's excellent
[exonerate](http://www.ebi.ac.uk/~guy/exonerate/)
package which handles many of the problems the Wise2 package
does but around 1,000 fold faster.

However, I've found that I can't quite leave Wise2 alone.
Partly this is because it is still used, in particular
in the Ensembl pipeline (Ensembl also heavily uses Exonerate,
but a number of the key steps still use Genewise), partly because
Wise2 is still the only package which handles some cases, for
example, protein HMMs to DNA. The main reason though is that
I still develop new methods, and unsurprisingly I find it easiest
to develop those in Wise2. Hence the on-going development of Wise2.

### Wise2.4

The Wise2.4 package is the "revival" release of Wise2. It includes
the following programs/methods:

+ In genewise, a more flexible splice site model is allowed, which takes PWMs of the 5' and 3' splice sites+ genewise has a new experimental model which can take into account
    intron phase position, -alg 623P. This allows tieing intron positions
    to specific points in the protein+ There is a new program, promoterwise, which is available for
      aligning sequences that are not co-linear+ The dynamite compiler generated code for the divide and conquor code is about twice as fast (many thank to Steve Searle for these improvements).

The latest package is [Wise2.4.1this release has the following improvements

+ A HMMer2 issue, fixed a while ago in HMMer2 has been back ported into Wise2 HMMer's libraries. This bug appears in i686 linux architectures and probably elsewhere+ The phased intron system is better documented and tested

Previous Wise2.4 releases

+ [Wise2.4.0](./wise2.4.0.tar.gz).](./wise2.4.1.tar.gz)