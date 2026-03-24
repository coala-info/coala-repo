ABACAS: Algorithm
Based Automatic Contiguation of

Assembled Sequences

* [Home](index.html)
* [Documentation](documentation.html)
* [Download](https://sourceforge.net/projects/abacas/files/)
* [Bugs](http://sourceforge.net/tracker/?group_id=238123&atid=1105374)
* [MUMmer](http://mummer.sourceforge.net/)
* [ACT](http://www.sanger.ac.uk/Software/ACT/)
* [Pathogen
  Genomics](http://www.sanger.ac.uk/Projects/Pathogens/)
* [WTSI](http://www.sanger.ac.uk)

## Instructions For Use

Inputs: Reference Genome (FASTA) & Contigs (FASTA)

1. Download ABACAS from the  [download page](https://sourceforge.net/projects/abacas/files/)
2. Run: perl abacas.pl -r <reference> -q
   <contigs> -p <nucmer|promer>
   **NOTE:** If ABACAS cannot find [MUMmer](http://mummer.sourceforge.net/) from
   the default path - it will prompt the user to enter the location of
   MUMer
3. ABACAS may take several minutes to run for large
   genomes/chromosomes and will produce a number of different output files
   in the working directory
4. Start [ACT](http://www.sanger.ac.uk/Software/ACT/)
   and load the sequence and comparison files as printed out by ABACAS.
5. In ACT, load the contig names by going to 'File',
   <query>, 'Read an Entry', and select the file
   <query>\_<reference>.tab
6. You can also load the repeat plot for the reference which
   tells whether or not gaps are due to repetitive sequence. You can load
   this by going to 'Graph', '<reference>', 'Add User Plot',
   and select the file '<reference>.Repeats.plot'
7. The file '<query>.bin' contains the names of
   the contigs that were not mapped and mapped multiple times to the
   reference.

## [User manual](Manual.html)

A detailed documentation and test dataset could be found in the [user manual](Manual.html) page.

## Conact

Email: sa4 {at} sanger.ac.uk

[SourceForge](https://sourceforge.net/)      [![sanger logo](sanger_w100.png)](www.sanger.ac.uk)    [![biomalpar](biomalpar.jpg)](http://www.biomalpar.org/)