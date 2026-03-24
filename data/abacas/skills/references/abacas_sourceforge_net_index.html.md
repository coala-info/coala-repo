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

ABACAS is intended to rapidly contiguate
(align, order, orientate), visualize and design primers to close gaps
on shotgun assembled contigs based on a reference sequence.

![](WorkFlow_abacas3.png)

ABACAS uses [MUMmer](http://mummer.sourceforge.net/)
to find alignment positions and identify syntenies of assembled contigs
against the reference. The output is then processed to generate a
pseudomolecule taking overlapping contigs and gaps in to account.
ABACAS generates a comparision file that can be used to visualize
ordered and oriented contigs in [ACT](http://www.sanger.ac.uk/Software/ACT/).
Synteny is represented by red bars where colour intensity decreases
with lower values of percent identity between comparable blocks.
Information on contigs such as the orientation, percent identity,
coverage and overlap with other contigs can also be visualized by
loading the outputted feature file on ACT.

## Funding

Funding for the development of ABACAS is provided by the European Union
6th Framework Program grant to the [BioMalPar Consortium](http://www.biomalpar.org/)
[grant number
LSHP-LT-2004-503578] and the [Wellcome
Trust Sanger Institute](http://www.sanger.ac.uk).

[SourceForge](https://sourceforge.net/)
     [![sanger logo](sanger_w100.png)](www.sanger.ac.uk)
   [![biomalpar](biomalpar.jpg)](http://www.biomalpar.org/)