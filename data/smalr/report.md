# smalr CWL Generation Report

## smalr

### Tool Description
This program will take a native aligned_reads.cmph5 and compare each molecule's kinetics profile with a matching WGA aligned_reads.cmp.h5. There are two protocols available for use within the pipeline, SMsn and SMp. The single argument for both protocols is an inputs_file containing paths to the relevant files.

### Metadata
- **Docker Image**: biocontainers/smalr:v1.1dfsg-2-deb_cv1
- **Homepage**: https://github.com/silviazuffi/smalr_online
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smalr/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/silviazuffi/smalr_online
- **Stars**: N/A
### Original Help Text
```text
Usage: smalr [--help] [options] <inputs_file>

		This program will take a native aligned_reads.cmph5 and compare each molecule's
		kinetics profile with a matching WGA aligned_reads.cmp.h5. There are two protocols
		available for use within the pipeline, SMsn and SMp. The single argument for both 
		protocols is an inputs_file containing paths to the relevant files.

		The inputs_file has the following format:
		
		native_cmph5 : /path/to/native/aligned_reads.cmp.h5
		fastq        : /path/to/native/CCS_reads.fastq       (DEPRECATED; specify NONE)
		wga_cmph5    : /path/to/WGA/aligned_reads.cmp.h5     
		ref          : /path/to/sample/reference.fasta

		With the updated support for aligned BAM files (in addition to *.cmp.h5 files), 
		please supply the path to the aligned BAM file using the 'native_cmph5' and 
		'wga_cmph5' lines in the input file.
		

		SMsn: Single-molecule, single nucleotide analysis
		Each motif site on each sequencing molecule is assessed for methylation
		status. This is designed for use with short (~250bp) sequencing library
		preps, where the long read lengths of SMRT reads enables multiple passes
		over each motif site. The reliability of the SMsn scores increases with
		more passes (i.e. higher single-molecule coverage).

		Example usage for SMsn analysis:
		smalr -i --SMsn --motif=GATC --mod_pos=2 --procs=4 -c 5 input.txt


		SMp: Single-molecule, motif-pooled analysis
		All motif sites on a sequencing molecule are pooled together and the
		molecule-wide methylation status for the given motif is assessed. This
		is designed for use with long (10Kb+) sequencing library preps, where each
		single long subread can span many distinct motif sites. The reliability of
		the SMp scores increases with increasing number of distinct motif sites
		contained in the subread.

		Example usage for SMp analysis:
		smalr -i --SMp --motif=GATC --mod_pos=2 --procs=4 -c 5 input.txt
		

Options:
  -h, --help            show this help message and exit
  -d, --debug           Increase verbosity of logging
  -i, --info            Add basic logging
  --logFile=LOGFILE     Write logging to file [log.out]
  --out=OUT             Filename to output SMsn/SMp results [<SMsn/SMp>.out]
  -c NATIVECOVTHRESH, --nativeCovThresh=NATIVECOVTHRESH
                        Per mol/strand coverage threshold below which to
                        ignore molecules [10]
  -m MOTIF, --motif=MOTIF
                        (Required) The sequence motif to be analyzed [None]
  -s MOD_POS, --mod_pos=MOD_POS
                        (Required) The modified position in the motif to be
                        analyzed (e.g. for Gm6ATC, mod_pos=2) [None]
  --wgaCovThresh=WGACOVTHRESH
                        Aggregate WGA coverage threshold below which to skip
                        analysis at that position [10]
  --SMsn                Use short-library, single-nucleotide detection
                        protocol. [False]
  --SMp                 Use long-library epigenetic phasing protocol (pool
                        IPDs from each subread). [False]
  --procs=PROCS         Number of processors to use [4]
  --align               [DEPRECATED; not supported for BAM input] Align native
                        reads to reference to avoid real SNP positions. Only
                        use when expecting sequence heterogeneity in sample
                        (i.e. mtDNA). [False]
  --upstreamSkip=UPSTREAMSKIP
                        Number of bases 5' of a CCS-detected, molecule-level
                        SNP to skip in analysis (only when using --align) [10]
  --downstreamSkip=DOWNSTREAMSKIP
                        Number of bases 3' of a CCS-detected, molecule-level
                        SNP to skip in analysis (only when using --align) [10]
  --minSubreadLen=MINSUBREADLEN
                        Minimum length of a subread to analyze [100]
  --minAcc=MINACC       Minimum accuracy of a subread to analyze [0.8]
  --natProcs=NATPROCS   Number of processors to use for native molecule
                        analysis [same as procs]
  --leftAnchor=LEFTANCHOR
                        Number of left bp to exclude around subread-level
                        alignment errors [1]
  --rightAnchor=RIGHTANCHOR
                        Number of right bp to exclude around subread-level
                        alignment errors [1]
  --write_vars=WRITE_VARS
                        Write mol-specific variant calls to this filename
                        (only when using --align) [None]
  --useZMW              Index molecules using ZMW/movie ID's instead of
                        molecule IDs (if all alignments all have unique
                        molecule IDs) [False]
```

