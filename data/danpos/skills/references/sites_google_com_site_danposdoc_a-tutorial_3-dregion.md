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

# (3) Dregion

**Dregion****, the third peak-calling algorithm in DANPOS, analyzes change in width, summit height, and total signal in each enriched region between samples.**

![](https://lh3.googleusercontent.com/sitesv/APaQ0SSNTna4zK3BPXrKsStaj4Y-uV-Gbaq9BKZ719yJos_Y5lQvkghTPRvcjZghfzTjKkMrSwIgTlrJHkA5cat9a-OliRrx_YexcByHxqFdac55leFu5xl23PMqEsJkRASvQTRJTYv6apdCYy1M2sT9opW9nvx3OmVGSOIDvZ3bPCydnhm5g6B38QOTdydFgns7978cGuN2dV5w_bfMuZNf334kTkuztz5MTg=w1280)

Example 1. Define enriched region for histone modification H3K4me3 in a single sample, with input effect subtracted:

**Test data** (right click to download and put files in directories as indicated below):

(1) H3K4me3\_sampleA/

[H3K4me3\_sampleA\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleA%2FH3K4me3_sampleA_rep1.bed&sa=D&sntz=1&usg=AOvVaw2JK81jZ211rzm1QIh1_Y63)

[H3K4me3\_sampleA\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleA%2FH3K4me3_sampleA_rep2.bed&sa=D&sntz=1&usg=AOvVaw3n1xjAvS0G1W9BIzoqcBA4)

(2) input\_sampleA/

[input\_sampleA\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleA%2Finput_sampleA_rep1.bed&sa=D&sntz=1&usg=AOvVaw2Ft0QfYdI3Lkg-tse90wA8)

[input\_sampleA\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleA%2Finput_sampleA_rep2.bed&sa=D&sntz=1&usg=AOvVaw3mKGP7RLHXtSNEipqeepdY)

**Command**:

python danpos.py dregion H3K4me3\_sampleA -b input\_sampleA

Example 2. Compare H3K4me3 ChIP-Seq data between two samples A and B, each sample has its own input effect to be subtracted.

**Test data** (right click to download and put files in directories as indicated below):

(1) H3K4me3\_sampleA/

[H3K4me3\_sampleA\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleA%2FH3K4me3_sampleA_rep1.bed&sa=D&sntz=1&usg=AOvVaw2JK81jZ211rzm1QIh1_Y63)

[H3K4me3\_sampleA\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleA%2FH3K4me3_sampleA_rep2.bed&sa=D&sntz=1&usg=AOvVaw3n1xjAvS0G1W9BIzoqcBA4)

(2) input\_sampleA/

[input\_sampleA\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleA%2Finput_sampleA_rep1.bed&sa=D&sntz=1&usg=AOvVaw2Ft0QfYdI3Lkg-tse90wA8)

[input\_sampleA\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleA%2Finput_sampleA_rep2.bed&sa=D&sntz=1&usg=AOvVaw3mKGP7RLHXtSNEipqeepdY)

(3) [H3K4me3\_sampleB.bed.gz](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleB.bed.gz&sa=D&sntz=1&usg=AOvVaw0Gt7xN4bZEReQTs6B59IP9)

(4) input\_sampleB/

[input\_sampleB\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleB%2Finput_sampleB_rep1.bed&sa=D&sntz=1&usg=AOvVaw1h7am5OJoRB-TQV1XlaTWF)

[input\_sampleB\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleB%2Finput_sampleB_rep2.bed&sa=D&sntz=1&usg=AOvVaw03vIwUGWaSeIzHdHZrDdd1)

**Command**:

python danpos.py dregion H3K4me3\_sampleA**:**H3K4me3\_sampleB.bed.gz -b H3K4me3\_sampleA**:**input\_sampleA**,**H3K4me3\_sampleB.bed.gz**:**input\_sampleB

Example 3. Compare H3K4me3 ChIP-Seq data between two samples A and B, with spike-in controls to specify libarary size for each sample, each sample has its own input effect to be subtracted.

**Test data** (right click to download and put files in directories as indicated below):

(1) H3K4me3\_sampleA/

[H3K4me3\_sampleA\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleA%2FH3K4me3_sampleA_rep1.bed&sa=D&sntz=1&usg=AOvVaw2JK81jZ211rzm1QIh1_Y63)

[H3K4me3\_sampleA\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleA%2FH3K4me3_sampleA_rep2.bed&sa=D&sntz=1&usg=AOvVaw3n1xjAvS0G1W9BIzoqcBA4)

(2) input\_sampleA/

[input\_sampleA\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleA%2Finput_sampleA_rep1.bed&sa=D&sntz=1&usg=AOvVaw2Ft0QfYdI3Lkg-tse90wA8)

[input\_sampleA\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleA%2Finput_sampleA_rep2.bed&sa=D&sntz=1&usg=AOvVaw3mKGP7RLHXtSNEipqeepdY)

(3) [H3K4me3\_sampleB.bed.gz](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FH3K4me3_sampleB.bed.gz&sa=D&sntz=1&usg=AOvVaw0Gt7xN4bZEReQTs6B59IP9)

(4) input\_sampleB/

[input\_sampleB\_rep1.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleB%2Finput_sampleB_rep1.bed&sa=D&sntz=1&usg=AOvVaw1h7am5OJoRB-TQV1XlaTWF)

[input\_sampleB\_rep2.bed](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Finput_sampleB%2Finput_sampleB_rep2.bed&sa=D&sntz=1&usg=AOvVaw03vIwUGWaSeIzHdHZrDdd1)

**Spike-ins information**:

Suppose that we have spike-ins to indicate that there would be 10 and 20 million reads for sample A and B, respectively.

**Command**:

python danpos.py dregion H3K4me3\_sampleA**:**H3K4me3\_sampleB.bed.gz -b H3K4me3\_sampleA**:**input\_sampleA**,**H3K4me3\_sampleB.bed.gz**:**input\_sampleB -c H3K4me3\_sampleA**:**10000000**,**input\_sampleA**:**10000000**,**H3K4me3\_sampleB.bed.gz**:**20000000**,** input\_sampleB**:**20000000

Example 4. Quantile Normalization: Different from DANPOS1, currently, the -n Q parameter for quantile normalization is disabled. If you try to use quantile normalization, first, use dpos function to generate wiq file with -n N parameter, which disable all normalization method and--smooth\_width 0 which prevent smooth. Then, you could use "python danpos.py wiq --buffer\_size 50 chromosome\_size\_file yourfileA.wig:yourfileB.wiq" to normalize your file with quantile normalization and call danpos peak caller functions (dpos, dpeak, dregion, dtriple) again. Make sure you always disable -n N and only smooth your data once.

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse