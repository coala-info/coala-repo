# dialign-tx CWL Generation Report

## dialign-tx

### Tool Description
Align sequences using the DIALIGN-T algorithm.

### Metadata
- **Docker Image**: biocontainers/dialign-tx:v1.0.2-12-deb_cv1
- **Homepage**: https://dialign-tx.gobics.de
- **Package**: https://anaconda.org/channels/bioconda/packages/dialign-tx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dialign-tx/overview
- **Total Downloads**: 73.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: dialign-t [OPTIONS] <conf-directory> <fasta-file> [<fasta-out-file>]

  -d	Debug-Mode  [DEFAULT 0]
   		 0 no debug statements
   		 1 debugs the current phase of the processing
   		 2 very loquacious debugging
   		 5 hardcore debugging
  -s	maximum amount of input sequences [DEFAULT 5000]
  -a	maximum number of characters per line in a FASTA file [DEFAULT 100]
  -c	maximum amount of characters per line when printing a sequence
     	[DEFAULT 80]
  -l	sensitivity mode, the higher the level the less likely
    	spurious random fragments are aligned in local alignments 
     	[DEFAULT 0]
   		 0 switched off 
   		 1 level-1, reduced sensitivity
   		 2 level-2, strongly reduced sensitivity
  -m	score matrix file name (in the configuration directory)
     		[DEFAULT PROTEIN: BLOSUM.scr]
 		[DEFAULT DNA: dna_matrix.scr]
  -w	defines the minimum weight when the weight formula is changed
     	to 1-pow(1-prob, factor) [DEFAULT 0.000000065]
  -p	probability distribution file name (in the configuration
     	directory) 
 		[DEFAULT PROTEIN: BLOSUM.diag_prob_t10]
		[DEFAULT DNA: dna_diag_prob_100_exp_550000]
  -v	add to each score (to prevent negative values) [DEFAULT 0]
  -t	"even" threshold for low score for sequences alignment 
 		[DEFAULT PROTEIN: 4]
		[DEFAULT DNA: 0]
  -n	maximum number of consecutive positions for window containing
     	low scoring positions 
 		[DEFAULT PROTEIN: 4]
		[DEFAULT DNA: 4]
  -g	global minimum fragment length for stop criterion 
 		[DEFAULT PROTEIN: 40] 
		[DEFAULT DNA: 40]
  -m	minimal allowed average score in frag window containing low 
     	scoring positions 
 		[DEFAULT PROTEIN: 4.0]
		[DEFAULT DNA: 0.25]
  -o	whether overlap weights are calculated or not [DEFAULT 0]
  -f	minimum fragment length [DEFAULT 1]
  -r	threshold weight to consider the fragment at all [DEFAULT 0.0]
  -u	[DEFAULT 0]
    		1: only use a sqrt(amount_of_seqs) stripe of neighbour
     		   sequences to calculate pairwise alignments (increase performance)
    		0: all pairwise alignments will be calculated
  -A	optional anchor file [DEFAULT none]
  -D	input is DNA-sequence
  -T	translate DNA into aminoacids from begin to end (length will be cut to mod 3 = 0)
	WARNING: Do not use -D with this option 
	(Default values for PROTEIN input will be loaded)
  -L	compare only longest Open Reading Frame
	WARNING: Do not use -D with this option 
	(Default values for PROTEIN input will be loaded)
  -O	translate DNA to aminoacids, reading frame for each sequence calculated due to its longest ORF
	WARNING: Do not use -D with this option 
	(Default values for PROTEIN input will be loaded)
  -P	output in aminoacids, no retranslation of DNA sequences
	[DEFAULT: input = output]
  -F	fast mode (implies -l0, since it already significantly reduces sensitivity)
  -C	generate probability table saved in <config_dir>/prob_table and exit
  -H -h	print this message
```

