cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - recab
label: bamutil_recab
doc: "Recalibrate\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: input BAM file name
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: output BAM file name (recalibrated qualities)
    inputBinding:
      position: 1
      prefix: --out
  - id: log
    type:
      - 'null'
      - string
    doc: 'log and summary statistics (default: [outfile].log)'
    inputBinding:
      position: 1
      prefix: --log
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose mode
    inputBinding:
      position: 1
      prefix: --verbose
  - id: ref_file
    type: File
    doc: reference file name
    inputBinding:
      position: 1
      prefix: --refFile
  - id: dbsnp
    type:
      - 'null'
      - File
    doc: dbsnp file of positions
    inputBinding:
      position: 1
      prefix: --dbsnp
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: 'minimum base quality of bases to recalibrate (default: 5)'
    inputBinding:
      position: 1
      prefix: --minBaseQual
  - id: max_base_qual
    type:
      - 'null'
      - int
    doc: 'maximum recalibrated base quality (default: 50)'
    inputBinding:
      position: 1
      prefix: --maxBaseQual
  - id: blended
    type:
      - 'null'
      - int
    doc: blended model weight
    inputBinding:
      position: 1
      prefix: --blended
  - id: fit_model
    type:
      - 'null'
      - boolean
    doc: check if the logistic regression model fits the data
    inputBinding:
      position: 1
      prefix: --fitModel
  - id: fast
    type:
      - 'null'
      - boolean
    doc: use a compact representation (at most 256 read groups, quality 63, 127 cycles)
    inputBinding:
      position: 1
      prefix: --fast
  - id: keep_prev_dbsnp
    type:
      - 'null'
      - boolean
    doc: do not exclude entries where the previous base is in dbsnp when building
      the recalibration table
    inputBinding:
      position: 1
      prefix: --keepPrevDbsnp
  - id: keep_prev_non_adjacent
    type:
      - 'null'
      - boolean
    doc: do not exclude entries where the previous base is not adjacent when building
      the recalibration table
    inputBinding:
      position: 1
      prefix: --keepPrevNonAdjacent
  - id: use_log_reg
    type:
      - 'null'
      - boolean
    doc: use logistic regression calculated quality for the new quality
    inputBinding:
      position: 1
      prefix: --useLogReg
  - id: qual_field
    type:
      - 'null'
      - string
    doc: tag to get the starting base quality (default is to get it from the Quality
      field)
    inputBinding:
      position: 1
      prefix: --qualField
  - id: store_qual_tag
    type:
      - 'null'
      - string
    doc: tag to store the previous quality into
    inputBinding:
      position: 1
      prefix: --storeQualTag
  - id: build_exclude_flags
    type:
      - 'null'
      - string
    doc: exclude reads with any of these flags set when building the recalibration
      table. Default is 0xF04
    inputBinding:
      position: 1
      prefix: --buildExcludeFlags
  - id: apply_exclude_flags
    type:
      - 'null'
      - string
    doc: do not apply the recalibration table to any reads with any of these flags
      set
    inputBinding:
      position: 1
      prefix: --applyExcludeFlags
  - id: bin_qual_s
    type:
      - 'null'
      - string
    doc: 'Bin the Qualities as specified (phred): minQualOfBin2, minQualofBin3...'
    inputBinding:
      position: 1
      prefix: --binQualS
  - id: bin_qual_f
    type:
      - 'null'
      - File
    doc: Bin the Qualities based on the specified file
    inputBinding:
      position: 1
      prefix: --binQualF
  - id: bin_custom
    type:
      - 'null'
      - boolean
    doc: Use the custom point of the quality bin (followed by colon) for the quality
      value of the bin.
    inputBinding:
      position: 1
      prefix: --binCustom
  - id: bin_mid
    type:
      - 'null'
      - boolean
    doc: Use the mid point of the quality bin range for the quality value of the bin.
    inputBinding:
      position: 1
      prefix: --binMid
  - id: bin_high
    type:
      - 'null'
      - boolean
    doc: Use the high end of the quality bin range for the quality value of the bin.
    inputBinding:
      position: 1
      prefix: --binHigh
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
  - id: output_file
    type: File
    doc: Recalibrated BAM file
    outputBinding:
      glob: $(inputs.out)
  - id: logs
    type: File[]
    doc: Log and summary statistics
    outputBinding:
      glob: '*.log'
  - id: recab_table
    type: File[]
    doc: Recalibration table
    outputBinding:
      glob: '*.qemp'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
