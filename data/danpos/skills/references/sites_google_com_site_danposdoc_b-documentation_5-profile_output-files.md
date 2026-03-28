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

# Output files

\*\*\*.pdf

* This file contains all the figures plotted by the Profile function.

\*\*\*.R file

* This file contains all the R commands for plotting figures in the .pdf file.

\*\*\*\_genomicSiteCategory.xls

* This file contains the data that is used to plot each figure in the .pdf file. There should be one such file for each category of genomic sites, e.g., \*\*\*\_TSS.xls for transcription start site (TSS), or \*\*\*\_gene.xls for gene body.
* Each file would start with the column "pos", which each row in this column indicate the position (distance) relative to a category of genomic site, e.g., .
* There will be one or more additional columns each representing the average occupancy of one wiggle data around one group of genomic sites. The specific wiggle data , genomic site groups, and genomic site category will be indicated by the column name. E.g., for a column with name "wild\_type.wig.up\_regulated.xls.tss", the wiggle file wild\_type.wig, gene file up\_regulated.xls, and genomic site category TSS (transcription start site) are used to calculated the data in this column.

\*\*\*\_genomicSiteCategory\_heatmap/

* + This is a directory containing data for plotting heat map, e.g., by subjecting the data to the tool MEV. There should be one such directory for each category of genomic sites. Actually, each directory contains the data that is used to calculate the data in the file \*\*\*\_genomicSiteCategory.xls. e.g., \*\*\*\_TSS\_heatmap/ contains the data that is used to calculate the data in the file \*\*\*\_TSS.xls.
  + Each such directory would contain 1 or more .xls files. Each such file contain the data used to calculate data in a column of the file \*\*\*\_genomicSiteCategory.xls. E.g., in the directory \*\*\*\_TSS\_heatmap/, there may be a file up\_regulated.xls.tss.wild\_type.wig.heatmap.xls that contains the data used to calculate the column "wild\_type.wig.up\_regulated.xls.tss" in the file \*\*\*\_TSS.xls
  + Each file in the directory, e.g., the file up\_regulated.xls.tss.wild\_type.wig.heatmap.xls, starts with the following columns:
  + **(1) name** the name of a genomic site, e.g., the gene name of a TSS (transcription start site)
  + **(2) max** the maximal occupancy in a given region, e.g., trom 1.5kb upstream to 1.5kb down stream of a TSS
  + **(3) min** the minimal occupancy in a given region, e.g., trom 1.5kb upstream to 1.5kb down stream of a TSS
  + **(4) sum** the sum of occupancy values in a given region, e.g., trom 1.5kb upstream to 1.5kb down stream of a TSS
  + **(5) There would be multiple additional columns** each with a name represents a data point in a given region, e.g., "-100" and "100" may represent the 100th data point upstream and downstream of TSS. When calculating for gene body, "-100", "100" and "+100" may represent the 100th data point upstream of TSS, downstream of TSS, and downstream of TTS (Transcription terminal site). NOTE: each data point represent a bin, e.g., when --bin\_size is set to be 10, then each data point represent 10bp.

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse