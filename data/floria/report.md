# floria CWL Generation Report

## floria

### Tool Description
strain phasing for short or long-read shotgun metagenomic sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/floria:0.0.2--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/floria
- **Package**: https://anaconda.org/channels/bioconda/packages/floria/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/floria/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bluenote-1577/floria
- **Stars**: N/A
### Original Help Text
```text
floria 0.0.2
floria - strain phasing for short or long-read shotgun metagenomic sequencing.

Example usage :
floria -b bamfile.bam -v vcffile.vcf -r reference.fa -o results -t 10

USAGE:
    floria [OPTIONS] -b <BAM FILE> -v <VCF FILE> -r <FASTA FILE>

OPTIONS:
        --debug            Debugging output.
    -h, --help             Print help information
    -t, --threads <INT>    Number of threads to use. (default: 10)
        --trace            Trace output.
    -V, --version          Print version information

REQUIRED:
    -b <BAM FILE>          Indexed and sorted bam file to phase.
    -r <FASTA FILE>        Reference fasta for the BAM file.
    -v <VCF FILE>          VCF file with contig header information; see README if contig header
                           information is not present.

INPUT:
    -G, --contigs <LIST OF CONTIGS>...
            Phase only contigs in this argument. Usage: -G contig1 contig2 contig3 ...

        --ignore-monomorphic
            Ignore SNPs that have minor allele frequency less than -e.

        --snp-count-filter <snp_count_filter>
            Skip contigs with less than --snp-count-filter SNPs. (default: 100)

    -X, --no-supp
            Do not use supplementary alignments. (default: use supp. alignments with MAPQ = 60)

OUTPUT:
        --extra-trimming         Trim the reads extra carefully against the reference genome. May
                                 cause more fragmented but accurate assemblies.
        --gzip-reads             Output gzipped reads instead of raw fastq if using --output-reads.
    -o, --output-dir <STRING>    Output folder. (default: floria_out_dir)
        --output-reads           Output reads in fastq format for the resulting haplosets.
        --overwrite              Force overwrite for output directory.

ALGORITHM:
    -e, --epsilon <FLOAT>               Estimated allele call error rate; we recommend: noisy
                                        long-reads, 0.02-0.06; hifi, 0.01; short-reads, 0.01.
                                        (default: if no -e provided, -e is estimated from data.)
    -l, --block-length <INT>            Length of blocks (in bp) for flow graph construction when
                                        using bam file. (default: 66th percentile of read-lengths,
                                        minimum 500 bp)
    -d, --snp-density <FLOAT>           Blocks with fraction of SNPs per base less than -d won't be
                                        phased. (default: 0.0005)
    -m, --mapq-cutoff <INT>             Primary MAPQ cutoff. (default: 15)
    -n, --beam-solns <INT>              Maximum number of solutions for beam search. (default: 10)
        --no-stop-heuristic             Do not use MEC stopping heuristic for local ploidy/strain
                                        count computation; only stop phasing when SNP error rate in
                                        block is < epsilon. (default: use stopping heuristic)
    -p, --max-ploidy <INT>              Maximum ploidy (i.e. strain count) to try to phase up to.
                                        (default: 5)
    -s, --ploidy-sensitivity <1,2,3>    Sensitivity for the local strain count stopping heuristic;
                                        higher values try to phase more haplotypes, but may give
                                        more spurious results. (default: 2)
        --supp-aln-dist-cutoff <INT>    Maximum allowed distance between supp. alignments. (default:
                                        40000)
```

