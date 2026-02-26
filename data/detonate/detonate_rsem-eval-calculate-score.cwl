cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-eval-calculate-score
label: detonate_rsem-eval-calculate-score
doc: "Calculates RSEM-EVAL score and expression values using alignments.\n\nTool homepage:
  https://github.com/deweylab/detonate"
inputs:
  - id: input
    type: File
    doc: SAM/BAM formatted input file. If "-" is specified for the filename, 
      SAM/BAM input is instead assumed to come from standard input. RSEM-EVAL 
      requires all alignments of the same read group together. For paired-end 
      reads, RSEM-EVAL also requires the two mates of any alignment be adjacent.
      See Description section for how to make input file obey RSEM-EVAL's 
      requirements.
    inputBinding:
      position: 1
  - id: upstream_read_files
    type:
      type: array
      items: File
    doc: Comma-separated list of files containing single-end reads or upstream 
      reads for paired-end data. By default, these files are assumed to be in 
      FASTQ format. If the --no-qualities option is specified, then FASTA format
      is expected.
    inputBinding:
      position: 2
  - id: assembly_fasta_file
    type: File
    doc: A multi-FASTA file contains the assembly used for calculating RSEM-EVAL
      score.
    inputBinding:
      position: 3
  - id: downstream_read_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of files containing downstream reads which are 
      paired with the upstream reads. By default, these files are assumed to be 
      in FASTQ format. If the --no-qualities option is specified, then FASTA 
      format is expected.
    inputBinding:
      position: 4
  - id: sample_name
    type: string
    doc: The name of the sample analyzed. All output files are prefixed by this 
      name (e.g., sample_name.isoforms.results).
    inputBinding:
      position: 5
  - id: L
    type: float
    doc: For single-end data, L represents the average read length. For 
      paired-end data, L represents the average fragment length. It should be a 
      positive integer (real value will be rounded to the nearest integer).
    inputBinding:
      position: 6
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Input file is in BAM format.
    default: false
    inputBinding:
      position: 107
      prefix: --bam
  - id: bowtie2
    type:
      - 'null'
      - boolean
    doc: Use Bowtie 2 instead of Bowtie to align reads. Since currently 
      RSEM-EVAL does not handle indel, local and discordant alignments, the 
      Bowtie2 parameters are set in a way to avoid those alignments. In 
      particular, we use options '--sensitive --dpad 0 --gbar 99999999 --mp 1,1 
      --np 1 --score-min L,0,-0.1' by default. "-0.1", the last parameter of 
      '--score-min' is the negative value of the maximum mismatch rate allowed. 
      This rate can be set by option '--bowtie2-mismatch-rate'. If reads are 
      paired-end, we additionally use options '--no-mixed' and 
      '--no-discordant'.
    default: false
    inputBinding:
      position: 107
      prefix: --bowtie2
  - id: bowtie2_k
    type:
      - 'null'
      - int
    doc: '(Bowtie 2 parameter) Find up to <int> alignments per read. (Default: 200)'
    default: 200
    inputBinding:
      position: 107
      prefix: --bowtie2-k
  - id: bowtie2_mismatch_rate
    type:
      - 'null'
      - float
    doc: (Bowtie 2 parameter) The maximum mismatch rate allowed.
    default: 0.1
    inputBinding:
      position: 107
      prefix: --bowtie2-mismatch-rate
  - id: bowtie2_path
    type:
      - 'null'
      - Directory
    doc: (Bowtie 2 parameter) The path to the Bowtie 2 executables.
    default: the path to the Bowtie 2 executables is assumed to be in the user's
      PATH environment variable
    inputBinding:
      position: 107
      prefix: --bowtie2-path
  - id: bowtie2_sensitivity_level
    type:
      - 'null'
      - string
    doc: "(Bowtie 2 parameter) Set Bowtie 2's preset options in --end-to-end mode.
      This option controls how hard Bowtie 2 tries to find alignments. <string> must
      be one of \"very_fast\", \"fast\", \"sensitive\" and \"very_sensitive\". The
      four candidates correspond to Bowtie 2's \"--very-fast\", \"--fast\", \"--sensitive\"\
      \ and \"--very-sensitive\" options. (Default: \"sensitive\" - use Bowtie 2's
      default)"
    default: sensitive
    inputBinding:
      position: 107
      prefix: --bowtie2-sensitivity-level
  - id: bowtie_chunkmbs
    type:
      - 'null'
      - int
    doc: "(Bowtie parameter) memory allocated for best first alignment calculation
      (Default: 0 - use Bowtie's default)"
    default: 0
    inputBinding:
      position: 107
      prefix: --bowtie-chunkmbs
  - id: bowtie_e
    type:
      - 'null'
      - int
    doc: '(Bowtie parameter) max sum of mismatch quality scores across the alignment.
      (Default: 99999999)'
    default: 99999999
    inputBinding:
      position: 107
      prefix: --bowtie-e
  - id: bowtie_m
    type:
      - 'null'
      - int
    doc: '(Bowtie parameter) suppress all alignments for a read if > <int> valid alignments
      exist. (Default: 200)'
    default: 200
    inputBinding:
      position: 107
      prefix: --bowtie-m
  - id: bowtie_n
    type:
      - 'null'
      - int
    doc: '(Bowtie parameter) max # of mismatches in the seed. (Range: 0-3, Default:
      2)'
    default: 2
    inputBinding:
      position: 107
      prefix: --bowtie-n
  - id: bowtie_path
    type:
      - 'null'
      - Directory
    doc: The path to the Bowtie executables.
    default: the path to the Bowtie executables is assumed to be in the user's 
      PATH environment variable
    inputBinding:
      position: 107
      prefix: --bowtie-path
  - id: estimate_rspd
    type:
      - 'null'
      - boolean
    doc: Set this option if you want to estimate the read start position 
      distribution (RSPD) from data. Otherwise, RSEM-EVAL will use a uniform 
      RSPD.
    default: false
    inputBinding:
      position: 107
      prefix: --estimate-rspd
  - id: forward_prob
    type:
      - 'null'
      - float
    doc: Probability of generating a read from the forward strand of a 
      transcript. Set to 1 for a strand-specific protocol where all (upstream) 
      reads are derived from the forward strand, 0 for a strand-specific 
      protocol where all (upstream) read are derived from the reverse strand, or
      0.5 for a non-strand-specific protocol.
    default: 0.5
    inputBinding:
      position: 107
      prefix: --forward-prob
  - id: fragment_length_max
    type:
      - 'null'
      - int
    doc: Maximum read(SE)/fragment(PE) length allowed. This is also the value 
      for the Bowtie/Bowtie 2 -X option.
    default: 1000
    inputBinding:
      position: 107
      prefix: --fragment-length-max
  - id: fragment_length_min
    type:
      - 'null'
      - int
    doc: Minimum read(SE)/fragment(PE) length allowed. This is also the value 
      for the Bowtie/Bowtie2 -I option.
    default: 1
    inputBinding:
      position: 107
      prefix: --fragment-length-min
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary files generated by RSEM-EVAL. RSEM-EVAL creates a 
      temporary directory, 'sample_name.temp', into which it puts all 
      intermediate output files. If this directory already exists, RSEM-EVAL 
      overwrites all files generated by previous RSEM-EVAL runs inside of it. By
      default, after RSEM-EVAL finishes, the temporary directory is deleted. Set
      this option to prevent the deletion of this directory and the intermediate
      files inside of it.
    default: false
    inputBinding:
      position: 107
      prefix: --keep-intermediate-files
  - id: no_qualities
    type:
      - 'null'
      - boolean
    doc: Input reads do not contain quality scores.
    default: false
    inputBinding:
      position: 107
      prefix: --no-qualities
  - id: num_rspd_bins
    type:
      - 'null'
      - int
    doc: Number of bins in the RSPD. Only relevant when '--estimate-rspd' is 
      specified. Use of the default setting is recommended.
    default: 20
    inputBinding:
      position: 107
      prefix: --num-rspd-bins
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Both Bowtie/Bowtie2, expression estimation 
      and 'samtools sort' will use this many threads.
    default: 1
    inputBinding:
      position: 107
      prefix: --num-threads
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: Generate BAM outputs.
    default: false
    inputBinding:
      position: 107
      prefix: --output-bam
  - id: overlap_size
    type:
      - 'null'
      - int
    doc: The minimum overlap size required to join two reads together.
    default: 0
    inputBinding:
      position: 107
      prefix: --overlap-size
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Input reads are paired-end reads.
    default: false
    inputBinding:
      position: 107
      prefix: --paired-end
  - id: phred33_quals
    type:
      - 'null'
      - boolean
    doc: Input quality scores are encoded as Phred+33.
    default: true
    inputBinding:
      position: 107
      prefix: --phred33-quals
  - id: phred64_quals
    type:
      - 'null'
      - boolean
    doc: Input quality scores are encoded as Phred+64 (default for GA Pipeline 
      ver. >= 1.3).
    default: false
    inputBinding:
      position: 107
      prefix: --phred64-quals
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress the output of logging information.
    default: false
    inputBinding:
      position: 107
      prefix: --quiet
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Input file is in SAM format.
    default: false
    inputBinding:
      position: 107
      prefix: --sam
  - id: sam_header_info
    type:
      - 'null'
      - File
    doc: RSEM-EVAL reads header information from input by default. If this 
      option is on, header information is read from the specified file. For the 
      format of the file, please see SAM official website.
    default: ''
    inputBinding:
      position: 107
      prefix: --sam-header-info
  - id: sampling_for_bam
    type:
      - 'null'
      - boolean
    doc: When RSEM-EVAL generates a BAM file, instead of outputing all 
      alignments a read has with their posterior probabilities, one alignment is
      sampled according to the posterior probabilities. The sampling procedure 
      includes the alignment to the "noise" transcript, which does not appear in
      the BAM file. Only the sampled alignment has a weight of 1. All other 
      alignments have weight 0. If the "noise" transcript is sampled, all 
      alignments appeared in the BAM file should have weight 0.
    default: false
    inputBinding:
      position: 107
      prefix: --sampling-for-bam
  - id: samtools_sort_mem
    type:
      - 'null'
      - string
    doc: Set the maximum memory per thread that can be used by 'samtools sort'. 
      <string> represents the memory and accepts suffices 'K/M/G'. RSEM-EVAL 
      will pass <string> to the '-m' option of 'samtools sort'. Please note that
      the default used here is different from the default used by samtools.
    default: 1G
    inputBinding:
      position: 107
      prefix: --samtools-sort-mem
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the seed for the random number generators used in calculating 
      posterior mean estimates and credibility intervals. The seed must be a 
      non-negative 32 bit interger.
    inputBinding:
      position: 107
      prefix: --seed
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Seed length used by the read aligner. Providing the correct value is 
      important for RSEM-EVAL. If RSEM-EVAL runs Bowtie, it uses this value for 
      Bowtie's seed length parameter. Any read with its or at least one of its 
      mates' (for paired-end reads) length less than this value will be ignored.
      If the references are not added poly(A) tails, the minimum allowed value 
      is 5, otherwise, the minimum allowed value is 25. Note that this script 
      will only check if the value >= 5 and give a warning message if the value 
      < 25 but >= 5.
    default: 25
    inputBinding:
      position: 107
      prefix: --seed-length
  - id: solexa_quals
    type:
      - 'null'
      - boolean
    doc: Input quality scores are solexa encoded (from GA Pipeline ver. < 1.3).
    default: false
    inputBinding:
      position: 107
      prefix: --solexa-quals
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: The RNA-Seq protocol used to generate the reads is strand specific, 
      i.e., all (upstream) reads are derived from the forward strand. This 
      option is equivalent to --forward-prob=1.0. With this option set, if 
      RSEM-EVAL runs the Bowtie/Bowtie 2 aligner, the '--norc' Bowtie/Bowtie 2 
      option will be used, which disables alignment to the reverse strand of 
      transcripts.
    default: false
    inputBinding:
      position: 107
      prefix: --strand-specific
  - id: tag
    type:
      - 'null'
      - string
    doc: The name of the optional field used in the SAM input for identifying a 
      read with too many valid alignments. The field should have the format 
      <tagName>:i:<value>, where a <value> bigger than 0 indicates a read with 
      too many alignments.
    default: ''
    inputBinding:
      position: 107
      prefix: --tag
  - id: temporary_folder
    type:
      - 'null'
      - string
    doc: Set where to put the temporary files generated by RSEM-EVAL. If the 
      folder specified does not exist, RSEM-EVAL will try to create it.
    default: sample_name.temp
    inputBinding:
      position: 107
      prefix: --temporary-folder
  - id: time
    type:
      - 'null'
      - boolean
    doc: Output time consumed by each step of RSEM-EVAL to 'sample_name.time'.
    default: false
    inputBinding:
      position: 107
      prefix: --time
  - id: transcript_length_mean
    type:
      - 'null'
      - float
    doc: The mean of true transcript length distribution. This option is used 
      together with '--transcript-length-sd' and mutually exclusive with 
      '--estimate-transcript-length-distribution'.
    inputBinding:
      position: 107
      prefix: --transcript-length-mean
  - id: transcript_length_parameters
    type:
      - 'null'
      - File
    doc: Read the true transcript length distribution's mean and standard 
      deviation from <file>. This option is mutually exclusive with 
      '--transcript-length-mean' and '--transcript-length-sd'.
    inputBinding:
      position: 107
      prefix: --transcript-length-parameters
  - id: transcript_length_sd
    type:
      - 'null'
      - float
    doc: The standard deviation of true transcript length distribution. This 
      option is used together with '--transcript-length-mean' and mutually 
      exclusive with '--estimate-transcript-length-distribution'.
    inputBinding:
      position: 107
      prefix: --transcript-length-sd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/detonate:1.11--boost1.64_1
stdout: detonate_rsem-eval-calculate-score.out
