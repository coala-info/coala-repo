# hg-color CWL Generation Report

## hg-color_HG-CoLoR

### Tool Description
Corrects, trims, and splits long reads using short reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/hg-color:1.1.1--he1b5a44_0
- **Homepage**: https://github.com/pierre-morisse/HG-CoLoR
- **Package**: https://anaconda.org/channels/bioconda/packages/hg-color/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hg-color/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pierre-morisse/HG-CoLoR
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/HG-CoLoR [options] --longreads LR.fasta --shortreads SR.fastq --out resultPrefix -K maxK

Note: HG-CoLoR default parameters are adapted for a 50x coverage set of short reads with a 1% error rate.
Please modify the parameters, in particular the --solid and --bestn ones, as indicated below
if using a set of short reads with a much higher coverage and/or a highly different error rate.

	Input:
	LR.fasta:                      fasta file of long reads, one sequence per line.
	SR.fastq:                      fastq file of short reads.
	                               Warning: only one file must be provided.
	                               If using paired reads, please concatenate them into one single file.
	resultPrefix:                  Prefix of the fasta files where to output the corrected, trim and split long reads.
	maxK:                          Maximum K-mer size of the variable-order de Bruijn graph.

	Options:
	--minorder INT, -k INT:        Minimum k-mer size of the variable-order de Bruijn graph (default: K/2).
	--solid INT, -S INT:           Minimum number of occurrences to consider a short read k-mer as solid, after correction (default: 1).
	                               This parameter should be carefully raised accordingly to the short reads coverage and accuracy,
	                               and to the chosen maximum order of the graph.
                                 It should only be increased when using high coverage of short reads, or a small maximum order.
	--seedsoverlap INT, -o INT:    Minimum overlap length to allow the merging of two overlapping seeds (default: K - 1).
  --seedsdistance INT, -d INT:   Maximum distance to consider two consecutive seeds for merging (default: 10).
	--branches INT, -b INT:        Maximum number of branches exploration (default: 1,250).
	                               Raising this parameter will result in less split corrected long reads.
	                               However, it will also increase the runtime, and may create chimeric linkings between the seeds.
	--seedskips INT, -s INT:       Maximum number of seed skips (default: 3).
	--mismatches INT, -m INT:      Allowed mismatches when attempting to link two seeds together (default: 3).
	--bestn INT, -n INT:           Top alignments to be reported by BLASR (default: 50).
	                               This parameter should be raised accordingly to the short reads coverage.
	                               Its default value is adapted for a 50x coverage of short reads.
                                 It should be decreased with higher coverage, and increased with lower coverage.
	--nproc INT, -j INT:           Number of processes to run in parallel (default: number of cores).
	--tmpdir STRING, -t STRING:    Path where to store the directory containing temporary files (default: working directory).
	--kmcmem INT, -r INT:          Maximum amount of RAM for KMC, in GB (default: 12).
	--help, -h:                    Print this help message.
```

