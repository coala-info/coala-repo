# ska CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ska_align | PASS |  |
| ska_alleles | PASS |  |
| ska_annotate | PASS |  |
| ska_compare | PASS |  |
| ska_distance | PASS |  |
| ska_fasta | PASS |  |
| ska_fastq | PASS |  |
| ska_humanise | PASS |  |
| ska_info | PASS |  |
| ska_map | PASS |  |
| ska_merge | PASS |  |
| ska_summary | PASS |  |
| ska_type | Not completed | no allele fasta files and profile table with a matching split kmer file for typing were available; not run |
| ska_unique | PASS |  |
| ska_weed | PASS |  |

## ska_alleles

### Tool Description
Create a merged split kmer file for all sequences in one or more multifasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska fasta [options] <fasta files>

Options:
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or
		used as an alternative input to the list provided on the
		command line.
-k <int>	Split Kmer size. The kmer used for searches will be twice
		this length, with the variable base in the middle. e.g. a
		kmer of 15 will search for 31 base matches with the middle
		base being allowed to vary. Must be divisible by 3.
		[Default = 15]
```

## ska_type

### Tool Description
Type split kmer files using a set of allele files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska type [options] <locus fasta files>

Options:
-h		Print this help.
-f <file>	File of locus fasta file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-p <file>	tab file containing profile information.
-q <file>	Query split kmer file. This can be a single kmer file.
```

## ska_info

### Tool Description
Print some information about one or more kmer files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska info [options] <split kmer files>

Options:
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-t		Print tabulated output.
```

## ska_humanise

### Tool Description
Print kmers from a split kmer file in human readable format

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska info [options] <split kmer files>

Options:
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-t		Print tabulated output.
```

## ska_compare

### Tool Description
Print comparison statistics for a query split kmer file against a set of subject split kmer files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska compare [options] <subject split kmer files>

Options:
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-q <file>	Query split kmer file.
```

## ska_annotate

### Tool Description
Locate/annotate split kmers in a reference fasta/gff file

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska annotate [options] <kmer files>

Options:
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-i		Include kmers in repetitive reference regions.
-o <file>	Prefix for output files. [Default = annotation]
-p		Include product in output.
-r <file>	Reference fasta/gff file name. [Required]
-v		Only output variant sites.
```

## ska_map

### Tool Description
Align split kmer file(s) against a reference fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska map [options] <split kmer files>

Options:
-a <file>	Map all bases of kmers (Default = just map middle base).
-c		Treat all reference contigs as circular.
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-k <int>	Split Kmer size. The kmer used for searches will be twice 
		this length, with the variable base in the middle. e.g. a 
		kmer of 15 will search for 31 base matches with the middle 
		base being allowed to vary. Must be divisible by 3. 
		Must be the same value used to create the kmer files. 
		[Default = 15]
-i		Include reference sequence in alignment.
-m		Map bases to repeats rather than making them N.
-o <file>	Output file prefix. [Default = mappedkmers]
-r <file>	Reference fasta file name. [Required]
-s <file>	File of sample names to include in the alignment.
-v		Output variant only alignment. [Default = all sites]
```

## ska_distance

### Tool Description
Pairwise distance calculation and clustering from split kmer files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska distance [options] <split kmer files>

Options:
-c 		Do not print clusters files.
-d 		Do not print distances file.
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-i <float>	Identity cutoff for defining clusters. Isolates will be 
		clustered if they share at least this proportion of the 
		split kmers in the file with fewer kmers and pass the SNP 
		cutoff. [Default = 0.9]
-o <file>	Prefix for output files. [Default = distances]
-s <int>	SNP cutoff for defining clusters. Isolates will be clustered 
		if they are separated by fewer than this number of SNPs and 
		pass the identity cutoff. [Default = 20]
-S 		Include singletons in dot file
```

## ska_fasta

### Tool Description
Create a split kmer file from fasta file(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska fasta [options] <fasta files>

Options:
-c		Treat all contigs as circular.
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-k <int>	Split Kmer size. The kmer used for searches will be twice 
		this length, with the variable base in the middle. e.g. a 
		kmer of 15 will search for 31 base matches with the middle 
		base being allowed to vary. Must be divisible by 3. 
		[Default = 15]
-o <file>	Output file prefix. [Default = fasta]
```

## ska_align

### Tool Description
Reference-free alignment from a set of split kmer files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska align [options] <split kmer files>

Options:
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-k		Print aligned split kmers to file.
-o <file>	Prefix for output files. [Default = reference_free]
-p <float>	Minimum proportion of isolates required to possess a split 
		kmer for that kmer to be included in the alignment. 
		[Default = 0.9]
-s <file>	File of sample names to include in the alignment.
-v		Output variant only alignment. [Default = all sites]
```

## ska_fastq

### Tool Description
Create a split kmer file from fastq file(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska fastq [options] <fastq files>

Options:
-h		Print this help.
-a		Print allele frequencies of split kmers to file [Default = false]
-c <int>	Coverage cutoff. Kmers with coverage below this value will 
		be discarded. [Default = 4]
-C <int>	File coverage cutoff. Kmers with coverage below this value 
		in any of the fastq files will be discarded. [Default = 2]
-k <int>	Split Kmer size. The kmer used for searches will be twice 
		this length, with the variable base in the middle. e.g. a 
		kmer of 15 will search for 31 base matches with the middle 
		base being allowed to vary. Must be divisible by 3. 
		[Default = 15]
-m <float>	Minimum allowable minor allele frequency. Kmer alleles below 
		this frequency will be discarded. [Default = 0.2]
-o <file>	Output prefix. [Default = fastq]
-q <int>	Quality filter for fastq files. No kmers will be created 
		from sequence including quality scores below this cutoff. 
		[Default = 20]
```

## ska_unique

### Tool Description
Output kmers unique to a set of split kmer files

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska unique [options]

Options:
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-h		Print this help.
-i <file>	File of ingroup sample names. Unique kmers found 
		in these files will be retained.
-n		Allow Ns as in unique split kmers.
-o <file>	Output file prefix. [Default = unique]
-p <float>	Minimum proportion of ingroup isolates required to possess a 
		split kmer for that kmer to be retained. [Default = 0.9]
```

## ska_summary

### Tool Description
Print split kmer file summary statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska summary [options] <split kmer files>

Options:
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-h		Print this help.
```

## ska_weed

### Tool Description
Weed kmers from a split kmer file

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska weed [options] <split kmer files>

Options:
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-h		Print this help.
-i <file>	Name of kmer file containing kmers to be weeded. [Required]
-m <int>	Minimum number of samples required to possess a split
		kmer for that kmer to be retained. [Default = 0]
-M <int>	Maximum number of samples required to possess a split
		kmer for that kmer to be retained. 0 = No maximum. [Default = 0]
-p <float>	Minimum proportion of samples required to possess a split
		kmer for that kmer to be retained. [Default = 0.0]
-P <float>	Maximum proportion of samples required to possess a split
		kmer for that kmer to be retained. [Default = 1.0]
```

## ska_merge

### Tool Description
Merge split kmer file(s) into one file

### Metadata
- **Docker Image**: quay.io/biocontainers/ska:1.0--h077b44d_7
- **Homepage**: https://github.com/simonrharris/SKA
- **Package**: https://anaconda.org/channels/bioconda/packages/ska/overview
- **Validation**: PASS

### Original Help Text
```text

Usage:
ska merge [options] <subject split kmer files>

Options:
-h		Print this help.
-f <file>	File of split kmer file names. These will be added to or 
		used as an alternative input to the list provided on the 
		command line.
-o <file>	Output file prefix. [Default = merged]
-s <file>	File of sample names to include in the merged file. Can 
		be used to extract samples from a merge
```

