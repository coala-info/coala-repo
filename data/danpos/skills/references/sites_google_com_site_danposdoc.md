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

# Home

**DANPOS2**

A toolkit for Dynamic Analysis of Nucleosome and Protein Occupancy by Sequencing, version 2

[**Tutorial**](/site/danposdoc/a-tutorial) **-** [**Documentation**](/site/danposdoc/b-documentation) **-** [**Install**](/site/danposdoc/c-install) **-** [**Download**](/site/danposdoc/d-download) **-** [**Help**](/site/danposdoc/e-help)

Developed by [Kaifu Chen](http://www.google.com/url?q=http%3A%2F%2Fkaifu.openwetware.org%2F&sa=D&sntz=1&usg=AOvVaw13-aqlNJa4xAd5QUUe5FYj) in the [Li lab](http://www.google.com/url?q=http%3A%2F%2Flilab.openwetware.org%2F&sa=D&sntz=1&usg=AOvVaw2kO25KJ_LMdl8Wyzx7rKss) at [Baylor College of Medicine](https://www.google.com/url?q=https%3A%2F%2Fwww.bcm.edu&sa=D&sntz=1&usg=AOvVaw0wKtbjQg-H6ukriIHNG4oJ).

**Citations:**

1. Kaifu Chen, etc. Broad H3K4me3 is associated with increased transcription elongation and enhancer activity at tumor suppressor genes. ***Nature Genetics***. 2015.
2. (DANPOS2 was used in this project to normalize ChIP-seq reads density by the Quantile method, define enriched regions, assign region to gene, and plot figures)
3. Kaifu Chen, etc. DANPOS: Dynamic Analysis of Nucleosome Position and Occupancy by Sequencing. ***Genome Research***. 2012. doi:10.1101/gr.142067.112
4. (This version has later became the Dpos function in DANPOS2)

### Tools in kit

* **Tools (1)-(4): DANPOS provides different tools to analyze chromatin feature in different manner:**

![](https://lh3.googleusercontent.com/sitesv/APaQ0STtc8r9Y_B5ekcRuCHFP4OtklQNcmMVCSsdTP-2MhS3xIDbaGvFq3w8vZ9k0ihuB595UTPXv6KcOhi9uOnrM88kvgtlfdXdyH_5Ms-RddoM9qicafUnEiX3618E_uEsb8tHK2mmD9Fx0cbfE8McayuScghGWO8ssdMW3ARgk0Efb55v2vA54x7YBIMHKcAjVn_XuSC3NSLC9tpejhzBjL2JBgQ32OQTjubOJWQ=w1280)

* + **(1)** [**Dpos**](/site/danposdoc/b-documentation/1-dpos) analyzes changes in the location, fuzziness, and occupancy at each nucleosome or protein binding position. The functions is designed to analyze nucleosomes, but can be also very useful for analyzing other proteins whose binding pattern is similar to that of nucleosome, such as the protein MeCP2.
  + **(2)** [**Dpeak**](/site/danposdoc/b-documentation/2-dpeak) analyzes change in width, height and total signal of each enriched peak. A peak may contains multiple positions. This function is designed to analyze transcription factor and is also useful for defining some histone modification peaks.
  + **(3)** [**Dregion**](/site/danposdoc/b-documentation/3-dregion) analyzes change in width, summit height, and total signal in each enriched region between samples. A region may contains multiple peaks, this function is designed to analyze chromatin features such as the histone modification H3K4me3.
  + **(4)** [**Dtriple**](/site/danposdoc/b-documentation/4-dtriple) is a combination of the Dpos, Dpeak, and Dregion functions. When there is no knowledge about characteristics of the sequencing target, this function provide users a way to try all the three algorithms above.

* **Tool (5):** [**Profile**](/site/danposdoc/b-documentation/5-profile/output-files) **is a tool in DANPOS for analyzing the distribution of a chromatin feature flanking each given group of genomic sites or regions.**

such as transcription start sites, gene bodies, or enhancers. The distribution can be presented in either heat map or average density plot. See examples below:

![](https://lh3.googleusercontent.com/sitesv/APaQ0SSZ39qswJLrmSRyR5_-10jMZhVTcoA6U8dSA9hJMo--9TXgIBwEnrwkWqMDKFlq7nIi_xEaXMV9tebp2lvxGKbdPbKmK-AOdhmKq_RkvG1G2xG6hbj9lzc3yG8t-QK3sW2-s7a7QYCmJqlMj5-61qX3KhX-4RDCD7WbhzNCyyFYG6ZDeufi4vKuPCwxgQVtfEw9sZgmVrHz25kv82RYMKkK3nj1EldqoNwUvKI=w1280)

* **Tool (6):** [**Stat**](/site/danposdoc/b-documentation/6-stat) **is a tool in DANPOS to do statistical analysis for positions, peaks, or regions.**

For example, the figures below compare changes in fuzziness (left) and width (right) of nucleosome positions across the whole genome.

![](https://lh3.googleusercontent.com/sitesv/APaQ0SQbSsnozT1IAnQLU_KiEfL7ppvyi-egWDYpPb13HRtQMjrJaL3YP-RgzOY_OumpDZ3iOZhTYqVARReBbToaEJVTxVT7VRPfCBY8jQGrz-IV6lsvIlPvoT6dymsxdWNLxYlrISA37CHZlwqK97IZgPyTf9IONASjoL63o6qqrSsRHczETBPvnIVTV4D-XevlCSzdwsb-wOA9Ty7eibK6vY9UKGURBpZU1MXOfNI=w1280)

* **Tool (7):** [**WIQ**](/site/danposdoc/b-documentation/7-wiq/output-files) **is a tool in DANPOS to do genome wide quantile normalization for data in wiggle format file.**

For example, in the figure below:

Before normalization, the signal-to-noise ratio is lower in replicate 3 relative to replicate 1 and 2.

**After normalization**, the signal-to-noise ratio become the same in all 3 replicates.

![](https://lh3.googleusercontent.com/sitesv/APaQ0SS_ih6jMMBXV-n84m-RiGXCi2c4sMrmddRSpvlakJiNNRnO30esco3brv3aYLLxhMkP8CjkWGKZ8hWsv7rx84oqsQ-VGowVyEp2iC_uUyHBrmLUVFhy674eZLBhfnxAAAiFsEzkwOJvIgXVsatF9DRZEgah-LzoB7M4g76Vl9dIjBsIlPYdkp4aicBD38zc4p_KZHyJKU8qyr8ZjJmQisrNKrGt6R2ScgPr=w1280)

* **Tool (8):** [**Wig2Wiq**](/site/danposdoc/b-documentation/8-wig2wiq) **is a tool for converting .wig format file to .wiq format.**

**News****:**

**September 2014, Version 2.2.2:**

**June 2014, Version 2.2.1:**

* The function fetchValueFromWig() in summits was revised to accomodate sampes that have no peak in some chromosomes.
* The function to read .Wig file are improved to allow empty line in the file.
* The Wiq function is improved.

  + help message for Wiq and Wig2Wiq[?](https://code.google.com/p/danpos/w/edit/Wig2Wiq) was updated.
  + the mean(), sum(), and size() functions in wig.py was updated.

**April 2013, Version 2.2.0:**

* + The Big changes designed for DANPOS2 has finally come out with this version. DANPOS becomes a comprehensive set of tools for analyzing not only nucleosome, but also other chromatin component such as histone modification.

**Apr 2011**

**Aug 2012, the new release 2.0.0 now:**

**Sep 2012,**

**Oct 2012,**

**Nov 2012,**

**Dec 2012, the new release 2.1.0 now:**

**Dec 2012,**

**Jan 2013,**

**Version 2.1.4:**

**Version 2.1.3:**

**Feb 2013, the 2.1.2 version now:**

**Feb 2013, the 2.1.1 version now:**

**Mar 2011**

**Jun 2011**

**Oct 2011**

**Dec 2011**

**Mar 2011**

* + minor change, some bug corrections.
  + minor change, some bug corrections.
  + put back the occupancy P value, fuzziness score, and fuzziness P value in the file pooled/#.peaks.xls
  + comes with a dantools 0.2.0 version at <http://code.google.com/p/dantools/>, which could be used to do additional analysis, e.g. select peaks based on differential values or distance to promoters, or do plot around transcription start sites. Thanks to **Gabriel Gutiérrez** and **Jared Taylor** for their suggestions on this.
  + Rename the final out put file to #.allPeaks.xls and contains all nucleosomes that are either differential or not, this allow users to retrieve nucleosomes showing most or least significant changes in occupancy, fuzziness, or positions.
  + provide a differential FDR value in addition to each of the previous P value, thanks to **Gabriel Gutiérrez** for his suggestions on this point.
  + DANPOS was highlighted in headlines by the Epigenie website on Jan 2nd, 2013, see [http://epigenie.com/danpos-reveals-dynamic-nucleosomes/](http://www.google.com/url?q=http%3A%2F%2Fepigenie.com%2Fdanpos-reveals-dynamic-nucleosomes%2F&sa=D&sntz=1&usg=AOvVaw1GWew4bvyqgNvWXZsSbUXV)
  + **DANPOS was used by Bilian and colleagues in their Cell Reports paper for the analysis of relationship between DNA Methyltransferases and nucleosome structure, see** [http://www.cell.com/cell-reports/fulltext/S2211-1247(12)00372-5?switch=standard](http://www.google.com/url?q=http%3A%2F%2Fwww.cell.com%2Fcell-reports%2Ffulltext%2FS2211-1247%2812%2900372-5%3Fswitch%3Dstandard&sa=D&sntz=1&usg=AOvVaw1shZ4YAKzPAPef7omUSXO7)
  + change the file seperater '-' to ':', due to the reason that some users tend to have file name containing '-'.
  + support the default output format of bowtie.
  + gives out the nucleosome fragment sizes distribution for paired-end reads too.

* **The DANPOS methodology paper has been published online at Genome Research, see**[**http://genome.cshlp.org/content/early/2012/11/27/gr.142067.112.abstract**](http://www.google.com/url?q=http%3A%2F%2Fgenome.cshlp.org%2Fcontent%2Fearly%2F2012%2F11%2F27%2Fgr.142067.112.abstract&sa=D&sntz=1&usg=AOvVaw1C05CTWNefsgjWJHu59M5z)

  + **A paper using DANPOS to analyze nucleosome re-organization by the transcription repressor Cyc8-Tup1 complex has been accepted to Genome Research, see** [http://genome.cshlp.org/content/early/2012/11/01/gr.141952.112.abstract](http://www.google.com/url?q=http%3A%2F%2Fgenome.cshlp.org%2Fcontent%2Fearly%2F2012%2F11%2F01%2Fgr.141952.112.abstract&sa=D&sntz=1&usg=AOvVaw2sJOiI_tzfptPnLavYDLQt).
  + A bug in setting the step size for paired-end reads input has been corrected in the new release danpos-2.0.1.
  + **DANPOS was used in a Cell paper by Zhaoyu and his colleagues to analyze nucleosome dynamics mediated by Foxa2, see**[http://www.cell.com/abstract/S0092-8674(12)01403-1?switch=standard](http://www.google.com/url?q=http%3A%2F%2Fwww.cell.com%2Fabstract%2FS0092-8674%2812%2901403-1%3Fswitch%3Dstandard&sa=D&sntz=1&usg=AOvVaw3yavp_N6mbOkG7Yt7j26Da).
  + support paired-end reads, fragment size correction based on pair information.
  + support input files in the very popular sam/bam format.
  + need not to specify an input format; for each input directory specified, automatively serch input files in all the supported formats (bam,sam,bed,wig).
  + come with comprehensive Comments/help information in the scripts.
  + report nucleosome gain/loss results in additional seperate files.
  + support multiple groups comparison rather than the previous pair-wise comparison.
  + support normalization of each group to a specified coverage, for the reason that some samples may have pre-known degree of global nucleosome loss relative to other samples (Gossett and Lieb, 2012).
  + DANPOS manuscript is under review now.
  + Ducumentation is now available in the new release danpos-1.0.0, along with some minor improvements in the package.
  + the release 0.9.0 provide options to remove clonal reads, calculates FDR value, and also further optimized some default parameters.
  + the new version 0.8.0 adds a positioning (fuzziness) score and P value for each nucleosome in each sample, and also gives out a P value to estimate difference in positioning degree between control and treatment samples.
  + Jun 2011, the new version 0.7.0 has been tested on Human genome.
  + new version 0.4 released

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse