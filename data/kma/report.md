# kma CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kma | PASS | Galaxy test reads against a kma-built E. coli b0842 DB: b0842_3 at 99.84% identity, depth 30, as expected |
| kma_cmp | PASS | merged DB and full DB compare as matching hashmaps |
| kma_db | PASS | DB statistics list 5 templates and 6240 nucleotides as expected |
| kma_dist | PASS | 5x5 distance matrix for the 5 alleles, plausible values |
| kma_index | PASS | indexed the 5 Galaxy test alleles; mapping on the index gives the expected hit |
| kma_merge | PASS | merging a (2 alleles) and b (3 alleles) gives name and seq files identical to the full DB |
| kma_seq2fasta | PASS | templates 3 and 5 printed from the index match the input FASTA |
| kma_trim | PASS | Galaxy reads trimmed: 544 reads in, 534 out, 5 bases cut from the 5 prime end |
| kma_update | Not completed | needs a database made by KMA 0.14 (only 0.14 to 0.15 conversion exists); none available, current DB gives Conversion error |

## kma

### Tool Description
KMA-1.6.8 maps and/or aligns raw reads to a template database.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Total Downloads**: 254.7K
- **Last updated**: 2025-11-19
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# KMA-1.6.8 maps and/or aligns raw reads to a template database.
#         Options:	Desc:                           	Default:
#
# Input:
#               -i	Single end input(s)             	stdin
#             -ipe	Paired end input(s)             	
#             -int	Interleaved input(s)            	
#
# Output:
#               -o	Output prefix                   	
#              -ef	Output additional features      	False
#             -vcf	Output vcf file, 2 to apply FT  	False
#             -sam	Output sam, 4/2096 for mapped/aligned	False
#              -nc	No consensus file               	False
#              -na	No aln file                     	False
#              -nf	No frag file                    	False
#          -matrix	Output assembly matrix          	False
#               -a	Output all template mappings    	False
#             -and	Use both mrs and p-value on consensus	or
#              -oa	Use neither mrs or p-value on consensus	False
#             -tsv	Tsv flag                        	0
#            -tsvh	Help on -tsv                    	
#
# Consensus:
#        -reassign	Reassign consensus sequences    	False
#              -bc	Minimum support to call bases   	0
#          -bcNano	Altered indel calling for ONT data	False
#             -bcd	Minimum depth to cal bases      	1
#             -bcg	Maintain insignificant gaps     	False
#              -ID	Minimum consensus ID            	1.0%
#              -md	Minimum depth                   	0.0
#           -dense	Skip insertion in consensus     	False
#         -ref_fsa	Use n's on indels               	False
#
# General:
#            -t_db	Template DB                     	
#               -p	P-value                         	0.05
#             -shm	Use DB in shared memory         	0
#            -mmap	Memory map *.comp.b             	False
#             -tmp	Set directory for temporary files	
#              -mf	Max number of fragments to store in memory	1000000
#               -t	Number of threads               	1
#          -status	Extra status                    	False
#         -verbose	Extra verbose                   	False
#               -c	Citation                        	
#               -v	Version                         	
#               -h	Shows this help message         	
#
# Template mapping:
#        -ConClave	ConClave version                	1
#        -mem_mode	Base ConClave on template mappings	False
#           -proxi	Proximity scoring (negative for soft)	False/1.0
#         -ex_mode	Searh kmers exhaustively        	False
#           -deCon	Remove contamination            	False
#          -Sparse	Only count kmers                	False
#              -ss	Sparse sorting (q,c,d,n)        	q
#             -Mt1	Map everything to one template  	False/0
#              -pm	Pairing method (p,u,f)          	u
#             -1t1	One query to one template       	False
#             -hmm	Use a HMM to assign template(s) 	False
#              -ck	Count k-mers over pseudo alignment	False
#       -localopen	Penalty for opening a local chain	6
#             -mct	Max overlap between templates   	0.1
#              -lc	Length corrected template chaining	False
#
# Chaining:
#               -k	K-mersize                       	DB defined
#              -ts	Trim front of seeds             	0
#             -ssa	Seeds soround alignments        	False
#         -ex_mode	Searh kmers exhaustively        	False
#             -fpm	Pairing method (p,u,f)          	u
#              -mq	Minimum mapping quality         	0
#       -localopen	Penalty for local opening       	6
#
# Alignment:
#              -ca	Circular alignments             	False
#             -mrs	Minimum relative alignment score	0.5
#             -mrc	Minimum query coverage          	0.0
#              -ml	Minimum alignment length        	16
#          -reward	Score for match                 	1
#         -penalty	Penalty for mismatch            	2
#         -gapopen	Penalty for gap opening         	3
#       -gapextend	Penalty for gap extension       	1
#             -per	Reward for pairing reads        	7
#        -Npenalty	Penalty matching N              	0
#      -transition	Penalty for transition          	2
#    -transversion	Penalty for transversion        	2
#            -sasm	Skip alignment                  	False
#
# Trimming:
#              -mp	Minimum phred score             	20
#              -mi	Minimum internal phred score    	0
#              -eq	Minimum avg. quality score      	0
#              -5p	Trim 5 prime                    	0
#              -3p	Trim 3 prime                    	0
#              -ml	Minimum length                  	16
#              -xl	Maximum length on se            	2147483647
#            -boot	Bootstrap sub-sequence          	False
#
# Presets:
#             -apm	Sets both pm and fpm            	u
#             -cge	Set CGE penalties and rewards   	False
#           -mint2	Set 2nd gen Mintyper preset     	False
#           -mint3	Set 3rd gen Mintyper preset     	False
#             -ont	Set 3rd gen genefinding preset  	False
#             -ill	Set 2nd gen genefinding preset  	False
#             -asm	Set assembly genefinding preset 	False
#
```

## kma_index

### Tool Description
kma_index creates the databases needed to run KMA, from a list of fasta files given.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
# kma_index creates the databases needed to run KMA, from a list of fasta files given.
# Options are:		Desc:					Default:
#
#	-i		Input/query file name (STDIN: "--")	None
#	-o		Output file				Input/template file
#	-batch		Batch input file
#	-deCon		File with contamination (STDIN: "--")	None/False
#	-batchD		Batch decon file
#	-t_db		Add to existing DB			None/False
#	-k		Kmersize				16
#	-m		Minimizer size				16/False
#	-hc		Homopolymer compression				False
#	-c		Templates are open reading frames
#	-C		Templates are CDSs
#	-ML		Minimum length of templates		kmersize (16)
#	-CS		Start Chain size			1 M
#	-ME		Mega DB					False
#	-NI		Do not dump *.index.b			False
#	-Sparse		Make Sparse DB ('-' for no prefix)	None/False
#	-ht		Homology template			1.0
#	-hq		Homology query				1.0
#	-and		Both homolgy thresholds
#			has to be reached			or
#	-nbp		No bias print				False
#	-v		Version
#	-h		Shows this help message
#
```

## kma_seq2fasta

### Tool Description
kma seq2fasta prints the fasta sequence of a given kma index to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
kma seq2fasta prints the fasta sequence of a given kma index to stdout.
# Options are:	Desc:					Default:	Requirements:
#	-t_db	Template DB				None		REQUIRED
#	-seqs	Comma separated list of templates	Print entire index.
#	-h	Shows this help message
```

## kma_db

### Tool Description
KMA db gives statistics on a KMA database.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
# KMA db gives statistics on a KMA database
# Options are:		Desc:					Requirements:
#
#	-t_db		Template DB				REQUIRED
#	-h		Shows this help message
#
```

## kma_cmp

### Tool Description
kma cmp compares two indexed kma databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
# kma cmp compare two indexed kma databases.
#         Options:	Desc:                           	Default:
#            -t_db	DB to compare to                	
#            -s_db	DB to compare with              	
#             -tmp	Set directory for temporary files	
#               -v	Version                         	
#               -h	Shows this help message         	
#
```

## kma_merge

### Tool Description
kma merge merges two indexed kma databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
# kma merge merges two indexed kma databases.
#         Options:	Desc:                           	Default:
#               -o	Output prefix                   	
#            -t_db	Add to DB                       	
#            -s_db	DB to merge                     	
#             -tmp	Set directory for temporary files	
#               -v	Version                         	
#               -h	Shows this help message         	
#
```

## kma_update

### Tool Description
KMA_update synchronises kma-indexes to the needed version.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
# KMA_update synchronises kma-indexes to the needed version.
# Options are:		Desc:					Requirements:
#
#	-t_db		Template DB				REQUIRED
#	-v		[XXYY], from version major version XX
#			to major version YY. Use minor version,
#			if major version is 0.			REQUIRED
#	-h		Shows this help message
#
```

## kma_dist

### Tool Description
kma dist calculates distances between templates from a kma index.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
#kma dist calculates distances between templates from a kma index
#     Options are:	Desc:                           	Default:
#            -t_db	Template DB                     	
#               -o	Output file                     	DB
#               -f	Output flags                    	1
#              -fh	Help on option "-f"             	
#               -d	Distance method                 	1
#              -dh	Help on option "-d"             	
#               -m	Allocate matrix on the disk     	False
#             -tmp	Set directory for temporary files	
#               -t	Number of threads               	1
#               -h	Shows this helpmessage
```

## kma_trim

### Tool Description
kma trim trims sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/kma
- **Package**: https://anaconda.org/channels/bioconda/packages/kma/overview
- **Validation**: PASS

### Original Help Text
```text
#kma trim trims sequences
#     Options are:	Desc:                           	Default:
#               -i	Input file(s)                   	STDIN
#             -ipe	Paired input files              	
#             -int	Inerleaved input file(s)        	
#               -o	Output file                     	STDOUT
#              -qc	Report QC, repeat for verbose   	
#              -ml	Minimum length                  	16
#              -xl	Maximum length                  	2147483647
#              -mp	Minimum phred                   	20
#              -mi	Minimum internal phred score    	0
#              -eq	Minimum average quality         	0
#              -5p	Trim 5 prime                    	0
#              -3p	Trim 3 prime                    	0
#               -h	Shows this helpmessage
```

