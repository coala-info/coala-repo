# fusioncatcher CWL Generation Report

## fusioncatcher

### Tool Description
FusionCatcher searches for novel and known somatic gene fusions in RNA-seq paired-end/single-end reads data produced by the Illumina sequencing platforms (like for example: Illumina HiSeq 2500, Illumina HiSeq 2000, Illumina HiSeq X, Illumina NextSeq 500, Illumina GAIIx, Illumina GAII, Illumina MiSeq, Illumina MiniSeq).

### Metadata
- **Docker Image**: quay.io/biocontainers/fusioncatcher:1.33--hdfd78af_6
- **Homepage**: https://github.com/ndaniel/fusioncatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/fusioncatcher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fusioncatcher/overview
- **Total Downloads**: 21.5K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/ndaniel/fusioncatcher
- **Stars**: N/A
### Original Help Text
```text
Usage: fusioncatcher.py [options]

FusionCatcher searches for novel and known somatic gene fusions in RNA-seq
paired-end/single-end reads data produced by the Illumina sequencing
platforms (like for example: Illumina HiSeq 2500,  Illumina HiSeq 2000,
Illumina HiSeq X, Illumina NextSeq 500,  Illumina GAIIx, Illumina GAII,
Illumina MiSeq, Illumina MiniSeq).

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FILENAME, --input=INPUT_FILENAME
                        The input file(s) or directory. The files should be in
                        FASTQ or SRA format and may be or not compressed using
                        gzip or zip. A list of files can be specified by given
                        the filenames separated by comma. If a directory is
                        given then it will analyze all the files found with
                        the following extensions: .sra, .fastq, .fastq.zip,
                        .fastq.gz, .fastq.bz2, fastq.xz, .fq, .fq.zip, .fq.gz,
                        .fq.bz2, fz.xz, .txt, .txt.zip, .txt.gz, .txt.bz2 .
  --batch               If this is used then batch mode is used and the input
                        specified using '--input' or '-i' is: (i) a tab-
                        separated text file containing a each line such that
                        there is one sample per line and first column are the
                        FASTQ files' full pathnames/URLs, separated by commas,
                        corresponding to the sample and an optional second
                        column containing the name for the sample, or (ii) a
                        input directory which contains a several
                        subdirectories such that each subdirectory corresponds
                        to only one sample and it contains all the FASTQ files
                        corresponding to that sample. This is useful when
                        several samples needs to be analyzed.
  --single-end          If this is used then it is assumed that all the input
                        reads are single-end reads which must be longer than
                        130 bp. Be default it is assumed that all input reads
                        come from a paired-end reads.
  -I NORMAL_MATCHED_FILENAME, --normal=NORMAL_MATCHED_FILENAME
                        The input file(s) or directory containing the healthy
                        normal-matched data. They should be given in the same
                        format as for '--input'. In case that this option is
                        used then the files/directory given to '--input' is
                        considered to be from the sample of a patient with
                        disease. This is optional.
  -o OUTPUT_DIRECTORY, --output=OUTPUT_DIRECTORY
                        The output directory where all the output files
                        containing information about the found candidate
                        fusiongenes are written. Default is 'none'.
  -d DATA_DIRECTORY, --data=DATA_DIRECTORY
                        The data directory where all the annotations files
                        from Ensembl database are placed, e.g. 'data/'. This
                        directory should be built using 'fusioncatcher-build'.
                        If it is not used then it is read from configuration
                        file specified with '--config' from 'data = ...' line.
  -T TMP_DIRECTORY, --tmp=TMP_DIRECTORY
                        The temporary directory where all the outputs files
                        and directories will be written. Default is directory
                        'tmp' in the output directory specified with '--
                        output'.
  -p PROCESSES, --threads=PROCESSES
                        Number or processes/threads to be used for running
                        SORT, Bowtie, BLAT, STAR, BOWTIE2 and other
                        tools/programs. If it is 0 (as it is by default) then
                        the number of processes/threads will be read first
                        from 'fusioncatcher/etc/configuration.cfg' file. If
                        even there it is still set to 0 then 'min(number-of-
                        CPUs-found,32)' processes will be used. Setting number
                        of threads in 'fusioncatcher/etc/configuration.cfg'
                        might be usefull in situations where one server is
                        shared between several users and in order to limit
                        FusionCatcher using all the CPUs/resources. Default is
                        '0'.
  --config=CONFIGURATION_FILENAME
                        Configuration file containing the paths to external
                        tools (e.g. Bowtie, Blat, fastq-dump.) in case that
                        they are not specified in PATH variable! Default is '/
                        usr/local/etc/configuration.cfg,/usr/local/bin/configu
                        ration.cfg'.
  -F, --force-paths     If it is specified then all external tools and all
                        Python tools will be executed by FusionCatcher by
                        using their corresponding absolute paths, which will
                        be obined from the fusioncatcher/bin/configuration.cfg
                        file. By default no paths are specified when executing
                        tools/scripts. Default is 'False'.
  -Z, --no-update-check
                        Skips the automatic routine that contacts the
                        FusionCatcher server to check for a more recent
                        version. Default is 'False'.
  --skip-parsort        It skips using GNU PARSORT and instead is using
                        classic SORT.
  --skip-fastqtk        It skips using FASTQTK.
  -V, --keep-viruses-alignments
                        If it is set then the SAM alignments files of reads
                        mapping on viruses genomes are saved in the output
                        directory for later inspection by the user. Default is
                        'False'.
  -U, --keep-unmapped-reads
                        If it is set then the FASTQ files, containing the
                        unmapped reads (i.e. reads which do not map on genome
                        and transcriptome), are saved in the output directory
                        for later inspection by the user. Default is 'False'.
  --aligners=ALIGNERS   The aligners to be used on Bowtie aligner. By default
                        always BOWTIE aligner is used and it cannot be
                        disabled. The choices are: ['blat','star','bowtie2'].
                        Any combination of these is accepted if the aligners'
                        names are comma separated. For example, if one wants
                        to used all four aligners then 'blat,star,bowtie2'
                        should be given. The command line options '--skip-
                        blat', '--skip-star', and '--skip-bowtie2' have
                        priority over this option. If the first element in the
                        list is the configuration file (that is '.cfg' file)
                        of FusionCatcher then the aligners specified in the
                        list of aligners specified in the configuration file
                        will be used (and the rest of aligner specified here
                        will be ignored). In case that the configuration file
                        is not found then the following aligners from the list
                        will be used. Default is
                        '/usr/local/etc/configuration.cfg,blat,star'.
  --skip-blat           If it is set then the pipeline will NOT use the BLAT
                        aligner and all options and methods which make use of
                        BLAT will be disabled. BLAT aligner is used by
                        default. Please, note that BLAT license does not allow
                        BLAT to be used for commercial activities. Fore more
                        information regarding BLAT please see its license:
                        <http://users.soe.ucsc.edu/~kent/src/>. Default is
                        'False'.
  --skip-star           If it is set then the pipeline will NOT use the STAR
                        aligner and all options and methods which make use of
                        STAR will be disabled. STAR aligner is used by
                        default. Default is 'False'.
  --skip-conversion-grch37
                        If it is set then the fusion coordinates for human
                        genome version GRCh38 (which is default) will NOT be
                        reported also using version GRCh37/hg19. Default is
                        'False'.
  --limitSjdbInsertNsj=LIMITSJDBINSERTNSJ
                        This option is passed diretly to STAR aligner For more
                        info see STAR aligner regarding this option. Default
                        is '2000000'.
  --limitOutSJcollapsed=LIMITOUTSJCOLLAPSED
                        This option is passed diretly to STAR aligner For more
                        info see STAR aligner regarding this option. Default
                        is '1000000'.
  --sort-buffer-size=SORT_BUFFER_SIZE
                        It specifies the buffer size for command SORT. Default
                        is '80%' if less than 32GB RAM is installed on
                        computer else is set to 26GB.
  --start=START_STEP    It re-starts executing the workflow/pipeline from the
                        given step number. This can be used when the pipeline
                        has crashed/stopped and one wants to re-run it from
                        from the step where it stopped without re-running from
                        the beginning the entire pipeline. 0 is for restarting
                        automatically and 1 is the first step. Default is '0'.
  --Xmx=XMX             The amount of memory to be used by Java tools. This
                        will be passed to Javas '-Xmx' so for more info see
                        '-Xmx' in java.Default is '18g'.
  --reads=READS         Only the first reads from the input FASTQ files will
                        be used. Default is '0'.

Author: Daniel Nicorici 
Email: Daniel.Nicorici@gmail.com 
Copyright (c) 2009-2021, Daniel Nicorici 
 
EXAMPLE:
========

fusioncatcher  -d /some/data/directory/  -i /some/input/directory/containing/fastq/files/  -o /some/output/directory/


where /some/data/directory/ contains data which was built previously by running:


fusioncatcher-build -g homo_sapiens -o /some/data/directory/

or it has been downloaded (see: FusionCatcher's manual, section 'Downloading/building organism's data').

NOTE:
'fusioncatcher-build' needs to be run only once (for each organism
or when the Ensembl database is updated) and 'fusioncatcher'
will reuse the '/some/data/directory/'.
```

