# biotradis CWL Generation Report

## biotradis

### Tool Description
The provided text is an error log indicating that the 'biotradis' executable was not found in the environment. No help text or usage information was available to parse arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/biotradis:1.4.5--0
- **Homepage**: https://github.com/sanger-pathogens/Bio-Tradis
- **Package**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Total Downloads**: 16.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/Bio-Tradis
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/07 01:18:53  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "biotradis": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## biotradis_bacteria_tradis

### Tool Description
Run a TraDIS analysis. This involves filtering data with tags, removing tags, mapping, creating an insertion site plot, and creating a stats summary.

### Metadata
- **Docker Image**: quay.io/biocontainers/biotradis:1.4.5--0
- **Homepage**: https://github.com/sanger-pathogens/Bio-Tradis
- **Package**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Validation**: PASS
### Original Help Text
```text
Run a TraDIS analysis. This involves:
1: filtering the data with tags matching that passed via -t option
2: removing the tags from the sequences
3: mapping
4: creating an insertion site plot
5: creating a stats summary

Usage: bacteria_tradis [options]

Options:
-f        : text file listing fastq files with tradis tags attached
-t        : tag to search for (optional.  If not set runs bwa in tagless mode with no filtering.)
-r        : reference genome in fasta format (.fa)
-td       : tag direction - 3 or 5 (optional. default = 3)
-mm       : number of mismatches allowed when matching tag (optional. default = 0)
-m        : mapping quality cutoff score (optional. default = 30)
-k        : custom k-mer value (min seed length) (optional)
--smalt   : use smalt rather than bwa as the mapper
--smalt_k : custom k-mer value for SMALT mapping (optional)
--smalt_s : custom step size for SMALT mapping (optional)
--smalt_y : custom y parameter for SMALT (optional. default = 0.96)
--smalt_r : custom r parameter for SMALT (optional. default = -1)
-n        : number of threads to use for SMALT and samtools sort (optional. default = 1)
-e        : set defaults for essentiality experiment (smalt_r = 0, -m = 0)
-v        : verbose debugging output
```

## biotradis_check_tradis_tags

### Tool Description
Check for the existence of tradis tags in a bam

### Metadata
- **Docker Image**: quay.io/biocontainers/biotradis:1.4.5--0
- **Homepage**: https://github.com/sanger-pathogens/Bio-Tradis
- **Package**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Validation**: PASS
### Original Help Text
```text
Check for the existence of tradis tags in a bam

Usage: check_tags -b file.bam

Options:
-b  : bam file with tradis tags
```

## biotradis_filter_tradis_tags

### Tool Description
Filters a BAM file and outputs reads with tag matching -t option

### Metadata
- **Docker Image**: quay.io/biocontainers/biotradis:1.4.5--0
- **Homepage**: https://github.com/sanger-pathogens/Bio-Tradis
- **Package**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Validation**: PASS
### Original Help Text
```text
Filters a BAM file and outputs reads with tag matching -t option

Usage: filter_tags -b file.bam -t tag [options]

Options:
-f  : fastq file with tradis tags attached
-t  : tag to search for
-m  : number of mismatches to allow when matching tag (optional. default = 0)
-o  : output file name (optional. default: <file>.tag.fastq)
```

## biotradis_remove_tradis_tags

### Tool Description
Removes transposon sequence and quality tags from the read strings

### Metadata
- **Docker Image**: quay.io/biocontainers/biotradis:1.4.5--0
- **Homepage**: https://github.com/sanger-pathogens/Bio-Tradis
- **Package**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Validation**: PASS
### Original Help Text
```text
Removes transposon sequence and quality tags from the read strings

Usage: remove_tags -f file.fastq [options]

Options:
-f  : fastq file with tradis tags
-t  : tag to remove
-m  : number of mismatches to allow when matching tag (optional. default = 0)
-o  : output file name (optional. default: <file>.rmtag.fastq)
```

## biotradis_tradis_plot

### Tool Description
Create insertion site plot for Artemis

### Metadata
- **Docker Image**: quay.io/biocontainers/biotradis:1.4.5--0
- **Homepage**: https://github.com/sanger-pathogens/Bio-Tradis
- **Package**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Validation**: PASS
### Original Help Text
```text
Create insertion site plot for Artemis

Usage: tradis_plot -f file.bam [options]

Options:
-f  : mapped, sorted bam file
-m	: mapping quality must be greater than X (optional. default: 30)
-o  : output base name for plot (optional. default: tradis.plot)
```

## biotradis_tradis_gene_insert_sites

### Tool Description
A tool for analyzing TraDIS gene insertion sites. Note: The provided help text contains execution errors and does not list specific arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/biotradis:1.4.5--0
- **Homepage**: https://github.com/sanger-pathogens/Bio-Tradis
- **Package**: https://anaconda.org/channels/bioconda/packages/biotradis/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
Can't locate Bio/SeqIO.pm in @INC (you may need to install the Bio::SeqIO module) (@INC contains: /usr/local/lib/site_perl/5.26.2/x86_64-linux-thread-multi /usr/local/lib/site_perl/5.26.2 /usr/local/lib/5.26.2/x86_64-linux-thread-multi /usr/local/lib/5.26.2 .) at /usr/local/bin/tradis_gene_insert_sites line 35.
BEGIN failed--compilation aborted at /usr/local/bin/tradis_gene_insert_sites line 35.
```

