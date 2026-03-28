# vgan CWL Generation Report

## vgan_euka

### Tool Description
euka performs abundance estimation of eukaryotic taxa from an environmental DNA sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
- **Homepage**: https://github.com/grenaud/vgan
- **Package**: https://anaconda.org/channels/bioconda/packages/vgan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vgan/overview
- **Total Downloads**: 13.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/grenaud/vgan
- **Stars**: N/A
### Original Help Text
```text
__        
  ___  __  __/ /______ _
 / _ \/ / / / /_/ __ `/
/  __/ /_/ / ,< / /_/ / 
\___/\__,_/_/|_|\__,_/  

euka performs abundance estimation of eukaryotic taxa from an environmental DNA sample.

vgan euka [options] 


No damage example:

	vgan euka -fq1 seqreads.fq.gz


Damage example:

	vgan euka -fq1 seqreads.fq.gz --deam5p ../share/damageProfiles/dhigh5.prof --deam3p ../share/damageProfiles/dhigh3.prof


User specific MCMC example:

	vgan euka -fq1 seqreads.fq.gz -iter 100000 -burnin 1000

Input options:
		--euka_dir [STR]	euka database location (default: current wroking directory)
		--dbprefix [STR]	database prefix name (defualt: euka_db)
		-fq1 [STR]		Input FASTQ file (for merged and single-end reads)
		-fq2 [STR]		Second input FASTQ file (for paired-end reads)
		-i			Paired-end reads are interleaved (default: false)
		-g [STR]		GAM input file
		-M [STR]		Alternative minimizer prefix input (defualt: euka_db)
		-o [STR]		Output file prefix (default: euka_output) 
		-t			Number of threads (-1 for all available)
		-Z			Temporary directory (default: /tmp)

Filter options:
		--minMQ [INT]		Set the mapping quality minimum for a fragment (default: 29)
		--minFrag [INT]		Minimum amount of fragments that need to map to a group (default: 10)
		--entropy [double]		Minimum entropy score for a bin to be considered (default: 1.17)
		--minBins [INT]		Minimum number of bins with an entropy higher than the thresold (default: 6)
		--maxBins [INT]		Maximum number of bins without coverage (default: 0)

Damage options:
		--deam5p		[.prof]	5p deamination frequency for eukaryotic species (default: no damage)
		--deam3p		[.prof]	3p deamination frequency for eukaryotic species (default: no damage)
		-l [INT]		Set length for substitution matrix (default: 5)
		--out_dir [STR]		Path for output prof-file (default: current wroking directory)

Markov chain Monte Carlo options:
		--no-mcmc		The MCMC does not run (default: false)
		--iter [INT]		Define the number of iterartions for the MCMC (default: 10000)
		--burnin [INT]		Define the burnin period for the MCMC (default: 100)

Additional output option:
		--outFrag		Outputs a file with all read names per taxonomic group (default: false)
		--outGroup [string]		Outputs all information about a taxonmic group of interest (default: empty)
```


## vgan_duprm

### Tool Description
Remove duplicates from GAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
- **Homepage**: https://github.com/grenaud/vgan
- **Package**: https://anaconda.org/channels/bioconda/packages/vgan/overview
- **Validation**: PASS

### Original Help Text
```text
vgan rmdup [sorted_input.gam] > [output.gam]
Remove duplicates from GAM file.
Note that the GAM file must be sorted. If it is not please run vg gamsort first
```


## vgan_gam2prof

### Tool Description
Convert gam file to profile file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
- **Homepage**: https://github.com/grenaud/vgan
- **Package**: https://anaconda.org/channels/bioconda/packages/vgan/overview
- **Validation**: PASS

### Original Help Text
```text
vgan gam2prof



		-g		Input gam file
		-l		Set length for substitution matrix (default: 5)
		-p		Path for output prof-file (default: stdout)
```


## vgan_haplocart

### Tool Description
Haplocart predicts the mitochondrial haplogroup for reads originating from an uncontaminated modern human sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
- **Homepage**: https://github.com/grenaud/vgan
- **Package**: https://anaconda.org/channels/bioconda/packages/vgan/overview
- **Validation**: PASS

### Original Help Text
```text
vgan haplocart [options]

Haplocart predicts the mitochondrial haplogroup for reads originating from an uncontaminated modern human sample.

Examples:

	vgan haplocart --hc-files /home/username/share/vgan/hcfiles/ -f myfasta.fa

	vgan haplocart --hc-files /home/username/share/vgan/hcfiles/ -fq1 seqreads_fwd.fq.gz -fq2 seqreads_rev.fq.gz


Options:

  Algorithm parameters
  	-e [FLOAT]			Background error probability for FASTA input (default 0.0001)
  Input/Output
  	--hc-files [STR]		HaploCart graph directory location (default: "../share/vgan/hcfiles/")
  	-f [STR]			FASTA consensus input file
  	-fq1 [STR]			FASTQ input file
  	-fq2 [STR]			FASTQ second input file (for paired-end reads)
  	-g [STR]			GAM input file
  	-i 				Input FASTQ (-fq1) is interleaved
  	-jf 				JSON output file (must be used with -j)
  	-o [STR]			Output file (default: stdout)
  	-s [STR]			Sample name
  	-pf				[STR] Posterior output file (default: stdout)
  	-z				Temporary directory (default: /tmp/)
  Non-algorithm parameters
  	-j				Output JSON file of alignments 
  	-np				Do not compute clade-level posterior probabilities 
  	-t				Number of threads (-t -1 for all available)
  	-q				Quiet mode
```


## vgan_soibean

### Tool Description
First, to create a taxon of interest for the --dbprefix option please use:
      /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh [taxon name]
The taxon name must be from our database. To get an overview of the available taxa use:
      /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh taxa

### Metadata
- **Docker Image**: quay.io/biocontainers/vgan:3.1.0--h9ee0642_0
- **Homepage**: https://github.com/grenaud/vgan
- **Package**: https://anaconda.org/channels/bioconda/packages/vgan/overview
- **Validation**: PASS

### Original Help Text
```text
_ 
               _ ( )
   ___    _   (_)| | _     __     _ _   ___  
 /',__) /'_`\ | || '_`\  /'__`\ /'_` )/' _ `\ 
 \__, \( (_) )| || |_) )(  ___/( (_| || ( ) | 
 (____/ \___/'(_)(_,__/'`\____)`\__,_)(_) (_) 


Usage: soibean [options]

First, to create a taxon of interest for the --dbprefix option please use:
      /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh [taxon name]
The taxon name must be from our database. To get an overview of the available taxa use:
      /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh taxa


No damage example:
	vgan soibean -fq1 [input.fq.gz] --dbprefix [taxon name] -o [output prefix]

Damage example:
	vgan soibean -fq1 [input.fq.gz] --dbprefix [taxon name] -o [output prefix] --deam5p ../share/damageProfiles/dhigh5.prof --deam3p ../share/damageProfiles/dhigh3.prof

User defined MCMC:
	vgan soibean -fq1 [input.fq.gz] --dbprefix [taxon name] -o [output prefix] --iter 1000000 --burnin 100000 -k 3

Options:
  --soibean_dir <directory>   Specify the directory containing the soibean files
  --tree_dir <directory>      Specify the directory containing the HKY trees
  --dbprefix <prefix>         Specify the prefix for the database files
  -o [STR]                    Output file prefix (default: beanOut) 
  -fq1 <filename>             Specify the input FASTQ file (single-end or first pair)
  -fq2 <filename>             Specify the input FASTQ file (second pair)
  -g <filename>               Specify the input GAM file (SAFARI output)
  -t <threads>                Specify the number of threads to use (default: 1)
  -z <directory>              Specify the temporary directory for intermediate files (default: /tmp/)
  -i                          Enable interleaved input mode
 -M <filename>                Specify an alternative minimizer index (default: <prefix>.rec.min) 
 -P [int]                     Penalty for unsupported paths (default: 7) 
Damage options:
  --deam5p [.prof]            5p deamination frequency for eukaryotic species (default: no damage)
  --deam3p [.prof]            3p deamination frequency for eukaryotic species (default: no damage)
Markov chain Monte Carlo options:
  --no-mcmc                   The MCMC does not run (default: false)
  --chains [INT]              Define the number of chains for the MCMC (default: 4)
  --iter [INT]                Define the number of iterations for the MCMC (default: 500.000)
  --burnin [INT]              Define the burn-in period for the MCMC (default: 75.000)
  --randStart [bool]          Set to get random starting nodes in the tree instead of the signature nodes (default: false)
  -k [INT]                    User defined value of k (k = number of expected sources) (default: not defined)
Additional output options:
 --alignment-detail [bool]    Additional TSV file with all match alignment information to identify SNPs (default: false)
 --pathThres [INT]            Reports all matches in additional TSV file for nodes with a number of paths less or equal to the threshold set (default: all paths)
```


## Metadata
- **Skill**: generated
