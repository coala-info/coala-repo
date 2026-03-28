# tqdist CWL Generation Report

## tqdist_triplet_dist

### Tool Description
Calculate the triplet distance between two trees in Newick format. The triplet distance between the two trees will be printed to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
- **Homepage**: http://users-cs.au.dk/cstorm/software/tqdist/
- **Package**: https://anaconda.org/channels/bioconda/packages/tqdist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tqdist/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: triplet_dist [-v] <filename1> <filename2>

Where <filename1> and <filename2> point to two files each containing one
tree in Newick format. In both trees all leaves should be labeled and the
two trees should have the same set of leaf labels.
The triplet distance between the two trees will be printed to stdout.
If the -v option is used, the following numbers will be reported (in this
order):
	 - The number of leaves in the trees (should be the same for both).
	 - The number of triplets in the two trees (n choose 3).
	 - The triplet distance between the two trees.
	 - The normalized triplet distance between the two trees.
	 - The number of resolved triplets that agree in the two trees.
	 - The normalized number of resolved triplets that agree in the two trees.
	 - The number triplets that are unresolved in both trees.
	 - The normalized number triplets that are unresolved in both trees.
```


## tqdist_quartet_dist

### Tool Description
Calculates the quartet distance between two trees in Newick format. The quartet distance is printed to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
- **Homepage**: http://users-cs.au.dk/cstorm/software/tqdist/
- **Package**: https://anaconda.org/channels/bioconda/packages/tqdist/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quartet_dist [-v] <filename1> <filename2>

Where: <filename1> and <filename2> point to two files each containing
one tree in Newick format. In both trees all leaves should be labeled
and the two trees should have the same set of leaf labels.
The quartet distance between the two trees will be printed to stdout.
If the -v option is used, the following numbers will be reported (in this
order):
	 - The number of leaves in the trees (should be the same for both).
	 - The number of quartets in the two trees (n choose 3).
	 - The quartet distance between the two trees.
	 - The normalized quartet distance between the two trees.
	 - The number of resolved quartets that agree in the two trees.
	 - The normalized number of resolved quartets that agree in the two trees.
	 - The number of quartets that are unresolved in both trees.
	 - The normalized number of quartets that are unresolved in both trees.
```


## tqdist_pairs_triplet_dist

### Tool Description
Calculates the triplet distance between pairs of trees in two files. The files must contain the same number of trees in Newick format, and trees on the same line must have the same set of leaf labels.

### Metadata
- **Docker Image**: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
- **Homepage**: http://users-cs.au.dk/cstorm/software/tqdist/
- **Package**: https://anaconda.org/channels/bioconda/packages/tqdist/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairs_triplet_dist [-v] <filename1> <filename2> [<output filename>]

Where: <filename1> and <filename2> point to two files each containing
the same number of trees in Newick format. The two trees on line i in
the two files must have the same set of leaf labels.
The output is a list of numbers, where the i'th number is the triplet
distance between the two trees on line i in the two files.
If [output filename] is specified the output is written to the file
pointed to (if the file already exists the current content is deleted
first), otherwise the output is written to stdout.
If the -v option is used, the following numbers will be reported for
each pair of trees (in this order):
	 - The number of leaves in the trees (should be the same for both).
	 - The number of triplets in the two trees (n choose 3).
	 - The triplet distance between the two trees.
	 - The normalized triplet distance between the two trees.
	 - The number of resolved triplets that agree in the two trees.
	 - The normalized number of resolved triplets that agree in the two trees.
	 - The number of triplets that are unresolved in both trees.
	 - The normalized number of triplets that are unresolved in both trees.
```


## tqdist_pairs_quartet_dist

### Tool Description
Calculates the quartet distance between pairs of trees in two files. The files must contain the same number of trees in Newick format, and corresponding trees must have the same set of leaf labels.

### Metadata
- **Docker Image**: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
- **Homepage**: http://users-cs.au.dk/cstorm/software/tqdist/
- **Package**: https://anaconda.org/channels/bioconda/packages/tqdist/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairs_quartet_dist [-v] <filename1> <filename2> [<output filename>]

Where: <filename1> and <filename2> point to two files each containing
the same number of trees in Newick format. The two trees on line i in
the two files must have the same set of leaf labels.
The output is a list of numbers, where the i'th number is the quartet
distance between the two trees on line i in the two files.
If [output filename] is specified the output is written to the file
pointed to (if the file already exists the current content is deleted
first), otherwise the output is written to stdout.
If the -v option is used, the following numbers will be reported for
each pair of trees (in this order):
	 - The number of leaves in the trees (should be the same for both).
	 - The number of triplets in the two trees (n choose 3).
	 - The triplet distance between the two trees.
	 - The normalized triplet distance between the two trees.
	 - The number of resolved triplets that agree in the two trees.
	 - The normalized number of resolved triplets that agree in the two trees.
	 - The number triplets that are unresolved in both trees.
	 - The normalized number triplets that are unresolved in both trees.
```


## tqdist_all_pairs_triplet_dist

### Tool Description
Calculates the pairwise triplet distance between all pairs of trees in a file. The output is a lower triangular matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
- **Homepage**: http://users-cs.au.dk/cstorm/software/tqdist/
- **Package**: https://anaconda.org/channels/bioconda/packages/tqdist/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: all_pairs_triplet_dist <input filename> [output filename]

Where:
	<input filename> is the name of a file containing multiple trees in
	Newick format. Each tree should be on a seperate line. In each tree
	all leaves should be labeled and all trees should have the same set
	of leaf labels.
	If [output filename] is specified the output is written to the file
	pointed to (if the file already exists the current content is deleted
	first), otherwise the output is written to stdout.
	The output is a lower triangular matrix in which the i, j'th entry
	is the pairwise triplet distance between the tree on line i and the
	tree on line j in <input filename>.
```


## tqdist_all_pairs_quartet_dist

### Tool Description
Calculates the pairwise quartet distance between all trees in a Newick file and outputs a lower triangular matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
- **Homepage**: http://users-cs.au.dk/cstorm/software/tqdist/
- **Package**: https://anaconda.org/channels/bioconda/packages/tqdist/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: all_pairs_quartet_dist <input filename> [output filename]

Where:
	<input filename> is the name of a file containing multiple trees in
	Newick format. Each tree should be on a seperate line. In each tree
	all leaves should be labeled and all trees should have the same set
	of leaf labels.
	If [output filename] is specified the output is written to the file
	pointed to (if the file already exists the current content is deleted
	first), otherwise the output is written to stdout.
	The output is a lower triangular matrix in which the i, j'th entry
	is the pairwise quartet distance between the tree on line i and the
	tree on line j in <input filename>.
```


## Metadata
- **Skill**: generated
