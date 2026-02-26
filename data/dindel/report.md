# dindel CWL Generation Report

## dindel

### Tool Description
dindel

### Metadata
- **Docker Image**: biocontainers/dindel:v1.01-wu1-3dfsg-1b1-deb_cv1
- **Homepage**: https://github.com/genome/dindel-tgi
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dindel/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/genome/dindel-tgi
- **Stars**: N/A
### Original Help Text
```text
Error parsing input options. Usage: 

[Required] :
  --ref arg                             fasta reference sequence (should be 
                                        indexed with .fai file)
  --outputFile arg                      file-prefix for output results

[Required] Program option:
  --analysis arg (=indels)              Analysis type:
                                        getCIGARindels:  Extract indels from 
                                        CIGARs of mapped reads, and infer 
                                        libary insert size distributions
                                        indels: infer indels
                                        realignCandidates: Realign/reposition 
                                        candidates in candidate file
                                        

[Required] BAM input. Choose one of the following:
  --bamFile arg                         read alignment file (should be indexed)
  --bamFiles arg                        file containing filepaths for BAMs to 
                                        be jointly analysed (not possible for 
                                        --analysis==indels

[Required for analysis == getCIGARindels]: 
Region to be considered for extraction of candidate indels.:
  --region arg                          region to be analysed in format 
                                        start-end, eg. 1000-2000
  --tid arg                             target sequence (eg 'X') 

[Required for analysis == indels]:
  --varFile arg                         file with candidate variants to be 
                                        tested.
  --varFileIsOneBased                   coordinates in varFile are one-based

Output options:
  --outputRealignedBAM                  output BAM file with realigned reads
  --processRealignedBAM arg             ABSOLUTE path to script to process 
                                        realigned BAM file
  --quiet                               quiet output

parameters for analysis==indels option:
  --doDiploid                           analyze data assuming a diploid 
                                        sequence
  --doPooled                            estimate haplotype frequencies using 
                                        Bayesian EM algorithm.
                                        May be applied to single individual and
                                        pools.

General algorithm parameters:
  --faster                              use faster but less accurate ungapped 
                                        read-haplotype alignment model
  --filterHaplotypes                    prefilter haplotypes based on coverage
  --flankRefSeq arg (=2)                #bases of reference sequence of indel 
                                        region
  --flankMaxMismatch arg (=2)           max number of mismatches in indel 
                                        region
  --priorSNP arg (=0.001)               prior probability of a SNP site
  --priorIndel arg (=0.0001)            prior probability of a detected indel 
                                        not being a sequencing error
  --width arg (=60)                     number of bases to left and right of 
                                        indel
  --maxHap arg (=8)                     maximum number of haplotypes in 
                                        likelihood computation
  --maxRead arg (=10000)                maximum number of reads in likelihood 
                                        computation
  --mapQualThreshold arg (=0.98999999999999999)
                                        lower limit for read mapping quality
  --capMapQualThreshold arg (=100)      upper limit for read mapping quality in
                                        observationmodel_old (phred units)
  --capMapQualFast arg (=45)            cap mapping quality in alignment using 
                                        fast ungapped method
                                         (WARNING: setting it too high (>50) 
                                        might result in significant 
                                        overcalling!)
  --skipMaxHap arg (=200)               skip computation if number of 
                                        haplotypes exceeds this number
  --minReadOverlap arg (=20)            minimum overlap between read and 
                                        haplotype
  --maxReadLength arg (=500)            maximum length of reads
  --minCount arg (=1)                   minimum number of WS observations of 
                                        indel
  --maxHapReadProd arg (=10000000)      skip if product of number of reads and 
                                        haplotypes exceeds this value
  --changeINStoN                        change sequence of inserted sequence to
                                        'N', so that no penalty is incurred if 
                                        a read mismatches the inserted sequence

parameters for --pooled option:
  --bayesa0 arg (=0.001)                Dirichlet a0 parameter haplotype 
                                        frequency prior
  --bayesType arg (=singlevariant)      Bayesian EM program type (all or 
                                        singlevariant or priorpersite)

General algorithm filtering options:
  --checkAllCIGARs arg (=1)             include all indels at the position of 
                                        the call site
  --filterReadAux arg                   match string for exclusion of reads 
                                        based on auxilary information

Observation model parameters:
  --pError arg (=0.00050000000000000001)
                                        probability of a read indel
  --pMut arg (=1.0000000000000001e-05)  probability of a mutation in the read
  --maxLengthIndel arg (=5)             maximum length of a _sequencing error_ 
                                        indel in read [not for --faster option]

Library options:
  --libFile arg                         file with library insert histograms (as
                                        generated by --analysis getCIGARindels)

Misc results analysis options:
  --compareReadHap                      compare likelihood differences in reads
                                        against haplotypes
  --compareReadHapThreshold arg (=0.5)  difference threshold for viewing
  --showEmpirical                       show empirical distribution over 
                                        nucleotides
  --showCandHap                         show candidate haplotypes for fast 
                                        method
  --showHapAlignments                   show for each haplotype which reads map
                                        to it
  --showReads                           show reads
  --inferenceMethod arg (=empirical)    inference method
  --opl                                 output likelihoods for every read and 
                                        haplotype
```

