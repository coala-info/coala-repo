# cctk CWL Generation Report

## cctk_blast

### Tool Description
BLASTn settings:

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: cctk blast [-h] -r <path> -d <path (no extension)> -o <path> [-a <path>] [-p <string>] [-q <string>] [-t <int>] [-i <int>] [-c <float>] [-s <int>] [--min-shared <int>] [--append] [-e <float>] [-m <int>] [-b <int>] [-x <string>]

optional arguments:
  -h, --help            show this help message and exit

required arguments:
  -r, --repeats         CRISPR repeats in FASTA format
  -d, --blastdb         path to blast db (excluding file extension)
  -o, --outdir          directory to store output files

other inputs:
  -a, --assemblies      file containing a list of your assembly names
  -p, --regex-pattern   pattern describing your assembly names
  -q, --regex-type      {E, P} regex type describing assembly names. Default: P
  -t, --threads         number of threads to use. Default: 1
  -i, --repeat-interval maximum interval between repeats. Default: 100
  -l, --min-sp-len      minimum spacer length when identifying arrays. Default: 25
  -n, --min-array-len   minimum array length (number of spacers). Default 2
  -c, --percent-id      minumum percent ID of repeat BLAST hits. Default: 80
  -s, --snp-thresh      number of SNPs to consider spacers the same. Default: 0
  --min-shared          minimum spacers shared to draw an edge in network
  --append              add new CRISPR data to a previous run

BLASTn settings:
  -e, --evalue          blastn evalue. Default: 10
  -m, --max-target-seqs max_target_seqs option for blastn. Default: 10000
  -b, --batch-size      batch size for blastdbcmd. Default: 1000
  -x, --blast-options   input additional blastn options. Forbidden options: blastn -query -db -task -outfmt -num_threads -max_target_seqs -evalue
```


## cctk_minced

### Tool Description
Find and process CRISPR arrays using minced.

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk minced [-h] -o <path> [-i <path>] [-l <path>] [-r <path>] [-s <int>] [--min-shared <int>] [-m] [-p] [--append]

optional arguments:
  -h, --help          	show this help message and exit

Required arguments:
  -o, --outdir        	directory for minced output and processed files

Other inputs:
  -i, --indir         	input directory containing genome fastas.
  -l, --minced-path   	path to minced executable if not in PATH
  -r, --repeats       	CRISPR repeats in FASTA format
  -s, --snp-thresh    	number of SNPs to consider spacers the same. Default: 0
  --min-shared          minimum spacers shared to draw an edge in network

Specify run type:
  -m, --run-minced      run minced to find CRISPR arrays
  -p, --process-minced  run processing steps on minced output
  --append              add new CRISPR data to a previous run
```


## cctk_crisprdiff

### Tool Description
Control run behaviour

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk crisprdiff [-h] -a <path> -o <path> [--iterations <int>] [--preordered] [--approx-ordered] [--seed <int>] [--colour-file <path>] [--colour-scheme-outfile <path>] [--colour-scheme-infile <path>] [--force-colour-unique] [--line-width <float>] [--dpi <int>] [--connection-outline] [--plot-width <float>] [--plot-height <float>] [--font-size <float>] [arrays_to_align <list of names>]

optional arguments:
  -h, --help         show this help message and exit

required arguments:
  -a, --array-file   Array_IDs.txt or Array_seqs.txt
  -o, --out-file     output plot file name and path

positional arguments:
  must be at the end of your command
  arrays_to_align    IDs of the arrays you want to analyse. Default: all

running parameters:
  control run behaviour

  --iterations      number of iterations of order determination. Default = 100
  --preordered      array order you provided is the one you want plotted
  --approx-ordered  array order you provided should be optimized slightly
  --seed            set seed for random processes

colour scheme files:
  set inputs and outputs for optional colour scheme files

  --colour-file     file with custom colour list
  --colour-scheme-outfile
                    output file to store json format colour schemes
  --colour-scheme-infile
                    input file json format colour scheme
  --force-colour-unique
                    override black colour of unique spacers. Instead use specified colour scheme

plotting parameters:
  control elements of the produced plot

  --line-width      scale factor for lines between identical spacers
  --dpi             resolution of output image
  --connection-outline 
                    add outline colour to lines connecting identical spacers
  --plot-width      width of plot in inches. Default = 3
  --plot-height     height of plot in inches. Default = 3
  --font-size       font size. Defualt automatically scaled.
```


## cctk_crisprtree

### Tool Description
Builds a CRISPR array phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk crisprtree [-h] -a <path> -o <path> [--output-arrays <path>] [--print-tree] [-x] [-r <int>] [--acquisition <int>] [--deletion <int>] [--insertion <int>] [--rep-indel <int>] [--duplication <int>] [--trailer-loss <int>] [--no-ident <int>] [-t <int>] [--seed <int>] [--colour-file <path>] [--colour-scheme-outfile <path>] [--colour-scheme-infile <path>] [--force-colour-unique] [-b] [--brlen-scale <float>] [--no-align-cartoons] [--no-align-labels] [--dpi <int>] [--no-fade-anc] [--plot-width <float>] [--plot-height <float>] [--font-override-labels <float>] [--font-override-annotations <float>] [arrays_to_join <list of names>] [--branch-support {colour,number,newick}]

optional arguments:
  -h, --help        show this help message and exit

positional arguments:
  arrays_to_join    IDs of the arrays you want to analyse. Default: all

required arguments:
  -a, --array-file  Array_IDs.txt or Array_seqs.txt
  -o, --out-file    output plot file name and path

output control:
  set which of the optional outputs you want

  --output-arrays   file to store analyzed arrays and hypothetical ancestors
  --print-tree      print an ascii symbol representation of the tree

running parameters:
  control run behaviour

  -x, --fix-order   only build one tree using the provided order of arrays
  -r, --replicates  number of replicates of tree building. Default: 100
  --acquisition     parsimony cost of a spacer acquisition event. Default: 1
  --deletion        parsimony cost of a deletion event. Default: 10
  --insertion       parsimony cost of an insertion event. Default: 30
  --rep-indel       parsimony cost independently acquiring spacers. Default: 50
  --duplication     parsimony cost of a duplication event. Default: 1
  --trailer-loss    parsimony cost of trailer spacer loss. Default: 1
  --no-ident        parsimony cost of an array having no identity with its ancestor. Default: 100
  
  -t, --num-threads 
                    number of threads to use. Default: 1
  --seed            set seed for random processes

colour scheme files:
  set inputs and outputs for optional colour scheme files

  --colour-file     file with custom colour list
  --colour-scheme-outfile
                    output file to store json format colour schemes
  --colour-scheme-infile
                    input file json format colour scheme
  --force-colour-unique
                    override black colour of unique spacers. Instead use specified colour scheme

plotting parameters:
  control elements of the produced plot

  -b                include branch lengths in tree plot
  --brlen-scale     factor to scale branch length
  --branch-support  Show support. Default: colour. Options: colour, number, newick
  --no-emphasize-diffs
                    don't emphasize events in each array since its ancestor
  --no-align-cartoons
                    draw array cartoons next to leaf node
  --no-align-labels
                    draw leaf labels next to leaf node
  --dpi             resolution of the output image. Default = 600
  --no-fade-anc     do not apply transparency to ancestral array depiction
  --plot-width      width of plot in inches. Default = 3
  --plot-height     height of plot in inches. Default = 3
  --font-override-labels
                    set label font size in pts
  --font-override-annotations
                    set annotation font size in pts
```


## cctk_constrain

### Tool Description
Control run behaviour and plotting elements for tree analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk constrain [-h] -a <path> -t <path> -g <path> -o <path> [--output-arrays <path>] [--print-tree] [-u] [--acquisition <int>] [--deletion <int>] [--insertion <int>] [--rep-indel <int>] [--duplication <int>] [--trailer-loss <int>] [--no-ident <int>] [--seed <int>] [--colour-file <path>] [--colour-scheme-outfile <path>] [--force-colour-unique] [--colour-scheme-infile <path>] [-b] [--brlen-scale <float>] [--no-align-cartoons] [--no-align-labels] [--dpi <int>] [--no-fade-anc] [--plot-width <float>] [--plot-height <float>] [--font-override-labels <float>] [--font-override-annotations <float>]

optional arguments:
  -h, --help        show this help message and exit

required inputs:
  -a, --array-file  Array_IDs.txt or Array_seqs.txt file
  -t, --input-tree  file containing tree in newick format
  -g, --genome-array-file	
                    file corresponding array ID and genome ID
  -o, --out-plot    output plot file name

output control:
  set which of the optional outputs you want.

  --output-arrays   file to store analyzed arrays and hypothetical ancestors
  --print-tree      print an ascii symbol representation of the tree

running parameters:
  control run behaviour.

  -u, --unrooted    input tree is unrooted
  --acquisition     parsimony cost of a spacer acquisition event. Default: 1
  --deletion        parsimony cost of a deletion event. Default: 10
  --insertion       parsimony cost of an insertion event. Default: 30
  --rep-indel       parsimony cost independently acquiring spacers. Default: 50
  --duplication     parsimony cost of a duplication event. Default: 1
  --trailer-loss    parsimony cost of trailer spacer loss. Default: 1
  --no-ident        parsimony cost of an array having no identity with its ancestor. Default: 100
  --seed            set seed for random processes

colour scheme files:
  set inputs and outputs for optional colour scheme files.

  --colour-file     file with custom colour list
  --colour-scheme-outfile
                    output file to store json format colour schemes
  --colour-scheme-infile
                    input file json format colour scheme
  --force-colour-unique
                    override black colour of unique spacers. Instead use specified colour scheme

plotting parameters:
  control elements of the produced plot.

  -b                include branch lengths in tree plot
  --brlen-scale     factor to scale branch length.
  --no-emphasize-diffs
                    don't emphasize events in each array since its ancestor
  --no-align-cartoons
                    draw array cartoons next to leaf node
  --no-align-labels
                    draw leaf labels next to leaf node
  --replace-brlens  replace input tree branch lengths with array parsimony costs
  --dpi             resolution of the output image. Default = 600
  --no-fade-anc     do not apply transparency to ancestral array depiction
  --plot-width      width of plot in inches. Default = 3
  --plot-height     height of plot in inches. Default = 3
  --font-override-labels
                    set label font size in pts
  --font-override-annotations
                    set annotation font size in pts
```


## cctk_network

### Tool Description
Builds a network of CRISPR arrays based on shared spacers.

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk network [-h] -i <path> [-t <path>] [-o <path>] [--min-shared <int>]

required argument:
  -i, --input 	Array_IDs.txt or Array_seqs.txt

optional arguments:
  -h, --help  	show this help message and exit
  -t, --types 	array CRISPR subtypes file. 2 columns: Array Type
  -o, --outdir	output directory path. Default ./
  --min-shared  minimum spacers shared to draw an edge in network
```


## cctk_evolve

### Tool Description
Run a simulation of array evolution and plot the resulting tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk evolve [-h] -n <int> [-s <int>] [-o <path>] [-i <int>] [-a <int>] [-t <int>] [-d <int>] [-l <int>] [--font-override-labels <float>] [--font-override-annotations <float>] [-b] [--dpi <int>] [--plot-width <float>] [--plot-height <float>] [--branch-weight <float>] [--branch-spacing <float>] [--brlen-scale <float>] [--no-align] [--no-fade-anc] [--no-emphasize-diffs]

required arguments
  -n, --num-events      events to run the simulation

optional arguments:
  -h, --help            show this help message and exit
  -o, --outdir          output directory. Default ./

evolution parameters:
  specify parameters of simulation

  -s, --seed            set seed for random processes
  -i, --initial-length  length of the starting array. Default = 5
  -a, --acquisition     relative frequency of spacer acquisitions. Default = 75
  -t, --trailer-loss    relative frequency of trailer spacer decay. Default = 15
  -d, --deletion        relative frequency of deletions . Default = 10
  -l, --loss-rate       rate arrays are lost after spawning descendant. Default = 50

plotting parameters:
  set parameters for plotting the tree to file

  --font-override-labels
                        set label font size in pts
  --font-override-annotations
                        set annotation font size in pts
  -b, --brlen-labels    include branch lengths in tree plot
  --dpi                 resolution of the output image. Default = 300
  --plot-width          width of plot in inches. Default = 3
  --plot-height         height of plot in inches. Default = 3
  --branch-weight       thickness of branch lines. Default = 1
  --branch-spacing      vertical space between branches scaling
  --brlen-scale         factor to scale branch length
  --no-align            draw array labels and cartoons at leaf nodes
  --no-fade-anc         do not apply transparency to ancestral array depiction
  --no-emphasize-diffs  don't emphasize events in each array since its ancestor
```


## cctk_spacerblast

### Tool Description
Finds protospacers in a blast database that match a given set of spacers.

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk spacerblast [-h] -d <path (no extension)> -s <path> [-o <path>] [-q <path>] [-n <int>] [-u <int>] [-w <int>] [-R <string>] [-P <string>] [-l {'up', 'down'}] [-p <float>] [-b <int>] [-r <path>] [-e <float>] [-m <int>] [-t <int>] [-x <string>]

optional arguments:
  -h, --help        show this help message and exit

required arguments:
  -d, --blastdb     path to blast db excluding extension
  -s, --spacers     spacers in fasta format

output control arguments:
  -o, --out         path to output file. Default: stdout
  -q, --no-pam-out  path to output file for protospacers with no PAM, if desired
  -n, --flanking    number of bases to return from both sides of protospacers
  -u, --upstream    number of bases to return from the 5'side of protospacers
  -w, --downstream  number of bases to return from the 3'side of protospacers
  -R, --regex-pam   regex describing the PAM sequence
  -P, --pam         nucleotide pattern describing the PAM sequence e.g. NNNCC
  -l, --pam-location
                    {'up', 'down'} PAM location relative to protospacer
  -p, --percent-id  minimum percent identity between spacer and protospacer
  -b, --batch-size  size of batch to submit to blastdbcmd. Default: 1000
  -r, --mask-regions
                    file in bed format listing regions to ignore
  -E, --seed-region
                    Specify part of protospacer in which mismatches should not be 
                    tolerated. Format: start:stop, 0-base coordinates, 5':3'. E.g., "0:6" 
                    or ":6" specifies first 6 bases (0,1,2,3,4,5). "-6:-1" or "-6:" 
                    specifies last 6 bases.

BLAST arguments:
  arguments to control the blastn command used by this script

  -e, --evalue      blast e value. Default: 10
  -m, --max-target-seqs
                    blast max target seqs. Default: 10000
  -t, --threads     threads to use. Default: 1
  -x, --other-options
                    additional blastn options. Forbidden options: blastn -query -db -task -outfmt -num_threads -max_target_seqs -evalue
```


## cctk_quickrun

### Tool Description
Runs the cctk pipeline on a directory of genome fastas.

### Metadata
- **Docker Image**: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/Alan-Collins/CRISPR_comparison_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cctk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cctk quickrun -i <path> -o <path> [-h]

optional arguments:
  -h, --help  show this help message and exit

Required arguments:
  -i, --indir         	input directory containing genome fastas.
  -o, --outdir        	directory to write output files
  -m, --max-cluster     Largest cluster size to plot. Default: 15
```

