# ccphylo CWL Generation Report

## ccphylo_dist

### Tool Description
calculates distances between samples based on overlaps between nucleotide count matrices created by e.g. KMA.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
#CCPhylo dist calculates distances between samples based on overlaps between nucleotide count matrices created by e.g. KMA.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file(s)                   	stdin
#    -o, --output          	Output file                     	stdout
#    -n, --nucleotide_numbers	Output number of nucleotides included	False/None
#    -S, --separator       	Separator                       	\t
#    -x, --print_precision 	Floating point print precision  	9
#    -y, --methylation_motifs	Mask methylation motifs from <file>	False/None
#    -V, --nucleotide_variations	Output nucleotide variations    	False/None
#    -r, --reference       	Target reference                	None
#    -a, --add             	Add file to existing matrix     	
#    -E, --min_depth       	Minimum depth                   	15
#    -C, --min_cov         	Minimum coverage                	50.0%
#    -L, --min_len         	Minimum overlapping length      	1
#    -W, --normalization_weight	Normalization weight            	0 / None
#    -P, --proximity       	Minimum proximity between SNPs  	0
#    -f, --flag            	Output flags                    	1
#    -F, --flag_help       	Help on option "-f"             	
#    -d, --distance        	Distance method                 	cos
#    -D, --distance_help   	Help on option "-d"             	
#    -l, --significance_lvl	Minimum lvl. of signifiacnce    	0.05
#    -p, --float_precision 	Float precision on distance matrix	double
#    -s, --short_precision 	Short precision on distance matrix	double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	double / 1e0
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -t, --threads         	Number of threads               	1
#    -h, --help            	Shows this helpmessage
```


## ccphylo_tree

### Tool Description
forms tree(s) in newick format given a set of phylip distance matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo forms tree(s) in newick format given a set of phylip distance matrices.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file                      	stdin
#    -o, --output          	Output file                     	stdout
#    -S, --separator       	Separator                       	\t
#    -q, --quotes          	Quote taxa                      	\0
#    -x, --print_precision 	Floating point print precision  	9
#    -m, --method          	Tree construction method.       	dnj
#    -M, --method_help     	Help on option "-m"             	
#    -f, --flag            	Output flags                    	0
#    -F, --flag_help       	Help on option "-f"             	
#    -p, --float_precision 	Float precision on distance matrix	False / double
#    -s, --short_precision 	Short precision on distance matrix	False / double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	False / double / 1e0
#    -g, --free            	Gradually free up D             	False
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -t, --threads         	Number of threads               	1
#    -h, --help            	Shows this helpmessage
```


## ccphylo_dbscan

### Tool Description
make a DBSCAN given a set of phylip distance matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo make a DBSCAN given a set of phylip distance matrices.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file                      	stdin
#    -o, --output          	Output file                     	stdout
#    -S, --separator       	Separator                       	\t
#    -q, --quotes          	Quote taxa                      	\0
#    -N, --min_neighbors   	Minimum neighbors               	1
#    -e, --max_distance    	Maximum distance                	10.0
#    -p, --float_precision 	Float precision on distance matrix	double
#    -s, --short_precision 	Short precision on distance matrix	double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	double / 1e0
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -h, --help            	Shows this helpmessage
```


## ccphylo_union

### Tool Description
CCPhylo union finds the union between templates in res files created by e.g. KMA.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
Missing arguments, printing helpmessage.
#CCPhylo union finds the union between templates in res files created by e.g. KMA.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file(s)                   	None
#    -o, --output          	Output file                     	stdout
#    -B, --database        	Print ordered wrt. template DB filename	None
#    -r, --reference_file  	Create reference fasta file     	None
#    -E, --min_depth       	Minimum depth                   	15
#    -C, --min_cov         	Minimum coverage                	50.0%
#    -L, --min_len         	Minimum overlapping length      	1
#    -h, --help            	Shows this helpmessage
```


## ccphylo_merge

### Tool Description
Merges matrices from a multi Phylip file into one matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo merges matrices from a multi Phylip file into one matrix
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input multi phylip distance file	stdin
#    -o, --output          	Output file                     	stdout
#    -w, --nucleotides_weights	Weigh distance with this Phylip file	
#    -n, --nucleotide_numbers	Output number of nucleotides included	False/None
#    -S, --separator       	Separator                       	\t
#    -x, --print_precision 	Floating point print precision  	9
#    -f, --flag            	Output flags                    	1
#    -F, --flag_help       	Help on option "-f"             	
#    -p, --float_precision 	Float precision on distance matrix	double
#    -s, --short_precision 	Short precision on distance matrix	double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	double / 1e0
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -h, --help            	Shows this helpmessage
```


## ccphylo_nwck2phy

### Tool Description
converts newick files to phylip distance files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo nwck2phy converts newick files to phylip distance files.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file                      	stdin
#    -o, --output          	Output file                     	stdout
#    -x, --print_precision 	Floating point print precision  	9
#    -f, --flag            	Output flags                    	1
#    -F, --flag_help       	Help on option "-f"             	
#    -p, --float_precision 	Float precision on distance matrix	False / double
#    -s, --short_precision 	Short precision on distance matrix	False / double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	False / double / 1e0
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -h, --help            	Shows this helpmessage
```


## ccphylo_tsv2phy

### Tool Description
converts tsv files to phylip distance files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo tsv2phy converts tsv files to phylip distance files.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file                      	stdin
#    -o, --output          	Output file                     	stdout
#    -S, --separator       	Separator                       	\t
#    -x, --print_precision 	Floating point print precision  	9
#    -d, --distance        	Distance method                 	cos
#    -D, --distance_help   	Help on option "-d"             	
#    -f, --flag            	Output flags                    	1
#    -F, --flag_help       	Help on option "-f"             	
#    -p, --float_precision 	Float precision on distance matrix	False / double
#    -s, --short_precision 	Short precision on distance matrix	False / double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	False / double / 1e0
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -h, --help            	Shows this helpmessage
```


## ccphylo_rarify

### Tool Description
rarifies an KMA matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
Missing argument:	"-nf"
#CCPhylo rarify rarifies an KMA matrix.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file                      	stdin
#    -o, --output          	Output file                     	stdout
#    -A, --fragment_amount 	Total number of fragments in sample	0
#    -R, --rarification_factor	Rarification factor             	10000000
#    -h, --help            	Shows this helpmessage
```


## ccphylo_trim

### Tool Description
Trims multiple alignments from different files, and merge them into one

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo trims multiple alignments from different files, and merge them into one
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file(s)                   	stdin
#    -o, --output          	Output file                     	stdout
#    -y, --methylation_motifs	Mask methylation motifs from <file>	False/None
#    -r, --reference       	Target reference                	None
#    -C, --min_cov         	Minimum coverage                	50.0%
#    -L, --min_len         	Minimum overlapping length      	1
#    -P, --proximity       	Minimum proximity between SNPs  	0
#    -f, --flag            	Output flags                    	1
#    -F, --flag_help       	Help on option "-f"             	
#    -h, --help            	Shows this helpmessage
```


## ccphylo_phycmp

### Tool Description
Compares two distance matrices in phylip format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
# CCPhylo phycmp compares two distance matrices in phylip format.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file(s)                   	stdin
#    -o, --output          	Output file                     	stdout
#    -S, --separator       	Separator                       	\t
#    -f, --flag            	Output flags                    	1
#    -F, --flag_help       	Help on option "-f"             	
#    -p, --float_precision 	Float precision on distance matrix	False / double
#    -s, --short_precision 	Short precision on distance matrix	False / double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	False / double / 1e0
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -h, --help            	Shows this helpmessage
```


## ccphylo_fullphy

### Tool Description
forms tree(s) in newick format given a set of phylip distance matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo forms tree(s) in newick format given a set of phylip distance matrices.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file                      	stdin
#    -o, --output          	Output file                     	stdout
#    -S, --separator       	Separator                       	\t
#    -x, --print_precision 	Floating point print precision  	9
#    -f, --flag            	Output flags                    	1
#    -F, --flag_help       	Help on option "-f"             	
#    -p, --float_precision 	Float precision on distance matrix	False / double
#    -s, --short_precision 	Short precision on distance matrix	False / double / 1e0
#    -b, --byte_precision  	Byte precision on distance matrix	False / double / 1e0
#    -H, --mmap            	Allocate matrix on the disk     	False
#    -T, --tmp             	Set directory for temporary files	
#    -h, --help            	Shows this helpmessage
```


## ccphylo_makespan

### Tool Description
make a DBSCAN given a set of phylip distance matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
- **Homepage**: https://bitbucket.org/genomicepidemiology/ccphylo
- **Package**: https://anaconda.org/channels/bioconda/packages/ccphylo/overview
- **Validation**: PASS

### Original Help Text
```text
#CCPhylo make a DBSCAN given a set of phylip distance matrices.
#   Options are:            	Desc:                           	Default:
#    -i, --input           	Input file                      	stdin
#    -o, --output          	Output file                     	stdout
#    -O, --machine_output  	Machine output file             	stdout
#    -S, --separator       	Separator                       	\t
#    -k, --key             	Field containing cluster number 	3
#    -c, --classes         	Field(s) containing class weights	False
#    -m, --method          	Makespan initial method         	DBF
#    -M, --method_help     	Help on option "-m"             	
#    -t, --tabu            	Makespan tabu search method     	BB
#    -T, --tabu_help       	Help on option "-t"             	
#    -w, --weight          	Weighing method                 	none
#    -W, --weight_help     	Help on option "-w"             	
#    -l, --loads           	Load on machines double[,double...]	5
#    -h, --help            	Shows this helpmessage
```

