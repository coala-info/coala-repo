# duplomap CWL Generation Report

## duplomap

### Tool Description
Realign reads overlapping segmental duplications.

### Metadata
- **Docker Image**: quay.io/biocontainers/duplomap:0.9.5--h577a1d6_4
- **Homepage**: https://gitlab.com/tprodanov/duplomap
- **Package**: https://anaconda.org/channels/bioconda/packages/duplomap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/duplomap/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
duplomap 0.9.5
Timofey Prodanov, Vikas Bansal
Realign reads overlapping segmental duplications.

USAGE:
    duplomap -i <bam> -r <fasta> -d <psv-database> -o <dir> [args]

OPTIONS:
    -i, --input <FILE>                                Input reads in the sorted and indexed bam format.
    -d, --database <FILE|DIR+>                        Database file or directory (multiple entries allowed).
    -r, --reference <FILE>                            Reference genome in the indexed fasta format.
    -o, --output <DIR>                                Output directory.
    -@, --threads <INT>                               Number of threads to use. [default: 4]
    -f, --force                                       Force work with non-empty output directory.
        --continue
            Continue duplomap run in the same output directory. In that case duplomap will skip already analyzed
            duplications clusters (be careful to use the same command line arguments).
    -n, --iterations <INT>                            Maximum number of iterations of EM-algorithm. [default: 100]
        --log <LEVEL>
            Logging level in log files (stderr shows logs with info level and higher). [default: debug]  [possible
            values: trace, debug, info, warning, error, critical, none]
        --samtools <PATH>                             Path to Samtools executable. [default: samtools]
        --minimap-kmer <INT>                          Minimap2 k-mer size. [default: 11]
    -x, --preset <STR>
            Minimap2 alignment preset. Possible values: pacbio [pb] and nanopore [ont] [default: pacbio]  [possible
            values: pacbio, pb, nanopore, ont]
        --gt-prior <FLOAT>                            Reference genotype prior. [default: 0.95]
        --relative-padding <FLOAT>
            Padding added to the sides of possible read locations. For example, for a read with with length 3,000 and
            relative-padding 0.01, possible locations would be padded by 30 bp on both sides. [default: 0.01]
        --psv-complexity <FLOAT> <FLOAT>
            Keep PSVs that have complexity higher than FLOAT[1] for substitutions (0.6 by default), and FLOAT[2] for
            indels (0.8 by default).
        --psv-size-diff <INT>
            Maximal difference in sizes of the PSV sequences (including anchors). PSVs with bigger difference are not
            used, but influence pre-PSV LCS comparison. [default: 10]
        --gt-min-mapq <INT>
            Do not use reads with MAPQ lower than INT to determine genotype probabilities. [default: 30]

        --read-psv-impact <FLOAT>
            Maximal read-PSV impact. A single read cannot decrease genotype probability of a PSV by more than 10^FLOAT,
            and a single PSV cannot affect location probabilities by more than 10^FLOAT. [default: 3]
        --ambiguous <FLOAT> <FLOAT>
            A read is aligned to a PSV ambiguously if local alignment probabilities between the read and the PSV alleles
            are within FLOAT[1]-fold range (max(probabilities) < min(probabilities) * FLOAT[1]). If the PSV has more
            than FLOAT[2] percent ambiguously aligned reads, it is not used.
            [default: 4 30]
        --copy-num-perc <FLOAT>
            Do not realign reads that overlap high copy number regions by more than FLOAT %. High copy number regions
            are defined in duplomap-prepare with --skip-copy-num. [default: 50]
        --unknown-regions <realign|keep-old|mapq0>
            How to process reads that overlap unknown regions in the reference:
             realign  - Realign a read and assign appropriate MAPQ,
             keep-old - Keep an old alignment and MAPQ,
             mapq0    - Keep an old alignment and set MAPQ to 0.
             [default: realign]  [possible values: realign, keep-old, mapq0]
        --filtering-kmer <INT>
            k-mer size used for filtering possible location for a read. [default: 11]

        --filtering-p-value <FLOAT>
            We compare LCS paths of a read and its possible locations. If location A is better than location B with p-
            value lower than FLOAT, location B may be discarded. [default: 1e-4]
        --max-locations <INT>
            Maximal number of locations after filtering. If read can align to more than INT locations, it will get the
            original alignment and MAPQ 0. [default: 50]
        --conflicts-p-value <FLOAT>
            Each read is put through Binomial test with the number of conflicting PSVs out of all homozygous PSVs. All
            reads that fail the test are assigned low MAPQ. The threshold p-value is divided by the number of reads in
            each component according to the Bonferroni correction. [default: 0.05]
        --min-conflicts <INT>
            Minimal number of conflicts between a read and PSVs to discard the read. [default: 5]

        --skip-mapq <INT|none>
            Skip reads with mapping quality at least INT in the original alignment. These reads will be used to estimate
            genotypes, but will not be realigned. [default: none]
        --secondary <INT|all>
            Output at most INT secondary alignments for each realigned read. Use "all" to output all secondary
            alignments. [default: 0]
        --first <INT> <INT>
            Use first INT[1] databases and first INT[2] reads for each database. Use all databases/reads when INT = 0.

        --generated                                   Reads are generated and the true position is known.
        --skip-unique                                 Do not output reads from unique (not duplicated) regions.
        --skip-vcf                                    Do not output vcf file with genotyped PSVs.
        --keep                                        Do not clean, keep all output files.
        --default-hmm                                 Use default HMM parameters (instead of estimating using reads).
        --output-debug                                Output additional CSV files.
    -h, --help                                        Prints help information
    -V, --version                                     Prints version information
```


## Metadata
- **Skill**: generated
