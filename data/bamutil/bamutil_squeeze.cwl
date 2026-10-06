cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - squeeze
label: bamutil_squeeze
doc: "Reduces files size by dropping OQ fields, duplicates, & specified tags, using\
  \ '=' when a base matches the reference, binning quality scores, and replacing readNames\
  \ with unique integers\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to be read
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: the SAM/BAM file to be written (.sam, .bam or .ubam)
    inputBinding:
      position: 1
      prefix: --out
  - id: ref_file
    type:
      - 'null'
      - File
    doc: reference file name used to convert any bases that match the reference to
      '='
    inputBinding:
      position: 1
      prefix: --refFile
  - id: keep_oq
    type:
      - 'null'
      - boolean
    doc: keep the OQ tag rather than removing it.  Default is to remove it.
    inputBinding:
      position: 1
      prefix: --keepOQ
  - id: keep_dups
    type:
      - 'null'
      - boolean
    doc: keep duplicates rather than removing records marked duplicate.
    inputBinding:
      position: 1
      prefix: --keepDups
  - id: read_name
    type:
      - 'null'
      - string
    doc: Replace read names with unique integers and write the mapping to the specified
      file (input need not be name sorted).
    inputBinding:
      position: 1
      prefix: --readName
  - id: s_read_name
    type:
      - 'null'
      - string
    doc: Replace read names with unique integers and write the mapping to the specified
      file (input presorted by readname).
    inputBinding:
      position: 1
      prefix: --sReadName
  - id: rm_tags
    type:
      - 'null'
      - string
    doc: Remove the specified Tags formatted as Tag:Type,Tag:Type,Tag:Type...
    inputBinding:
      position: 1
      prefix: --rmTags
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
    doc: Squeezed SAM/BAM file
    outputBinding:
      glob: $(inputs.out)
  - id: read_name_map
    type: File?
    doc: Read name to integer mapping file
    outputBinding:
      glob: '$(inputs.read_name ? inputs.read_name : inputs.s_read_name ? inputs.s_read_name
        : ''_none_'')'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
