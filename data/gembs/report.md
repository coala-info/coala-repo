# gembs CWL Generation Report

## gembs_gemBS prepare

### Tool Description
Sets up pipeline directories and controls files. Input Files: Two files are required, a configuration file describing the model parameters and analysis directory structure, and second file describing the sample metadata and associated data files. The sample file will normally be a text file in CSV format with a header line, although there is also the option to import a JSON file from the CNAG LIMS. A full description of the input file formats can be found in the gemBS documentation. The prepare command reads in the configuration files and writes a JSON file with the data from both files, that is used by the subsequent gemBS commands. Any parameters supplied in the configuration files is used as the default by the other gemBS commands, so judicious use can prevent a lot of typing and help standardize analyses. The prepare command will then check that the mimum required information has been provided, and will check for the existence of key input files (notable the genome reference fasta file). A persistant (disk-based) sqlite3 database is used by default so that gemBS can track at what stage the pipeline has reached and handle pipeline steps that failed. This allows normal operation and restarting of the pipeline to be achieved using minimal input from the user. The use of the disk-base database is recommended for normal operations but does require a shared filesystem (that supports non-local file locks) across all instances of gemBS that are running on the same datafiles. If this is not the case then this can be turned off using the --no-db option. Use of this option will require that the user tracks the state of the analysis themselves. Note that if multiple instances of gemBS are run simultaneously on common analysis directories (i.e., using a shared filesystem, stroing output files in the same locations) then the disk based database must be used to avoid interference between the different gemBS instances. By default the database (if used) is stored in the file .gemBS/gemBS.db and the output JSON file is stored in .gemBS/gemBS.json. If the -no-db option is set then the JSON file will be stored to the file gemBS.json in the current directory. The --output option can be used to specify an alternate locationn for the JSON file and the --db-file option can specify an alternate locaiton for the database file. The database location is stored in the JSON file so that it can be recovered by subsequent calls to gemBS. However if the default location is not used for the JSON file them it will be necessary to specify the location of the JSON file for each gemBS command. It is therefore advised to stay with the default option if possible.

### Metadata
- **Docker Image**: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
- **Homepage**: https://github.com/heathsc/gemBS
- **Package**: https://anaconda.org/channels/bioconda/packages/gembs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gembs/overview
- **Total Downloads**: 28.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/heathsc/gemBS
- **Stars**: N/A
### Original Help Text
```text
usage: gemBS prepare [-h] -c CONFIG [-t TEXT_METADATA] [-o OUTPUT] [-D]
                     [-d DBFILE] [-l LIMS_CNAG_JSON]

Sets up pipeline directories and controls files. Input Files: Two files are
required, a configuration file describing the model parameters and analysis
directory structure, and second file describing the sample metadata and
associated data files. The sample file will normally be a text file in CSV
format with a header line, although there is also the option to import a JSON
file from the CNAG LIMS. A full description of the input file formats can be
found in the gemBS documentation. The prepare command reads in the
configuration files and writes a JSON file with the data from both files, that
is used by the subsequent gemBS commands. Any parameters supplied in the
configuration files is used as the default by the other gemBS commands, so
judicious use can prevent a lot of typing and help standardize analyses. The
prepare command will then check that the mimum required information has been
provided, and will check for the existence of key input files (notable the
genome reference fasta file). A persistant (disk-based) sqlite3 database is
used by default so that gemBS can track at what stage the pipeline has reached
and handle pipeline steps that failed. This allows normal operation and
restarting of the pipeline to be achieved using minimal input from the user.
The use of the disk-base database is recommended for normal operations but
does require a shared filesystem (that supports non-local file locks) across
all instances of gemBS that are running on the same datafiles. If this is not
the case then this can be turned off using the --no-db option. Use of this
option will require that the user tracks the state of the analysis themselves.
Note that if multiple instances of gemBS are run simultaneously on common
analysis directories (i.e., using a shared filesystem, stroing output files in
the same locations) then the disk based database must be used to avoid
interference between the different gemBS instances. By default the database
(if used) is stored in the file .gemBS/gemBS.db and the output JSON file is
stored in .gemBS/gemBS.json. If the -no-db option is set then the JSON file
will be stored to the file gemBS.json in the current directory. The --output
option can be used to specify an alternate locationn for the JSON file and the
--db-file option can specify an alternate locaiton for the database file. The
database location is stored in the JSON file so that it can be recovered by
subsequent calls to gemBS. However if the default location is not used for the
JSON file them it will be necessary to specify the location of the JSON file
for each gemBS command. It is therefore advised to stay with the default
option if possible.

optional arguments:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        Text config file with gemBS parameters.
  -t TEXT_METADATA, --text-metadata TEXT_METADATA
                        Sample metadata in csv file. See documentation for
                        description of file format.
  -o OUTPUT, --output OUTPUT
                        Output JSON file. See documentation for description of
                        file format.
  -D, --no-db           Do not use disk base database.
  -d DBFILE, --db-file DBFILE
                        Specify location for database file.
  -l LIMS_CNAG_JSON, --lims-cnag-json LIMS_CNAG_JSON
                        Lims CNAG subproject JSON file.
```


## gembs_gemBS db-sync

### Tool Description
Synchronize database with filesystem

### Metadata
- **Docker Image**: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
- **Homepage**: https://github.com/heathsc/gemBS
- **Package**: https://anaconda.org/channels/bioconda/packages/gembs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemBS db-sync [-h] [-y]

Synchronize database with filesystem

optional arguments:
  -h, --help  show this help message and exit
  -y, --yes   Confirm operation
```


## gembs_gemBS index

### Tool Description
Reference indexing for Bisulfite GEM mapping Generates by default a file called reference.BS.gem (GEM Index), reference.BS.info (Information about the index process) and reference.chrom.sizes (a list of contigs and sizes). Optionally the index command will also take a list of bed files with SNP names and locations (such as can be downloaded from dbSNP) and make an indexed file that can be used during the calling process to add SNP names into the output VCF/BCF file. The list of input files for thed dbSNP index generation can include shell wildcards (*, ? etc.) PLEASE NOTE! If bisulfite conversion control sequences have been added to the sequencing libraries then their sequences should be added to the fasta reference file, and gemBS should be told the names of these sequences. More details about the reference files, conversion control sequences, GEM index and dbSNP index can be found in the gemBS documentation.

### Metadata
- **Docker Image**: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
- **Homepage**: https://github.com/heathsc/gemBS
- **Package**: https://anaconda.org/channels/bioconda/packages/gembs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemBS index [-h] [-t THREADS] [-s SAMPLING_RATE] [-p]
                   [-d FILES [FILES ...]]

Reference indexing for Bisulfite GEM mapping Generates by default a file
called reference.BS.gem (GEM Index), reference.BS.info (Information about the
index process) and reference.chrom.sizes (a list of contigs and sizes).
Optionally the index command will also take a list of bed files with SNP names
and locations (such as can be downloaded from dbSNP) and make an indexed file
that can be used during the calling process to add SNP names into the output
VCF/BCF file. The list of input files for thed dbSNP index generation can
include shell wildcards (*, ? etc.) PLEASE NOTE! If bisulfite conversion
control sequences have been added to the sequencing libraries then their
sequences should be added to the fasta reference file, and gemBS should be
told the names of these sequences. More details about the reference files,
conversion control sequences, GEM index and dbSNP index can be found in the
gemBS documentation.

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads. By default GEM indexer will use the
                        maximum available on the system.
  -s SAMPLING_RATE, --sampling-rate SAMPLING_RATE
                        Text sampling rate. Increasing will decrease index
                        size at the expense of slower performance.
  -p, --populate-cache  Populate reference cache if required (for CRAM).
  -d FILES [FILES ...], --list-dbSNP-files FILES [FILES ...]
                        List of dbSNP files (can be compressed) to create an
                        index to later use it at the bscall step. The bed
                        files should have the name of the SNP in column 4.
```


## gembs_gemBS map

### Tool Description
Maps single end or paired end bisulfite sequence using the GEM3 mapper. By default the map command will try and perform mapping on all datafiles that it knows about that have not already been mapped. If all datafiles for a sample have been mapped then the map command will merge the BAM files if multiple BAMs exist for the sample. The resulting BAM will then be indexed and the md5 sum calculated. If the option --remove is set or 'remove_individual_bams' is set to True in the configuration file then the individual BAM files will be deleted after the merge step has been successfully completed. The --no-merge options will prevent this automatic merging - this can be useful for batch processing. Aside from the --no-merge option, if no disk based database is being used for gemBS and separate instances of gemBS are being run on non- shared file systems then the merging will not always be performed automatically. When the merging is not performed automatically for whatever reason, it can be invoked manually using the merge-bams command. The mapping process can be restricted to a single sample using the option '-n <SAMPLE NAME>' or '-b <SAMPLE BARCODE>'. The mapping can also be restricted to a single dataset ID using the option '-D <DATASET>' The locations of the input and output data are given by the configuration files; see the gemBS documentation for details. The --dry-run option will output a list of the mapping / merging operations that would be run by the map command without executing any of the commands. The --json <JSON OUTPUT> options is similar to --dry-run, but writes the commands to be executed in JSON format to the supplied output file, including information about the input and output files for the commands. The --ignore-db option modifies the --dry-run and --json options such that the database is not consulted (i.e., gemBS assumes that nothing has already been completed.

### Metadata
- **Docker Image**: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
- **Homepage**: https://github.com/heathsc/gemBS
- **Package**: https://anaconda.org/channels/bioconda/packages/gembs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemBS map [-h] [-D DATASET] [-n SAMPLE] [-b BARCODE] [-d PATH]
                 [-t THREADS] [--map-threads MAP_THREADS]
                 [--sort-threads SORT_THREADS] [--merge-threads MERGE_THREADS]
                 [--sort-memory SORT_MEMORY] [-T FTYPE] [-p] [-r] [-R] [-s]
                 [-u SEQUENCE] [-v SEQUENCE] [--non-bs] [--no-merge]
                 [--dry-run] [--json JSON FILE] [--ignore-db]
                 [--benchmark-mode]

Maps single end or paired end bisulfite sequence using the GEM3 mapper. By
default the map command will try and perform mapping on all datafiles that it
knows about that have not already been mapped. If all datafiles for a sample
have been mapped then the map command will merge the BAM files if multiple
BAMs exist for the sample. The resulting BAM will then be indexed and the md5
sum calculated. If the option --remove is set or 'remove_individual_bams' is
set to True in the configuration file then the individual BAM files will be
deleted after the merge step has been successfully completed. The --no-merge
options will prevent this automatic merging - this can be useful for batch
processing. Aside from the --no-merge option, if no disk based database is
being used for gemBS and separate instances of gemBS are being run on non-
shared file systems then the merging will not always be performed
automatically. When the merging is not performed automatically for whatever
reason, it can be invoked manually using the merge-bams command. The mapping
process can be restricted to a single sample using the option '-n <SAMPLE
NAME>' or '-b <SAMPLE BARCODE>'. The mapping can also be restricted to a
single dataset ID using the option '-D <DATASET>' The locations of the input
and output data are given by the configuration files; see the gemBS
documentation for details. The --dry-run option will output a list of the
mapping / merging operations that would be run by the map command without
executing any of the commands. The --json <JSON OUTPUT> options is similar to
--dry-run, but writes the commands to be executed in JSON format to the
supplied output file, including information about the input and output files
for the commands. The --ignore-db option modifies the --dry-run and --json
options such that the database is not consulted (i.e., gemBS assumes that
nothing has already been completed.

optional arguments:
  -h, --help            show this help message and exit
  -D DATASET, --dataset DATASET
                        Dataset to be mapped.
  -n SAMPLE, --sample-name SAMPLE
                        Name of sample to be mapped.
  -b BARCODE, --barcode BARCODE
                        Barcode of sample to be mapped.
  -d PATH, --tmp-dir PATH
                        Temporary folder to perform sorting operations.
                        Default: /tmp
  -t THREADS, --threads THREADS
                        Number of threads for the mapping pipeline. Default: 1
  --map-threads MAP_THREADS
                        Number of threads for GEM mapper. Default: threads
  --sort-threads SORT_THREADS
                        Number of threads for the sort operations. Default:
                        threads
  --merge-threads MERGE_THREADS
                        Number of threads for the merge operations. Default:
                        threads
  --sort-memory SORT_MEMORY
                        Per thread memory used for the sort operation.
                        Default: 768M
  -T FTYPE, --type FTYPE
                        Type of data file (PAIRED, SINGLE, INTERLEAVED,
                        STREAM, BAM)
  -p, --paired-end      Input data is Paired End
  -r, --remove          Remove individual BAM files after merging.
  -R, --reverse-conversion
                        Perform G2A conversion on read 1 and C2T on read 2
                        rather than the reverse.
  -s, --read-non-stranded
                        Automatically selects the proper C->T and G->A read
                        conversions based on the level of Cs and Gs on the
                        read.
  -u SEQUENCE, --underconversion-sequence SEQUENCE
                        Name of unmethylated sequencing control.
  -v SEQUENCE, --overconversion-sequence SEQUENCE
                        Name of methylated sequencing control.
  --non-bs              Use regular (non bisulfite) index
  --no-merge            Do not automatically merge BAMs
  --dry-run             Output mapping commands without execution
  --json JSON FILE      Output JSON file with details of pending commands
  --ignore-db           Ignore database for --dry-run and --json commands
  --benchmark-mode      Omit dates etc. to make file comparison simpler
```


## gembs_gemBS call

### Tool Description
Performs a methylation and SNV calling from bam aligned files. This process is performed (optionally in parallel) over contigs. Smaller contigs are processed together in pools to increaes efficiency. By default gemBS will analyze all contigs / contig pools for all samples that have not already been processed. After all contigs have been processed for one sample, the resulting BCFs are merged into a single BCF for the sample. This sample BCF is then indexed and the md5 signature calculated. If the option --remove is set or 'remove_individual_bcfs' is set to True in the configuration file then the individual BAM files will be deleted after the merge step has been successfully completed. The --no-merge options will prevent this automatic merging - this can be useful for batch processing. Aside from the --no-merge option, if no disk based database is being used for gemBS and separate instances of gemBS are being run on non-shared file systems then the merging will not always be performed automatically. When the merging is not performed automatically for whatever reason, it can be invoked manually using the merge- bcfs command. The calling process can be restricted to a single sample using the option '-n <SAMPLE NAME>' or '-b <SAMPLE BARCODE>'. The mapping can also be restricted to a list of contigs or contig pool using the option '-l <contig1, contig2, ...>' or '--pool <pool>'. The --list-pools option will list the available contig pools and exit. More information on how contig pools are determined is given in the gemBS documentation. If the dbSNP_index key has been set in the configuration file (and the index has been gemerated) then this will be used by the caller to add public IDs in the BCF file where available. The locations of the input and output data are given by the configuration file; see the gemBS documentation for details. The --dry-run option will output a list of the calling / merging operations that would be run by the call command without executing any of the commands. The --json <JSON OUTPUT> options is similar to --dry-run, but writes the commands to be executed in JSON format to the supplied output file, including information about the input and output files for the commands. The --ignore-db option modifies the --dry-run and --json options such that the database is not consulted (i.e., gemBS assumes that no calling has already been completed but that all dependencies (i.e., BAM files) are available. The --ignore-dep option is similar - it ignores dependencies, but does check whether a task has already been completed.

### Metadata
- **Docker Image**: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
- **Homepage**: https://github.com/heathsc/gemBS
- **Package**: https://anaconda.org/channels/bioconda/packages/gembs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemBS call [-h] [-l CONTIGS [CONTIGS ...]] [-n SAMPLE] [-b BARCODE]
                  [-q MAPQ_THRESHOLD] [-Q QUAL_THRESHOLD] [-g BASES]
                  [-f BASES] [-t THREADS] [--call-threads THREADS]
                  [--merge-threads THREADS] [-j JOBS] [-u] [-U] [-k]
                  [-e SPECIES] [-r] [-1 HAPLOID] [-C CONVERSION] [-R REF_BIAS]
                  [-x] [--no-merge] [--pool POOL] [--list-pools [LEVEL]]
                  [--dry-run] [--json JSON FILE] [--ignore-db] [--ignore-dep]
                  [--benchmark-mode]

Performs a methylation and SNV calling from bam aligned files. This process is
performed (optionally in parallel) over contigs. Smaller contigs are processed
together in pools to increaes efficiency. By default gemBS will analyze all
contigs / contig pools for all samples that have not already been processed.
After all contigs have been processed for one sample, the resulting BCFs are
merged into a single BCF for the sample. This sample BCF is then indexed and
the md5 signature calculated. If the option --remove is set or
'remove_individual_bcfs' is set to True in the configuration file then the
individual BAM files will be deleted after the merge step has been
successfully completed. The --no-merge options will prevent this automatic
merging - this can be useful for batch processing. Aside from the --no-merge
option, if no disk based database is being used for gemBS and separate
instances of gemBS are being run on non-shared file systems then the merging
will not always be performed automatically. When the merging is not performed
automatically for whatever reason, it can be invoked manually using the merge-
bcfs command. The calling process can be restricted to a single sample using
the option '-n <SAMPLE NAME>' or '-b <SAMPLE BARCODE>'. The mapping can also
be restricted to a list of contigs or contig pool using the option '-l
<contig1, contig2, ...>' or '--pool <pool>'. The --list-pools option will list
the available contig pools and exit. More information on how contig pools are
determined is given in the gemBS documentation. If the dbSNP_index key has
been set in the configuration file (and the index has been gemerated) then
this will be used by the caller to add public IDs in the BCF file where
available. The locations of the input and output data are given by the
configuration file; see the gemBS documentation for details. The --dry-run
option will output a list of the calling / merging operations that would be
run by the call command without executing any of the commands. The --json
<JSON OUTPUT> options is similar to --dry-run, but writes the commands to be
executed in JSON format to the supplied output file, including information
about the input and output files for the commands. The --ignore-db option
modifies the --dry-run and --json options such that the database is not
consulted (i.e., gemBS assumes that no calling has already been completed but
that all dependencies (i.e., BAM files) are available. The --ignore-dep option
is similar - it ignores dependencies, but does check whether a task has
already been completed.

optional arguments:
  -h, --help            show this help message and exit
  -l CONTIGS [CONTIGS ...], --contig-list CONTIGS [CONTIGS ...]
                        List of contigs on which to perform the methylation
                        calling.
  -n SAMPLE, --sample-name SAMPLE
                        Name of sample to be called
  -b BARCODE, --barcode BARCODE
                        Barcode of sample to be called
  -q MAPQ_THRESHOLD, --mapq-threshold MAPQ_THRESHOLD
                        Threshold for MAPQ scores
  -Q QUAL_THRESHOLD, --qual-threshold QUAL_THRESHOLD
                        Threshold for base quality scores
  -g BASES, --right-trim BASES
                        Bases to trim from right of read pair, Default: 0
  -f BASES, --left-trim BASES
                        Bases to trim from left of read pair, Default: 5
  -t THREADS, --threads THREADS
                        Number of threads, Default: 1
  --call-threads THREADS
                        Number of threads for calling process, Default: 1s
  --merge-threads THREADS
                        Number of threads for merging process, Default:
                        threads
  -j JOBS, --jobs JOBS  Number of parallel jobs
  -u, --keep-duplicates
                        Do not merge duplicate reads.
  -U, --ignore_duplicate_flag
                        Ignore duplicate flag from SAM/BAM files.
  -k, --keep-unmatched  Do not discard reads that do not form proper pairs.
  -e SPECIES, --species SPECIES
                        Sample species name. Default: None
  -r, --remove          Remove individual BCF files after merging.
  -1 HAPLOID, --haploid HAPLOID
                        Force genotype calls to be homozygous
  -C CONVERSION, --conversion CONVERSION
                        Set under and over conversion rates (under,over)
  -R REF_BIAS, --reference-bias REF_BIAS
                        Set bias to reference homozygote
  -x, --concat-only     Only perform merging BCF files.
  --no-merge            Do not automatically merge BCFs
  --pool POOL           Contig pool on which to perform the methylation
                        calling.
  --list-pools [LEVEL]  List contig pools and exit. Level 1 - list names,
                        level > 1 - list pool composition
  --dry-run             Output mapping commands without execution
  --json JSON FILE      Output JSON file with details of pending commands
  --ignore-db           Ignore database for --dry-run and --json commands
  --ignore-dep          Ignore dependencies for --dry-run and --json commands
  --benchmark-mode      Omit dates etc. to make file comparison simpler
```


## gembs_gemBS extract

### Tool Description
Extracts summary files from BCF files generated for all or a subset of samples to produce a series of summary output files. The detailed formats of the output files are given in the gemBS docuemntation. The default output are CpG files. These are BED3+8 format files with information on methylation and genotypes. A list of non-CpG sites in the same basic format can also be produced. Various options on filtering these files on genotype quality and coverage are available. By default the CpG files have 1 output line per CpG (so the information from the two strands is combined). This can be changed to give strand specific information using the -s option. Standard filtering strategy is to only output sites where the sample genotype is called as being homozygous CG/CG with a phred score >= to the theshold set using the -q option (default 20). Using the --allow-het option will allow heterozygous CpG sites to be included in the output. The sitest can also be filtered on minimum informative coverage using the -I option (default = 1). For non-CpG sites the strategy is to only output sites with a minimum number of non-converted reads. This level can be set using the --min-nc option (default = 1). A second set of extracted outputs that correspond to the ENCODE WGBS pipeline are also available using the --bed-methyl and --bigwig options. The --bed-methyl option will produce three files per sample for all covered sites in CpG, CHG and CHH context in BED9+5 format. Each of the files will also be generated in bigBed format for display in genome browsers. In addition a bigWig format file will be generated giving the methylation percentage at all covered cytosine sites (informative coverage > 0). If the --strand-specific option is given then two bigWig files will be geenrated - one for each strand. For the ENCODE output files, not further filtering is performed. In addition to the methylation result, SNP genotypes can also be extracted with the --snps options. By default, this will return a file with genotypes on all SNPs covered by the experiment that were in the dbSNP_idx file used for the calling stage. This selection can be refined uwing the --snp-list option, which is a file with a list of SNP ids, one id per line. An alternate dbSNP_idx file can also be supplied using the --snp-db option, allowing SNPs that were not in the original dbSNP_idx file used for calling to be extracted. The --dry-run option will output a list of the merging operations that would be run by the merge- bcfs command without executing any of the commands. The --json <JSON OUTPUT> options is similar to --dry-run, but writes the commands to be executed in JSON format to the supplied output file, including information about the input and output files for the commands. The --ignore-db option modifies the --dry- run and --json options such that the database is not consulted (i.e., gemBS assumes that no calling has already been completed but that all dependencies (i.e., BAM files) are available. The --ignore-dep option is similar - it ignores dependencies, but does check whether a task has already been completed.

### Metadata
- **Docker Image**: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
- **Homepage**: https://github.com/heathsc/gemBS
- **Package**: https://anaconda.org/channels/bioconda/packages/gembs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gemBS extract [-h] [-j JOBS] [-n SAMPLE_NAME] [-b SAMPLE_BARCODE] [-s]
                     [-W] [-q PHRED] [-I INFORM] [-M MIN_NC] [-H]
                     [-R REF_BIAS] [-c] [-N] [-B] [-S] [-t THREADS]
                     [--snp-list SNP_LIST] [--snp-db SNP_DB] [--dry-run]
                     [--json JSON FILE] [--ignore-db] [--ignore-dep]

Extracts summary files from BCF files generated for all or a subset of samples
to produce a series of summary output files. The detailed formats of the
output files are given in the gemBS docuemntation. The default output are CpG
files. These are BED3+8 format files with information on methylation and
genotypes. A list of non-CpG sites in the same basic format can also be
produced. Various options on filtering these files on genotype quality and
coverage are available. By default the CpG files have 1 output line per CpG
(so the information from the two strands is combined). This can be changed to
give strand specific information using the -s option. Standard filtering
strategy is to only output sites where the sample genotype is called as being
homozygous CG/CG with a phred score >= to the theshold set using the -q option
(default 20). Using the --allow-het option will allow heterozygous CpG sites
to be included in the output. The sitest can also be filtered on minimum
informative coverage using the -I option (default = 1). For non-CpG sites the
strategy is to only output sites with a minimum number of non-converted reads.
This level can be set using the --min-nc option (default = 1). A second set of
extracted outputs that correspond to the ENCODE WGBS pipeline are also
available using the --bed-methyl and --bigwig options. The --bed-methyl option
will produce three files per sample for all covered sites in CpG, CHG and CHH
context in BED9+5 format. Each of the files will also be generated in bigBed
format for display in genome browsers. In addition a bigWig format file will
be generated giving the methylation percentage at all covered cytosine sites
(informative coverage > 0). If the --strand-specific option is given then two
bigWig files will be geenrated - one for each strand. For the ENCODE output
files, not further filtering is performed. In addition to the methylation
result, SNP genotypes can also be extracted with the --snps options. By
default, this will return a file with genotypes on all SNPs covered by the
experiment that were in the dbSNP_idx file used for the calling stage. This
selection can be refined uwing the --snp-list option, which is a file with a
list of SNP ids, one id per line. An alternate dbSNP_idx file can also be
supplied using the --snp-db option, allowing SNPs that were not in the
original dbSNP_idx file used for calling to be extracted. The --dry-run option
will output a list of the merging operations that would be run by the merge-
bcfs command without executing any of the commands. The --json <JSON OUTPUT>
options is similar to --dry-run, but writes the commands to be executed in
JSON format to the supplied output file, including information about the input
and output files for the commands. The --ignore-db option modifies the --dry-
run and --json options such that the database is not consulted (i.e., gemBS
assumes that no calling has already been completed but that all dependencies
(i.e., BAM files) are available. The --ignore-dep option is similar - it
ignores dependencies, but does check whether a task has already been
completed.

optional arguments:
  -h, --help            show this help message and exit
  -j JOBS, --jobs JOBS  Number of parallel jobs
  -n SAMPLE_NAME, --sample-name SAMPLE_NAME
                        Name of sample to be filtered
  -b SAMPLE_BARCODE, --barcode SAMPLE_BARCODE
                        Barcode of sample to be filtered
  -s, --strand-specific
                        Output separate lines in CpG file for each strand.
  -W, --bigwig-strand-specific
                        Output separate bigWig files for each strand.
  -q PHRED, --phred-threshold PHRED
                        Min threshold for genotype phred score.
  -I INFORM, --min-inform INFORM
                        Min threshold for informative reads.
  -M MIN_NC, --min-nc MIN_NC
                        Min threshold for non-converted reads for non CpG
                        sites.
  -H, --allow-het       Allow both heterozygous and homozgyous sites.
  -R REF_BIAS, --reference-bias REF_BIAS
                        Allow both heterozygous and homozgyous sites.
  -c, --cpg             Output gemBS bed with cpg sites.
  -N, --non-cpg         Output gemBS bed with non-cpg sites.
  -B, --bed-methyl      Output bedMethyl files (bed and bigBed)
  -S, --snps            Output SNPs
  -t THREADS, --extract-threads THREADS
                        Number of extra threads for extract step
  --snp-list SNP_LIST   List of SNPs to output
  --snp-db SNP_DB       dbSNP_idx processed SNP idx
  --dry-run             Output mapping commands without execution
  --json JSON FILE      Output JSON file with details of pending commands
  --ignore-db           Ignore database for --dry-run and --json commands
  --ignore-dep          Ignore dependencies for --dry-run and --json commands
```


## Metadata
- **Skill**: generated
