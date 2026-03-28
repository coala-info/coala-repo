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

# (5) Profile

[**Profile**](/site/danposdoc/b-documentation/5-profile/output-files)is a function in **DANPOS** for analyzing the distribution of a chromatin feature flanking each given group of genomic sites or regions, such as transcription start sites, gene bodies, or enhancers. The distribution can be presented in either heat map or average density plot. See examples below:

![](https://lh3.googleusercontent.com/sitesv/APaQ0STTnbNZBbnmTkidCIaAPgL4KxJ5gJ5unhxXRS6FupQpIGxMK98K0D32PxkRqt1CLF0OMTqmMzgVfyVKZKj88jEh9rzS45w3JQIZxg5qU4YXq69sCL2YUbnHdNGq2AYkLgfcCJa0JSMwfSpPnURc8V0WNq9pnZSpNiWuZoytJwFYYfURyC8Pq55gKxnmyliWUVMSipscRLwdQx18awUOVgBX1B153i2hUGEM=w1280)

Example 1. Analyze histone modification H3K4me3 in two samples on two gene groups:

**Test data** (right click to download and put files in directories as indicated below):

(1) [sampleA.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FsampleA.wig&sa=D&sntz=1&usg=AOvVaw0r8NEa67jd5bV8NgCSFwIV)

(2) [sampleB.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FsampleB.wig&sa=D&sntz=1&usg=AOvVaw3arWsCfHq6Hk2HVd6BRU8I)

(3) [geneGroup1.xls](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FgeneGroup1.xls&sa=D&sntz=1&usg=AOvVaw1GEOLQRPUymKZknic5Q5e2)

(4) [geneGroup2.xls](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FgeneGroup2.xls&sa=D&sntz=1&usg=AOvVaw1SR3UOT4dcbbGC8gxwN67-)

**Command**:

python danpos.py profile sampleA.wig**,**sampleB.wig --genefile\_paths geneGoup1.xls**,**geneGroup2.xls

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse