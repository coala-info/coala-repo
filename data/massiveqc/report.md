# massiveqc CWL Generation Report

## massiveqc_MultiQC

### Tool Description
MultiQC is a modular tool to run multiple                       bioinformatics tools and aggregate their                       results into a single, interactive HTML report.

### Metadata
- **Docker Image**: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
- **Homepage**: https://github.com/shimw6828/MassiveQC
- **Package**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Total Downloads**: 9.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shimw6828/MassiveQC
- **Stars**: N/A
### Original Help Text
```text
usage: MultiQC [-h] [-c CONF] -i INPUT [-a ASCP_KEY] -f FASTQ_SCREEN_CONFIG -g
               GTF -x HT2_IDX [-k KNOWN_SPLICESITE_INFILE] -p PICARD -r
               REF_FLAT -o OUTDIR [-w WORKERS] [-t THREADS] [-d DOWNLOAD]
               [--only_download] [--skip_download] [--remove_fastq]
               [--remove_bam]

...

options:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF
  -i INPUT, --input INPUT
                        Input file, containing two columns srx and srr
  -a ASCP_KEY, --ascp_key ASCP_KEY
                        Locate aspera key. Default
                        $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh
  -f FASTQ_SCREEN_CONFIG, --fastq_screen_config FASTQ_SCREEN_CONFIG
                        Path to the fastq_screen conf file, can be download
                        from fastq_screen website
  -g GTF, --gtf GTF     Path to the GTF file with annotations
  -x HT2_IDX, --ht2-idx HT2_IDX
                        Hisat2 index filename prefix
  -k KNOWN_SPLICESITE_INFILE, --known-splicesite-infile KNOWN_SPLICESITE_INFILE
                        Hisat2 splicesite file, provide a list of known splice
                        sites
  -p PICARD, --picard PICARD
                        Path to picard.jar
  -r REF_FLAT, --ref_flat REF_FLAT
                        Path to refflat file
  -o OUTDIR, --outdir OUTDIR
                        Path to result output directory. If it doesn't exist,
                        it will be created automatically
  -w WORKERS, --workers WORKERS
                        The number of simultaneous tasks
  -t THREADS, --THREADS THREADS
                        The number of threads for tools like Hisat2 in one
                        task
  -d DOWNLOAD, --download DOWNLOAD
                        Path to SRA fastq files. The default is
                        $OUTDIR/download
  --only_download       Only run the download step
  --skip_download       Skip the download step
  --remove_fastq        Don't remain the fastq after running hisat2
  --remove_bam          Don't remain the bam after running FeatureCounts
```


## massiveqc_SingleQC

### Tool Description
Single-cell RNA-seq quality control tool

### Metadata
- **Docker Image**: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
- **Homepage**: https://github.com/shimw6828/MassiveQC
- **Package**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SingleQC [-h] [-c CONF] -s SRR [-a ASCP_KEY] -f FASTQ_SCREEN_CONFIG -g
                GTF -x HT2_IDX [-k KNOWN_SPLICESITE_INFILE] -p PICARD -r
                REF_FLAT -o OUTDIR [-t THREADS] [-d DOWNLOAD]
                [--only_download] [--skip_download] [--remove_fastq]
                [--remove_bam]

...

options:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF
  -s SRR, --srr SRR     SRR id
  -a ASCP_KEY, --ascp_key ASCP_KEY
                        Locate aspera key. Default=$HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh
  -f FASTQ_SCREEN_CONFIG, --fastq_screen_config FASTQ_SCREEN_CONFIG
                        Path to the fastq_screen conf file, can be download from fastq_screen website
  -g GTF, --gtf GTF     Path to the GTF file with annotations
  -x HT2_IDX, --ht2-idx HT2_IDX
                        Hisat2 index filename prefix
  -k KNOWN_SPLICESITE_INFILE, --known-splicesite-infile KNOWN_SPLICESITE_INFILE
                        Hisat2 splicesite file, provide a list of known splice sites
  -p PICARD, --picard PICARD
                        Path to picard.jar
  -r REF_FLAT, --ref_flat REF_FLAT
                        Path to refflat file
  -o OUTDIR, --outdir OUTDIR
                        Path to result output directory. If it doesn't exist, it will be created automatically
  -t THREADS, --THREADS THREADS
                        The number of threads for tools like Hisat2 in one task
  -d DOWNLOAD, --download DOWNLOAD
                        Path to SRA fastq files. The default is $OUTDIR/download
  --only_download       Only run the download step
  --skip_download       Skip the download step
  --remove_fastq        Don't remain the fastq after running hisat2
  --remove_bam          Don't remain the bam after running FeatureCounts
```


## massiveqc_fastq_screen

### Tool Description
FastQ Screen is intended to be used as part of a QC pipeline. It allows you to take a sequence dataset and search it against a set of bowtie databases. It will then generate both a text and a graphical summary of the results to see if the sequence dataset contains the kind of sequences you expect.

### Metadata
- **Docker Image**: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
- **Homepage**: https://github.com/shimw6828/MassiveQC
- **Package**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Validation**: PASS

### Original Help Text
```text
FastQ Screen - Map sequences against multiple genomes

www.bioinformatics.babraham.ac.uk/projects/fastq_screen

Synopsis

  fastq_screen [OPTIONS]... [FastQ FILE]...

Function

  FastQ Screen is intended to be used as part of a QC pipeline.
  It allows you to take a sequence dataset and search it
  against a set of bowtie databases.  It will then generate
  both a text and a graphical summary of the results to see if
  the sequence dataset contains the kind of sequences you expect.

Options

 --add_genome <text>  Edits the file 'fastq_screen.conf' (in the folder where
                      this script is saved) to add a new genome. Specify the 
                      additional genome as a comma separated list:
                      'Database name','Genome path and basename','Notes'

 --aligner <func>     Specify the aligner to use for the mapping. Valid 
                      arguments are 'bowtie', bowtie2' (default) or 'bwa'.  
                      Bowtie maps with parameters -k 2, Bowtie 2 with 
                      parameters -k 2 --very-fast-local and BWA with mem -a.  
                      Local aligners such as BWA or Bowtie2 will be better 
                      at detecting the origin of chimeric reads. 

 --bisulfite          Process bisulfite libraries. The path to the 
                      bisulfite aligner (Bismark) may be specified in the 
                      configuration file. Bismark runs in non-directional 
                      mode. Either conventional or bisulfite libraries may
                      be processed, but not both simultaneously. The 
                      --bisulfite option cannot be used in conjunction with 
                      --bwa.

 --bismark <text>     Specify extra parameters to be passed to Bismark. 
                      These parameters should be quoted to clearly 
                      delimit Bismark parameters from FastQ Screen 
                      parameters.                      

 --bowtie <text>      Specify extra parameters to be passed to Bowtie. 
                      These parameters should be quoted to clearly 
                      delimit bowtie parameters from FastQ Screen 
                      parameters. You should not try to use this option 
                      to override the normal search or reporting options 
                      for bowtie which are set automatically but it might 
                      be useful to allow reads to be trimmed before
                      alignment etc.

 --bowtie2 <text>     Specify extra parameters to be passed to Bowtie 2. 
                      These parameters should be quoted to clearly 
                      delimit Bowtie 2 parameters from FastQ Screen 
                      parameters. You should not try to use this option 
                      to override the normal search or reporting options 
                      for bowtie which are set automatically but it might 
                      be useful to allow reads to be trimmed before
                      alignment etc.  

 --bwa <text>         Specify extra parameters to be passed to BWA. 
                      These parameters should be quoted to clearly 
                      delimit BWA parameters from FastQ Screen 
                      parameters. You should not try to use this option 
                      to override the normal search or reporting options 
                      for BWA which are set automatically but it might 
                      be useful to allow reads to be trimmed before
                      alignment etc. 

 --conf <path>        Manually specify a location for the configuration.
 
 --filter <text>      Produce a FASTQ file containing reads mapping to 
                      specified genomes. Pass the argument a string of
                      characters (0, 1, 2, 3, -), in which each character 
                      corresponds to a reference genome (in the order the 
                      reference genome occurs in the configuration file).  
                      Below gives an explanation of each character.		
                      0: Read does not map
                      1: Read maps uniquely
                      2: Read multi-maps
                      3: Read maps (one or more times)
                      4: Passes filter 0 or filter 1
                      5: Passes filter 0 or filter 2
                      -: Do not apply filter to this genome
				
                      Consider mapping to three genomes (A, B and C), the 
                      string '003' produces a file in which reads do not 
                      map to genomes A or B, but map (once or more) to 
                      genome C.  The string '--1' would generate a file in 
                      which reads uniquely map to genome C. Whether reads 
                      map to genome A or B would be ignored.
					  
                      A read needs to pass all the genome filters to be
                      considered valid (unless --pass specified).
			   
                      When --filter is used in conjuction with --tag, FASTQ
                      files shall be mapped, tagged and then filtered. If
                      the --tag option is not selected however, the input 
                      FASTQ file should have been previously tagged.
				
 --force              Do not terminate if output files already exist,
                      instead overwrite the files.
 
 --get_genomes        Download pre-indexed Bowtie2 genomes for a range of
                      commonly studied species and sequences. If used with
                      --bisulfite, Bismark bisulfite Bowtie2 indices will
                      be downloaded instead.					  
					  
 --help               Print program help and exit.

 --illumina1_3        Assume that the quality values are in encoded in
                      Illumina v1.3 format. Defaults to Sanger format
                      if this flag is not specified.

 --inverse            Inverts the --filter results i.e. reads that pass
                      the --filter parameter will not pass when 
                      --filter --inverse are specified together, and vice
                      versa.					  

 --nohits             Writes to a file the sequences that did not map to 
                      any of the specified genomes. This option is 
                      equivalent to specifying --tag --filter 0000 (number
                      of zeros corresponds to the number of genomes
                      screened).  By default the whole input file will be
                      mapped, unless overridden by --subset.				

 --outdir <text>      Specify a directory in which to save output files.
                      If no directory is specified then output files
                      are saved in the current working directory.
					  
 --pass <int>         Used in conjunction with --filter. By default all
                      genome filters must be passed for a read to pass
                      the --filter option.  However, a minimum number 
                      of genome filters may be specified that a read
                      needs pass to be considered to pass the --filter
                      option. (--pass 1 effecitively acts as an OR
                      boolean operator for the genome filters.)					  
					  
 --quiet              Suppress all progress reports on stderr and only
                      report errors.

 --subset <int>       Don't use the whole sequence file, but create a 
                      temporary dataset of this specified number of 
                      reads. The dataset created will be of 
                      approximately (within a factor of 2) of this size. 
                      If the real dataset is smaller than twice the 
                      specified size then the whole dataset will be used. 
                      Subsets will be taken evenly from throughout the 
                      whole original dataset. By Default FastQ Screen 
                      runs with this parameter set to 100000. To process
                      an entire dataset however, adjust --subset to 0.

--tag                 Label each FASTQ read header with a tag listing to 
                      which genomes the read did, or did not align. The 
                      first read in the output FASTQ file will list the 
                      full genome names along with a score denoting 
                      whether the read did not align (0), aligned 
                      uniquely to the specified genome (1), or aligned 
                      more than once (2). In subsequent reads the 
                      genome names are omitted and only the score is 
                      printed, in the same order as the first line.

                      This option results in the he whole file being 
                      processed unless overridden explicitly by the user 
                      with the --subset parameter 

--threads <int>       Specify across how many threads bowtie will be
                      allowed to run. Overrides the default value set
                      in the configuration file

--top <int>/<int,int> Don't use the whole sequence file, but create a 
                      temporary dataset of the specified number of 
                      reads taken from the top of the original file. It is
                      also possible to specify the number of lines to skip
                      before beginning the selection e.g. 
                      --top 100000,5000000 skips the first five million 
                      reads and selects the subsequent one hundred thousand 
                      reads. While this option is usually faster than 
                      comparable --subset operations, it does not prevent 
                      biases arising from non-uniform distribution of 
                      reads in the original FastQ file. This option should 
                      only be used when minimising processing time is of 
                      highest priority. 

--version             Print the program version and exit.

2020 Babraham Institute, Cambridge, UK
```


## Metadata
- **Skill**: generated
