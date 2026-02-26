# mitobim CWL Generation Report

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

