Search this site

Embedded Files

Skip to main content

Skip to navigation

[DANPOS](/site/danposdoc/home)

* [Home](/site/danposdoc/home)
* [A. Tutorial](/site/danposdoc/a-tutorial)

  + [(1) Dpos](/site/danposdoc/a-tutorial/1-dpos)
  + [(2) Dpeak](/site/danposdoc/a-tutorial/2-dpeak)
  + [(3) Dregion](/site/danposdoc/a-tutorial/3-dregion)
  + [(4) Dtriple](/site/danposdoc/a-tutorial/4-dtriple)
  + [(5) Profile](/site/danposdoc/a-tutorial/5-profile)
  + [(6) stat](/site/danposdoc/a-tutorial/6-stat)
  + [(7) wiq](/site/danposdoc/a-tutorial/7-wiq)
  + [(8) wig2wiq](/site/danposdoc/a-tutorial/8-wig2wiq)
* [B. Documentation](/site/danposdoc/b-documentation)

  + [(1) Dpos](/site/danposdoc/b-documentation/1-dpos)

    - [Input files](/site/danposdoc/b-documentation/1-dpos/input-files)
    - [Output files](/site/danposdoc/b-documentation/1-dpos/output-files)
    - [parameters](/site/danposdoc/b-documentation/1-dpos/parameters)
  + [(2) dpeak](/site/danposdoc/b-documentation/2-dpeak)

    - [Input files](/site/danposdoc/b-documentation/2-dpeak/input-files)
    - [Output files](/site/danposdoc/b-documentation/2-dpeak/output-files)
    - [Parameters](/site/danposdoc/b-documentation/2-dpeak/parameters)
  + [(3) dregion](/site/danposdoc/b-documentation/3-dregion)

    - [Input files](/site/danposdoc/b-documentation/3-dregion/input-files)
    - [Output files](/site/danposdoc/b-documentation/3-dregion/output-files)
    - [Parameters](/site/danposdoc/b-documentation/3-dregion/parameters)
  + [(4) Dtriple](/site/danposdoc/b-documentation/4-dtriple)
  + [(5) Profile](/site/danposdoc/b-documentation/5-profile)

    - [Input files](/site/danposdoc/b-documentation/5-profile/input-files)
    - [Output files](/site/danposdoc/b-documentation/5-profile/output-files)
    - [Parameters](/site/danposdoc/b-documentation/5-profile/parameters)
  + [(6) stat](/site/danposdoc/b-documentation/6-stat)
  + [(7) WIQ](/site/danposdoc/b-documentation/7-wiq)

    - [Input files](/site/danposdoc/b-documentation/7-wiq/input-files)
    - [Output files](/site/danposdoc/b-documentation/7-wiq/output-files)
    - [parameters](/site/danposdoc/b-documentation/7-wiq/parameters)
  + [(8) Wig2Wiq](/site/danposdoc/b-documentation/8-wig2wiq)

    - [Input files](/site/danposdoc/b-documentation/8-wig2wiq/input-files)
    - [Output files](/site/danposdoc/b-documentation/8-wig2wiq/output-files)
    - [Parameters](/site/danposdoc/b-documentation/8-wig2wiq/parameters)
* [C. Install](/site/danposdoc/c-install)
* [D. Download](/site/danposdoc/d-download)
* [E. Help](/site/danposdoc/e-help)

[DANPOS](/site/danposdoc/home)

# Input files

**Wiggle format file:**

Wiggle format file should contain protein occupancy data. We suggest using DANPOS to calculate occupancy from sequencing reads. DANPOS will save the occupancy data in .wig files.

Click for [help information](http://www.google.com/url?q=http%3A%2F%2Fgenome.ucsc.edu%2FFAQ%2FFAQformat.html%23format6&sa=D&sntz=1&usg=AOvVaw3-lRIg_tCDYLgjxgQHEtGj) about .wig format.

**Bed format file (--bed3file\_paths):**

Bed format file always contains a set of genomic elements, including their location in the genome. To be used by the Profile function in DANPOS, each .bed file must contain at least the following columns:

**(1) chr**  chromosome name

**(2) start** the start point of an element

**(3) end** the end point of an element

Click for more [help information](http://www.google.com/url?q=http%3A%2F%2Fgenome.ucsc.edu%2FFAQ%2FFAQformat.html%23format1&sa=D&sntz=1&usg=AOvVaw1L8RXPsJoqBhwmG_5d8kfB) about .bed format.

**Gene file (--genefile\_paths)**

we suggest to download gene set from the [UCSC table browser](http://www.google.com/url?q=http%3A%2F%2Fgenome.ucsc.edu%2Fcgi-bin%2FhgTables%3Fcommand%3Dstart&sa=D&sntz=1&usg=AOvVaw06sENyi985ZHTmIlD98Y3K). Each file must contain at least the following columns:

**(1) name** Gene name

**(2) chrom** chromosome name

**(3) strand** Strand, can be "+" or "-"

**(4) txStart** the start point of gene body, must be smaller than txEnd

**(5) txEnd** the end point of gene body, must be larger than txStart

**(6) cdsStart** the start point of coding DNA sequence, must be smaller than cdsEnd

**(7) cdsEnd** the end point of coding DNA sequence, must be larger than cdsStart

**(8) exonCount** exon number

**(9) exonStarts** the start point of each exon, must be smaller than the associated exonEnd

**(10) exonEnds** the end point of each exon, must be larger than the associated exonStart

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse