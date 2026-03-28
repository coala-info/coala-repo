# groot CWL Generation Report

## groot_align

### Tool Description
Sketch sequences, align to references and weight variation graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
- **Homepage**: https://github.com/will-rowe/groot
- **Package**: https://anaconda.org/channels/bioconda/packages/groot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/groot/overview
- **Total Downloads**: 85.9K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/will-rowe/groot
- **Stars**: N/A
### Original Help Text
```text
Sketch sequences, align to references and weight variation graphs

Usage:
  groot align [flags]

Flags:
  -t, --contThresh float   containment threshold for the LSH ensemble (default 0.99)
      --fasta              if set, the input will be treated as fasta sequence(s) (experimental feature)
  -f, --fastq strings      FASTQ file(s) to align
  -g, --graphDir string    directory to save variation graphs to (default "./groot-graphs-20260225205238")
  -h, --help               help for align
  -c, --minKmerCov float   minimum number of k-mers covering each base of a graph segment (default 1)
      --noAlign            if set, no exact alignment will be performed - graphs will be weighted using approximate read mappings

Global Flags:
  -i, --indexDir string   directory for to write/read the GROOT index files
      --log string        filename for log file (default "groot.log")
  -p, --processors int    number of processors to use (default 1)
      --profiling         create the files needed to profile GROOT using the go tool pprof
```


## groot_get

### Tool Description
Download a pre-clustered ARG database

### Metadata
- **Docker Image**: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
- **Homepage**: https://github.com/will-rowe/groot
- **Package**: https://anaconda.org/channels/bioconda/packages/groot/overview
- **Validation**: PASS

### Original Help Text
```text
Download a pre-clustered ARG database

Usage:
  groot get [flags]

Flags:
  -d, --database string   database to download (please choose: arg-annot/resfinder/card/groot-db/groot-core-db) (default "arg-annot")
  -h, --help              help for get
      --identity string   the sequence identity used to cluster the database (only 90 available atm) (default "90")
  -o, --out string        directory to save the database to (default ".")

Global Flags:
  -i, --indexDir string   directory for to write/read the GROOT index files
      --log string        filename for log file (default "groot.log")
  -p, --processors int    number of processors to use (default 1)
      --profiling         create the files needed to profile GROOT using the go tool pprof
```


## groot_iamgroot

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
- **Homepage**: https://github.com/will-rowe/groot
- **Package**: https://anaconda.org/channels/bioconda/packages/groot/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
|                                                               (@@@@@@@@@@@@@@@
|                                                          @@@@@@@@@@/@&/////@@@
|                                                       @@@@@@/////@%/@%/////@@@
|                                                      @@@(////////@//@@//////@@(
|                                                      @@@////////*@//@@******@@@       @@@@@@@@@@@@@@
|                                                     (@@/////*****@*/@@***,,,@@@   &@@@@@@@(//@@@/@@@@@@@.
|                                                     @@@//********@*/@@**,,,,,@@@(@@@@////////@@@//////@@@@@
|                                                     @@@****,,,,*/@/*@@**,,,,*@@@@@@**//**////@@////////@@@@&   @@@  @@@@@@
|                                                    ,@@***,,,,,**/@/*@@***,,,,&@@@@,*,*******%@@******@@@/@@@ @@@@@@@@@**@@@
|                                               @@@  @@@******,,***//*%@*****,,,@@@,,,,,,,,,,*@@%*****@@///#@@@@@//@@***@@@@
|                                             @@@@@@ @@@/**,,,,,,*****(@*****,*,@@,,,,,******/@@(**/@@//////@@@@@****&@@@@
|                                            @@@@/@@@@@@/*,,,,,,,,****(@**,,,,*****,*********/@@/*(&****////(@@@***@@@@.
|                                           @@@@@///@@@@/,,,,,,,,,,,,*/@/,,,,,,,,,,,,,,******#@&*************@@*,@@@@
|                                          @@@/@@////@@@*,,,,,,,,,,,,*/@@*,,,,,,,,,,,,,,***,*@@(**********,**/@@@@@@@
|                                         @@@*/(@/***/@@*,,,,,,,,,,,,*/@@/*,,,,,,,,,,,,,,***/@@******,,,,,,,,*@@@@@@@@
|                                        @@@,,/(@****/@@*,,,,,,,,,,,,*/@@@/***,,,,,,,,,,,***/@(****,,,,,,,,,,,,@@//#@@@*
|                                        @@@,**/@****/(@*,,,,,,,,,,,,**#@@@***,,,,,,,,,,,,**(@/**,,,,,,,,,,,,,*****@/@@@
|                                        @@@*,*/&*****/@**,,,,,,,,,,,**/@/(@/**,,,,,,,,,,,**((/*,,,,,,,,,,,,,,***/@@//@@@
|                                        @@@,*********/@/*,,,,,,,,,,,**/@(/(@**,,,,,,,,,,,*/((*,,,,,,,,,,,,,,,**/@(**@@@@,
|                                        @@@**********//(**,,,,,,,,,,******/@#,,,,,,,,,,,,*/(/,,,,,,,,,,,,,,,,*/@(/*@@*@@@
|                                        @@@***********//**,,,,,,,,,,,******//*,,,,,,,,,,**//*,,,,,,,,,,,,,,,**/(/*@@/*@@@
|                                        @@@,***,,,,*******,,,,,,,,,,,*********,,,,,,,,,,****,,,,,,,,,,,,,,,**//***@**@@@
|                                        @@@,**,,,,,,,,,*,*,,,,,,,,,,********,,,,,,,,,,,****,,,,,,,,,,,,,,,,******@/*(@@@
|                                        (@@,*,,,,,,,,,,,,,,,*,,,,************,,,,,,,,,*****,,,,,,,,,,,,,,,******/@**@@@
|                                         @@@,,,,,,,,,,,,,,,,********************,,,********,,,,,,,,,,,,,,*******@/*@@@@
|                                         @@@,,,,,,,,,,,,,,**,***********,******************,,,,,,,,,,,,********//**@@@
|                                         @@@/,,,,,,,,,,,,,,,*,,********,,********************,,,,,,,,*************@@@.
|                                          @@@**,,,,,,,*@@@@@@@@@@,******,,********************@@@@@@@@@@*******,**@@@
|                                          @@@***,,,,,@@@@@@@@@@@@@@#*,,**,*****************@@@@@@@@@@@@@@@*******/@@*
|                                          (@@&**,*,@@@@     @@@@@@@@@**,*****************,@@@*    @@@@@@@@@,,****@@@
|                                           @@@***,*@@@,     @@@@@@@@@/*****************,,@@@@      @@@@@@@@@,****@@@
|                                           @@@***,(@@@@@   @@@@@@@@@@@*****************,,@@@@@   .@@@@@@@@@@****@@@
|                                            @@@***,@@@@@@@@@@@@@@@@@@(*****************,,@@@@@@@@@@@@@@@@@@@****@@@
|                                            @@@****@@@@@@@@@&  @@@@@@,****************,,,,@@@@@@@@@   @@@@@*****@@@
|                                            .@@&****,@@@@@@@@  @@@@&,******************,,,,@@@@@@@@@ /@@@@*****@@@
|                                             @@@*****,*@@@@@@@@@@,,**********************,,,,%@@@@@@@@@@,,****/@@@
|                                             (@@/********,,,,,,,,,,*******************,,,,,,,*,,,*,,,,,,,,***/@@@,
|                                              @@@//*******,,,,,,,,,,,,,,,,,********,,,,,,,,,,,,,,,,,,,,,****//@@@
|                                               @@@//******,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,****/(@@@
|                                                @@@#//****,,,,,,,,,,,,,,,,@@@@@@@@@,,,,,,,,,,,,,,,,,,***///#@@@
|                                                 @@@@///*****,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,****//(@@@%
|                                                   @@@@((///****,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,***///(@@@@
|                                                @@@/ @@@@((((///*****,,,,,,,,,,,*******,,,,,,***////(@@@@&
|                                               @@%#@@@, @@@@&(((((/////********************//////(@@@@@
|                                               @@@@/**,@@# @@@@@@@((((((((((////((((((((((((&@@@@@@ &@@@@@
|                                                @@@@&,**@,/@@@/(((@@@@@@@@@@@@@@@@@@@@@@@@@@&(//@@@@**&@@
|                                              .@@%/%@@@@@%*@@***///@@/((((((@@((@@@((/(((@@@///**@@**@@@
|                                                @@@@/   @@@**,****@@///***///(@@@(////////@&**@@@@@@@@
|                                                       @@@,,,,,**(@@//******//@@(/******//@@*******,@@@
|                                                      @@@***,*,*@@@//**,,,,,,*@#/********/(@@@@*****,@@@
|                                                     @@@**/@@@@#/@@//**,,,,,,*(@***,*,***/(@@@/*****,,@@@
|                                                    @@@,@@@/***/(@@//***,,,**/(@/*******//(@@((@@@/***,@@@@@%&@@@
|                                                   @@***@*@***//@@(@@%///@@@@@@@@@@%((@#@@@(@@(////@(@@@@@*//@@@
|                                            @@    @@@**/%*@***//@&(((((@((((//////////@///(@@@(@@(*@**@**@@@@%
|                                            @@@@@@@@@**@**@**//@@@@///(%/////////****@/////(@@&(/**@%**@,,@@@
|                                            @@///@@*@**@**(@*//@@(/*@@@@/**********/%@&***/(@@@(//**@**@*,,@@@
|                                             @@/,@**@*@****@//@@@(****(@&@@@*********@*****@(@@@(//*@***@*,,@@.
|                                              %@@****@#****@/&@@@@@@@@@@@&**********@***(*@/(@@@&(/@,***@*,,@@@
|                                              @@@****@*****@%@@@@@@@@(**///%@@@#***@***@**@/(@@@@(@/******,,&@@@
|                                              @@,****@,****/@@@@@//********@******@(*%@***@/(@@@@@((*******,@,@@
|                                             @@@*****,@***//@@@@(/(@@@&**@@********%&****@@/(@@@@@((/*******@,@@@
|                                             @@@**,@**@***/(@@@@(/*,**@%*@@////****@@@@&,**@@@@@@@((/*******@*@@@
|                                             @@@***@*%#**%(%@@@@@**********/@@@@@@&@*******@/@@@@@%(/*@*****@*@@/
|                                              (@@@@@/@//(@@@@@@@(@****@**,***@@@@/********(*(%@@@@@((/@(///#@@@,
|                                                 @@@@@@@@@@@  @@@****@***,,%@@@@@@%********/%@@@  @@@@@@@@@@&
|                                                             ,@@/#@@%@@*(@@*%@@@@**@@@(*/@@@/(@@
|                                                             &@@/***********%@@@@***@******//(@@
|                                                             @@@//*(********&@@@@,,*%*******((@@
|                                                             @@@///#///@****@@@@@,,*@@*****//(@@
|                                                             /@@@#/%///@@**@@@&@@@*@**@////%@@@@
|                                                               /@@@@@@@@@@@@@    @@@@@@@@@@@@@
|
|
|				 __             ___      .___  ___.         _______ .______        ______     ______   .___________.
|				|  |           /   \     |   \/   |        /  _____||   _  \      /  __  \   /  __  \  |           |
|				|  |          /  ^  \    |  \  /  |       |  |  __  |  |_)  |    |  |  |  | |  |  |  | '---|  |----'
|				|  |         /  /_\  \   |  |\/|  |       |  | |_ | |      /     |  |  |  | |  |  |  |     |  |
|				|  |        /  _____  \  |  |  |  |       |  |__| | |  |\  \----.|  '--'  | |  '--'  |     |  |
|				|__|       /__/     \__\ |__|  |__|        \______| | _| '._____| \______/   \______/      |__|
```


## groot_index

### Tool Description
Convert a set of clustered reference sequences to variation graphs and then index them

### Metadata
- **Docker Image**: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
- **Homepage**: https://github.com/will-rowe/groot
- **Package**: https://anaconda.org/channels/bioconda/packages/groot/overview
- **Validation**: PASS

### Original Help Text
```text
Convert a set of clustered reference sequences to variation graphs and then index them

Usage:
  groot index [flags]

Flags:
  -h, --help                help for index
  -k, --kmerSize int        size of k-mer (default 31)
  -y, --maxK int            maxK in the LSH Ensemble (default 4)
      --maxSketchSpan int   max number of identical neighbouring sketches permitted in any graph traversal (default 30)
  -m, --msaDir string       directory containing the clustered references (MSA files) - required
  -x, --numPart int         number of partitions in the LSH Ensemble (default 8)
  -s, --sketchSize int      size of MinHash sketch (default 21)
  -w, --windowSize int      size of window to sketch graph traversals with (default 100)

Global Flags:
  -i, --indexDir string   directory for to write/read the GROOT index files
      --log string        filename for log file (default "groot.log")
  -p, --processors int    number of processors to use (default 1)
      --profiling         create the files needed to profile GROOT using the go tool pprof
```


## groot_report

### Tool Description
Generate a report from the output of groot align.

### Metadata
- **Docker Image**: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
- **Homepage**: https://github.com/will-rowe/groot
- **Package**: https://anaconda.org/channels/bioconda/packages/groot/overview
- **Validation**: PASS

### Original Help Text
```text
Generate a report from the output of groot align.

	This will report gene, read count, gene length, coverage cigar to STDOUT as tab separated values.

	Coverage cigar is present to help debug and indicates if the reference gene is covered (M) or not (D).

Usage:
  groot report [flags]

Flags:
      --bamFile string    BAM file generated by groot alignment (will use STDIN if not provided)
  -c, --covCutoff float   coverage cutoff for reporting ARGs (default 0.97)
  -h, --help              help for report
      --lowCov            reports ARGs which don't have 5' or 3' coverage (overrides -c option)

Global Flags:
  -i, --indexDir string   directory for to write/read the GROOT index files
      --log string        filename for log file (default "groot.log")
  -p, --processors int    number of processors to use (default 1)
      --profiling         create the files needed to profile GROOT using the go tool pprof
```


## Metadata
- **Skill**: generated
