# hlaprofiler CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hlaprofiler_build | Failed | tool bug: HLAProfiler.pl passes an extra argument to createDistractome and stops with Can't use string as a symbol ref (line 902) |
| hlaprofiler_build_taxonomy | Failed | tool bug: same createDistractome crash as the build module (line 902) |
| hlaprofiler_count_reads | PASS |  |
| hlaprofiler_create_profiles | Failed | tool bug: DetermineProfile.pm cannot load /modules/SequenceFunctions.pm (scripts_dir unset), so no profile is written |
| hlaprofiler_create_taxonomy | PASS | output files are identical to the expected outputs of the HLAProfiler tests |
| hlaprofiler_filter | PASS |  |
| hlaprofiler_predict | PASS | used the prebuilt database from the HLAProfiler test data; calls the expected HLA-A alleles |
| hlaprofiler_predict_only | PASS | expected HLA-A alleles called from the filtered and counted reads |

## hlaprofiler_build

### Tool Description
HLAProfiler build module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl build

DESCRIPTION
A tool for building the HLAProfiler reference from a fasta file containing the HLA reference and a fasta file containing GENCODE transcripts.

USAGE:
perl HLAProfiler.pl build <options>

Required Options:
-transcripts|t		location of fasta file containing transcripts. Currently only GENCODE transcripts are supported.(required)
-transcript_gtf|g	location of gtf file containing transcripts corresponding to the -transcripts option. Currently only GENCODE transcripts are supported.(required)
-exclusion_bed|e	location of bed file containing the coordinated any regions to be excluded from the distractome. i.e. HLA region.(required)
-reference|r		location of fasta file containing HLA reference. IPD-IMGT/HLA reference recommended.(required)
-cwd			File containing the names of common and well-documented alleles. This file can be blank but must be specified.(required)

Output Options:
-output_dir|o		location of output directory(default:".")
-database_name|db	name of the HLA database to be created(default:hla)
-kraken_path|kp	base directory of kraken installation. (default:base directory of path returned by `which kraken`)

HLA database creation
-k_mer|k		size of the k-mer used to create database.(default:31)
-minimizer|mi		size of the k-mer minimizer used to crate database.(default:13)

K-mer profile creation
-num_reads|nr		number of reads to simulated per reference allele for k-mer profile creations.(default:500000)
-read_length|rl		length of reads simulated for k-mer profile. Same as the length of the k-mers in the profile.(default:50)
-max_insert|m		maximum size of insert (default:1000)
-scale|sc		scale of pareto distribution to determine insert size (default:80)
-shape|sh		shape of pareto distribution to determine insert size (default:0.7)
-seed|sd		seed of random number generator for simulation (default:1234)
-filter_reads|f		toggle whether or not to filter reads using in the HLA database when building the k-mer profile.It is STRONGLY recommended to use the default for this setting. Possibile values 0 or 1. (default:1)
-intermediate_files|if	toggles flag to keep intermediate files (default:off)

General options:
-threads|c	number of threads to uses for processing.(default:1)
-help|h		prints this help prompt

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

## hlaprofiler_predict

### Tool Description
HLAProfiler predict module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl predict

DESCRIPTION
A tool for predicting the HLA type of Paired-end NGS data.

USAGE:
perl HLAProfiler.pl predict <options>

Required Options:
-fastq1|fq1		location of read1 fastq (required)
-fastq2|fq2		location of read2 fastq (required)
-database_name|db	name of HLA database (required)
-directory_dir|dd	name of parent directory of database (required)
-reference|r	reference fa used to create the database (required)

Allele Refinement Options:
-allele_refinement|ar	Specifies the level to which the predicted alleles are to be refined based on the observed reads (default:all)
     Possible values:
	refine_only	Refines the allelle call by looking predicting the true allele sequence using observed reads and looking for a better match in the reference
	predict_only	Reports if the observe reads support a novel allele sequence not found in the reference
	refineAndPredict	Refines the allele call (-refine_only) and report novel alleles (-novel_only)
	all		Refines the allele call (-refine_only) and report novel alleles (-novel_only), creates a profile for the refined/novel allele sequence and calculates prediction metrics.
	none		Turns off refinement and novel allele prediction.

-num_reads|nr		number of reads to simulated per reference allele for k-mer profile creations.(default:500000)
-read_length|rl		length of reads simulated for k-mer profile. Same as the length of the k-mers in the profile.(default:50)
-max_insert|m		maximum size of insert (default:1000)
-scale|sc		scale of pareto distribution to determine insert size (default:80)
-shape|sh		shape of pareto distribution to determine insert size (default:0.7)
-seed|sd		seed of random number generator for simulation (default:1234)

General Options:
-intermediate_files|if	toggles flag to keep intermediate files (default:off)
-minimum_reads|min	minimum number of reads from a gene before attempting to call HLA types.(default:100)
-threads|c		number of threads (default:1)
-output_dir|od		output directory (default:" .")
-kraken_path|kp		base directory of kraken installation. (default:base directory of path returned by `which kraken`)
-log|l			name of the prediction log file
-help|h			prints this help prompt

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

## hlaprofiler_create_taxonomy

### Tool Description
HLAProfiler create_taxonomy module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl create_taxonomy

DESCRIPTION
A tool for creating a kraken-compatable taxonomy for HLA alleles from a reference fasta.

USAGE:
perl HLAProfiler.pl create_taxonomy <options>

Required Options
-reference|r	HLA reference fasta (required)
-cwd		File containing the names of common and well-documented alleles. This file can be blank but must be specified.(required)

Options:
-output_dir|od	parent directory of taxonomy (default:".")
-help|h	i	prints this help prompt
-log|l		name of the prediction log file

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

## hlaprofiler_build_taxonomy

### Tool Description
HLAProfiler build_taxonomy module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl build_taxonomy

DESCRIPTION
A tool for building an HLA database using a reference and custom taxonomy

USAGE: HLAProfiler.pl build_taxonomy <options>

Required Options:
-transcripts|t		location of fasta file containing transcripts. Currently only GENCODE transcripts are supported.(required)
-transcript_gtf|g	location of gtf file containing transcripts corresponding to the -transcripts option. Currently only GENCODE transcripts are supported.(required)
-exclusion_bed|e	location of bed file containing the coordinated any regions to be excluded from the distractome. i.e. HLA region.(required)
-reference|r		location of fasta file containing HLA reference. IPD-IMGT/HLA reference recommended.(required)

Output Options:
-output_dir|o		location of database directory(default:".")
-database_name|db	name of the HLA database to be created(default:hla)
-kraken_path|kp		base directory of kraken installation. (default:base directory of path returned by `which kraken`)

HLA database creation
-k_mer|k		size of the k-mer used to create database.(default:31)
-minimizer|m		size of the k-mer minimizer used to crate database.(default:13)

General options:
-threads|c		number of threads to uses for processing.(default:1)
-help|h			prints this help prompt

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

## hlaprofiler_create_profiles

### Tool Description
HLAProfiler create_profiles module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl create_profiles

DESCRIPTION
A tool for creating a k-mer profile to used with HLAProfile.pl predict

USAGE:
perl HLAProfiler.pl create_profile <options>

Required Options:
-reference|r	location of HLA reference fasta file.(required)

Output Options:
-output_dir|o		location of output directory(default:".")
-database_dir|dd	location of database parent directory(default:".")
-database_name|db	name of the HLA database to be created(default:hla)
-kraken_path|kp		base directory of kraken installation. (default:base directory of path returned by `which kraken`)

K-mer profile creation
-num_reads|nr		number of reads to simulated per reference allele for k-mer profile creations.(default:500000)
-read_length|rl		length of reads simulated for k-mer profile. Same as the length of the k-mers in the profile.(default:50)
-filter_reads|f		toggle whether or not to filter reads using in the HLA database when building the k-mer profile.It is STRONGLY recommended to use the default for this setting. Possibile values 0 or 1. (default:1)
-intermediate_files|if	toggles flag to keep intermediate files (default:off)
-max_insert|mi		maximum size of insert (default:1000)
-scale|sc		scale of pareto distribution to determine insert size (default:80)
-shape|sh		shape of pareto distribution to determine insert size (default:0.7)
-seed			seed of random number generator for simulation (default:1234)

General options:
-threads|c		number of threads to uses for processing.(default:1)
-help|h			prints this help prompt

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

## hlaprofiler_filter

### Tool Description
HLAProfiler filter module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl filter

DESCRIPTION
A tool for filter paired fastq reads using a HLA database

USAGE:
perl HLAProfiler.pl filter <options>

Required Options:
-fastq1|fq1		read1 fastq.(required)
-fastq2|fq2		read2 fastq.(required)

Output Options:
-output_dir|od		location of output directory. (default:".")
-database_dir|dd	location of database directory(default:".")
-database_name|db	name of the HLA database to be created(default:hla)
-kraken_path|kp		base directory of kraken installation. (default:base directory of path returned by `which kraken`)

General options:
-threads|c		number of threads to uses for processing.(default:1)
-help|h			prints this help prompt

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

## hlaprofiler_count_reads

### Tool Description
HLAProfiler count_reads module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl count_reads

DESCRIPTION
A tool for counting reads in fastq files for a sample in a directory.

USAGE:
perl HLAProfiler.pl count_reads <options>

Required Options:
-reads_directory	location of directory containing filtered read fastqs. Please make sure to filter files using HLAProfiler.pl filter before counting (required)
-sample_name|sn		name of the sample. This must perfect match the prefix of each of the read count files. i.e. The sample name for file NA12878.200.B_1.uniq.cnt would be NA12878.200 (required)
-output_directory|od	location of directory containing filtered read fastqs. Please make sure to filter files using HLAProfiler.pl filter before counting (default:-reads_directory)

General options:
-threads|c		number of threads to uses for processing.(default:1)
-help|h			prints this help prompt

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

## hlaprofiler_predict_only

### Tool Description
HLAProfiler predict_only module.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

### Original Help Text
```text

HLAProfiler.pl predict_only

DESCRIPTION
A tool for predicting the HLA type of Paired-end NGS data from paired fastqs or read count files.

USAGE:
perl HLAProfiler.pl predict <options>

Required Options:
-counts_directory|cd		location of directory containing filtered and paired read counts files. To generate these files from fastq files please run HLAProfiler.pl filter followed by HLAProfiler.pl count_reads (required)
-reads_directory|cd		location of directory containing filtered and paired read fastqs.(required)
-profile_directory|sdir		path to directory containing the profile files (required)
-sample_name|sn			name of the sample. This must perfect match the prefix of each of the read count files. i.e. The sample name for file NA12878.200.B_1.uniq.cnt would be NA12878.200 (required)
-reference|r			HLA reference fasta. There must also be an allele map file in the sample directory as the reference fa. (required)

General Options:
-allele_refinement|ar	Specifies the level to which the predicted alleles are to be refined based on the observed reads (default:all)
   Possible values:
	refine_only		Refines the allelle call by looking predicting the true allele sequence using observed reads and looking for a better match in the reference
	predict_only		Reports if the observe reads support a novel allele sequence not found in the reference
	refineAndPredict	Refines the allele call (-refine_only) and report novel alleles (-novel_only)
	all			Refines the allele call (-refine_only) and report novel alleles (-novel_only), creates a profile for the refined/novel allele sequence and calculates prediction metrics.
	none			Turns off refinement and novel allele prediction.
-kraken_db|db		base directory of kraken database.
-kraken_path|kp		base directory of kraken installation. (default:base directory of path returned by `which kraken`)
-minimum_reads|min	minimum number of reads from a gene before attempting to call HLA types.(default:100)
-output_dir|od		output directory(default:'.')
-threads|c		number of threads (default:1)
-help|h			prints this help prompt

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown:chad.brown@q2labsolutions.com

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```
