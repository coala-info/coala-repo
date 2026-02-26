# codoff CWL Generation Report

## codoff

### Tool Description
This program compares the codon-usage distribution of a focal-region/BGC to the codon usage of the background genome. It reports the cosine distance and Spearman correlation between the two profiles, as well as a discordance percentile indicating how unusual the focal region's codon usage is compared to similarly sized genomic windows.

### Metadata
- **Docker Image**: quay.io/biocontainers/codoff:1.2.3--pyhdfd78af_0
- **Homepage**: https://github.com/Kalan-Lab/codoff
- **Package**: https://anaconda.org/channels/bioconda/packages/codoff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/codoff/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/Kalan-Lab/codoff
- **Stars**: N/A
### Original Help Text
```text
usage: codoff [-h] -g FULL_GENOME [-s SCAFFOLD] [-a START_COORD]
              [-b END_COORD] [-f FOCAL_GENBANKS [FOCAL_GENBANKS ...]]
              [-o OUTFILE] [-p PLOT_OUTFILE] [-ns NUM_SIMS] [-v] [-x SEED]
              [-m MAX_FOCAL_CDS_FRACTION]

	Program: codoff
	Author: Rauf Salamzade
	Affiliation: Kalan Lab, UW Madison

	This program compares the codon-usage distribution of a focal-region/BGC 
	to the codon usage of the background genome. It will report the cosine 
	distance and Spearman correlation between the two profiles, as well as
	a discordance percentile indicating how unusual the focal region's codon 
	usage is compared to similarly sized genomic windows. Only CDS features 
	which are of length divisible by 3 will be considered. 
									 
	Two modes of input are supported:
									 
	1. (WORKS FOR BOTH EUKARYOTES & BACTERIA) Focal region and full-genome 
	   provided as GenBank files with CDS features (compatible with 
	   antiSMASH outputs). Multiple focal region GenBank files can be provided, 
	   e.g. consider a biosynthetic gene cluster split across multiple 
	   scaffolds due to assembly fragmentation. 
																		 
	   Example command: 
									 
	   $ codoff -f Sw_LK413/NZ_JALXLO020000001.1.region001.gbk -g Sw_LK413/LK413.gbk
	   $ codoff -f region.gbk -g genome.gbk --num-sims 5000
									 
	2. (WORKS ONLY FOR BACTERIA) Full genome is provided as a FASTA or GenBank 
	   file. If CDS features are missing gene calling is performed using 
	   pyrodigal. Afterwards, the focal region is determined through user
	   speciefied coordinates.
	
	   Example command:
									 
	   $ codoff -s NZ_JALXLO020000001.1 -a 341425 -b 388343 -g Sw_LK413/LK413.fna
	   $ codoff -s scaffold -a 1000 -b 5000 -g genome.fna --num-sims 20000 
 
	

options:
  -h, --help            show this help message and exit
  -g, --full-genome FULL_GENOME
                        Path to a full-genome in GenBank or FASTA format. If GenBank file
                        provided, CDS features are required.
  -s, --scaffold SCAFFOLD
                        Scaffold identifier for focal region.
  -a, --start-coord START_COORD
                        Start coordinate for focal region.
  -b, --end-coord END_COORD
                        End coordinate for focal region.
  -f, --focal-genbanks FOCAL_GENBANKS [FOCAL_GENBANKS ...]
                        Path to focal region GenBank(s) for isolate. Locus tags must match
                        with tags in full-genome GenBank.
  -o, --outfile OUTFILE
                        Path to output file [Default is standard output].
  -p, --plot-outfile PLOT_OUTFILE
                        Plot output file name (will be in SVG format). If not provided, no
                        plot will be made.
  -ns, --num-sims NUM_SIMS
                        Number of simulations to run [Default: 10000].
  -v, --version         Print version and exist
  -x, --seed SEED       Random seed for reproducible results [Default: 42].
  -m, --max-focal-cds-fraction MAX_FOCAL_CDS_FRACTION
                        Maximum allowed fraction of total genome CDS length for focal region [Default: 0.05].
```

