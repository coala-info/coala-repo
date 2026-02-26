cwlVersion: v1.2
class: CommandLineTool
baseCommand: mageck_count
label: mageck_count
doc: "Count reads for MAGeCK analysis.\n\nTool homepage: http://mageck.sourceforge.net"
inputs:
  - id: control_gene
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of genes whose sgRNAs are used as control sgRNAs for 
      normalization and for generating the null distribution of RRA.
    inputBinding:
      position: 101
      prefix: --control-gene
  - id: control_sgrna
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of control sgRNAs for normalization and for generating the null 
      distribution of RRA.
    inputBinding:
      position: 101
      prefix: --control-sgrna
  - id: count_n
    type:
      - 'null'
      - boolean
    doc: Count sgRNAs with Ns. By default, sgRNAs containing N will be 
      discarded.
    inputBinding:
      position: 101
      prefix: --count-n
  - id: count_pair
    type:
      - 'null'
      - boolean
    doc: 'Report all valid alignments per read or pair (default: False).'
    default: false
    inputBinding:
      position: 101
      prefix: --count-pair
  - id: count_table
    type: File
    doc: The read count table file. Only 1 file is accepted.
    inputBinding:
      position: 101
      prefix: --count-table
  - id: day0_label
    type:
      - 'null'
      - string
    doc: Turn on the negative selection QC and specify the label for control 
      sample (usually day 0 or plasmid). For every other sample label, the 
      negative selection QC will compare it with day0 sample, and estimate the 
      degree of negative selections in essential genes.
    inputBinding:
      position: 101
      prefix: --day0-label
  - id: fastq
    type:
      type: array
      items: File
    doc: Sample fastq files (or fastq.gz files, or SAM/BAM files after v0.5.5), 
      separated by space; use comma (,) to indicate technical replicates of the 
      same sample. For example, "--fastq 
      sample1_replicate1.fastq,sample1_replicate2.fastq 
      sample2_replicate1.fastq,sample2_replicate2.fastq" indicates two samples 
      with 2 technical replicates for each sample.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: fastq_2
    type:
      - 'null'
      - type: array
        items: File
    doc: Paired sample fastq files (or fastq.gz files), the order of which 
      should be consistent with that in fastq option.
    inputBinding:
      position: 101
      prefix: --fastq-2
  - id: gmt_file
    type:
      - 'null'
      - File
    doc: The pathway file used for QC, in GMT format. By default it will use the
      GMT file provided by MAGeCK.
    inputBinding:
      position: 101
      prefix: --gmt-file
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files.
    inputBinding:
      position: 101
      prefix: --keep-tmp
  - id: list_seq
    type: File
    doc: 'A file containing the list of sgRNA names, their sequences and associated
      genes. Support file format: csv and txt. Provide an empty file for collecting
      all possible sgRNA counts.'
    inputBinding:
      position: 101
      prefix: --list-seq
  - id: norm_method
    type:
      - 'null'
      - string
    doc: Method for normalization, including "none" (no normalization), "median"
      (median normalization, default), "total" (normalization by total read 
      counts), "control" (normalization by control sgRNAs specified by the 
      --control-sgrna option).
    default: median
    inputBinding:
      position: 101
      prefix: --norm-method
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: The prefix of the output file(s). Default sample1.
    default: sample1
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: pdf_report
    type:
      - 'null'
      - boolean
    doc: Generate pdf report of the fastq files.
    inputBinding:
      position: 101
      prefix: --pdf-report
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Reverse complement the sequences in library for read mapping.
    inputBinding:
      position: 101
      prefix: --reverse-complement
  - id: sample_label
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample labels, separated by comma (,). Must be equal to the number of 
      samples provided (in --fastq option). Default "sample1,sample2,...".
    inputBinding:
      position: 101
      prefix: --sample-label
  - id: sgrna_len
    type:
      - 'null'
      - int
    doc: 'Length of the sgRNA. Default 20. ATTENTION: after v0.5.3, the program will
      automatically determine the sgRNA length from library file; so only use this
      if you turn on the --unmapped-to-file option.'
    default: 20
    inputBinding:
      position: 101
      prefix: --sgrna-len
  - id: test_run
    type:
      - 'null'
      - boolean
    doc: Test running. If this option is on, MAGeCK will only process the first 
      1M records for each file.
    inputBinding:
      position: 101
      prefix: --test-run
  - id: trim_5
    type:
      - 'null'
      - string
    doc: Length of trimming the 5' of the reads. Users can specify multiple 
      trimming lengths, separated by comma (,); for example, "7,8". Use "AUTO" 
      to allow MAGeCK to automatically determine the trimming length. Default 
      AUTO.
    default: AUTO
    inputBinding:
      position: 101
      prefix: --trim-5
  - id: unmapped_to_file
    type:
      - 'null'
      - boolean
    doc: Save unmapped reads to file, with sgRNA lengths specified by 
      --sgrna-len option.
    inputBinding:
      position: 101
      prefix: --unmapped-to-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
stdout: mageck_count.out
