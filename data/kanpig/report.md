# kanpig CWL Generation Report

## kanpig_plup

### Tool Description
BAM/CRAM to Pileup Index

### Metadata
- **Docker Image**: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
- **Homepage**: https://github.com/ACEnglish/kanpig
- **Package**: https://anaconda.org/channels/bioconda/packages/kanpig/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kanpig/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/ACEnglish/kanpig
- **Stars**: N/A
### Original Help Text
```text
BAM/CRAM to Pileup Index

Usage: kanpig plup [OPTIONS] --bam <BAM>

Options:
  -b, --bam <BAM>                Input BAM/CRAM file
  -r, --reference <REFERENCE>    Reference file for CRAMs
  -o, --output <OUTPUT>          Output plup (unsorted, uncompressed) [default: stdout]
  -t, --threads <THREADS>        Number of threads [default: 1]
      --sizemin <SIZEMIN>        Minimum size of variant to index [default: 50]
      --sizemax <SIZEMAX>        Maximum size of variant to index [default: 10000]
      --mapq <MAPQ>              Minimum mapq of reads to consider [default: 5]
      --mapflag <MAPFLAG>        Ignore alignments matching flag [default: 3840]
      --chunk-size <CHUNK_SIZE>  Chunksize in Mbp [default: 25]
      --debug                    Verbose logging
  -h, --help                     Print help
```


## kanpig_gt

### Tool Description
Germline SV Genotyping

### Metadata
- **Docker Image**: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
- **Homepage**: https://github.com/ACEnglish/kanpig
- **Package**: https://anaconda.org/channels/bioconda/packages/kanpig/overview
- **Validation**: PASS

### Original Help Text
```text
Germline SV Genotyping

Usage: kanpig gt [OPTIONS] --input <INPUT> --reads <READS> --reference <REFERENCE>

Options:
      --debug  Verbose logging
  -h, --help   Print help

I/O:
  -i, --input <INPUT>            VCF to genotype
  -r, --reads <READS>            Reads to genotype (indexed .bam, .cram, or .plup.gz)
  -f, --reference <REFERENCE>    Reference genome
  -o, --out <OUT>                Output VCF (unsorted, uncompressed) [default: stdout]
  -t, --threads <THREADS>        Number of threads [default: 1]
      --rnames <RNAMES>          Output RNAMES file
      --sample <SAMPLE>          Output VCF sample name
      --ploidy-bed <PLOIDY_BED>  Bed file of non-diploid regions
      --bed <BED>                Regions to analyze

Variants & Reads:
      --passonly               Only analyze variants with PASS FILTER
      --neighdist <NEIGHDIST>  Maximum variant distance within graphs [default: 1000]
      --sizemin <SIZEMIN>      Minimum size of variant to analyze [default: 50]
      --sizemax <SIZEMAX>      Maximum size of variant to analyze [default: 10000]
      --mapq <MAPQ>            Minimum mapq score for reads [default: 5]
      --mapflag <MAPFLAG>      Ignore alignments matching flag [default: 3840]

Graph:
      --seqsim <SEQSIM>            Minimum sequence similarity for paths [default: 0.9]
      --sizesim <SIZESIM>          Minimum size similarity for paths [default: 0.9]
      --gpenalty <GPENALTY>        Scoring penalty for gaps [default: 0.02]
      --fpenalty <FPENALTY>        Scoring penalty for FNs [default: 0.1]
      --kmer <KMER>                Kmer size for featurization [default: 4]
      --minkfreq <MINKFREQ>        Minimum frequency of kmers [default: 2]
      --maxnodes <MAXNODES>        Maximum graph size to search; otherwise perform 1-to-1 [default: 5000]
      --maxpaths <MAXPATHS>        Maximum paths to traverse per graph [default: 5000]
      --pileupmax <PILEUPMAX>      Maximum pileups allowed for partials matching [default: 100]
      --fnmax <FNMAX>              Maximum FNs allowed in a path [default: 3]
      --squish                     Prefer simplier paths during scoring
      --one-to-one                 Restrict to 1-to-1 haplotype/node matching
      --mincoverage <MINCOVERAGE>  Minimum coverage to attempt building haplotypes [default: 1]
      --maxcoverage <MAXCOVERAGE>  Maximum coverage to attempt building haplotypes [default: 1000]

Genotyping:
      --hps-weight <HPS_WEIGHT>  Clustering weight for haplotagged reads (off=0.0, full=1.0) [default: 1]
      --hapsim <HAPSIM>          Collapse haplotypes of similar size (off=1) [default: 1]
      --ab <AB>                  Minimum allele balance for compound het lower VAF (off=0) [default: 0]
      --gqconfig <GQCONFIG>      GQ Config
```


## kanpig_trio

### Tool Description
Trio SV Genotyping

### Metadata
- **Docker Image**: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
- **Homepage**: https://github.com/ACEnglish/kanpig
- **Package**: https://anaconda.org/channels/bioconda/packages/kanpig/overview
- **Validation**: PASS

### Original Help Text
```text
Trio SV Genotyping

Usage: kanpig trio [OPTIONS] --input <INPUT> --proband <PROBAND> --father <FATHER> --mother <MOTHER> --reference <REFERENCE>

Options:
      --debug  Verbose logging
  -h, --help   Print help

I/O:
  -i, --input <INPUT>
          VCF to genotype
      --proband <PROBAND>
          Proband reads to genotype (indexed .bam, .cram, or .plup.gz)
      --father <FATHER>
          Paternal reads to genotype (indexed .bam, .cram, or .plup.gz)
      --mother <MOTHER>
          Maternal reads to genotype (indexed .bam, .cram, or .plup.gz)
  -f, --reference <REFERENCE>
          Reference genome
  -o, --out <OUT>
          Output VCF (unsorted, uncompressed) [default: stdout]
  -t, --threads <THREADS>
          Number of threads [default: 1]
      --rnames <RNAMES>
          Output RNAMES file
      --proband-sample <PROBAND_SAMPLE>
          Output VCF proband sample name [default: PRO]
      --father-sample <FATHER_SAMPLE>
          Output VCF paternal sample name [default: PAT]
      --mother-sample <MOTHER_SAMPLE>
          Output VCF maternal sample name [default: MAT]
      --XYploidy-bed <XYPLOIDY_BED>
          Bed file of XY karyotype
      --XXploidy-bed <XXPLOIDY_BED>
          Bed file of XX karyotype
      --karyotype <KARYOTYPE>
          Proband karyotype [possible values: XX, XY]
      --bed <BED>
          Regions to analyze
      --min-coverage <MIN_COVERAGE>
          Minimum coverage of a region to analyze [default: 1]
      --max-coverage <MAX_COVERAGE>
          Maximum coverage of a region to analyze [default: 1000]

Variants & Reads:
      --passonly               Only analyze variants with PASS FILTER
      --neighdist <NEIGHDIST>  Maximum variant distance within graphs [default: 1000]
      --sizemin <SIZEMIN>      Minimum size of variant to analyze [default: 50]
      --sizemax <SIZEMAX>      Maximum size of variant to analyze [default: 10000]
      --mapq <MAPQ>            Minimum mapq score for reads [default: 5]
      --mapflag <MAPFLAG>      Ignore alignments matching flag [default: 3840]

Graph:
      --seqsim <SEQSIM>            Minimum sequence similarity for paths [default: 0.9]
      --sizesim <SIZESIM>          Minimum size similarity for paths [default: 0.9]
      --gpenalty <GPENALTY>        Scoring penalty for gaps [default: 0.02]
      --fpenalty <FPENALTY>        Scoring penalty for FNs [default: 0.1]
      --kmer <KMER>                Kmer size for featurization [default: 4]
      --minkfreq <MINKFREQ>        Minimum frequency of kmers [default: 2]
      --maxnodes <MAXNODES>        Maximum graph size to search; otherwise perform 1-to-1 [default: 5000]
      --maxpaths <MAXPATHS>        Maximum paths to traverse per graph [default: 5000]
      --pileupmax <PILEUPMAX>      Maximum pileups allowed for partials matching [default: 100]
      --fnmax <FNMAX>              Maximum FNs allowed in a path [default: 3]
      --squish                     Prefer simplier paths during scoring
      --one-to-one                 Restrict to 1-to-1 haplotype/node matching
      --mincoverage <MINCOVERAGE>  Minimum coverage to attempt building haplotypes [default: 1]
      --maxcoverage <MAXCOVERAGE>  Maximum coverage to attempt building haplotypes [default: 1000]

Genotyping:
      --msmin <MSMIN>            Minimum number of reads in a cluster [default: 5]
      --maxclust <MAXCLUST>      Max clusters [default: 5]
      --hps-weight <HPS_WEIGHT>  Clustering weight for haplotagged reads (off=0.0, full=1.0) [default: 0.25]
      --len-weight <LEN_WEIGHT>  Clustering weight for haplotype lengths (off=0.0, full=1.0) [default: 0.25]
      --gqconfig <GQCONFIG>      GQ Config
```


## kanpig_mosaic

### Tool Description
Mosaic SV Genotyping

### Metadata
- **Docker Image**: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
- **Homepage**: https://github.com/ACEnglish/kanpig
- **Package**: https://anaconda.org/channels/bioconda/packages/kanpig/overview
- **Validation**: PASS

### Original Help Text
```text
Mosaic SV Genotyping

Usage: kanpig mosaic [OPTIONS] --input <INPUT> --reference <REFERENCE>

Options:
      --debug  Verbose logging
  -h, --help   Print help

I/O:
  -i, --input <INPUT>            VCF to genotype
      --reads <READS>            Reads to genotype (indexed .bam, .cram, or .plup.gz; can be specified multiple times)
  -f, --reference <REFERENCE>    Reference genome
  -o, --out <OUT>                Output VCF (unsorted, uncompressed) [default: stdout]
  -t, --threads <THREADS>        Number of threads [default: 1]
      --rnames <RNAMES>          Output RNAMES file
      --sample <SAMPLE>          Output VCF sample names (one per `--reads`; can be specified multiple times) [default: SAMPLE]
      --ploidy-bed <PLOIDY_BED>  Bed file of non-diploid regions
      --bed <BED>                Regions to analyze

Variants & Reads:
      --passonly               Only analyze variants with PASS FILTER
      --neighdist <NEIGHDIST>  Maximum variant distance within graphs [default: 1000]
      --sizemin <SIZEMIN>      Minimum size of variant to analyze [default: 50]
      --sizemax <SIZEMAX>      Maximum size of variant to analyze [default: 10000]
      --mapq <MAPQ>            Minimum mapq score for reads [default: 5]
      --mapflag <MAPFLAG>      Ignore alignments matching flag [default: 3840]

Graph:
      --seqsim <SEQSIM>            Minimum sequence similarity for paths [default: 0.9]
      --sizesim <SIZESIM>          Minimum size similarity for paths [default: 0.9]
      --gpenalty <GPENALTY>        Scoring penalty for gaps [default: 0.02]
      --fpenalty <FPENALTY>        Scoring penalty for FNs [default: 0.1]
      --kmer <KMER>                Kmer size for featurization [default: 4]
      --minkfreq <MINKFREQ>        Minimum frequency of kmers [default: 2]
      --maxnodes <MAXNODES>        Maximum graph size to search; otherwise perform 1-to-1 [default: 5000]
      --maxpaths <MAXPATHS>        Maximum paths to traverse per graph [default: 5000]
      --pileupmax <PILEUPMAX>      Maximum pileups allowed for partials matching [default: 100]
      --fnmax <FNMAX>              Maximum FNs allowed in a path [default: 3]
      --squish                     Prefer simplier paths during scoring
      --one-to-one                 Restrict to 1-to-1 haplotype/node matching
      --mincoverage <MINCOVERAGE>  Minimum coverage to attempt building haplotypes [default: 1]
      --maxcoverage <MAXCOVERAGE>  Maximum coverage to attempt building haplotypes [default: 1000]

Genotyping:
      --msmin <MSMIN>            Minimum number of reads in a cluster [default: 2]
      --maxclust <MAXCLUST>      Max clusters [default: 8]
      --hps-weight <HPS_WEIGHT>  Clustering weight for haplotagged reads (off=0.0, full=1.0) [default: 0.25]
      --len-weight <LEN_WEIGHT>  Clustering weight for haplotype lengths (off=0.0, full=1.0) [default: 0.25]
      --bandwidth <BANDWIDTH>    Minimum haplotype size difference for K estimation [default: 2]
      --alpha <ALPHA>            VAF prior alpha [default: 1]
      --beta <BETA>              VAF prior beta [default: 15]
      --soma-vaf <SOMA_VAF>      Max somatic VAF [default: 0.2]
```


## Metadata
- **Skill**: generated
