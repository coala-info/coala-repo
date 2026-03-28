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

# (7) wiq

[**WIQ**](/site/danposdoc/b-documentation/7-wiq/output-files)is a function in **DANPOS**to do genome wide quantile normalization for wiggle format protein occupancy data.

![](https://lh3.googleusercontent.com/sitesv/APaQ0STHDBkhEiuLcEPhtISVMpGfsKx7LmdjTpPKKX-5gGTX7UThlpCqYKBq2rW5m8myKy46DRmLec3H1VDOz5-x6VXuSYGqdBx_HWlPF7DFPmf8m0DFTz3kEQFfhYM_RmtcaVBHutv0Wm8eQq7isVVsdXkSWAUQqnfHjW1LNcrPgrzK5exSUkmNbePSuvakuymcVMGxABW1p_4c6VdEZ2PJCm1zl8N2PlHLI1piL0w=w1280)

Example 1. normalize two wiggle format data sets to have the same quantile:

**Test data** (right click to download and put files in directories as indicated below):

(1) [mm9.chr.sizes.xls](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fmm9.chr.sizes.xls&sa=D&sntz=1&usg=AOvVaw2JvWKATviCVO19faCBvHUO)

(2) [rawA.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FrawA.wig&sa=D&sntz=1&usg=AOvVaw2zLdgzHVZ-Npu9oQRs0BcQ)

(3) [rawB.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FrawB.wig&sa=D&sntz=1&usg=AOvVaw2CPFt-8FkMKKs5p0Z83q8v)

**Command**:

python danpos.py wiq --buffer\_size 50 mm9.chr.sizes.xls rawA.wig:rawB.wig

Example 2. normalize wiggle format data rawA.wig to have the same quantile as in rawB.wig:

**Test data** (right click to download and put files in directories as indicated below):

(1) [mm9.chr.sizes.xls](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fmm9.chr.sizes.xls&sa=D&sntz=1&usg=AOvVaw2JvWKATviCVO19faCBvHUO)

(2) [rawA.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FrawA.wig&sa=D&sntz=1&usg=AOvVaw2zLdgzHVZ-Npu9oQRs0BcQ)

(3) [rawB.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FrawB.wig&sa=D&sntz=1&usg=AOvVaw2CPFt-8FkMKKs5p0Z83q8v)

**Command**:

python danpos.py wiq --buffer\_size 50 mm9.chr.sizes.xls rawA.wig --reference rawB.wig

Example 3. normalize 10 wiggle format data sets raw1.wig, raw2.wig, … , raw10.wig to have the same quantile as in rawA.wig:

**Test data** (right click to download and put files in directories as indicated below):

(1) [mm9.chr.sizes.xls](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fmm9.chr.sizes.xls&sa=D&sntz=1&usg=AOvVaw2JvWKATviCVO19faCBvHUO)

(2) [rawA.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2FrawA.wig&sa=D&sntz=1&usg=AOvVaw2zLdgzHVZ-Npu9oQRs0BcQ)

(3) [raw1.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fraw1.wig&sa=D&sntz=1&usg=AOvVaw16vEYxXdIYN9lh52Zox5F2)

(4) [raw2.wig](http://www.google.com/url?q=http%3A%2F%2Fdldcc-web.brc.bcm.edu%2Flilab%2Fkaifuc%2Fdanpos%2Ftest%2Fraw2.wig&sa=D&sntz=1&usg=AOvVaw2DmPDcy7pzyHHXK22F-LvO)

(…) ...

**Command**:

step1: python danpos.py wig2wiq --buffer\_size 50 mm9.chr.sizes.xls rawA.wig

(now we will have a result file rawA.sorted.wiq)

step2:  python danpos.py wiq --buffer\_size 50 mm9.chr.sizes.xls raw1.wig --reference rawA.sorted.wiq --rformat wiq --rsorted 1

(using a sorted .wiq format data as reference will be 2 fold faster than using a .wig format reference data)

Google Sites

Report abuse

Page details

Page updated

Google Sites

Report abuse