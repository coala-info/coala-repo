# skder CWL Generation Report

## skder

### Tool Description
skDER: efficient & high-resolution dereplication of microbial genomes to select representative genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/skder:1.3.4--py310h184ae93_1
- **Homepage**: https://github.com/raufs/skDER
- **Package**: https://anaconda.org/channels/bioconda/packages/skder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/skder/overview
- **Total Downloads**: 29.1K
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/raufs/skDER
- **Stars**: N/A
### Original Help Text
```text
usage: skder [-h] [-g GENOMES [GENOMES ...]] [-t TAXA_NAME] -o
             OUTPUT_DIRECTORY [-d DEREPLICATION_MODE]
             [-i PERCENT_IDENTITY_CUTOFF] [-f ALIGNED_FRACTION_CUTOFF]
             [-a MAX_AF_DISTANCE_CUTOFF] [-tc] [-p SKANI_TRIANGLE_PARAMETERS]
             [-s] [-fm] [-gd GENOMAD_DATABASE] [-n] [-mn MINIMAL_N50] [-l]
             [-r GTDB_RELEASE] [-auto] [-mm MAX_MEMORY] [-c THREADS] [-v]

	Program: skder
	Author: Rauf Salamzade
	Affiliation: Kalan Lab, UW Madison, Department of Medical Microbiology and Immunology

	skDER: efficient & high-resolution dereplication of microbial genomes to select 
		   representative genomes.

	skDER will perform dereplication of genomes using skani average nucleotide identity 
	(ANI) and aligned fraction (AF) estimates and either a dynamic programming or 
	greedy-based based approach. It assesses such pairwise ANI & AF estimates to determine 
	whether two genomes are similar to each other and then chooses which genome is better 
	suited to serve as a representative based on assembly N50 (favoring the more contiguous 
	assembly) and connectedness (favoring genomes deemed similar to a greater number of 
	alternate genomes).
								  
	Note, if --filter-mge is requested, the original paths to genomes are reported but 
	the statistics reported in the clustering reports (e.g. ANI, AF) will all be based 
	on processed (MGE filtered) genomes. Importantly, computation of N50 is performed 
	before MGE filtering to not penalize genomes of high quality that simply have many 
	MGEs and enable them to still be selected as representatives.
	
	If you use skDER for your research, please kindly cite both:

	Fast and robust metagenomic sequence comparison through sparse chaining with skani.
	Nature Methods. Shaw and Yu, 2023.

	and
    
	skDER & CiDDER: two scalable approaches for microbial dereplication. Microbial
	Genomics. Salamzade, Kottapalli, and Kalan, 2025.
    

options:
  -h, --help            show this help message and exit
  -g GENOMES [GENOMES ...], --genomes GENOMES [GENOMES ...]
                        Genome assembly file paths or paths to containing
                        directories. Files should be in FASTA format and can be gzipped
                        (accepted suffices are: *.fasta,
                        *.fa, *.fas, or *.fna) [Optional].
  -t TAXA_NAME, --taxa-name TAXA_NAME
                        Genus or species identifier from GTDB for which to
                        download genomes for and include in
                        dereplication analysis [Optional].
  -o OUTPUT_DIRECTORY, --output-directory OUTPUT_DIRECTORY
                        Output directory.
  -d DEREPLICATION_MODE, --dereplication-mode DEREPLICATION_MODE
                        Whether to use a "dynamic" (more concise), "greedy" (more
                        comprehensive), or "low_mem_greedy" (currently
                        experimental) approach to selecting representative genomes.
                        [Default is "greedy"]
  -i PERCENT_IDENTITY_CUTOFF, --percent-identity-cutoff PERCENT_IDENTITY_CUTOFF
                        ANI cutoff for dereplication [Default is 99.5].
  -f ALIGNED_FRACTION_CUTOFF, --aligned-fraction-cutoff ALIGNED_FRACTION_CUTOFF
                        Aligned cutoff threshold for dereplication - only needed by
                        one genome [Default is 50.0].
  -a MAX_AF_DISTANCE_CUTOFF, --max-af-distance-cutoff MAX_AF_DISTANCE_CUTOFF
                        Maximum difference for aligned fraction between a pair to
                        automatically disqualify the genome with a higher
                        AF from being a representative [Default is 10.0].
  -tc, --test-cutoffs   Assess clustering using various pre-selected cutoffs.
  -p SKANI_TRIANGLE_PARAMETERS, --skani-triangle-parameters SKANI_TRIANGLE_PARAMETERS
                        Options for skani triangle. Note ANI and AF cutoffs
                        are specified separately and the -E parameter is always
                        requested. [Default is "-s X", where X is
                        10 below the ANI cutoff].
  -s, --sanity-check    Confirm each FASTA file provided or downloaded is actually
                        a FASTA file. Makes it slower, but generally
                        good practice.
  -fm, --filter-mge     Filter predicted MGE coordinates along genomes before
                        dereplication assessment but after N50
                        computation.
  -gd GENOMAD_DATABASE, --genomad-database GENOMAD_DATABASE
                        If filter-mge is specified, it will by default use PhiSpy;
                        however, if a database directory for
                        geNomad is provided - it will use that instead
                        to predict MGEs.
  -n, --determine-clusters
                        Perform secondary clustering to assign non-representative
                        genomes to their closest representative genomes.
  -mn MINIMAL_N50, --minimal_n50 MINIMAL_N50
                        Minimal N50 of genomes to be included in dereplication
                        [Default is 0].
  -l, --symlink         Symlink representative genomes in results subdirectory
                        instead of performing a copy of the files.
  -r GTDB_RELEASE, --gtdb-release GTDB_RELEASE
                        Which GTDB release to use if -t argument issued [Default is R226].
  -auto, --automate     Automatically skip warnings and download genomes from NCBI if -t
                        argument issued. Automatation off by default to prevent
                        unexpected downloading of large genomes [Default
                        is False].
  -mm MAX_MEMORY, --max-memory MAX_MEMORY
                        Max memory in Gigabytes [Default is 0 = unlimited].
  -c THREADS, --threads THREADS
                        Number of threads/processes to use [Default is 1].
  -v, --version         Report version of skDER.
```

