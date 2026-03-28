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

Danpos recognizes raw reads data in the following format:

**(1) .bed** The first 6 columns of .bed format file are required, click to see[help information](http://www.google.com/url?q=http%3A%2F%2Fgenome.ucsc.edu%2FFAQ%2FFAQformat.html%23format1&sa=D&sntz=1&usg=AOvVaw1L8RXPsJoqBhwmG_5d8kfB).

NOTE: If the data is paired-end reads, please make sure the names for each pair of reads are end with 1 and 2, but with the remaining part of names to be the same e.g., readA1 and readA2. It is also required that each pair of reads are located in two neighbor lines in the file.

**(2) .bam or .sam** click to see[help information](http://www.google.com/url?q=http%3A%2F%2Fsamtools.github.io%2Fhts-specs%2FSAMv1.pdf&sa=D&sntz=1&usg=AOvVaw3lNiPGjX8AqtXEUO0G5tZV). Make sure the file has the header information, keep option -h when use samtools to generate input files.

**(3) .bowtie** This is the default output format of the mapping tool[bow tie](http://www.google.com/url?q=http%3A%2F%2Fbowtie-bio.sourceforge.net%2Findex.shtml&sa=D&sntz=1&usg=AOvVaw3ysPdRKcs3WilqskIucR_v).

Note: If the data is paired-end reads, please make sure the names for each pair of reads are end with 1 and 2, e.g., readA1 and read A2. It is also required that each pair of reads are located in two neighbor lines in the file.

Danpos also recognizes protein occupancy data in the following format:

**(1) .wig** Click for[help information](http://www.google.com/url?q=http%3A%2F%2Fgenome.ucsc.edu%2FFAQ%2FFAQformat.html%23format6&sa=D&sntz=1&usg=AOvVaw3-lRIg_tCDYLgjxgQHEtGj) about .wig format.

NOTE: when input data is in .wig format, DANPOS will not do reads shifting, fragment extending, and occupancy calculation, because it suppose the data is already protein occupancy calculated from raw reads, but DANPOS may do normalization and smoothing before defining protein binding positions.

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse