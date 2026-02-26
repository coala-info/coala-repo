cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_screen
label: fastq-screen_fastq_screen
doc: "Map sequences against multiple genomes\n\nTool homepage: https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen"
inputs:
  - id: fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FastQ files
    inputBinding:
      position: 1
  - id: add_genome
    type:
      - 'null'
      - string
    doc: "Edits the file 'fastq_screen.conf' (in the folder where this script is saved)
      to add a new genome. Specify the additional genome as a comma separated list:
      'Database name','Genome path and basename','Notes'"
    inputBinding:
      position: 102
      prefix: --add_genome
  - id: aligner
    type:
      - 'null'
      - string
    doc: Specify the aligner to use for the mapping. Valid arguments are 
      'bowtie', bowtie2' (default), 'bwa' or 'minimap2'. Bowtie maps with 
      parameters -k 2, Bowtie 2 with parameters -k 2 --very-fast-local and BWA 
      with mem -a. Local aligners such as BWA or Bowtie2 will be better at 
      detecting the origin of chimeric reads.
    default: bowtie2
    inputBinding:
      position: 102
      prefix: --aligner
  - id: bismark_params
    type:
      - 'null'
      - string
    doc: Specify extra parameters to be passed to Bismark. These parameters 
      should be quoted to clearly delimit Bismark parameters from FastQ Screen 
      parameters.
    inputBinding:
      position: 102
      prefix: --bismark
  - id: bisulfite
    type:
      - 'null'
      - boolean
    doc: Process bisulfite libraries. The path to the bisulfite aligner 
      (Bismark) may be specified in the configuration file. Bismark runs in 
      non-directional mode. Either conventional or bisulfite libraries may be 
      processed, but not both simultaneously. The --bisulfite option cannot be 
      used in conjunction with --bwa.
    inputBinding:
      position: 102
      prefix: --bisulfite
  - id: bowtie2_params
    type:
      - 'null'
      - string
    doc: Specify extra parameters to be passed to Bowtie 2. These parameters 
      should be quoted to clearly delimit Bowtie 2 parameters from FastQ Screen 
      parameters. You should not try to use this option to override the normal 
      search or reporting options for bowtie which are set automatically but it 
      might be useful to allow reads to be trimmed before alignment etc.
    inputBinding:
      position: 102
      prefix: --bowtie2
  - id: bowtie_params
    type:
      - 'null'
      - string
    doc: Specify extra parameters to be passed to Bowtie. These parameters 
      should be quoted to clearly delimit bowtie parameters from FastQ Screen 
      parameters. You should not try to use this option to override the normal 
      search or reporting options for bowtie which are set automatically but it 
      might be useful to allow reads to be trimmed before alignment etc.
    inputBinding:
      position: 102
      prefix: --bowtie
  - id: bwa_params
    type:
      - 'null'
      - string
    doc: Specify extra parameters to be passed to BWA. These parameters should 
      be quoted to clearly delimit BWA parameters from FastQ Screen parameters. 
      You should not try to use this option to override the normal search or 
      reporting options for BWA which are set automatically but it might be 
      useful to allow reads to be trimmed before alignment etc.
    inputBinding:
      position: 102
      prefix: --bwa
  - id: conf
    type:
      - 'null'
      - File
    doc: Manually specify a location for the configuration.
    inputBinding:
      position: 102
      prefix: --conf
  - id: filter
    type:
      - 'null'
      - string
    doc: "Produce a FASTQ file containing reads mapping to specified genomes. Pass
      the argument a string of characters (0, 1, 2, 3, -), in which each character
      corresponds to a reference genome (in the order the reference genome occurs
      in the configuration file). Below gives an explanation of each character. 0:
      Read does not map 1: Read maps uniquely 2: Read multi-maps 3: Read maps (one
      or more times) 4: Passes filter 0 or filter 1 5: Passes filter 0 or filter 2
      -: Do not apply filter to this genome Consider mapping to three genomes (A,
      B and C), the string '003' produces a file in which reads do not map to genomes
      A or B, but map (once or more) to genome C. The string '--1' would generate
      a file in which reads uniquely map to genome C. Whether reads map to genome
      A or B would be ignored. A read needs to pass all the genome filters to be considered
      valid (unless --pass specified). When --filter is used in conjuction with --tag,
      FASTQ files shall be mapped, tagged and then filtered. If the --tag option is
      not selected however, the input FASTQ file should have been previously tagged."
    inputBinding:
      position: 102
      prefix: --filter
  - id: force
    type:
      - 'null'
      - boolean
    doc: Do not terminate if output files already exist, instead overwrite the 
      files.
    inputBinding:
      position: 102
      prefix: --force
  - id: get_genomes
    type:
      - 'null'
      - boolean
    doc: Download pre-indexed Bowtie2 genomes for a range of commonly studied 
      species and sequences. If used with --bisulfite, Bismark bisulfite Bowtie2
      indices will be downloaded instead.
    inputBinding:
      position: 102
      prefix: --get_genomes
  - id: illumina1_3
    type:
      - 'null'
      - boolean
    doc: Assume that the quality values are in encoded in Illumina v1.3 format. 
      Defaults to Sanger format if this flag is not specified.
    inputBinding:
      position: 102
      prefix: --illumina1_3
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Inverts the --filter results i.e. reads that pass the --filter 
      parameter will not pass when --filter --inverse are specified together, 
      and vice versa.
    inputBinding:
      position: 102
      prefix: --inverse
  - id: minimap2_params
    type:
      - 'null'
      - string
    doc: Specify extra parameters to be passed to BWA. These parameters should 
      be quoted to clearly delimit minimap2 parameters from FastQ Screen 
      parameters. You should not try to use this option to override the normal 
      search or reporting options for minimap2 which are set automatically but 
      it might be useful to allow reads to be trimmed before alignment etc.
    inputBinding:
      position: 102
      prefix: --minimap2
  - id: nohits
    type:
      - 'null'
      - boolean
    doc: Writes to a file the sequences that did not map to any of the specified
      genomes. This option is equivalent to specifying --tag --filter 0000 
      (number of zeros corresponds to the number of genomes screened). By 
      default the whole input file will be mapped, unless overridden by 
      --subset.
    inputBinding:
      position: 102
      prefix: --nohits
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Specify a directory in which to save output files. If no directory is 
      specified then output files are saved in the current working directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: pass_filters
    type:
      - 'null'
      - int
    doc: Used in conjunction with --filter. By default all genome filters must 
      be passed for a read to pass the --filter option. However, a minimum 
      number of genome filters may be specified that a read needs pass to be 
      considered to pass the --filter option. (--pass 1 effecitively acts as an 
      OR boolean operator for the genome filters.)
    inputBinding:
      position: 102
      prefix: --pass
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all progress reports on stderr and only report errors.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: subset
    type:
      - 'null'
      - int
    doc: Don't use the whole sequence file, but create a temporary dataset of 
      this specified number of reads. The dataset created will be of 
      approximately (within a factor of 2) of this size. If the real dataset is 
      smaller than twice the specified size then the whole dataset will be used.
      Subsets will be taken evenly from throughout the whole original dataset. 
      By Default FastQ Screen runs with this parameter set to 100000. To process
      an entire dataset however, adjust --subset to 0.
    default: 100000
    inputBinding:
      position: 102
      prefix: --subset
  - id: tag
    type:
      - 'null'
      - boolean
    doc: Label each FASTQ read header with a tag listing to which genomes the 
      read did, or did not align. The first read in the output FASTQ file will 
      list the full genome names along with a score denoting whether the read 
      did not align (0), aligned uniquely to the specified genome (1), or 
      aligned more than once (2). In subsequent reads the genome names are 
      omitted and only the score is printed, in the same order as the first 
      line. This option results in the he whole file being processed unless 
      overridden explicitly by the user with the --subset parameter
    inputBinding:
      position: 102
      prefix: --tag
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify across how many threads bowtie will be allowed to run. 
      Overrides the default value set in the configuration file
    inputBinding:
      position: 102
      prefix: --threads
  - id: top
    type:
      - 'null'
      - string
    doc: Don't use the whole sequence file, but create a temporary dataset of 
      the specified number of reads taken from the top of the original file. It 
      is also possible to specify the number of lines to skip before beginning 
      the selection e.g. --top 100000,5000000 skips the first five million reads
      and selects the subsequent one hundred thousand reads. While this option 
      is usually faster than comparable --subset operations, it does not prevent
      biases arising from non-uniform distribution of reads in the original 
      FastQ file. This option should only be used when minimising processing 
      time is of highest priority.
    inputBinding:
      position: 102
      prefix: --top
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-screen:0.16.0--pl5321hdfd78af_0
stdout: fastq-screen_fastq_screen.out
