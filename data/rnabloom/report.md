# rnabloom CWL Generation Report

## rnabloom

### Tool Description
RNA-Bloom v2.0.1

### Metadata
- **Docker Image**: quay.io/biocontainers/rnabloom:2.0.1--hdfd78af_1
- **Homepage**: https://github.com/bcgsc/RNA-Bloom
- **Package**: https://anaconda.org/channels/bioconda/packages/rnabloom/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnabloom/overview
- **Total Downloads**: 20.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/RNA-Bloom
- **Stars**: N/A
### Original Help Text
```text
RNA-Bloom v2.0.1
Ka Ming Nip, Canada's Michael Smith Genome Sciences Centre, BC Cancer
Copyright 2018-present

usage: java -jar RNA-Bloom.jar [-l <FILE FILE ...>] [-r <FILE FILE ...>]
       [-pool <FILE>] [-long <FILE FILE ...>] [-sef <FILE FILE ...>] [-ser
       <FILE FILE ...>] [-ref <FILE FILE ...>] [-rcl] [-rcr] [-rc] [-ss]
       [-n <STR>] [-prefix <STR>] [-u] [-t <INT>] [-o <DIR>] [-f] [-k
       <INT>] [-stage <INT>] [-q <INT>] [-Q <INT>] [-c <INT>] [-hash
       <INT>] [-sh <INT>] [-dh <INT>] [-ch <INT>] [-ph <INT>] [-nk <INT>]
       [-ntcard] [-mem <DECIMAL>] [-sm <DECIMAL>] [-dm <DECIMAL>] [-cm
       <DECIMAL>] [-pm <DECIMAL>] [-fpr <DECIMAL>] [-savebf] [-tiplength
       <INT>] [-lookahead <INT>] [-sample <INT>] [-e <INT>] [-grad
       <DECIMAL>] [-indel <INT>] [-p <DECIMAL>] [-length <INT>] [-norr]
       [-mergepool] [-overlap <INT>] [-bound <INT>] [-extend] [-nofc]
       [-sensitive] [-artifact] [-chimera] [-stratum
       <01|e0|e1|e2|e3|e4|e5>] [-pair <INT>] [-a <INT>] [-mmopt <OPTIONS>]
       [-lrop <DECIMAL>] [-lrrd <INT>] [-lrpb] [-lrsub <arg>] [-debug]
       [-h] [-v]
 -l,--left <FILE FILE ...>         left reads file(s)
 -r,--right <FILE FILE ...>        right reads file(s)
 -pool <FILE>                      list of read files for pooled assembly
 -long <FILE FILE ...>             long reads file(s)
                                   (Requires `minimap2` and `racon` in
                                   your environment. Presets `-k 25 -c 2
                                   -indel 50 -e 2 -p 0.7 -length 200
                                   -overlap 150 -tip 50 -polya 12` unless
                                   each option is defined otherwise.)
 -sef <FILE FILE ...>              single-end forward read file(s)
 -ser <FILE FILE ...>              single-end reverse read file(s)
 -ref <FILE FILE ...>              reference transcripts file(s) for
                                   guiding the assembly process
 -rcl,--revcomp-left               reverse-complement left reads [false]
 -rcr,--revcomp-right              reverse-complement right reads [false]
 -rc,--revcomp-long                reverse-complement long reads [false]
 -ss,--stranded                    reads are strand specific [false]
 -n,--name <STR>                   assembly name [rnabloom]
 -prefix <STR>                     name prefix in FASTA header for
                                   assembled transcripts
 -u,--uracil                       output uracils (U) in place of thymines
                                   (T) in assembled transcripts [false]
 -t,--threads <INT>                number of threads to run [2]
 -o,--outdir <DIR>                 output directory [//rnabloom_assembly]
 -f,--force                        force overwrite existing files [false]
 -k,--kmer <INT>                   k-mer size [25]
 -stage <INT>                      assembly termination stage
                                   short reads: [3]
                                   1. construct graph
                                   2. assemble fragments
                                   3. assemble transcripts
                                   long reads: [3]
                                   1. construct graph
                                   2. correct reads
                                   3. assemble transcripts
 -q,--qual <INT>                   minimum base quality in reads [3]
 -Q,--qual-avg <INT>               minimum average base quality in reads
                                   [0]
 -c,--mincov <INT>                 minimum k-mer coverage [1]
 -hash <INT>                       number of hash functions for all Bloom
                                   filters [2]
 -sh,--sbf-hash <INT>              number of hash functions for screening
                                   Bloom filter [2]
 -dh,--dbgbf-hash <INT>            number of hash functions for de Bruijn
                                   graph Bloom filter [2]
 -ch,--cbf-hash <INT>              number of hash functions for k-mer
                                   counting Bloom filter [2]
 -ph,--pkbf-hash <INT>             number of hash functions for paired
                                   k-mers Bloom filter [2]
 -nk,--num-kmers <INT>             expected number of unique k-mers in
                                   input reads
 -ntcard                           count unique k-mers in input reads with
                                   ntCard [false]
                                   (Requires `ntcard` in your environment.
                                   Turns on automatically if `-nk` is not
                                   specified and `ntcard` is in your
                                   environment.)
 -mem,--memory <DECIMAL>           total amount of memory (GB) for all
                                   Bloom filters [auto]
 -sm,--sbf-mem <DECIMAL>           amount of memory (GB) for screening
                                   Bloom filter [auto]
 -dm,--dbgbf-mem <DECIMAL>         amount of memory (GB) for de Bruijn
                                   graph Bloom filter [auto]
 -cm,--cbf-mem <DECIMAL>           amount of memory (GB) for k-mer
                                   counting Bloom filter [auto]
 -pm,--pkbf-mem <DECIMAL>          amount of memory (GB) for paired kmers
                                   Bloom filter [auto]
 -fpr,--fpr <DECIMAL>              maximum allowable false-positive rate
                                   of Bloom filters [0.01]
 -savebf                           save graph (Bloom filters) from stage 1
                                   to disk [false]
 -tiplength <INT>                  maximum number of bases in a tip [auto]
 -lookahead <INT>                  number of k-mers to look ahead during
                                   graph traversal [3]
 -sample <INT>                     sample size for estimating
                                   read/fragment lengths [10000]
 -e,--errcorritr <INT>             number of iterations of
                                   error-correction in reads [1]
 -grad,--maxcovgrad <DECIMAL>      maximum k-mer coverage gradient for
                                   error correction [0.50]
 -indel <INT>                      maximum size of indels to be collapsed
                                   [1]
 -p,--percent <DECIMAL>            minimum percent identity of sequences
                                   to be collapsed [0.90]
 -length <INT>                     minimum transcript length in output
                                   assembly [200]
 -norr                             skip redundancy reduction for assembled
                                   transcripts [false]
                                   (will not create 'transcripts.nr.fa')
 -mergepool                        merge pooled assemblies [false]
                                   (Requires `-pool`; overrides `-norr`)
 -overlap <INT>                    minimum number of overlapping bases
                                   between reads [k-1]
 -bound <INT>                      maximum distance between read mates
                                   [500]
 -extend                           extend fragments outward during
                                   fragment reconstruction [false]
 -nofc                             turn off assembly consistency with
                                   fragment paired k-mers [false]
 -sensitive                        assemble transcripts in sensitive mode
                                   [false]
 -artifact                         keep potential sequencing artifacts
                                   [false]
 -chimera                          keep potential chimeras [false]
 -stratum <01|e0|e1|e2|e3|e4|e5>   fragments lower than the specified
                                   stratum are extended only if they are
                                   branch-free in the graph [e0]
 -pair <INT>                       minimum number of consecutive k-mer
                                   pairs for assembling transcripts [10]
 -a,--polya <INT>                  prioritize assembly of transcripts with
                                   poly-A tails of the minimum length
                                   specified [0]
 -mmopt <OPTIONS>                  options for minimap2 ["'-K 250M -e 25
                                   -f 0.0001 -c'"]
                                   (`-x` and `-t` are already in use)
 -lrop <DECIMAL>                   minimum proportion of matching bases
                                   within long-read overlaps [0.80]
 -lrrd <INT>                       min read depth required for long-read
                                   assembly [3]
 -lrpb                             use PacBio presets [false].
                                   (Used in conjunction with `-long`
                                   option. Presets `-k35 -indel 30 -tip 10
                                   -p 0.8 -lrop 0.9` unless each option is
                                   defined otherwise.)
 -lrsub <arg>                      subsample long reads before assembly
                                   using strobemers (depth,s,size,window)
                                   or k-mer pairs (depth,k,size)
                                   [3,s,11,50]
 -debug                            print debugging information [false]
 -h,--help                         print this message and exits
 -v,--version                      print version information and exits
```

