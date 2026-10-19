# rainbow CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rainbow_cluster | PASS |  |
| rainbow_div | PASS |  |
| rainbow_merge | PASS |  |
| rainbow_select_all_rbcontig | PASS |  |
| rainbow_select_best_rbcontig | PASS |  |
| rainbow_select_best_rbcontig_plus_read1 | PASS |  |
| rainbow_select_sec_rbcontig | PASS |  |

## rainbow_cluster

### Tool Description
rainbow 2.0.4 -- <ruanjue@gmail.com, chongzechen@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
- **Homepage**: https://sourceforge.net/projects/bio-rainbow/
- **Package**: https://anaconda.org/channels/bioconda/packages/rainbow/overview
- **Validation**: PASS

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

## rainbow_div

### Tool Description
rainbow 2.0.4 -- <ruanjue@gmail.com, chongzechen@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
- **Homepage**: https://sourceforge.net/projects/bio-rainbow/
- **Package**: https://anaconda.org/channels/bioconda/packages/rainbow/overview
- **Validation**: PASS

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

## rainbow_merge

### Tool Description
rainbow 2.0.4 -- <ruanjue@gmail.com, chongzechen@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
- **Homepage**: https://sourceforge.net/projects/bio-rainbow/
- **Package**: https://anaconda.org/channels/bioconda/packages/rainbow/overview
- **Validation**: PASS

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

## rainbow_select_all_rbcontig

### Tool Description
Usage: /usr/local/bin/select_all_rbcontig.pl <rbasmed file>

### Metadata
- **Docker Image**: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
- **Homepage**: https://sourceforge.net/projects/bio-rainbow/
- **Package**: https://anaconda.org/channels/bioconda/packages/rainbow/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/select_all_rbcontig.pl <rbasmed file>
```

## rainbow_select_sec_rbcontig

### Tool Description
Usage: /usr/local/bin/select_sec_rbcontig.pl <rbasmed file>

### Metadata
- **Docker Image**: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
- **Homepage**: https://sourceforge.net/projects/bio-rainbow/
- **Package**: https://anaconda.org/channels/bioconda/packages/rainbow/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/select_sec_rbcontig.pl <rbasmed file>
```

## rainbow_select_best_rbcontig

### Tool Description
Usage: /usr/local/bin/select_best_rbcontig.pl <rbasmed file>

### Metadata
- **Docker Image**: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
- **Homepage**: https://sourceforge.net/projects/bio-rainbow/
- **Package**: https://anaconda.org/channels/bioconda/packages/rainbow/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/select_best_rbcontig.pl <rbasmed file>
```

## rainbow_select_best_rbcontig_plus_read1

### Tool Description
Usage: /usr/local/bin/select_best_rbcontig_plus_read1.pl <rbasmed file> <rbdiv output file>

### Metadata
- **Docker Image**: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
- **Homepage**: https://sourceforge.net/projects/bio-rainbow/
- **Package**: https://anaconda.org/channels/bioconda/packages/rainbow/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/select_best_rbcontig_plus_read1.pl <rbasmed file> <rbdiv output file>
```

## Metadata
- **Skill**: generated
