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

# Parameters

usage:

python danpos.py <command> <wiggle\_file\_paths> [optional arguments]

positional arguments:

* **command** set as 'profile'
* **wigfile\_paths** Path to file that contains protein occupancy data. Each path points to a wiggle format file. Can be multiple paths separated by ',', e.g. f.wig,file\_b.wig,file\_c.wig. For more information, please go to the page for[input files](/site/danposdoc/b-documentation/5-profile/input-files).

optional arguments:

* **-h, --help** show this help message and exit

  + **--bed3file\_paths** Path to .bed format file that contain a set of genomic elements, such as the positions, peaks, or regions defined by DANPOS. Can be multiple paths separated by ',', e.g., peaks\_a.bed,peaks\_b.bed. Only the first three columns in bed format are required. For more information, please go to the page for [input files](/site/danposdoc/b-documentation/5-profile/input-files). (default: None)
  + **--genefile\_paths** Path to file that contain a set of genes. Can be multiple paths separated by ',', with each path point to one set of genes. For more information, please go to the page for [input files](/site/danposdoc/b-documentation/5-profile/input-files). (default: None)
* **--genomic\_sites** the category of genomic site to be analyzed. Can be one or multiple categories chosen from:
* **TSS** transcription start site
* **TTS** transcription terminal site
* **CSS** coding start site
* **CTS** coding terminal site
* **ESS** exon start site
* **ETS** exon terminal site
* **center** center of each element provided in bed file
* **region** the whole region of each element provided in bed file
* **gene** gene body
* Names must be separated by ',', (default:TSS,TTS,CSS,CTS,ESS,ETS,gene,center,region)
* **--heatmap** Set to 1 to calculate heatmap values, else set to 0 to cancel this analysis. (default: 0)
* **--periodicity** Set to 1 to do power spectrum density (PSD) analysis, else set to 0 to cancel this analysis. This function checks the strength of periodicity in protein occupancy along DNA. (default: 0)
* **--wigfile\_aliases**  name for each .wig file. Can be multiple names separated by ',' but must be arranged in the same order as the .wig files. (default: None)
* **--bed3file\_aliases**  name for each .bed file. Can be multiple names separated by ',' but must be arranged in the same order as the .bed files. (default: None)
* **--genefile\_aliases** name for each gene file. Can be multiple names separated by ',' but must be arranged in the same order as the gene files. (default: None)
* **--name** A name for the this run. (default: profile)
* **--vcal**  The method to calculate average plot value at each position relative to a given genomic site category (e.g. TSS or peak) in group of genes or genomic elements, could be 'median' or 'mean' (default: mean)

  + **--excludeP** Exclude the extremely low or high (outgroup) values by this percentage. useful to avoid the effects of repeat DNA or clonal reads. (default: 0)
* **--pos\_neg** The category of values in .wig file to be used in analysis, can be:
* **0** positive and negative values together
* **1** positive values only
* **-1** negative values only

  + **2** positive and negative values separately
  + **3** all kinds of analysis (together, positive, negative),
  + can be useful when we are analyze the differential signal between two samples. (default: 0)
* **--bin\_size** Bin size to be used for plotting, we suggest to set as the step or span size in the .wig files. (default: 10)
* **--flank\_up** How far to calculate from the up-stream of each category of genomic site (e.g., TSS). (default: 1500)
* **--flank\_dn** How far to calculate to the down-stream of each category of genomic site (e.g., TSS). (default: 1500)
* **--region\_size** when 'gene' or 'region' is included in the parameter **--genomic\_sites,** normalize the length of each gene body or region (not include the flanking regions) to this size (default: 1500)
* **--plot\_row** Number of rows to plot on each page. (default: 2)
* **--plot\_column** Number of columns to polt on each page. (default: 2)
* **--plot\_xmin** Minimal value on the x axis of each plot. (default:None)
* **--plot\_xmax**  Maximal value on the x axis of each plot. (default:None)
* **--plot\_ymin** Minimal value on the y axis of each plot. (default:None)
* **--plot\_ymax** Maximal value on the y axis of each plot. (default:None)
* **--plot\_xlab** The label on the x axis. (default: Relative distance)
* **--plot\_ylab**  The label on the y axis. (default: Average signal value)
* **--plot\_colors** The colors to be used in the plot. (default: black,gray,red,blue,orange,purple,skyblue,cyan,green,blue4,darkgoldenrod)

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse