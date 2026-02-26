# pseudo-it CWL Generation Report

## pseudo-it_pseudo_it.py

### Tool Description
Pseudo assembly by iterative mapping. Genomes assembly by iterative mapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/pseudo-it:3.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/goodest-goodlab/pseudo-it
- **Package**: https://anaconda.org/channels/bioconda/packages/pseudo-it/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pseudo-it/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/goodest-goodlab/pseudo-it
- **Stars**: N/A
### Original Help Text
```text
#
# =============================================================================================================================
    _____                    _             _ _   
   |  __ \                  | |           (_) |  
   | |__) |__  ___ _   _  __| | ___ ______ _| |_ 
   |  ___/ __|/ _ \ | | |/ _` |/ _ \______| | __|
   | |   \__ \  __/ |_| | (_| | (_) |     | | |_ 
   |_|   |___/\___|\__,_|\__,_|\___/      |_|\__|
                                              
       Pseudo assembly by iterative mapping.

usage: pseudo_it.py [-h] [-ref REF] [-se SE] [-pe1 PE1] [-pe2 PE2] [-pem PEM]
                    [-bam BAM] [-tmp TMP_DIR] [-o OUT_DEST] [-resume RESUME]
                    [-mapper MAPPER] [-mapperpath MAPPER_PATH]
                    [-picard PICARD_PATH] [-samtools SAMTOOLS_PATH]
                    [-gatk GATK_PATH] [-bedtools BEDTOOLS_PATH]
                    [-bcftools BCFTOOLS_PATH] [-i NUM_ITERS]
                    [-map-t MAP_THREADS] [-gatk-t GATK_THREADS] [-bed BED]
                    [-bedmode BED_MODE] [-vcf VCF] [-f FILTER] [-p PROCESSES]
                    [-mask MASK_OPT] [-strandness STRANDNESS] [--nomkdups]
                    [--maponly] [--noindels] [--diploid] [--keepall]
                    [--keeponlyfinal] [--overwrite] [--quiet] [--version]
                    [--depcheck] [--dryrun]

Pseudo-it: Genomes assembly by iterative mapping.

options:
  -h, --help            show this help message and exit
  -ref REF              The FASTA assembly to use for the initial mapping.
  -se SE                A FASTQ file containing single-end reads. At least one
                        of -se, -pe1 and pe2, or pem must be provided.
  -pe1 PE1              A FASTQ file containing pair 1 of paired-end reads. At
                        least one of -se, -pe1 and pe2, or pem must be
                        provided.
  -pe2 PE2              A FASTQ file containing pair 2 of paired-end reads. At
                        least one of -se, -pe1 and pe2, or pem must be
                        provided.
  -pem PEM              A FASTQ file containing merged paired-end reads. At
                        least one of -se, -pe1 and pe2, or pem must be
                        provided.
  -bam BAM              OPTIONAL: A BAM file with the provided reads mapped to
                        the reference to be used for the first iteration. This
                        BAM file must be pre-indexed with samtools index.
  -tmp TMP_DIR          Some programs write files to a temporary directory. If
                        your default tmp dir is size limited, specify a new
                        one here, or just specifiy 'tmp-pi-out' to have a
                        folder called 'tmp' created and used within the main
                        output folder. Default: Your system's tmp dir.
  -o OUT_DEST           Desired output directory. This will be created for you
                        if it doesn't exist. Default: pseudoit-[date]-[time]
  -resume RESUME        The path to a previous Pseudo-it directory to resume a
                        run. Scans for presence of files and resumes when it
                        can't find an expected file.
  -mapper MAPPER        The name of the mapping progam. One of: bwa, hisat2.
                        Default: bwa
  -mapperpath MAPPER_PATH
                        The path to the mapping program. By default, just the
                        name of the program.
  -picard PICARD_PATH   The exact command used to run picard. For a jar file:
                        java -jar <full path to jar file>. For an alias or
                        conda install: picard. Include heap size in command,
                        i.e. -Xmx6g. Default: picard
  -samtools SAMTOOLS_PATH
                        The path to the samtools progam. Default: samtools
  -gatk GATK_PATH       The path to the GATK progam. Default: gatk
  -bedtools BEDTOOLS_PATH
                        The path to the bedtools progam. Default: bedtools
  -bcftools BCFTOOLS_PATH
                        The path to the bcftools progam. Default: bcftools
  -i NUM_ITERS          The number of iterations Pseudo-it will run. Default:
                        4.
  -map-t MAP_THREADS    The number of threads for the mapper to use for each
                        read type. If you specify -map-t 3 and have 3 read
                        types (and have at least -p 3), this means a total of
                        9 processes will be used during mapping. If left
                        unspecified and -p is specified this will be
                        determined automatically by dividing -p by the number
                        of libraries you provide. Otherwise, default: 1.
  -gatk-t GATK_THREADS  The number of threads for GATK's Haplotype caller to
                        use. If you specify -p 4 and -gatk-t 4, this means
                        that a total of 16 processes will be used. GATK
                        default: 4.
  -bed BED              A bed file. Only intervals in this file will have
                        variants called.
  -bedmode BED_MODE     When a .bed file is provided, this option specifies
                        how it is used. With 'regions', each entry in the bed
                        file will be run with it's own instance of gatk. With
                        'file', a single instance of gatk will be run for all
                        regions. This distinction is made because with many
                        regions in a .bed file, the overhead to run them
                        separately with gatk is too great. For many small
                        regions, specify 'file'. Default: file
  -vcf VCF              A VCF with variants to IGNORE in the called data. Beta
                        mode -- only use for small genomes.
  -f FILTER             The expression to filter variants. Must conform to VCF
                        INFO field standards. Default read depth filters are
                        optimized for a 30-40X sequencing run -- adjust for
                        your assembly. Default: "MQ < 30.0 || DP < 5 || DP >
                        60"
  -p PROCESSES          The MAX number of processes Pseudo-it can use. If -p
                        is set to 12 and -gatk-t is set to 4, then Pseudo-it
                        will spawn 3 GATK processes in parallel. Default: 1.
  -mask MASK_OPT        The type of masking to perform on the final consensus
                        sequence for sites without genotypes called. 'hard' to
                        replace these sites with Ns, 'soft' to replace these
                        sites with lower-case reference nucleotides, and
                        'none' to leave these sites as reference. Default:
                        soft
  -strandness STRANDNESS
                        For use with hisat2 and stranded RNA-seq data. Either
                        'RF' or 'FR'.
  --nomkdups            Do not run Picard's MarkDuplicates on mapped reads.
  --maponly             Only do one iteration and stop after read mapping.
  --noindels            Set this to not incorporate indels into the final
                        assembly.
  --diploid             Set this use IUPAC ambiguity codes in the final FASTA
                        file.
  --keepall             By default, pseudo-it keeps only the final files for
                        each step of each iteration (BAM, VCF, FASTA and their
                        respective indices). Set this option to keep all
                        intermediate files. While this is the best way to
                        ensure your runs can be resumed with different
                        settings this will result many large files being saved
                        (total of ~1TB for a 30X genome and 4 iterations).
  --keeponlyfinal       By default, pseudo-it keeps only the final files for
                        each step of each iteration (BAM, VCF, FASTA and their
                        respective indices). Set this option to keep these
                        files ONLY for the final iteration. While this
                        minimizes storage space required, you will be unable
                        to resume this run.
  --overwrite           Set this to overwrite existing files.
  --quiet               Set this flag to prevent psuedo-it from reporting
                        detailed information about each step.
  --version             Simply print the version and exit. Can also be called
                        as '-version', '-v', or '--v'
  --depcheck            Run this to check that all dependencies are installed
                        at the provided path. No other options necessary.
  --dryrun              With all options provided, set this to run through the
                        whole pseudo-it pipeline without executing external
                        commands.
```

