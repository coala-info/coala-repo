# mitobim CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mitobim_MITObim.pl | PASS | matched Galaxy test 3 output (reverse complement of ex3.fasta); output identical |
| mitobim_circules.py | PASS | synthetic data: real mitogenome with its first 300 bp appended; roll mode checked on the real genome |
| mitobim_downsample.py | PASS |  |
| mitobim_interleave-fastqgz-MITOBIM.py | PASS |  |

## mitobim_MITObim.pl

### Tool Description
MITObim - mitochondrial baiting and iterative mapping

### Metadata
- **Docker Image**: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
- **Homepage**: https://github.com/chrishah/MITObim
- **Package**: https://anaconda.org/channels/bioconda/packages/mitobim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mitobim/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrishah/MITObim
- **Stars**: N/A
### Original Help Text
```text
MITObim - mitochondrial baiting and iterative mapping
version 1.9.1
author: Christoph Hahn, (c) 2012-2018

usage: ./MITObim.pl <parameters>
	 	
parameters:
		-start <int>		iteration to start with (default=0, when using '-quick' reference)
		-end <int>		iteration to end with (default=startiteration, i.e. if not specified otherwise stop after 1 iteration)
		-sample <string>	sampleID (please don't use '.' in the sampleID). If resuming, the sampleID needs to be identical to that of the previous iteration / MIRA assembly.
		-ref <string>		referenceID. If resuming, use the same as in previous iteration/initial MIRA assembly.
		-readpool <FILE>	readpool in fastq format (*.gz is also allowed). read pairs need to be interleaved for full functionality of the '-pair' option below.
                -quick <FILE>           reference sequence to be used as bait in fasta format
                -maf <FILE>             extracts reference from maf file created by previous MITObim iteration/MIRA assembly (resume)
		
optional:
		--kbait <int>		set kmer for baiting stringency (default: 31)
		--platform		specify sequencing platform (default: 'solexa'; other options: 'iontor', '454', 'pacbio')
		--denovo		runs MIRA in denovo mode
		--pair			extend readpool to contain full read pairs, even if only one member was baited (relies on /1 and /2 header convention for read pairs) (default: no).
		--verbose		show detailed output of MIRA modules (default: no)
		--split			split reference at positions with more than 5N (default: no)
		--help			shows this helpful information
		--clean                 retain only the last 2 iteration directories (default: no)
		--trimreads		trim data (default: no; we recommend to trim beforehand and feed MITObim with pre trimmed data)
		--trimoverhang		trim overhang up- and downstream of reference, i.e. don't extend the bait, just re-assemble (default: no)
		--mismatch <int>	number of allowed mismatches in mapping - only for illumina data (default: 15% of avg. read length)
		--min_cov <int>		minimum average coverage of contigs to be retained (default: 0 - off)
		--min_len <int>		minimum length of contig to be retained as backbone (default: 0 - off)
		--mirapath <string>     full path to MIRA binaries (only needed if MIRA is not in PATH)
		--redirect_tmp		redirect temporary output to this location (useful in case you are running MITObim on an NFS mount)
		--NFS_warn_only		allow MIRA to run on NFS mount without aborting -  warn only (expert option - see MIRA documentation 'check_nfs')
		--version		display MITObim version
		
examples:
		./MITObim.pl -start 1 -end 5 -sample StrainX -ref reference-mt -readpool illumina_readpool.fastq -maf initial_assembly.maf
		./MITObim.pl -end 10 -quick reference.fasta -sample StrainY -ref reference-mt -readpool illumina_readpool.fastq



You need to specify a bait, either a maf file from a previous assembly (use '-maf'), or a fasta file (use '--quick')
```

## mitobim_circules.py

### Tool Description
Checks for circularity in a nucleotide sequence, clips the circular part and rolls it to a new start.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
- **Homepage**: https://github.com/chrishah/MITObim
- **Package**: https://anaconda.org/channels/bioconda/packages/mitobim/overview
- **Validation**: PASS

### Original Help Text
```text
[help] circules.py: ok via circules.py --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: circules.py [-h] [-f <FILE>] [-k KMER] [-s KMER_STEP] [-p <STR>]
                   [-c <INT,INT>] [-l <INT>]
                   [--length_tolerance_percent <FLOAT>]
                   [--length_tolerance_absolute <INT>] [-n <INT>] [--version]

circules - checks for circularity in nucleotide sequences
version: v.0.5

# Disclaimer: #
The script is currently in the beta phase. Any feedback is much appreciated.

optional arguments:
  -h, --help            show this help message and exit
  -f <FILE>, --fasta <FILE>
                        fasta file containing the sequence to be evaluate.
  -k KMER, --kmer KMER  kmer size. single number (default = 31) or range (e.g.
                        31-35).
  -s KMER_STEP, --kmer_step KMER_STEP
                        kmer step size (default = 2).
  -p <STR>, --prefix <STR>
                        prefix for output files (default = 'circular').
  -c <INT,INT>, --extract_by_coordinates <INT,INT>
                        Coordinates for clipping of sequence in format
                        'startpos,endpos'. Clipped sequence will be written to
                        file 'prefix.circular.fasta'.
  -l <INT>, --extract_by_length <INT>
                        expected length (in bp) of circular molecule. If a
                        candidate of length expected (+-length tolerance if
                        specified) is found, sequence will be clipped and
                        written to file 'prefix.circular.fasta'.
  --length_tolerance_percent <FLOAT>
                        percent length tolerance (e.g. 0.1, for 10 %).
                        Candidate fragments must have a length of 'expected
                        length +/- t * expected length'. Default = 0.
  --length_tolerance_absolute <INT>
                        absolute length tolerance (e.g. 1000). Candidate
                        fragments must have a length of 'expected length +/-
                        tolerance'. Default = 0.
  -n <INT>, --newstart_roll <INT>
                        'roll' a putative ciruclar sequence to a specified new
                        start point. Sequence will be written to file
                        'prefix.roll.{n}.fasta'.
  --version             show program's version number and exit

   examples: 
	# check for circularity using a k-mer length of 31 - returns suggestion(s) for clipping points in putative circular sequences.
	circules.py -f test.fasta -k 31
	
	# check for circularity using k-mer lengths 31-51, stepsize 2bp - returns suggestion(s) for clipping points in putative circular sequences.
	circules.py -f test.fasta -k 31-51 -s 2
	
	# check for circularity using a k-mer length of 31. If length of suggested circular sequence is within +/- 1 percent of the expected length (15000 bp)
	# the clipped sequence will be written to a file called 'mytest.circular.fasta'. In addition a file 'mytest.for-testing.fasta' will be written. It contains
	# a 1000 bp sequence obtained by joining the first/last 500 bp of the proposed clipped circular sequence for additional evaluation if required.
	circules.py -f test.fasta -k 31 -l 15000 -p mytest

	# check for circularity using a k-mer length of 41. Extract if candidate is found in length range 9000 - 11000.
	circules.py -f test.fasta -k 41 -k 10000 --length_tolerance_percent 10 

	# clip sequence at specific clip points
	circules.py -f test.fasta -c 32,15430
	
	# roll circular sequence to new startposition, e.g. 46
	circules.py -f test.fasta -n 46
```

## mitobim_downsample.py

### Tool Description
Randomly subsamples reads from FASTQ files to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
- **Homepage**: https://github.com/chrishah/MITObim
- **Package**: https://anaconda.org/channels/bioconda/packages/mitobim/overview
- **Validation**: PASS

### Original Help Text
```text
[help] downsample.py: ok via downsample.py --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: downsample.py [-h] [-r <FILE>] [-s <INT>] [--interleave] [--seed <INT>]
                     [--version]

        downsample.py - version: v.0.1
        
        

optional arguments:
  -h, --help            show this help message and exit
  -r <FILE>, --reads <FILE>
                        Readfile (flag can be used repeatadly to process
                        several files
  -s <INT>, --sample <INT>
                        Desired size of subsample in percent (1-100; default =
                        50)
  --interleave          Optional. In case of two input files, data will be
                        interleaved from these in the output. Otherwise data
                        will be treated as already interleaved.
  --seed <INT>          Optional. Seed for random number generator
  --version             show program's version number and exit

   examples: 
        # sample ~20 % of reads from three files
        downsample.py -s 20 -r test.fastq.gz -r test2.fastq -r test3.fastq.gz
        
        # sample ~30 % of reads from two files, and interleave reads in output
        downsample.py -s 30 --interleave -r test_R1.fastq.gz -r test_R2.fastq.gz

	# sample ~40 % of reads from three files, defining a seed for the random number generator, to allow replication of the process.
	downsample.py -s 20 --rand -421039 -r test.fastq.gz -r test2.fastq -r test3.fastq.gz > test.subsample_40.fastq

	# sample ~20 % of reads from two files, compressing results on the fly.
	downsample.py -s 20 -r test.fastq.gz -r test2.fastq | gzip > test.subsample_20.fastq.gz

	#sample ~5% of reads from a single file that contains interleaved read data
	downsample.py -s 5 --interleave -r test.interleaved.fastq.gz | gzip > test.interleaved.subsample_5.fastq.gz
```

## mitobim_interleave-fastqgz-MITOBIM.py

### Tool Description
Interleaves two FASTQ or FASTQ.gz files for MITObim.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
- **Homepage**: https://github.com/chrishah/MITObim
- **Package**: https://anaconda.org/channels/bioconda/packages/mitobim/overview
- **Validation**: PASS

### Original Help Text
```text
[help] interleave-fastqgz-MITOBIM.py: ok via interleave-fastqgz-MITOBIM.py --help (--help=usage_only, -h=usage_only, -help=usage_only, (no args)=usage_only)
This script takes two fastq or fastq.gz files and interleaves them
Usage:
    interleave-fasta fasta_file1 fasta_file2
```
