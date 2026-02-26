# confindr CWL Generation Report

## confindr

### Tool Description
Check for contamination in fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/confindr:0.8.2--pyhdfd78af_0
- **Homepage**: https://github.com/lowandrew/ConFindr
- **Package**: https://anaconda.org/channels/bioconda/packages/confindr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/confindr/overview
- **Total Downloads**: 60.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lowandrew/ConFindr
- **Stars**: N/A
### Original Help Text
```text
usage: confindr [-h] -i INPUT_DIRECTORY -o OUTPUT_NAME [-d DATABASES]
                [--rmlst] [-t THREADS] [-tmp TMP] [-k] [-q QUALITY_CUTOFF]
                [-b BASE_CUTOFF] [-bf BASE_FRACTION_CUTOFF] [-e ERROR_CUTOFF]
                [-fid FORWARD_ID] [-rid REVERSE_ID] [-v]
                [-dt {Illumina,Nanopore}] [-Xmx XMX] [-cgmlst CGMLST]
                [--fasta] [-verbosity {debug,info,warning}]
                [-m MIN_MATCHING_HASHES]

options:
  -h, --help            show this help message and exit
  -i INPUT_DIRECTORY, --input_directory INPUT_DIRECTORY
                        Folder that contains fastq files you want to check for
                        contamination. Will find any file that contains .fq or
                        .fastq in the filename.
  -o OUTPUT_NAME, --output_name OUTPUT_NAME
                        Base name for output/temporary directories.
  -d DATABASES, --databases DATABASES
                        Databases folder. To download these, you will need to
                        get access to the rMLST databases. For complete
                        instructions on how to do this, please see
                        https://olc-bioinformatics.github.io/ConFindr/install/
                        #downloading-confindr-databases
  --rmlst               Activate to prefer using rMLST databases over core-
                        gene derived databases. By default,ConFindr will use
                        core-gene derived databases where available.
  -t THREADS, --threads THREADS
                        Number of threads to run analysis with.
  -tmp TMP, --tmp TMP   If your ConFindr databases are in a location you don't
                        have write access to, you can enter this option to
                        specify a temporary directory to put genus-specific
                        databases to.
  -k, --keep_files      By default, intermediate files are deleted. Activate
                        this flag to keep intermediate files.
  -q QUALITY_CUTOFF, --quality_cutoff QUALITY_CUTOFF
                        Base quality needed to support a multiple allele call.
                        Defaults to 20.
  -b BASE_CUTOFF, --base_cutoff BASE_CUTOFF
                        Number of bases necessary to support a multiple allele
                        call, and automatically increments based upon gene-
                        specific quality score, length and depth of coverage.
                        Default is 3.
  -bf BASE_FRACTION_CUTOFF, --base_fraction_cutoff BASE_FRACTION_CUTOFF
                        Fraction of bases necessary to support a multiple
                        allele call. Particularly useful when dealing with
                        very high coverage samples. Default is 0.05.
  -e ERROR_CUTOFF, --error_cutoff ERROR_CUTOFF
                        Value to use for the calculated error cutoff when
                        setting the base cutoff value. Default is 1.0%.
  -fid FORWARD_ID, --forward_id FORWARD_ID
                        Identifier for forward reads.
  -rid REVERSE_ID, --reverse_id REVERSE_ID
                        Identifier for reverse reads.
  -v, --version         show program's version number and exit
  -dt {Illumina,Nanopore}, --data_type {Illumina,Nanopore}
                        Type of input data. Default is Illumina, but can be
                        used for Nanopore too. No PacBio support (yet).
  -Xmx XMX, --Xmx XMX   Very occasionally, parts of the pipeline that use the
                        BBMap suite will have their memory reservation fail
                        and request not enough, or sometimes negative, memory.
                        If this happens to you, you can use this flag to
                        override automatic memory reservation and use an
                        amount of memory requested by you. -Xmx 20g will
                        specify 20 gigs of RAM, and -Xmx 800m will specify 800
                        megs.
  -cgmlst CGMLST, --cgmlst CGMLST
                        Path to a cgMLST database to use for contamination
                        detection instead of using the default rMLST database.
                        Sequences in this file should have headers in format
                        >genename_allelenumber. To speed up ConFindr runs,
                        clustering the cgMLST database with CD-HIT before
                        running ConFindr is recommended. This is highly
                        experimental, results should be interpreted with great
                        care.
  --fasta               If activated, will look for FASTA files instead of
                        FASTQ for unpaired reads.
  -verbosity {debug,info,warning}, --verbosity {debug,info,warning}
                        Amount of output you want printed to the screen.
                        Defaults to info, which should be good for most users.
  -m MIN_MATCHING_HASHES, --min_matching_hashes MIN_MATCHING_HASHES
                        Minimum number of matching hashes in a MASH screen in
                        order for a genus to be considered present in a
                        sample. Default is 150
```

