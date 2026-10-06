cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - filter
label: bamutil_filter
doc: "Filter reads by clipping ends with too high of a mismatch percentage and by\
  \ marking reads unmapped if the quality of mismatches is too high\n\nTool homepage:\
  \ http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to be read
    inputBinding:
      position: 1
      prefix: --in
  - id: ref_file
    type: File
    doc: the reference file
    inputBinding:
      position: 1
      prefix: --refFile
  - id: out
    type: string
    doc: the SAM/BAM file to write to
    inputBinding:
      position: 1
      prefix: --out
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: maximum sum of the mismatch qualities before marking a read unmapped. (Defaults
      to 60)
    inputBinding:
      position: 1
      prefix: --qualityThreshold
  - id: default_quality_int
    type:
      - 'null'
      - int
    doc: quality value to use for mismatches that do not have a quality (Defaults
      to 20)
    inputBinding:
      position: 1
      prefix: --defaultQualityInt
  - id: mismatch_threshold
    type:
      - 'null'
      - float
    doc: maximum ratio of mismatches to matches and mismatches allowed before clipping
      from the ends (Defaults to .10)
    inputBinding:
      position: 1
      prefix: --mismatchThreshold
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
    doc: Filtered SAM/BAM file
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
