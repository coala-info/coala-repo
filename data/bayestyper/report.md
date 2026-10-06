# bayestyper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bayestyper_bayesTyperTools_addAttributes | Failed | image problem: the bioconda build compiles out code inside assert() calls (NDEBUG), so addAttributes segfaults on a valid sarscov2 VCF. |
| bayestyper_bayesTyperTools_annotate | Failed | image problem: the bioconda build compiles out code inside assert() calls (NDEBUG), so annotate segfaults on valid sarscov2 VCFs and writes an empty VCF. |
| bayestyper_bayesTyperTools_combine | Failed | image problem: the bioconda build compiles out code inside assert() calls (NDEBUG), so combine segfaults even on a one-line valid VCF. |
| bayestyper_bayesTyperTools_convertAllele | Failed | image problem: the bioconda build compiles out code inside assert() calls (NDEBUG), so convertAllele loads no genome sequences and aborts with unordered_map::at. |
| bayestyper_bayesTyperTools_filter | Failed | image problem: the bioconda build compiles out code inside assert() calls (NDEBUG), so filter segfaults on a valid sarscov2 VCF. |
| bayestyper_bayesTyperTools_makeBloom | Failed | image problem: the bioconda build compiles out code inside assert() calls (NDEBUG), so makeBloom reads 0 k-mers from a valid KMC3 table and segfaults. |
| bayestyper_bayesTyper_cluster | Failed | image problem: the bioconda build compiles out code inside assert() calls (NDEBUG), so bayesTyper cluster aborts with map::at on a valid sarscov2 VCF, FASTA and KMC3 sample. |
| bayestyper_bayesTyper_genotype | Not completed | needs bayesTyper cluster output, which this image cannot produce because cluster and makeBloom crash. |

## bayestyper_bayesTyper_cluster

### Tool Description
create variant clusters

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyper cluster options ##:

  -h [ --help ]                         produce help message for options

== Required ==:
  -v [ --variant-file ] arg             variant file (vcf format).
  -s [ --samples-file ] arg             samples file (see github documentation for format specifications).
  -g [ --genome-file ] arg              reference genome file (fasta format).

== General ==:
  -d [ --decoy-file ] arg               decoy sequences file (fasta format).
  -o [ --output-prefix ] arg (=bayestyper)
                                        output prefix.
  -r [ --random-seed ] arg (=unix time) seed for pseudo-random number generator.
  -p [ --threads ] arg (=1)             number of threads used (+= 2 I/O threads).
  -u [ --min-number-of-unit-variants ] arg (=5000000)
                                        minimum number of variants per inference unit.

== Cluster ==:
  --max-allele-length arg (=500000)     exclude alleles (reference and alternative) longer than <length>.
  --copy-number-variant-threshold arg (=0.5)
                                        minimum fraction of identical kmers required between an allele and the downstream reference sequence in order for it to
                                        be classified as a copy number.
  --max-number-of-sample-haplotypes arg (=32)
                                        maximum number of haplotype candidates per sample.
```

## bayestyper_bayesTyper_genotype

### Tool Description
genotype variant clusters

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyper genotype options ##:

  -h [ --help ]                         produce help message for options

== Required ==:
  -v [ --variant-clusters-file ] arg    variant_clusters.bin file (BayesTyper cluster output).
  -c [ --cluster-data-dir ] arg         cluster data directory containing intercluster_regions.txt.gz, multigroup_kmers.bloom[Meta|Data] & 
                                        parameter_kmers.fa.gz (BayesTyper cluster output).
  -s [ --samples-file ] arg             samples file (see github documentation for format specifications).
  -g [ --genome-file ] arg              reference genome file (fasta format).

== General ==:
  -d [ --decoy-file ] arg               decoy sequences file (fasta format).
  -o [ --output-prefix ] arg (=bayestyper)
                                        output prefix.
  -z [ --gzip-output ] [=arg(=1)] (=0)  compress <output-prefix>.vcf using gzip.
  -r [ --random-seed ] arg (=unix time) seed for pseudo-random number generator.
  -p [ --threads ] arg (=1)             number of threads used (+= 2 I/O threads).
  -y [ --chromosome-ploidy-file ] arg   chromosome gender ploidy file (see github documentation for format specifications). Human ploidy levels will be assumed
                                        if no file is given.

== Genotyping ==:
  --gibbs-burn-in arg (=100)            number of burn-in iterations.
  --gibbs-samples arg (=250)            number of Gibbs iterations.
  --number-of-gibbs-chains arg (=20)    number of independent Gibbs sampling chains.
  --kmer-subsampling-rate arg (=0.1)    subsampling rate for subsetting kmers used for genotype inference.
  --max-haplotype-variant-kmers arg (=500)
                                        maximum number of kmers used for genotype inference after subsampling across a haplotype candidate for each variant.
  --noise-genotyping [=arg(=1)] (=0)    estimate noise model parameters and genotypes jointly (generally slower and uses more memory).
  --noise-rate-prior arg (=1,0.01)      parameters for Poisson noise rate gamma prior (<shape>,<scale>). All samples will use the same parameters.

== Filter ==:
  --min-genotype-posterior arg (=0.99)  filter genotypes with a posterior probability (GPP) below <value>.
  --min-number-of-kmers arg (=1)        filter sampled alleles with less than <value> kmers (NAK).
  --disable-observed-kmers [=arg(=1)] (=0)
                                        disable filtering of sampled alleles with a low fraction of observed kmers (FAK).
```

## bayestyper_bayesTyperTools_makeBloom

### Tool Description
create kmer bloom filter

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyperTools makeBloom ##:

  -h [ --help ]                       produce help message for options

== Required ==:
  -k [ --kmc-table-prefix ] arg       KMC kmer table prefix. Output is written as <kmc-table-prefix>.bloomMeta and <kmc-table-prefix>.bloomData.

== General ==:
  -p [ --num-threads ] arg (=1)       number of threads used (+= 1 I/O thread).

== Parameters ==:
  --false-positive-rate arg (=0.001)  bloom filter false positive rate.
```

## bayestyper_bayesTyperTools_convertAllele

### Tool Description
convert allele IDs to sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyperTools convertAllele ##:

  -h [ --help ]                         produce help message for options

== Required ==:
  -v [ --variant-file ] arg             variant file (vcf format).
  -g [ --genome-file ] arg              reference genome file (fasta format).
  -o [ --output-prefix ] arg            output prefix.

== General ==:
  -z [ --gzip-output ] [=arg(=1)] (=0)  compress output file(s) using gzip.

== Alleles ==:
  --alt-file arg                        alternative allele file (fasta format). Sequence name in fasta (>"name") should match <"name">.
  --mei-file arg                        mobile element insertion(s) file (fasta format). Sequence name in fasta (>"name") should match <INS:ME:"name">.
  --keep-imprecise [=arg(=1)] (=0)      do not filter imprecise variants
  --keep-partial [=arg(=1)] (=0)        keep partial insertions where the center and length is unknown (Manta output supported). The known left and right side 
                                        is connected with ten N's.
```

## bayestyper_bayesTyperTools_combine

### Tool Description
combine callsets (vertical)

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyperTools combine ##:

  -h [ --help ]                         produce help message for options

== Required ==:
  -v [ --variant-files ] arg            comma-separated list of name and variant file (vcf format) pairs (<name>:<file>).
  -o [ --output-prefix ] arg            output prefix.

== General ==:
  -z [ --gzip-output ] [=arg(=1)] (=0)  compress output file(s) using gzip.

== Filters ==:
  --filter-ambiguous-alleles [=arg(=1)] (=0)
                                        filter alleles (including reference) with ambiguous nucleotides (non ACGT).
```

## bayestyper_bayesTyperTools_filter

### Tool Description
filter variants, alleles and/or samples

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyperTools filter ##:

  -h [ --help ]                         produce help message for options

== Required ==:
  -v [ --variant-file ] arg             variant file (vcf format).
  -o [ --output-prefix ] arg            output prefix.

== General ==:
  -z [ --gzip-output ] [=arg(=1)] (=0)  compress output file(s) using gzip.

== Filters ==:
  --min-homozygote-genotypes arg (=0)   filter variants with less than <value> homozygote genotypes (calculated before other filters).
  --min-genotype-posterior arg (=0.99)  filter genotypes with a posterior probability (GPP) below <value>.
  --min-number-of-kmers arg (=1)        filter sampled alleles with less than <value> kmers (NAK).
  --kmer-coverage-file arg (=bayestyper_genomic_parameters.txt)
                                        sample kmer coverage file used for filtering sampled alleles with a low fraction of observed kmers (FAK).
```

## bayestyper_bayesTyperTools_annotate

### Tool Description
annotate alleles

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyperTools annotate ##:

  -h [ --help ]                         produce help message for options

== Required ==:
  -v [ --variant-file ] arg             variant file (vcf format).
  -a [ --annotation-file ] arg          annotation file (vcf format).
  -o [ --output-prefix ] arg            output prefix.

== General ==:
  -z [ --gzip-output ] [=arg(=1)] (=0)  compress output file(s) using gzip.
  -c [ --clear-prev-annotation ] [=arg(=1)] (=0)
                                        clear previous annotations (variant id and AAI).

== Parameters ==:
  --match-threshold arg (=0.5)          minimum sequence overlap between input allele and annotation allele.
  --window-size-scale arg (=3)          window size allele length scaling factor.
```

## bayestyper_bayesTyperTools_addAttributes

### Tool Description
add variant, allele and/or trio attributes

### Metadata
- **Docker Image**: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
- **Homepage**: https://github.com/bioinformatics-centre/BayesTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayestyper/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinformatics-centre/BayesTyper
- **Stars**: N/A

### Original Help Text
```text
 ## BayesTyperTools addAttributes ##:

  -h [ --help ]                         produce help message for options

== Required ==:
  -v [ --variant-file ] arg             variant file (vcf format).
  -o [ --output-prefix ] arg            output prefix.

== General ==:
  -z [ --gzip-output ] [=arg(=1)] (=0)  compress output file(s) using gzip.

== Attributes ==:
  --genome-file arg                     reference genome file (fasta format) used for homopolymer length (HPL) calculation. If not specified HPL will not be 
                                        calculated.
  --repeat-file arg                     repeatmasker file used for repeat annotation (RMA). If not specified RMA will not be annotated.
  --independent-samples-regex arg       regular expression for matching independent samples (e.g. parents in a trio) used for absolute inbreeding coefficient 
                                        (IBC) calculation. If not specified IBC will not be calculated.
  --trio-sample-info arg                trio sample id information used for concordance (CONC) calculation 
                                        (<father>,<mother>,<child>:<father>,<mother>,<child>:...). If not specified CONC will not be calculated.
```

## Metadata
- **Skill**: generated
