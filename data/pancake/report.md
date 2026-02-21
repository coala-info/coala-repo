# pancake CWL Generation Report

## pancake_create

### Tool Description
Create a PanCake Object from sequences and alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pancake/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pancakeswap/pancake-frontend
- **Stars**: N/A
### Original Help Text
```text
usage: pancake create [-h] [--sequences SEQUENCES [SEQUENCES ...]]
                      [--ids IDS [IDS ...]] [--email EMAIL]
                      [--pan_file PAN_FILE] [--ali [ALI [ALI ...]]]
                      [--min_len MIN_LEN] [--no_self_alignments]

optional arguments:
  -h, --help            show this help message and exit
  --sequences SEQUENCES [SEQUENCES ...], -s SEQUENCES [SEQUENCES ...]
                        fasta or multiple fasta file providing input
                        chromosome sequences
  --ids IDS [IDS ...], -i IDS [IDS ...]
                        gi ids of sequences to download from NCBI
  --email EMAIL, -e EMAIL
                        if downloading your sequences via gi ids, please
                        specify your email address; in case of excessive
                        usage, NCBI will attempt to contact a user at the
                        e-mail address provided prior to blocking access to
                        the E-utilities
  --pan_file PAN_FILE, -p PAN_FILE
                        File name of new PanCake Object
                        (DEFAULT=pan_files/pancake.pan)
  --ali [ALI [ALI ...]], -a [ALI [ALI ...]]
                        pairwise alignments (BLAST or nucmer output) to
                        include in PanCake Object
  --min_len MIN_LEN, -l MIN_LEN
                        minimum length of pairwise alignments to include
                        (DEFUALT=25)
  --no_self_alignments, -nsa
                        if set, skip pairwise alignments between regions on
                        identical chromosomes as input (DEFAULT=False)
```


## pancake_status

### Tool Description
Check the status of a PAN_FILE

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: pancake status [-h] PAN_FILE
pancake status: error: argument -h/--help: ignored explicit argument 'elp'
```


## pancake_addali

### Tool Description
Add alignments to a pancake project

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: pancake [-h]
               {create,status,addAli,specify,addChrom,core,singletons,sequence,graph}
               ...
pancake: error: argument subcommand: invalid choice: 'addali' (choose from 'create', 'status', 'addAli', 'specify', 'addChrom', 'core', 'singletons', 'sequence', 'graph')
```


## pancake_specify

### Tool Description
Specify or modify chromosome information in a PanCake Data Object File

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: pancake specify [-h] --panfile PAN_FILE [--chrom CHROM [CHROM ...]]
                       [--name NEW_NAME] [--genome GENOME]
                       [--genome_file FILE_NAME]
                       [--delete OLD_NAME [OLD_NAME ...]]

optional arguments:
  -h, --help            show this help message and exit
  --panfile PAN_FILE, -p PAN_FILE
                        Name of PanCake Data Object File (required)
  --chrom CHROM [CHROM ...], -c CHROM [CHROM ...]
                        name(s) of respective chromosome(s)
  --name NEW_NAME, -n NEW_NAME
                        new name of specified chromosome, this will become the
                        chromosome's name in incidental output files
  --genome GENOME, -g GENOME
                        name of genome CHROM belongs to
  --genome_file FILE_NAME, -f FILE_NAME
                        input file containing mapping of chromosomes to
                        genomes and additional chromosome names
  --delete OLD_NAME [OLD_NAME ...], -d OLD_NAME [OLD_NAME ...]
                        chromosome names to delete
```


## pancake_addchrom

### Tool Description
Add chromosomes to a pancake database

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: pancake [-h]
               {create,status,addAli,specify,addChrom,core,singletons,sequence,graph}
               ...
pancake: error: argument subcommand: invalid choice: 'addchrom' (choose from 'create', 'status', 'addAli', 'specify', 'addChrom', 'core', 'singletons', 'sequence', 'graph')
```


## pancake_core

### Tool Description
Identify and extract core genome regions from a PanCake Data Object File.

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: pancake core [-h] --panfile PAN_FILE [--ref_chrom REF_CHROM]
                    [--ref_genome REF_GENOME]
                    [--non_ref_chroms NON_REF_CHROMS [NON_REF_CHROMS ...]]
                    [--non_ref_genomes NON_REF_GENOMES [NON_REF_GENOMES ...]]
                    [--exclude_genomes GENOME [GENOME ...]]
                    [--exclude_chromosomes CHROMOSOME [CHROMOSOME ...]]
                    [--max_non_core_frac MAX_NON_CORE_FRAC]
                    [--min_len MIN_LEN] [--output DICT] [--no_output]
                    [--bed_file BED_FILE] [--max_space INT]

optional arguments:
  -h, --help            show this help message and exit
  --panfile PAN_FILE, -p PAN_FILE
                        Name of PanCake Data Object File (required)
  --ref_chrom REF_CHROM, -rc REF_CHROM
                        Reference CHROMOSOME (define either ONE reference
                        chromosome OR ONE reference genome)
  --ref_genome REF_GENOME, -rg REF_GENOME
                        Reference GENOME (define either ONE reference
                        chromosome OR ONE reference genome)
  --non_ref_chroms NON_REF_CHROMS [NON_REF_CHROMS ...], -nrc NON_REF_CHROMS [NON_REF_CHROMS ...]
                        Names of non-reference CHROMOSOMES (DEFAULT: ALL non-
                        reference chromosomes)
  --non_ref_genomes NON_REF_GENOMES [NON_REF_GENOMES ...], -nrg NON_REF_GENOMES [NON_REF_GENOMES ...]
                        Names of non-reference GENOMES (DEFAULT: ALL non-
                        reference genomes)
  --exclude_genomes GENOME [GENOME ...], -eg GENOME [GENOME ...]
                        Names of GENOMES to exclude from core analysis
                        (DEFAULT: No genomes excluded)
  --exclude_chromosomes CHROMOSOME [CHROMOSOME ...], -ec CHROMOSOME [CHROMOSOME ...]
                        Names of CHROMOSOMES to exclude from core analysis
                        (DEFAULT: No chromosomes excluded)
  --max_non_core_frac MAX_NON_CORE_FRAC, -f MAX_NON_CORE_FRAC
                        Maximum fraction of non-core sequence regions within
                        each included sequence (FLOAT, DEAFULT=0.05)
  --min_len MIN_LEN, -l MIN_LEN
                        minimum length of regions to identify as part of core
                        genome (INTEGER, DEFAULT=25)
  --output DICT, -o DICT
                        directory to which .fasta files of core regions are
                        written (DEFAULT: core_{REF_CHROM|REF_GENOME})
  --no_output, -no      if set, supress .fasta output of core regions
  --bed_file BED_FILE, -b BED_FILE
                        .bed file to which core regions are written (DEFAULT=
                        core_{REF_CHROM|REF_GENOME}.bed)
  --max_space INT, -s INT
                        maximum non-core space allowed within a core region
                        (DEFAULT=25)
```


## pancake_singletons

### Tool Description
Identify singleton regions in a PanCake Data Object File and output them as FASTA or BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: pancake singletons [-h] --panfile PAN_FILE [--ref_chrom REF_CHROM]
                          [--ref_genome REF_GENOME]
                          [--non_ref_chroms NON_REF_CHROMS [NON_REF_CHROMS ...]]
                          [--non_ref_genomes NON_REF_GENOMES [NON_REF_GENOMES ...]]
                          [--exclude_genomes GENOME [GENOME ...]]
                          [--exclude_chromosomes CHROMOSOME [CHROMOSOME ...]]
                          [--min_len MIN_LEN] [--output DICT] [--no_output]
                          [--bed_file BED_FILE]

optional arguments:
  -h, --help            show this help message and exit
  --panfile PAN_FILE, -p PAN_FILE
                        Name of PanCake Data Object File (required)
  --ref_chrom REF_CHROM, -rc REF_CHROM
                        Reference CHROMOSOME (define either ONE reference
                        chromosome or ONE reference genome)
  --ref_genome REF_GENOME, -rg REF_GENOME
                        Reference GENOME (define either ONE reference
                        chromosome or ONE reference genome)
  --non_ref_chroms NON_REF_CHROMS [NON_REF_CHROMS ...], -nrc NON_REF_CHROMS [NON_REF_CHROMS ...]
                        Names of non-reference CHROMOSOMES (DEFAULT: ALL non-
                        reference chromosomes)
  --non_ref_genomes NON_REF_GENOMES [NON_REF_GENOMES ...], -nrg NON_REF_GENOMES [NON_REF_GENOMES ...]
                        Names of non-reference GENOMES (DEFAULT: ALL non-
                        reference genomes)
  --exclude_genomes GENOME [GENOME ...], -eg GENOME [GENOME ...]
                        Names of GENOMES to exclude from singleton analysis
                        (DEFAULT: No genomes excluded)
  --exclude_chromosomes CHROMOSOME [CHROMOSOME ...], -ec CHROMOSOME [CHROMOSOME ...]
                        Names of CHROMOSOMES to exclude from singleton
                        analysis (DEFAULT: No chromosomes excluded)
  --min_len MIN_LEN, -l MIN_LEN
                        minimum length of regions to identify as a singleton
                        region (INTEGER, DEFAULT=25)
  --output DICT, -o DICT
                        directory to which .fasta files of singleton regions
                        are written (DEFAULT:
                        singletons_{REF_CHROM|REF_GENOME})
  --no_output, -no      if set, supress .fasta output of singleton regions
  --bed_file BED_FILE, -b BED_FILE
                        .bed file to which singleton regions are written
                        (DEFAULT= singletons_{REF_CHROM|REF_GENOME}.bed)
```


## pancake_sequence

### Tool Description
Extract sequences from PanCake Data Object Files

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: pancake sequence [-h] --panfile PAN_FILE
                        [--chrom CHROMOSOME | --genome GENOME] [--output F]
                        [--linewidth INT] [-start INT] [-stop INT]

optional arguments:
  -h, --help            show this help message and exit
  --panfile PAN_FILE, -p PAN_FILE
                        Name of PanCake Data Object File (required)
  --chrom CHROMOSOME, -c CHROMOSOME
                        Chromosome from which sequence originates
  --genome GENOME, -g GENOME
                        (multiple) .fasta output of GENOME (if set, start and
                        stop will be ignored)
  --output F, -o F      file to which .fasta output will be written (DEFAULT =
                        STDOUT)
  --linewidth INT, -lw INT
                        line witdth in .fastafile (DEFAULT=100)
  -start INT            (1-based) start position on CHROMOSME (DEFAULT = 1)
  -stop INT             (1-based) stop position on CHROMOSME (DEFAULT = length
                        of CHROMOSME)
```


## pancake_graph

### Tool Description
Generate a DOT graph from PanCake Data Object Files

### Metadata
- **Docker Image**: quay.io/biocontainers/pancake:1.1.2--py35_0
- **Homepage**: https://github.com/pancakeswap/pancake-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: pancake graph [-h] --panfile PAN_FILE [--chroms CHROMS [CHROMS ...]]
                     [-starts START_POS [START_POS ...]]
                     [-stops STOP_POS [STOP_POS ...]] [--max_nodes MAX_NODES]
                     [--max_edges MAX_EDGES] [--max_entries MAX_ENTRIES]
                     [-all] [-regions] [--output FILE]

optional arguments:
  -h, --help            show this help message and exit
  --panfile PAN_FILE, -p PAN_FILE
                        Name of PanCake Data Object File (required)
  --chroms CHROMS [CHROMS ...], -c CHROMS [CHROMS ...]
                        Chromosomes in Output (by default all chromosomes
                        covered in PAN_FILE)
  -starts START_POS [START_POS ...]
                        Start positions (in same order as chromosomes),
                        DEFAULT=1 on all chromosomes
  -stops STOP_POS [STOP_POS ...]
                        Stop positions (in same order as chromosomes),
                        DEFAULT=length of chromosomes
  --max_nodes MAX_NODES
                        Maximal number of nodes in output graph.
                        (DEFAULT=10,000): if exceeded, PanCake will warn and
                        interrupt!
  --max_edges MAX_EDGES
                        Maximal number of edges in output graph.
                        (DEFAULT=10,000): if exceeded, PanCake will warn and
                        interrupt!
  --max_entries MAX_ENTRIES, -me MAX_ENTRIES
                        Shared features are truncated in output if number of
                        contained feature instances > MAX_ENTRIES (DEFAULT:
                        MAX_ENTRIES=50)
  -all                  if set, all chromosomes contained in PAN_FILE appear
                        in output (irrespective to CHROMS), DEFAULT=False
  -regions              if set, only specified regions are shown in output
                        (DEFAULT=False), ignored if -all is set
  --output FILE, -o FILE
                        output DOT file (DEFAULT: STDOUT)
```


## Metadata
- **Skill**: generated
