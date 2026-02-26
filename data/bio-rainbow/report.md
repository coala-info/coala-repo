# bio-rainbow CWL Generation Report

## bio-rainbow_cluster

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/bio-rainbow:v2.0.4-1b1-deb_cv1
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio-rainbow/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/ialbert/bio
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
rainbow 2.0.4 -- <ruanjue@gmail.com, chongzechen@gmail.com>
Usage: rainbow <cmd> [options]

 cluster
Input  File Format: paired fasta/fastq file(s)
Output File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>
  -1 <string> Input fasta/fastq file, supports multiple '-1'
  -2 <string> Input fasta/fastq file, supports multiple '-2' [null]
  -l <int>    Read length, default: 0 variable
  -m <int>    Maximum mismatches [4]
  -e <int>    Exactly matching threshold [2000]
  -L          Low level of polymorphism
 div
Input File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>
Output File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>[\t<pre_cluster_id:int>]
  -i <string> Input file [stdin]
  -o <string> Output file [stdout]
  -k <int>    K_allele, min variants to create a new group [2]
  -K <int>    K_allele, divide regardless of frequency when num of variants exceed this value [50]
  -f <float>  Frequency, min variant frequency to create a new group [0.2]
 merge 
Input File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>[\t<pre_cluster_id:int>]
  -i <string> Input rbasm output file [stdin]
  -a          output assembly
  -o <string> Output file for merged contigs, one line per cluster [stdout]
  -N <int>    Maximum number of divided clusters to merge [300]
  -l <int>    Minimum overlap when assemble two reads (valid only when '-a' is opened) [5]
  -f <float>  Minimum fraction of similarity when assembly (valid only when '-a' is opened) [0.90]
  -r <int>    Minimum number of reads to assemble (valid only when '-a' is opened) [5]
  -R <int>    Maximum number of reads to assemble (valid only when '-a' is opened) [300]
```


## bio-rainbow_div

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/bio-rainbow:v2.0.4-1b1-deb_cv1
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
rainbow 2.0.4 -- <ruanjue@gmail.com, chongzechen@gmail.com>
Usage: rainbow <cmd> [options]

 cluster
Input  File Format: paired fasta/fastq file(s)
Output File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>
  -1 <string> Input fasta/fastq file, supports multiple '-1'
  -2 <string> Input fasta/fastq file, supports multiple '-2' [null]
  -l <int>    Read length, default: 0 variable
  -m <int>    Maximum mismatches [4]
  -e <int>    Exactly matching threshold [2000]
  -L          Low level of polymorphism
 div
Input File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>
Output File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>[\t<pre_cluster_id:int>]
  -i <string> Input file [stdin]
  -o <string> Output file [stdout]
  -k <int>    K_allele, min variants to create a new group [2]
  -K <int>    K_allele, divide regardless of frequency when num of variants exceed this value [50]
  -f <float>  Frequency, min variant frequency to create a new group [0.2]
 merge 
Input File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>[\t<pre_cluster_id:int>]
  -i <string> Input rbasm output file [stdin]
  -a          output assembly
  -o <string> Output file for merged contigs, one line per cluster [stdout]
  -N <int>    Maximum number of divided clusters to merge [300]
  -l <int>    Minimum overlap when assemble two reads (valid only when '-a' is opened) [5]
  -f <float>  Minimum fraction of similarity when assembly (valid only when '-a' is opened) [0.90]
  -r <int>    Minimum number of reads to assemble (valid only when '-a' is opened) [5]
  -R <int>    Maximum number of reads to assemble (valid only when '-a' is opened) [300]
```


## bio-rainbow_merge

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/bio-rainbow:v2.0.4-1b1-deb_cv1
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
rainbow 2.0.4 -- <ruanjue@gmail.com, chongzechen@gmail.com>
Usage: rainbow <cmd> [options]

 cluster
Input  File Format: paired fasta/fastq file(s)
Output File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>
  -1 <string> Input fasta/fastq file, supports multiple '-1'
  -2 <string> Input fasta/fastq file, supports multiple '-2' [null]
  -l <int>    Read length, default: 0 variable
  -m <int>    Maximum mismatches [4]
  -e <int>    Exactly matching threshold [2000]
  -L          Low level of polymorphism
 div
Input File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>
Output File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>[\t<pre_cluster_id:int>]
  -i <string> Input file [stdin]
  -o <string> Output file [stdout]
  -k <int>    K_allele, min variants to create a new group [2]
  -K <int>    K_allele, divide regardless of frequency when num of variants exceed this value [50]
  -f <float>  Frequency, min variant frequency to create a new group [0.2]
 merge 
Input File Format: <seqid:int>\t<cluster_id:int>\t<read1:string>\t<read2:string>[\t<pre_cluster_id:int>]
  -i <string> Input rbasm output file [stdin]
  -a          output assembly
  -o <string> Output file for merged contigs, one line per cluster [stdout]
  -N <int>    Maximum number of divided clusters to merge [300]
  -l <int>    Minimum overlap when assemble two reads (valid only when '-a' is opened) [5]
  -f <float>  Minimum fraction of similarity when assembly (valid only when '-a' is opened) [0.90]
  -r <int>    Minimum number of reads to assemble (valid only when '-a' is opened) [5]
  -R <int>    Maximum number of reads to assemble (valid only when '-a' is opened) [300]
```

