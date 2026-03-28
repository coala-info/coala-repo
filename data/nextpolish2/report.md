# nextpolish2 CWL Generation Report

## nextpolish2_yak

### Tool Description
yak <command> <argument>

### Metadata
- **Docker Image**: quay.io/biocontainers/nextpolish2:0.2.2--h74ec884_0
- **Homepage**: https://github.com/Nextomics/NextPolish2
- **Package**: https://anaconda.org/channels/bioconda/packages/nextpolish2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nextpolish2/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-11-05
- **GitHub**: https://github.com/Nextomics/NextPolish2
- **Stars**: N/A
### Original Help Text
```text
Usage: yak <command> <argument>
Command:
  count     count k-mers
  qv        evaluate quality values
  triobin   trio binning
  trioeval  evaluate phasing accuracy with trio
  inspect   k-mer hash tables
  chkerr    check errors
  sexchr    count sex-chromosome-specific k-mers
  version   print version number
```


## nextpolish2_nextPolish2

### Tool Description
Repeat-aware polishing genomes assembled using HiFi long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/nextpolish2:0.2.2--h74ec884_0
- **Homepage**: https://github.com/Nextomics/NextPolish2
- **Package**: https://anaconda.org/channels/bioconda/packages/nextpolish2/overview
- **Validation**: PASS

### Original Help Text
```text
Repeat-aware polishing genomes assembled using HiFi long reads

Usage: nextPolish2 [OPTIONS] <HiFi.map.bam> <genome.fa[.gz]> <short.read.yak>...

Arguments:
  <HiFi.map.bam>
          HiFi-to-ref mapping file in sorted BAM format.

  <genome.fa[.gz]>
          genome assembly file in [GZIP] FASTA format.

  <short.read.yak>...
          one or more k-mer dataset in yak format.

Options:
  -o, --out <FILE>
          output file.
          
          [default: stdout]

  -u, --uppercase
          output in uppercase sequences.

      --out_pos
          output each base and its position.

  -k, --min_kmer_count <INT>
          filter kmers in k-mer dataset with count <= INT.
          
          [default: 5]

  -t, --thread <INT>
          number of threads.
          
          [default: 1]

  -i, --iter_count <INT>
          number of iterations to attempt phasing.
          
          [default: 2]

  -m, --model <STR>
          phasing model.

          Possible values:
          - ref: output the same haplotype phase blocks as the reference
          - len: output longer haplotype phase blocks
          
          [default: ref]

  -l, --min_read_len <INT>
          filter reads with length <= INT.
          
          [default: 1000]

  -L, --min_ctg_len <INT>
          don't correct reference sequences with length <= INT.
          
          [default: 1000000]

  -n, --max_indel_len <INT>
          ignore indel errors with length > INT.
          
          [default: 20]

  -s, --use_supplementary
          use supplementary alignments.

  -S, --use_secondary
          use secondary alignments, consider setting `min_map_qual` to -1 when using this option.

  -a, --min_map_len <INT.FLOAT>
          filter alignments with alignment length <= min(INT, FLOAT * read_length).
          
          [default: 500.5]

  -q, --min_map_qual <INT>
          filter alignments with mapping quality <= INT.
          
          [default: 1]

  -c, --max_clip_len <INT>
          filter alignments with unaligned length >= INT.
          
          [default: 100]

  -r, --use_all_reads
          use all unfiltered reads, reads with different haplotypes from the reference assembly are discarded by default.

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## Metadata
- **Skill**: generated
