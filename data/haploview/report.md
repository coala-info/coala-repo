# haploview CWL Generation Report

## haploview

### Tool Description
Haploview 4.2 Command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/haploview:4.2--hdfd78af_1
- **Homepage**: https://www.broadinstitute.org/haploview/haploview
- **Package**: https://anaconda.org/channels/bioconda/packages/haploview/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haploview/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Haploview 4.2 Command line options
-h, -help                       Print this message
-v, -version                    Print out the version number
-memory <memsize>               allocates <memsize> megabytes of memory (default 512)
-n, -nogui                      Command line output only
-q, -quiet                      Quiet mode- doesnt print any warnings or information to screen
-log <filename>                 Specify a logfile name (defaults to haploview.log if no name specified)
-out <fileroot>                 Specify a fileroot to be used for all output files
-pedfile <pedfile>              Specify an input file (or http:// location) in pedigree file format
-hapmap <hapmapfile>            Specify an input file (or http:// location) in HapMap format
-phasedhmpdata <phasedfile>     Specify a HapMap PHASE data file (or http:// location)
-phasedhmpsample <samplefile>   Specify a HapMap PHASE sample file (or http:// location)
-phasedhmplegend <legendfile>   Specify a HapMap PHASE legend file (or http:// location)
-gzip                           Indicates that phased input files use GZIP compression
-hapmapDownload                 Specify a phased HapMap download
-haps <hapsfile>                Specify an input file (or http:// location) in .haps format
-info <infofile>                Specify a marker info file (or http:// location)
-plink <plinkfile>              Specify a PLINK or other results file (or http:// location)
-map <mapfile>                  Specify a map file or binary map file (or http:// location)
-nonSNP                         Specify that the accompanying PLINK file is non-SNP based output
-selectCols                     Activate the preloading column filter for PLINK loads
-batch <batchfile>              Batch mode. Each line in batch file should contain a genotype file 
                                followed by an optional info file, separated by a space.
-blocks <blockfile>             Blocks file (or http:// location), one block per line, will force output for these blocks
-track <trackfile>              Specify an input analysis track file (or http:// location)
-excludeMarkers <markers>       Specify markers (in range 1-N where N is total number of markers) to be
                                skipped for all analyses. Format: 1,2,5..12
-skipcheck                      Skips the various genotype file checks
-chromosome <1-22,X,Y>          Specifies the chromosome for this file or download
-panel <CEU,YRI,CHB+JPT>        Specifies the analysis panel for this HapMap download
-startpos <integer>             Specifies the start position in kb for this HapMap download
-endpos <integer>               Specifies the end position in kb for this HapMap download
-release <16a,21,22>            Specifies the HapMap phase for this HapMap download (defaults to 21)
-dprime                         Outputs LD text to <fileroot>.LD
-png                            Outputs LD display to <fileroot>.LD.PNG
-compressedpng                  Outputs compressed LD display to <fileroot>.LD.PNG
-svg                            Outputs svg format LD display to <fileroot>.LD.SVG
-infoTrack                      Downloads and displays HapMap info track on PNG image output
-ldcolorscheme <argument>       Specify an LD color scheme. <argument> should be one of:
                                DEFAULT, RSQ, DPALT, GAB, GAM
-ldvalues <DPRIME,RSQ,NONE>     Specify what to print in LD image output. default is DPrime
-check                          Outputs marker checks to <fileroot>.CHECK
                                note: -dprime  and -check default to no blocks output. 
                                Use -blockoutput to also output blocks
-indcheck                       Outputs genotype percent per individual to <fileroot>.INDCHECK
-mendel                         Outputs Mendel error information to <fileroot>.MENDEL
-malehets                       Outputs male heterozygote information to <fileroot>.MALEHETS
-blockoutput <GAB,GAM,SPI,ALL>  Output type. Gabriel, 4 gamete, spine output or all 3. default is Gabriel.
-blockCutHighCI <thresh>        Gabriel 'Strong LD' high confidence interval D' cutoff.
-blockCutLowCI <thresh>         Gabriel 'Strong LD' low confidence interval D' cutoff.
-blockMAFThresh <thresh>        Gabriel MAF threshold.
-blockRecHighCI <thresh>        Gabriel recombination high confidence interval D' cutoff.
-blockInformFrac <thresh>       Gabriel fraction of informative markers required to be in LD.
-block4GamCut <thresh>          4 Gamete block cutoff for frequency of 4th pairwise haplotype.
-blockSpineDP <thresh>          Solid Spine blocks D' cutoff for 'Strong LD
-maxdistance <distance>         Maximum comparison distance in kilobases (integer). Default is 500
-hapthresh <frequency>          Only output haps with at least this frequency
-spacing <threshold>            Proportional spacing of markers in LD display. <threshold> is a value
                                between 0 (no spacing) and 1 (max spacing). Default is 0
-minMAF <threshold>             Minimum minor allele frequency to include a marker. <threshold> is a value
                                between 0 and 0.5. Default is .001
-maxMendel <integer>            Markers with more than <integer> Mendel errors will be excluded. Default is 1.
-minGeno <threshold>            Exclude markers with less than <threshold> valid data. <threshold> is a value
                                between 0 and 1. Default is .75
-hwcutoff <threshold>           Exclude markers with a HW p-value smaller than <threshold>. <threshold> is a value
                                between 0 and 1. Default is .001
-missingCutoff <threshold>      Exclude individuals with more than <threshold> fraction missing data.
                                <threshold> is a value between 0 and 1. Default is .5 
-assocCC                        Outputs case control association results to <fileroot>.ASSOC and <fileroot>.HAPASSOC
-assocTDT                       Outputs trio association results to <fileroot>.ASSOC and <fileroot>.HAPASSOC
-customAssoc <file>             Loads a set of custom tests for association.
-permtests <numtests>           Performs <numtests> permutations on default association tests (or custom tests
                                if a custom association file is specified) and writes to <fileroot>.PERMUT
-pairwiseTagging                Generates pairwise tagging information in <fileroot>.TAGS and .TESTS
-aggressiveTagging              As above but generates 2-marker haplotype tags unless specified otherwise by -aggressiveNumMarkers
-aggressiveNumMarkers <2,3>     Specifies whether to use 2-marker haplotype tags or 2 and 3-marker haplotype tags.
-maxNumTags <n>                 Only selects <n> best tags.
-dontaddtags                    Only uses forced in tags.
-includeTags <markers>          Forces in a comma separated list of marker names as tags.
-includeTagsFile <file>         Forces in a file (or http:// location) of one marker name per line as tags.
-excludeTags <markers>          Excludes a comma separated list of marker names from being used as tags.
-excludeTagsFile <file>         Excludes a file (or http:// location) of one marker name per line from being used as tags.
-captureAlleles <file>          Capture only the alleles contained in a file (or http:// location) of one marker name per line.
-designScores <file>            Specify design scores in a file (or http:// location) of one marker name and one score per line
-mindesignscores <threshold>    Specify a minimum design score threshold.
-mintagdistance <distance>      Specify a Minimum distance in bases between picked tags.
-taglodcutoff <thresh>          Tagger LOD cutoff for creating multimarker tag haplotypes.
-tagrsqcutoff <thresh>          Tagger r^2 cutoff.
```

