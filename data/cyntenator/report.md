# cyntenator CWL Generation Report

## cyntenator

### Tool Description
guide-tree: -t "((rat.txt mouse.txt ) human.txt)"
Homology: -h id -h blast [file] -h orthologs [file] -h phylo [file] [weighted_tree]
Alignment Parameters:
	-thr	threshold (4)
	-gap	gap (-2)
	-mis	mismatch (-3)

Filter options:
	-filter [int] best alignments or only unique assignments n=0 (100)
	-coverage [int] each gene may occur only c times in alignments (2)
	-length [int] minimum alignment length treshold (1)
	-last prints only the alignments at the last step

Output:
	-o output file

### Metadata
- **Docker Image**: quay.io/biocontainers/cyntenator:0.0.r2326--h9948957_4
- **Homepage**: https://github.com/dieterich-lab/cyntenator
- **Package**: https://anaconda.org/channels/bioconda/packages/cyntenator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cyntenator/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dieterich-lab/cyntenator
- **Stars**: N/A
### Original Help Text
```text
program -t guide-tree -h homology_type ... 
guide-tree:
	-t "((rat.txt mouse.txt ) human.txt)"
Homology:
	-h id
	-h blast [file]
	-h orthologs [file]
	-h phylo [file] [weighted_tree]

Alignment Parameters:
	-thr	threshold (4)
	-gap	gap (-2)
	-mis	mismatch (-3)

Filter options:
	-filter [int] best alignments or only unique assignments n=0 (100)
	-coverage [int] each gene may occur only c times in alignments (2)
	-length [int] minimum alignment length treshold (1)
	-last prints only the alignments at the last step

Output:
	-o output file
```

