cwlVersion: v1.2
class: CommandLineTool
baseCommand: syri
label: syri
doc: "SyRI is a tool for identifying structural variations (SVs) in genomes based
  on pairwise alignments.\n\nTool homepage: https://github.com/schneebergerlab/syri"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Use duplications too for variant identification
    default: false
    inputBinding:
      position: 101
      prefix: --all
  - id: allow_offset
    type:
      - 'null'
      - int
    doc: BPs allowed to overlap
    default: 5
    inputBinding:
      position: 101
      prefix: --allow-offset
  - id: bruteruntime
    type:
      - 'null'
      - int
    doc: Cutoff to restrict brute force methods to take too much time (in 
      seconds). Smaller values would make algorithm faster, but could have 
      marginal effects on accuracy. In general case, would not be required.
    default: 60
    inputBinding:
      position: 101
      prefix: -b
  - id: cigar
    type:
      - 'null'
      - boolean
    doc: Find SNPs/indels using CIGAR string. Necessary for alignments generated
      using aligners other than nucmers
    default: false
    inputBinding:
      position: 101
      prefix: --cigar
  - id: delta
    type:
      - 'null'
      - File
    doc: .delta file from mummer. Required for short variation (SNPs/indels) 
      identification when CIGAR string is not available
    inputBinding:
      position: 101
      prefix: -d
  - id: dir
    type:
      - 'null'
      - Directory
    doc: path to working directory (if not current directory). All files must be
      in this directory.
    default: None
    inputBinding:
      position: 101
      prefix: --dir
  - id: filter_alignments
    type:
      - 'null'
      - boolean
    doc: As a default, syri filters out low quality and small alignments. Use 
      this parameter to use the full list of alignments without any filtering.
    default: true
    inputBinding:
      position: 101
      prefix: -f
  - id: hdrseq
    type:
      - 'null'
      - boolean
    doc: Output highly-diverged regions (HDRs) sequence.
    default: false
    inputBinding:
      position: 101
      prefix: --hdrseq
  - id: increaseby
    type:
      - 'null'
      - int
    doc: Minimum score increase required to add another alignment to 
      translocation cluster solution
    default: 1000
    inputBinding:
      position: 101
      prefix: --inc
  - id: infile
    type: File
    doc: File containing alignment coordinates
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file_type
    type:
      - 'null'
      - string
    doc: 'Input file type. T: Table, S: SAM, B: BAM, P: PAF'
    default: T
    inputBinding:
      position: 101
      prefix: -F
  - id: invgaplen
    type:
      - 'null'
      - int
    doc: Maximum allowed gap-length between two alignments of a multi-alignment 
      inversion. It affects the selection of large inversions that can have 
      different length in the reference and query genomes.
    default: 1000000000
    inputBinding:
      position: 101
      prefix: --invgaplen
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: Keep intermediate output files
    default: false
    inputBinding:
      position: 101
      prefix: -k
  - id: log
    type:
      - 'null'
      - string
    doc: log level
    default: INFO
    inputBinding:
      position: 101
      prefix: --log
  - id: log_file
    type:
      - 'null'
      - File
    doc: Name of log file
    default: syri.log
    inputBinding:
      position: 101
      prefix: --lf
  - id: maxsize
    type:
      - 'null'
      - int
    doc: Max size for printing sequence of large SVs (insertions, deletions and 
      HDRs). Only affect printing (.out/.vcf file) and not the selection. SVs 
      larger than this value would be printed as symbolic SVs. For no cut-off 
      use -1.
    default: -1
    inputBinding:
      position: 101
      prefix: --maxsize
  - id: ncores
    type:
      - 'null'
      - int
    doc: number of cores to use in parallel (max is number of chromosomes)
    default: 1
    inputBinding:
      position: 101
      prefix: --nc
  - id: no_chrmatch
    type:
      - 'null'
      - boolean
    doc: Do not allow SyRI to automatically match chromosome ids between the two
      genomes if they are not equal
    default: false
    inputBinding:
      position: 101
      prefix: --no-chrmatch
  - id: nosnp
    type:
      - 'null'
      - boolean
    doc: Set to skip SNP/Indel (within alignment) identification
    default: false
    inputBinding:
      position: 101
      prefix: --nosnp
  - id: nosr
    type:
      - 'null'
      - boolean
    doc: Set to skip structural rearrangement identification
    default: false
    inputBinding:
      position: 101
      prefix: --nosr
  - id: nosv
    type:
      - 'null'
      - boolean
    doc: Set to skip structural variation identification
    default: false
    inputBinding:
      position: 101
      prefix: --nosv
  - id: novcf
    type:
      - 'null'
      - boolean
    doc: Do not combine all files into one output file
    default: false
    inputBinding:
      position: 101
      prefix: --novcf
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add before the output file Names
    default: ''
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qry
    type:
      - 'null'
      - File
    doc: Genome B (which is considered as query for the alignments). Required 
      for local variation (large indels, CNVs) identification.
    inputBinding:
      position: 101
      prefix: -q
  - id: ref
    type:
      - 'null'
      - File
    doc: Genome A (which is considered as reference for the alignments). 
      Required for local variation (large indels, CNVs) identification.
    inputBinding:
      position: 101
      prefix: -r
  - id: samplename
    type:
      - 'null'
      - string
    doc: Sample name to be used in the output VCF file.
    default: sample
    inputBinding:
      position: 101
      prefix: --samplename
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for generating random numbers
    default: 1
    inputBinding:
      position: 101
      prefix: --seed
  - id: show_snps_path
    type:
      - 'null'
      - File
    doc: path to show-snps from mummer
    default: show-snps
    inputBinding:
      position: 101
      prefix: -s
  - id: tdgaplen
    type:
      - 'null'
      - int
    doc: Maximum allowed gap-length between two alignments of a multi-alignment 
      translocation or duplication (TD). Larger values increases TD 
      identification sensitivity but also runtime.
    default: 500000
    inputBinding:
      position: 101
      prefix: --tdgaplen
  - id: tdmaxolp
    type:
      - 'null'
      - float
    doc: Maximum allowed overlap between two translocations. Value should be in 
      range (0,1].
    default: 0.8
    inputBinding:
      position: 101
      prefix: --tdmaxolp
  - id: transunicount
    type:
      - 'null'
      - int
    doc: Number of uniques bps for selecting translocation. Smaller values would
      select smaller TLs better, but may increase time and decrease accuracy.
    default: 1000
    inputBinding:
      position: 101
      prefix: --unic
  - id: transuniperecent
    type:
      - 'null'
      - float
    doc: Percent of unique region requried to select translocation. Value should
      be in range (0,1]. Smaller values would allow selection of TDs which are 
      more overlapped with other regions.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --unip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syri:1.7.1--py311hcf77733_1
stdout: syri.out
