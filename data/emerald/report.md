# emerald CWL Generation Report

## emerald

### Tool Description
EMERALD is a tool for finding suboptimal alignments in protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/emerald:1.2.1--hd2a2fb8_2
- **Homepage**: https://github.com/algbio/emerald
- **Package**: https://anaconda.org/channels/bioconda/packages/emerald/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emerald/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/algbio/emerald
- **Stars**: N/A
### Original Help Text
```text
Usage: emerald -f <clusterfile> -o <outputfile> [arguments]

Optional arguments:
	-a, --alpha <value>      	Floating value, choose edges that appear in (alpha*100)% of all
	                         	(sub-)optimal paths to be safe. (Default: 0.75, Range: (0.5, 1])
	-p, --approximation      	Approximates big integers with doubles. Output might be less accurate,
	                         	but running speed will be increased.
	-d, --delta <value>      	Integer value, defines suboptimal paths to be in the delta neighborhood of
	                         	the optimal. (Default: 0, Range: [0.0, inf))
	-c, --costmat <file>     	Reads the aligning score of two symbols from a text file.
	                         	The text file is a lower triangular matrix with 20 lines. (Default: BLOSUM62)
	-g, --gapcost <value>    	Integer, set the score of aligning a character to a gap. (Default: 1)
	-e, --startgap <value>   	Integer, set the score of starting a gap alignment. (Default: 11)
	-s, --special <value>    	Integer, sets the score of aligning symbols with special characters.
	                         	INF value ignores these charachters. (Default: 1)
	-i, --threads <value>    	Integer, specifies the number of threads (Default: 1).
	-r, --reference <protein>	Protein identity, selects reference protein. By default, this is the first protein.
	-w, --drawgraph <dir>    	Returns dot code files of all alignments in an existent directory for plotting
	                         	the Delta suboptimal subgraph.
	-k, --alignments <value> 	Non-negative integer n, creates a fasta file in the current working directory containing
	                         	randomly chosen n suboptimal alignments. (Default: 0)
	-m, --windowmerge        	Merge safety windows if they intersect or are adjacent. EMERALD prints both merged and
	                         	unmerged safety windows if this option is in use. (Default: Off)
	-h, --help               	Shows this help message.
```

