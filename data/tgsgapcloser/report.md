# tgsgapcloser CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tgsgapcloser | PASS |  |
| tgsgapcloser_tgsgapcandidate | PASS |  |
| tgsgapcloser_tgsseqgen | PASS |  |
| tgsgapcloser_tgsseqsplit | PASS |  |

## tgsgapcloser

### Tool Description
TGS-GapCloser is a tool designed to use long reads (PacBio or Nanopore) to close gaps in draft assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
- **Homepage**: https://github.com/BGI-Qingdao/TGS-GapCloser
- **Package**: https://anaconda.org/channels/bioconda/packages/tgsgapcloser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tgsgapcloser/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BGI-Qingdao/TGS-GapCloser
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```


## tgsgapcloser_tgsgapcandidate

### Tool Description
Choose candidate gap-filling sequences from long reads aligned to contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
- **Homepage**: https://github.com/BGI-Qingdao/TGS-GapCloser
- **Package**: https://anaconda.org/channels/bioconda/packages/tgsgapcloser/overview
- **Validation**: PASS

### Original Help Text
```text
Usage : tgsgapcandidate args 
		--contig2ont_paf	[required]	[ string arg ]	the paf file that map contig into ont reads.
		--ont_reads_q	[optional]	[ string arg ]	the ont reads in fastq format.	 [ default=  ]
		--ont_reads_a	[optional]	[ string arg ]	the ont reads in fasta format.	 [ default=  ]
		--max_hang	[optional]	[ int arg ]	max hang for ont	 [ default= 2000 ]
		--factor_a	[optional]	[ float arg ]	factor_a for ont aligned factor	 [ default= 1 ]
		--factor_b	[optional]	[ float arg ]	factor_b for ont idy factor	 [ default= 6 ]
		--min_match	[optional]	[ int arg ]	min match for ont	 [ default= 0 ]
		--min_nread	[optional]	[ int arg ]	min read to cross the gap	 [ default= 1 ]
		--max_nread	[optional]	[ int arg ]	max read to cross the gap	 [ default= -1 ]
		--min_idy	[optional]	[ float arg ]	min idy for ont	 [ default= 0 ]
		--candidate_merge	[optional]	[ no arg ]	merge cadidates from same reads with overlaps 	 [ default= 0 ]
		--candidate_shake_filter	[optional]	[ no arg ]	filter cadidates that overlaps with others	 [ default= 0 ]
		--candidate_shake_factor	[optional]	[ float arg ]	factor to detect a overlaps	 [ default= 0.7 ]
		--candidate_max	[optional]	[ int arg ]	max number of candidates that 1 reads can provide for 1 gap , -1 means all	 [ default= -1 ]
```

## tgsgapcloser_tgsseqgen

### Tool Description
Generate the final scaffold sequences from the updated scaffold infos.

### Metadata
- **Docker Image**: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
- **Homepage**: https://github.com/BGI-Qingdao/TGS-GapCloser
- **Package**: https://anaconda.org/channels/bioconda/packages/tgsgapcloser/overview
- **Validation**: PASS

### Original Help Text
```text
Usage : tgsseqgen args 
		--prefix	[required]	[ string arg ]	prefix of files.
                                            Input
                                                    xxx.contig
                                                    xxx.updated_scaff_infos
                                                    xxx.name_map
                                            Output
                                                    xxx.scaff_seqs
                                                    xxx.fill_detail
```

## tgsgapcloser_tgsseqsplit

### Tool Description
Split scaffolds into contigs at gaps.

### Metadata
- **Docker Image**: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
- **Homepage**: https://github.com/BGI-Qingdao/TGS-GapCloser
- **Package**: https://anaconda.org/channels/bioconda/packages/tgsgapcloser/overview
- **Validation**: PASS

### Original Help Text
```text
Usage : tgsseqsplit args 
		--input_scaff	[required]	[ string arg ]	 the input scaffold fasta file
		--prefix	[required]	[ string arg ]	 the prefix of output files , will output :
                                prefix.contig
                                prefix.orignial_scaff_infos
                                prefix.name_map
```

## Metadata
- **Skill**: generated
