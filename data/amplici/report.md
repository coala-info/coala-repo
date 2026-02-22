# amplici CWL Generation Report

## amplici_run_AmpliCI

### Tool Description
Cluster amplicon sequences in a fastq file with or without UMIs.

### Metadata
- **Docker Image**: quay.io/biocontainers/amplici:2.2--h2555670_1
- **Homepage**: https://github.com/DormanLab/AmpliCI
- **Package**: https://anaconda.org/channels/bioconda/packages/amplici/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amplici/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DormanLab/AmpliCI
- **Stars**: 24
### Original Help Text
```text
INFO:    Using cached SIF image
RUN_AMPLICI(v2.2)

NAME
	run_AmpliCI - Amplicon Clustering Inference

SYNOPSIS
	run_AmpliCI [COMMAND] [-h | --help] [OPTIONS]

DESCRIPTION
	Cluster amplicon sequences in a fastq file with or without UMIs.

	WITHOUT UMIS (command cluster)

	Cluster amplicon sequences without UMIs in two steps.

	Step 1:  Estimate error profile from input fastq file <fstr> and
		write to file <ostr>.

		Example:

		run_ampliCI error --fastq <fstr> --outfile <ostr>

	Step 2:  Cluster amplicon sequences in fastq file <fstr> with
		estimated error profile from file <pstr>, using lower bound
		<adbl>, and output results in file <ostr>.

		Example:

		run_ampliCI cluster --profile <pstr> --abundance <adbl> \
			--fastq <fstr> --outfile <ostr>

	By default, run_AmpliCI cluster will automatically select K true
	haplotypes with estimated scaled true abundance greater than or equal
	to <adbl> using an alignment-free strategy. A diagnostic test is used
	to screen false positives with provided threshold.  The default
	diagnostic test threshold is quite liberal.  Reads with large enough
	log likelihood (see --log_likelihood) under the current model are
	assigned to clusters.

	WITH UMIS (command daumi)

	Cluster amplicon sequences with UMIs in three steps. The input is a
	FASTQ file <fastq_file> with <umi_length> UMI at 5' end. For more
	information on preparing the input files for these steps, see DAUMI
	instructions on Github: https://github.com/DormanLab/AmpliCI/blob/master/daumi.md

	Step 1:  Write candidate set of true UMIs to <umi_base>.fa FASTA file
		given FASTQ input file <fastq_umi_file> with UMIs only.

		Example:

		run_AmpliCI cluster --umi --fastq <fastq_umi_file> \
			--outfile <umi_base>

	Step 2:  Write candidate set of true haplotypes to FASTA file
		<haplotype_file> given FASTQ input file <fastq_file>. It
		also requires as input the FASTQ input file <fastq_trim_file>
		without the UMIs of length <umi_length>.

		Example:

		run_AmpliCI error --fastq <fastq_trim_file> \
			--outfile <error_file> --partition <partition_file>
		run_AmpliCI cluster --fastq <fastq_file> --trim <umi_length> \
			--outfile <haplotype_base> --profile <error_file>
		cat <haplotype_base>.fa | seqkit subseq -r <start>:<end> | \
			seqkit rmdup -s | seqkit seq -w 0 > <haplotype_file>

	Step 3:  Cluster amplicon reads in FASTQ input file <fastq_file> with
		candidate UMIs of length <umi_base> in <umi_base>.fa, candidate
		haplotypes in <haplotype_file>, and error profile in
		 <error_file>,all three files obtained from previous steps.

		Example:

		run_AmpliCI daumi --fastq <fastq_file> --umilen <umi_length> \
			--umifile <umi_base>.fa --haplotype <haplotype_file> \
			--outfile <outfile_base> --profile <error_file> \
			--rho <rho>

These are the available commands:
	cluster		Cluster amplicons without UMI information.
	daumi		Cluster amplicons with UMI information.
	error		Estimate an error profile.
	assignment	Assign reads to previously inferred haplotypes.
	histogram	Output observed abundance histogram.

run_AmpliCI COMMAND --help for more information about each command.

GENERAL OPTIONS
	--verbose INT
		Verbosity level; set to 8+ for debugging.  [DEFAULT: 1]
	--help, -h
		This help.

RUN_AMPLICI(1)
```

