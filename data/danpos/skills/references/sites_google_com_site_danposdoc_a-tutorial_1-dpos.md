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

# (1) Dpos

**Dpos****, the first peak-calling algorithm developed in DANPOS, analyzes changes in the location, fuzziness, and occupancy at each nucleosome or protein binding position.**

![](https://lh3.googleusercontent.com/sitesv/APaQ0SQrIbWV2AVNvzDoOxRQ0L94tVscL6k0j6qw6RFw5GhztnhNV67Mb77pICQuavOHMOThrlIFR6jnLVvkpQxl6JaAOts5prHjmNHC8APmNQKJp2bzOHaw1C4Mj6A2R5CGvExohoM8rKnbp9qsUPltULHu4eeTR6V-EnHkT6J079rNi27VolXF66AMyPKaQWgBY9Tq8rNQnHpLNZF8CzjCYW4BrDsEz8uRmoykDbQ=w1280)

Example 1. Define each nucleosome in MNase-Seq data:

**Test data** (right click to download and put files in directories as indicated below):

(1) nucleosome\_sampleA/

[nucleosome\_sampleA\_rep1.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleA%2Fnucleosome_sampleA_rep1.bowtie&sa=D&sntz=1&usg=AOvVaw2KdjKSan8eOaBl1egnEk4y)

[nucleosome\_sampleA\_rep2.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleA%2Fnucleosome_sampleA_rep2.bowtie&sa=D&sntz=1&usg=AOvVaw1sZ_CyQad5_YIMD0N1mXvD)

**Command**:

python danpos.py dpos nucleosome\_sampleA

Example 2. Compare MNase-Seq data at each nucleosome between two samples A and B.

**Test data** (right click to download and put files in directories as indicated below):

(1) nucleosome\_sampleA/

[nucleosome\_sampleA\_rep1.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleA%2Fnucleosome_sampleA_rep1.bowtie&sa=D&sntz=1&usg=AOvVaw2KdjKSan8eOaBl1egnEk4y)

[nucleosome\_sampleA\_rep2.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleA%2Fnucleosome_sampleA_rep2.bowtie&sa=D&sntz=1&usg=AOvVaw1sZ_CyQad5_YIMD0N1mXvD)

(2) [nucleosome\_sampleB.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleB.bowtie&sa=D&sntz=1&usg=AOvVaw2R-DB5onGXWmNSc1etI9C5)

**Command**:

python danpos.py dpos nucleosome\_sampleA**:**nucleosome\_sampleB.bed.gz

Example 3. Compare MNase-Seq data at each nucleosome between two samples A and B, with spike-in controls to specify libarary size for each sample.

**Test data** (right click to download and put files in directories as indicated below):

(1) nucleosome\_sampleA/

[nucleosome\_sampleA\_rep1.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleA%2Fnucleosome_sampleA_rep1.bowtie&sa=D&sntz=1&usg=AOvVaw2KdjKSan8eOaBl1egnEk4y)

[nucleosome\_sampleA\_rep2.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleA%2Fnucleosome_sampleA_rep2.bowtie&sa=D&sntz=1&usg=AOvVaw1sZ_CyQad5_YIMD0N1mXvD)

(2) [nucleosome\_sampleB.bowtie](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fnucleosome_sampleB.bowtie&sa=D&sntz=1&usg=AOvVaw2R-DB5onGXWmNSc1etI9C5)

**Spike-ins information**:

Suppose that we have spike-ins to indicate that there would be 10 and 20 million reads for sample A and B, respectively.

**Command**:

python danpos.py dpos nucleosome\_sampleA**:**nucleosome\_sampleB.bowtie -c nucleosome\_sampleA**:**10000000**,**nucleosome\_sampleB.bowtie**:** 20000000

Example 4. Quantile Normalization: Different from DANPOS1, currently, the -n Q parameter for quantile normalization is disabled. If you try to use quantile normalization, first, use dpos function to generate wiq file with -n N parameter, which disable all normalization method and--smooth\_width 0 which prevent smooth. Then, you could use "python danpos.py wiq --buffer\_size 50 chromosome\_size\_file yourfileA.wig:yourfileB.wiq" to normalize your file with quantile normalization and call danpos peak caller functions (dpos, dpeak, dregion, dtriple) again. Make sure you always disable -n N and only smooth your data once.

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse