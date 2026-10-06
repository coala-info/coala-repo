cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - clipOverlap
label: bamutil_clipOverlap
doc: "Clip overlapping read pairs in a SAM/BAM File already sorted by Coordinate or\
  \ ReadName\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to clip overlaping read pairs for
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: the SAM/BAM file to be written
    inputBinding:
      position: 1
      prefix: --out
  - id: store_orig
    type:
      - 'null'
      - string
    doc: Store the original cigar in the specified tag.
    inputBinding:
      position: 1
      prefix: --storeOrig
  - id: read_name
    type:
      - 'null'
      - boolean
    doc: Original file is sorted by Read Name instead of coordinate.
    inputBinding:
      position: 1
      prefix: --readName
  - id: no_rn_validate
    type:
      - 'null'
      - boolean
    doc: Turn off alpha-numeric read name sorting validation.
    inputBinding:
      position: 1
      prefix: --noRNValidate
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Print some statistics on the overlaps.
    inputBinding:
      position: 1
      prefix: --stats
  - id: overlaps_only
    type:
      - 'null'
      - boolean
    doc: Only output overlapping read pairs
    inputBinding:
      position: 1
      prefix: --overlapsOnly
  - id: exclude_flags
    type:
      - 'null'
      - string
    doc: Skip records with any of the specified flags set, default 0xF0C
    inputBinding:
      position: 1
      prefix: --excludeFlags
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: Mark records that would be completely clipped as unmapped
    inputBinding:
      position: 1
      prefix: --unmapped
  - id: pool_size
    type:
      - 'null'
      - int
    doc: 'Maximum number of records the program is allowed to allocate for clipping
      on Coordinate sorted files. (Default: 1000000)'
    inputBinding:
      position: 1
      prefix: --poolSize
  - id: pool_skip_overlap
    type:
      - 'null'
      - boolean
    doc: Skip clipping reads to free of usable records when the poolSize is hit (listed
      as --poolSkipClip in the description).
    inputBinding:
      position: 1
      prefix: --poolSkipOverlap
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
    doc: SAM/BAM file with overlapping read pairs clipped
    outputBinding:
      glob: $(inputs.out)
  - id: log
    type: stderr
    doc: Statistics and messages (stderr)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stderr: bamutil_clipOverlap.log
