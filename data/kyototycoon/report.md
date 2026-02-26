# kyototycoon CWL Generation Report

## kyototycoon_ktserver

### Tool Description
Kyoto Tycoon: a handy cache/storage server

### Metadata
- **Docker Image**: quay.io/biocontainers/kyototycoon:20170410--hbed32c3_5
- **Homepage**: https://github.com/alticelabs/kyoto
- **Package**: https://anaconda.org/channels/bioconda/packages/kyototycoon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kyototycoon/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alticelabs/kyoto
- **Stars**: N/A
### Original Help Text
```text
ktserver: Kyoto Tycoon: a handy cache/storage server

usage:
  ktserver [-host str] [-port num] [-tout num] [-th num] [-log file] [-li|-ls|-le|-lz] [-ulog dir] [-ulim num] [-uasi num] [-sid num] [-ord] [-oat|-oas|-onl|-otl|-onr] [-asi num] [-ash] [-bgs dir] [-bgsi num] [-bgsc str] [-dmn] [-pid file] [-cmd dir] [-scr file] [-mhost str] [-mport num] [-rts file] [-riv num] [-plsv file] [-plex str] [-pldb file] [db...]
```


## kyototycoon_ktremotemgr

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/kyototycoon:20170410--hbed32c3_5
- **Homepage**: https://github.com/alticelabs/kyoto
- **Package**: https://anaconda.org/channels/bioconda/packages/kyototycoon/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
ktremotemgr: the command line utility of the remote database of Kyoto Tycoon

usage:
  ktremotemgr report [-host str] [-port num] [-tout num]
  ktremotemgr script [-host str] [-port num] [-tout num] [-bin] [-swname str] [-swtime num] [-ssname str] [-ssbrd] proc [args...]
  ktremotemgr tunerepl [-host str] [-port num] [-tout num] [-mport num] [-ts num] [-iv num] [mhost]
  ktremotemgr inform [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-st]
  ktremotemgr clear [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str]
  ktremotemgr sync [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-hard] [-cmd str]
  ktremotemgr set [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-add|-rep|-app|-inci|-incd] [-sx] [-xt num] key value
  ktremotemgr remove [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-sx] key
  ktremotemgr get [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-rm] [-sx] [-px] [-pt] [-pz] key
  ktremotemgr list [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-des] [-max num] [-rm] [-sx] [-pv] [-px] [-pt] [key]
  ktremotemgr import [-host str] [-port num] [-tout num] [-db str] [-sx] [-xt num] [file]
  ktremotemgr vacuum [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-step num]
  ktremotemgr slave [-host str] [-port num] [-tout num] [-ts num] [-sid num] [-ux] [-uw] [-uf] [-ur]
  ktremotemgr setbulk [-host str] [-port num] [-tout num] [-bin] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-sx] [-xt num] key value ...
  ktremotemgr removebulk [-host str] [-port num] [-tout num] [-bin] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-sx] key ...
  ktremotemgr getbulk [-host str] [-port num] [-tout num] [-bin] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-sx] [-px] key ...
  ktremotemgr match [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-sx] [-px] [-limit num] prefix ...
  ktremotemgr regex [-host str] [-port num] [-tout num] [-swname str] [-swtime num] [-ssname str] [-ssbrd] [-db str] [-sx] [-px] [-limit num] regex ...
```

