# vt CWL Generation Report

## vt_view

### Tool Description
Views a VCF or BCF or VCF.GZ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS
- **wiki**: https://genome.sph.umich.edu/wiki/Vt

- **Conda**: https://anaconda.org/channels/bioconda/packages/vt/overview
- **Total Downloads**: 155.8K
- **Last updated**: 2025-09-21
- **GitHub**: https://genome.sph.umich.edu/wiki/Vt
- **Stars**: N/A
### Original Help Text
```text
undefined -- Required argument missing: <in.vcf>

view v0.5

description : Views a VCF or BCF or VCF.GZ file.

usage : vt view [options] <in.vcf>

options : -o  output VCF/VCF.GZ/BCF file [-]
          -f  filter expression []
          -w  local sorting window size [0]
          -s  print site information only without genotypes [false]
          -H  print header only, this option is honored only for STDOUT [false]
          -h  omit header, this option is honored only for STDOUT [false]
          -p  print options and summary []
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## vt_index

### Tool Description
Indexes a VCF.GZ or BCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in.vcf>

index v0.5

description : Indexes a VCF.GZ or BCF file.

usage : vt index [options] <in.vcf>

options : -p  print options and summary []
          -?  displays help
```


## vt_normalize

### Tool Description
normalizes variants in a VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required arguments missing: r, <in.vcf>

normalize v0.5

description : normalizes variants in a VCF file

usage : vt normalize [options] <in.vcf>

options : -o  output VCF file [-]
          -d  debug [false]
          -q  do not print options and summary [false]
          -n  do not fail when REF is inconsistent with reference sequence for non SNPs [false]
          -w  window size for local sorting of variants [10000]
          -I  file containing list of intervals []
          -i  intervals []
          -r  reference sequence fasta file []
          -?  displays help
```


## vt_decompose

### Tool Description
decomposes multiallelic variants into biallelic in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in.vcf>

decompose v0.5

description : decomposes multiallelic variants into biallelic in a VCF file.

usage : vt decompose [options] <in.vcf>

options : -s  smart decomposition [false]
          -o  output VCF file [-]
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## vt_uniq

### Tool Description
Drops duplicate variants that appear later in the the VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in.vcf>

uniq v0.57

description : Drops duplicate variants that appear later in the the VCF file.

usage : vt uniq [options] <in.vcf>

options : -o  output VCF file [-]
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## vt_cat

### Tool Description
Concatenate VCF files. Individuals must be in the same order.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
-hel -- Couldn't find match for argument

cat v0.5

description : Concatenate VCF files. Individuals must be in the same order.

usage : vt cat [options] <in1.vcf>...

options : -s  print site information only without genotypes [false]
          -p  print options and summary [false]
          -n  naive, assumes that headers are the same. [false]
          -w  local sorting window size [0]
          -f  filter expression []
          -L  file containing list of input VCF files
          -o  output VCF file [-]
          -I  file containing list of intervals []
          -i  intervals
          -?  displays help
```


## vt_paste

### Tool Description
Pastes VCF files like the unix paste functions. This is used after the per sample genotyping step in vt.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
-hel -- Couldn't find match for argument

paste v0.5

description : Pastes VCF files like the unix paste functions.
              This is used after the per sample genotyping step in vt.
              Input requirements and assumptions:
              1. Same variants are represented in the same order for each file (required)
              2. Genotype fields are the same for corresponding records (required)
              3. Sample names are different in all the files (warning will be given if not)
              4. Headers (not including the samples) are the same for all the files (unchecked assumption, will fail if output is BCF)
              Outputs:
              1. INFO fields output will be that of the first file
              2. Genotype fields are the same for corresponding records


usage : vt paste [options] <in1.vcf>...

options : -L  file containing list of input VCF files
          -o  output VCF file [-]
          -p  print options and summary []
          -?  displays help
```


## vt_sort

### Tool Description
Sorts a VCF or BCF or VCF.GZ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in.vcf>

sort v0.5

description : Sorts a VCF or BCF or VCF.GZ file.


usage : vt sort [options] <in.vcf>

options : -m  sorting modes. [full]
              local : locally sort within a 1000bp window.  Window size may be set by -w.
              chrom : sort chromosomes based on order of contigs in header.
                      input must be indexed
              full  : full sort with no assumptions
          -o  output VCF/VCF.GZ/BCF file [-]
          -w  local sorting window size, set by default to 1000 under local mode. [0]
          -p  print options and summary []
          -?  displays help
```


## vt_subset

### Tool Description
Subsets a VCF file to a set of variants that are polymorphic on a selected set of individuals.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required arguments missing: s, <in.vcf>

subset v0.5

description : Subsets a VCF file to a set of variants that are polymorphic on a selected set of individuals.

usage : vt subset [options] <in.vcf>

options : -o  output VCF/VCF.GZ/BCF file [-]
          -f  filter expression []
          -s  file containing list of samples []
          -I  file containing list of intervals
          -i  Intervals
          -?  displays help
```


## vt_peek

### Tool Description
Summarizes the variants in a VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in.vcf>

peek v0.5

description : Summarizes the variants in a VCF file

usage : vt peek [options] <in.vcf>

options : -y  output pdf file [summary.pdf]
          -x  output latex directory []
          -f  filter expression []
          -I  file containing list of intervals []
          -i  intervals []
          -r  reference sequence fasta file []
          -?  displays help
```


## vt_partition

### Tool Description
partition variants from two data sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in1.vcf><in2.vcf>

partition v0.5

description : partition variants from two data sets.


usage : vt partition [options] <in1.vcf><in2.vcf>

options : -w  write partitioned variants to file
          -f  filter
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## vt_multi_partition

### Tool Description
partition variants from any number of data sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in1.vcf><in2.vcf>...

multi_partition v0.5

description : partition variants from any number of data sets.


usage : vt multi_partition [options] <in1.vcf><in2.vcf>...

options : -f  filter
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## vt_annotate_variants

### Tool Description
annotates variants in a VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required arguments missing: r, <in.vcf>

annotate_variants v0.5

description : annotates variants in a VCF file

usage : vt annotate_variants [options] <in.vcf>

options : -g  coding regions BED file []
          -m  low complexity regions BED file []
          -r  reference sequence fasta file []
          -f  filter expression []
          -o  output VCF file [-]
          -I  file containing list of intervals []
          -i  intervals
          -?  displays help
```


## vt_annotate_db_rsid

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Command not found: annotate_db_rsid

Help page on http://statgen.sph.umich.edu/wiki/Vt

Useful tools:
view                      view vcf/vcf.gz/bcf files
index                     index vcf.gz/bcf files
normalize                 normalize variants
decompose                 decompose variants
uniq                      drop duplicate variants
cat                       concatenate VCF files
paste                     paste VCF files
sort                      sort VCF files
subset                    subset VCF file to variants polymorphic in a sample

peek                      summary of variants in the vcf file
partition                 partition variants
multi_partition           partition variants from multiple VCF files
annotate_variants         annotate variants
annotate_db_rsid          annotate variants with dbSNP rsid
annotate_1000g            annotate variants with 1000 Genomes variants
annotate_regions          annotate regions
compute_concordance       compute genotype concordance between 2 call sets
compute_features          compute genotype likelihood based statistics

discover                  discover variants
genotype                  genotype variants
```


## vt_annotate_1000g

### Tool Description
annotates variants that are present in 1000 Genomes variant set

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required arguments missing: d, <in.vcf>

annotate_1000g v0.5

description : annotates variants that are present in 1000 Genomes variant set

usage : vt annotate_1000g [options] <in.vcf>

options : -o  output VCF file [-]
          -d  1000G data set VCF file []
          -f  filter expression []
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## vt_annotate_regions

### Tool Description
annotates regions in a VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required arguments missing: d, t, b, <in.vcf>

annotate_regions v0.5

description : annotates regions in a VCF file

usage : vt annotate_regions [options] <in.vcf>

options : -r  right window size for overlap []
          -l  left window size for overlap []
          -d  regions tag description []
          -t  regions tag []
          -b  regions BED file []
          -o  output VCF file [-]
          -I  file containing list of intervals []
          -i  intervals
          -?  displays help
```


## vt_compute_concordance

### Tool Description
Compute Concordance.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in1.vcf><in2.vcf>

compute_concordance v0.5

description : Compute Concordance.


usage : vt compute_concordance [options] <in1.vcf><in2.vcf>

options : -f  filter expression
          -s  Sample concordance text file [s.txt]
          -m  Variant concordance text file [m.txt]
          -I  File containing list of intervals []
          -i  Intervals []
          -?  displays help
```


## vt_compute_features

### Tool Description
Compute features for variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required argument missing: <in.vcf>

compute_features v0.5

description : Compute features for variants.

usage : vt compute_features [options] <in.vcf>

options : -s  print site information only without genotypes [false]
          -o  output VCF/VCF.GZ/BCF file [-]
          -f  filter expression []
          -I  File containing list of intervals
          -i  Intervals
          -?  displays help
```


## vt_discover

### Tool Description
Discovers variants from reads in a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required arguments missing: b, s, r

discover v0.5

description : Discovers variants from reads in a BAM file.

usage : vt discover [options] 

options : -b  input BAM file
          -v  variant types [snps,mnps,indels]
          -f  fractional evidence cutoff for candidate allele [0.1]
          -e  evidence count cutoff for candidate allele [2]
          -q  base quality cutoff for bases [13]
          -m  MAPQ cutoff for alignments [20]
          -s  sample ID
          -r  reference sequence fasta file []
          -o  output VCF file [-]
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## vt_genotype

### Tool Description
Genotypes variants for each sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/vt:2015.11.10--2
- **Homepage**: https://genome.sph.umich.edu/wiki/Vt
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
undefined -- Required arguments missing: s, b, <in.vcf>

genotype v0.5

description : Genotypes variants for each sample.


usage : vt genotype [options] <in.vcf>

options : -d  debug alignments
          -r  reference FASTA file
          -s  sample ID
          -o  output VCF file
          -b  input BAM file
          -I  file containing list of intervals []
          -i  intervals []
          -?  displays help
```


## Metadata
- **Skill**: generated
