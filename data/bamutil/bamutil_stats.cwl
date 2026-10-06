cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - stats
label: bamutil_stats
doc: "Stats a SAM/BAM File\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to calculate stats for
    inputBinding:
      position: 1
      prefix: --in
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: basic
    type:
      - 'null'
      - boolean
    doc: Turn on basic statistic generation
    inputBinding:
      position: 1
      prefix: --basic
  - id: qual
    type:
      - 'null'
      - boolean
    doc: Generate a count for each quality (displayed as non-phred quality)
    inputBinding:
      position: 1
      prefix: --qual
  - id: phred
    type:
      - 'null'
      - boolean
    doc: Generate a count for each quality (displayed as phred quality)
    inputBinding:
      position: 1
      prefix: --phred
  - id: p_base_qc
    type:
      - 'null'
      - string
    doc: Write per base statistics as Percentages to the specified file. (use - for
      stdout)
    inputBinding:
      position: 1
      prefix: --pBaseQC
  - id: c_base_qc
    type:
      - 'null'
      - string
    doc: Write per base statistics as Counts to the specified file. (use - for stdout)
    inputBinding:
      position: 1
      prefix: --cBaseQC
  - id: max_num_reads
    type:
      - 'null'
      - int
    doc: 'Maximum number of reads to process (-1: all reads)'
    inputBinding:
      position: 1
      prefix: --maxNumReads
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: Only process unmapped reads (requires a bamIndex file)
    inputBinding:
      position: 1
      prefix: --unmapped
  - id: bam_index
    type:
      - 'null'
      - File
    doc: The path/name of the bam index file (if required and not specified, uses
      the --in value + ".bai")
    inputBinding:
      position: 1
      prefix: --bamIndex
  - id: region_list
    type:
      - 'null'
      - File
    doc: File containing the regions to be processed chr<tab>start_pos<tab>end_pos
      (0 based, end excluded). Uses bamIndex.
    inputBinding:
      position: 1
      prefix: --regionList
  - id: exclude_flags
    type:
      - 'null'
      - string
    doc: Skip any records with any of the specified flags set (integer representation)
    inputBinding:
      position: 1
      prefix: --excludeFlags
  - id: required_flags
    type:
      - 'null'
      - string
    doc: Only process records with all of the specified flags set (integer representation)
    inputBinding:
      position: 1
      prefix: --requiredFlags
  - id: within_region
    type:
      - 'null'
      - boolean
    doc: Only count qualities if they fall within regions specified (with regionList).
    inputBinding:
      position: 1
      prefix: --withinRegion
  - id: base_sum
    type:
      - 'null'
      - boolean
    doc: Print an overall summary of the baseQC for the file to stderr.
    inputBinding:
      position: 1
      prefix: --baseSum
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: 'Size of the pileup buffer for calculating the BaseQC parameters. Default:
      1024'
    inputBinding:
      position: 1
      prefix: --bufferSize
  - id: min_map_qual
    type:
      - 'null'
      - int
    doc: The minimum mapping quality for filtering reads in the baseQC stats.
    inputBinding:
      position: 1
      prefix: --minMapQual
  - id: dbsnp
    type:
      - 'null'
      - File
    doc: The dbSnp file of positions to exclude from baseQC analysis.
    inputBinding:
      position: 1
      prefix: --dbsnp
  - id: noeof
    type:
      - 'null'
      - boolean
    doc: Do not expect an EOF block on a bam file.
    inputBinding:
      position: 1
      prefix: --noeof
  - id: params
    type:
      - 'null'
      - boolean
    doc: Print the parameter settings
    inputBinding:
      position: 1
      prefix: --params
  - id: no_phone_home
    type:
      - 'null'
      - boolean
    doc: Do not send usage information (phone home)
    inputBinding:
      position: 1
      prefix: --noPhoneHome
  - id: phone_home_thinning
    type:
      - 'null'
      - int
    doc: Phone home thinning percentage [50]
    inputBinding:
      position: 1
      prefix: --phoneHomeThinning
outputs:
  - id: stats_stdout
    type: stdout
    doc: Statistics written to stdout
  - id: stats_stderr
    type: stderr
    doc: Statistics written to stderr (basic, qual, phred, baseSum)
  - id: base_qc
    type: File?
    doc: Per base statistics file (--pBaseQC or --cBaseQC)
    outputBinding:
      glob: '$(inputs.p_base_qc ? inputs.p_base_qc : inputs.c_base_qc ? inputs.c_base_qc
        : ''_none_'')'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stdout: bamutil_stats.out
stderr: bamutil_stats.txt
