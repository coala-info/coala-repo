# seer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seer | PASS | repo tests 1, 3, 5 and 6 (basic, print_samples, population structure, covariates) give output identical to the expected files |
| seer_blast_top_hits | PASS | reduced a blastn table (446 hits, helper blast image) to 129 top hits, one per query |
| seer_blastn_to_phandango | Not completed | needs fastlmm-format association results; seer output gives a perl 'beta is not numeric' error and no real fastlmm file is available |
| seer_combine_kmers | PASS | synthetic data: two random 2 kb sequences' 21-mer counts; union output comb.gz keeps kmers seen in both samples with --min_samples 2 |
| seer_filter_seer | PASS | repo test 7 (--pos_beta) output identical to the expected file |
| seer_hits_to_fastq | PASS | made a 174-read fastq from the repo test seer output |
| seer_kmds | PASS | filtered and subsampled the repo example kmers (3068 samples); wrote .dsm, .dsm.samples and kmers.gz |
| seer_map_back | PASS | repo test 8 output identical to the expected file (kmer mapped to 6259_5_16:342-361) |
| seer_mapping_to_phandango | PASS | bwa-mapped kmer reads (helper image) against the repo genome; 144 plot lines written |
| seer_mash2matrix | PASS | converted mash dist output for 3 real genomes to a 3x3 distance matrix |
| seer_r_mds | Failed | image problem: R is not installed in the image (Can't exec R), so no structure file is written |
| seer_reformat_output | PASS | reformatted the repo test 7 kmers with the pheno file into a tsv with per-sample columns |

## seer

### Tool Description
sequence element enrichment analysis

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/johnlees/seer
- **Stars**: N/A
### Original Help Text
```text
seer: sequence element enrichment analysis

Required options:
  -k [ --kmers ] arg       dsm kmer output file
  -p [ --pheno ] arg       .pheno metadata

Covariate options:
  --struct arg             mds values from kmds
  --covar_file arg         file containing covariates
  --covar_list arg         list of columns covariates to use. Format is 1,2q,3 
                           (use q for quantitative)

Performance options:
  --threads arg (=1)       number of threads. Suggested: 20

Filtering options:
  --no_filtering           turn off all filtering and perform tests on all 
                           kmers input
  --max_length arg (=100)  maximum kmer length
  --maf arg (=0.01)        minimum kmer frequency
  --min_words arg          minimum kmer occurences. Overrides --maf
  --chisq arg (=10e-5)     p-value threshold for initial chi squared test. Set 
                           to 1 to show all
  --pval arg (=10e-8)      p-value threshold for final logistic test. Set to 1 
                           to show all

Other options:
  --print_samples          print lists of samples significant kmers were found 
                           in
  --version                prints version and exits
  -h [ --help ]            full help message
```


## seer_hits_to_fastq

### Tool Description
Creates a fastq for mapping from significant kmers

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hits_to_fastq -k <significant_kmers.txt> -b <bonferroni_correction>

Creates a fastq for mapping from significant kmers

   Options

   Required
   -k, --kmers      Significant kmers, as output by seer
   -b, --bonf       Bonferroni correction to use (try 10e-8)

   Optional
   -h, --help       Displays this message
```

## seer_blast_top_hits

### Tool Description
Reduces a blast or blat output file to the top hit for each query sequence only

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast_top_hits --input blast_out --mode blast <options>

Reduces a blast or blat output file to the top hit for each query sequence
only

   Options

   Required
   --input              BLAST output file in -m 6/-outfmt 6 or BLAT .psl file
   --mode               Either blast or blat

   Optional
   --full_query        The entire query must be reported as a match to appear
                       in the output

   -h, --help          Shows this help.
```

## seer_kmds

### Tool Description
Control for population structure

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
kmds: control for population structure
kmds
	1) filter and subsample with --no_mds and --size
	2) combine, and do metric multidimensional scaling with --mds_concat

Required options:
  -k [ --kmers ] arg       dsm kmer output file (not needed if using 
                           --mds_concat)
  -p [ --pheno ] arg       .pheno metadata

MDS options:
  -o [ --output ] arg      output prefix for new dsm file
  --no_mds                 do not perform MDS; output subsampled matrix instead
  --write_distances        write csv of distance matrix
  --mds_concat arg         list of subsampled matrices to use in MDS. Performs 
                           only MDS; implies --no_filtering
  --pc arg (=10)           number of principal coordinates to output
  --size arg (=1000000)    number of kmers to use in MDS
  --threads arg (=1)       number of threads. Suggested: 20

Filtering options:
  --no_filtering           turn off all filtering and do not output new kmer 
                           file
  --max_length arg (=100)  maximum kmer length
  --maf arg (=0.01)        minimum kmer frequency
  --min_words arg          minimum kmer occurences. Overrides --maf

Other options:
  --version                prints version and exits
  -h [ --help ]            full help message
```

## seer_mapping_to_phandango

### Tool Description
Creates a plot file for visualisation in phandango

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mapping_to_phandango -s <sam_file> -k <seer_kmers> > phandango.plot

Creates a plot file for visualisation in phandango

   Options

   Required
   -s, --sam        Sam file of kmers mapped to reference (unsorted)
   -k, --kmers      Kmers that were mapped

   Optional
   -m, --map        Minimum mapping quality
   --print_kmer     Also print k-mer sequence in output

   -h, --help       Displays this message
```

## seer_reformat_output

### Tool Description
Reformats output for easier reading as tsv

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: reformat_output -k <filtered_kmers.txt> -p <pheno_file>

Reformats output for easier reading as tsv. Prints to stdout

   Options

   Required
   -k, --kmers      Filtered significant kmers, as output by seer + filter_seer
   -p, --pheno       Phenotype file used by seer

   Optional
   -h, --help       Displays this message
```

## seer_map_back

### Tool Description
Context of significant kmers

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
map_back: context of significant kmers

Required options:
  -k [ --kmers ] arg       seer kmer output file
  -r [ --references ] arg  file with tab separated reference name and fasta 
                           file

Other options:
  --threads arg (=1)       number of threads. Suggested: 20
  --version                prints version and exits
  -h [ --help ]            full help message
```

## seer_blastn_to_phandango

### Tool Description
Creates a plot file for visualisation in phandango

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ./mapping_to_phandango.pl -b <blast_file> -a <fastlmm_kmers> > phandango.plot

Creates a plot file for visualisation in phandango

   Options

   Required
   -b, --blast      blast results
   -a, --assoc      fastlmm results

   -h, --help       Displays this message
```

## seer_mash2matrix

### Tool Description
Uses mash to create all pairwise distances between samples

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mash2matrix <matrix_in> > all_distances.csv

Uses mash (http://mash.readthedocs.io/) to create all pairwise distances
between samples.

NB: the input to mash should be the same order as the .pheno file
generate <assemblies.fa> with:
cut -f 1 metadata.pheno | tr '
' ' '

Then run
mash sketch -o reference <assemblies.fa>
mash dist reference.msh reference.msh > mash_distances.txt
./mash2matrix.pl mash_distances.txt > all_distances.csv
```

## seer_r_mds

### Tool Description
Projects distance matrix into lower number of dimensions

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: R_mds -d <distances.csv> -p <pheno_file>

Projects distance matrix into lower number of dimensions
Requires R and rhdf5 to be installed, see github wiki for more details

NB ensure order in dist matrix and pheno file is the same!

   Options

   Required
   -d, --dist       Distance matrix output by kmds/mash
   -p, --pheno      Phenotype file used by seer

   Optional
   -o, --output     Output prefix (default 'all_structure')
   --pc             Number of dimensions to project into (default 10)
   --no_hdf5        Write output as csv, use if seer compiled with 'NO_HDF5'
   -R               R executable (default 'which R')
   -h, --help       Displays this message
```

## seer_combine_kmers

### Tool Description
Basic algorithm to combine kmer counts across samples

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
combineKmers: basic algorithm to combine kmer counts across samples

Required options:
  -r [ --samples ] arg    file with tab separated sample name and kmer file
  -o [ --output ] arg     output file prefix

Other options:
  --min_samples arg (=1)  minimum number of samples kmer must occur in to be 
                          printed
  -h [ --help ]           full help message
```

## seer_filter_seer

### Tool Description
Post filtering of significant kmers

### Metadata
- **Docker Image**: biocontainers/seer:v1.1.4-2b2-deb_cv1
- **Homepage**: https://github.com/johnlees/seer
- **Package**: https://anaconda.org/channels/bioconda/packages/seer/overview
- **Validation**: PASS

### Original Help Text
```text
filter_seer: post filtering of significant kmers

Required options:
  -k [ --kmers ] arg     file of output from seer

Filtering options:
  --chisq arg            minimum unadjusted p-value to output
  --pval arg             minimum adjusted p-value to output
  --maf arg              minimum maf/max 1-maf to output
  --beta arg             minimum |beta| to output
  --substr               remove smaller kmers completely represented elsewhere
  --pos_beta             output positive effect sizes only

Other options:
  -s [ --sort ] arg      field to sort on: chisq, pval, maf or beta
  --version              prints version and exits
  -h [ --help ]          full help message
```

## Metadata
- **Skill**: generated
