## Consan: pairwise structural RNA alignment

### Description:

Pairwise RNA structural alignment, both unconstrained and
constrained on alignment pins.

### Source Code:

The Consan package contains source and minimal compile instructions.
Consan was written in ANSI C and tested on Mandrake Linux.

<consan-1.2.tar.gz>

This is the Consan code only package (without datasets) as a single
gzip'ed tar ball (692 KB).

<consan-1.2_all.tar.gz>

This is the complete Consan package (with datasets, described below)
as a single gzip'ed tar ball (1.9 MB).

#### Version History

**v1.0**  Initial version.

**v1.1**  Improved documentation.

**v1.2**  Fixed bug which caused problems with long path names to
 *dpswalign*.

### Documentation:

* <README>* <INSTALL>* <LICENSE> (GPL)* <paperguide.txt>
        (Describes how Consan programs are used to generate the results
        reported in the paper referenced below).

### Reference:

Dowell, RD and Eddy, SR. Efficient pairwise RNA structure
prediction and alignment using sequence alignment constraints.
 *[BMC Bioinformatics 2006, 7:400](http://www.biomedcentral.com/1471-2105/7/400)*.

### Data Sets:

* <notes.txt>* Training Set (<mix80.stk>)
  * Rfam v7 Test Sets
    + Published Families excluding SSU
      (<Rfam.v7.pub80.stk>)
    + Random 100 5S and tRNA
      (<R100.stk> ;
      <R100.pairs.stk>)
    + Percent Identity Balanced Set
      (<percid.stk>)
  * Dynalign Benchmarking Set
    (contact
    [David H. Mathews](http://rna.urmc.rochester.edu/) )* Stemloc Benchmarking Set
      (<stemloc.stk>)

### Links to External Software:

* [Dynalign](http://rna.urmc.rochester.edu/)* [Stemloc](http://biowiki.org/dart) (part of Dart package)* [PMcomp](http://www.tbi.univie.ac.at/~ivo/RNA/PMcomp/)* [Foldalign](http://foldalign.kvl.dk/)

### Contributors and Acknowledgements

* Contributors of code include Robin Dowell, Sean Eddy, Robert J. Klein,
  and Elena Rivas.* Testers inclue Shandy Wikman and Matt Yoder* Acknowledgements to Sean Eddy, Ian Holmes, David Mathews,
      Ivo Hofacker, Jan Gorodkin, and Elena Rivas for intellectual
      contributions.

### Contact Info:

Robin Dowell

**Email:**   robin.dowell@colorado.edu

---

Last Modified:
Wed Nov 8 10:56:11 CST 2006