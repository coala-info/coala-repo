cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - revert
label: bamutil_revert
doc: "Revert SAM/BAM replacing the specified fields with their previous values (if\
  \ known) and removes specified tags\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
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
  - id: cigar
    type:
      - 'null'
      - boolean
    doc: update the cigar and the position based on the OC & OP tags.
    inputBinding:
      position: 1
      prefix: --cigar
  - id: qual
    type:
      - 'null'
      - boolean
    doc: update the quality based on the OQ tag.
    inputBinding:
      position: 1
      prefix: --qual
  - id: keep_tags
    type:
      - 'null'
      - boolean
    doc: keep the tags that are used to update the record.  Default is to remove them.
    inputBinding:
      position: 1
      prefix: --keepTags
  - id: rm_bq
    type:
      - 'null'
      - boolean
    doc: Remove the BQ Tag.
    inputBinding:
      position: 1
      prefix: --rmBQ
  - id: rm_tags
    type:
      - 'null'
      - string
    doc: Remove the specified Tags formatted as Tag:Type,Tag:Type,Tag:Type...
    inputBinding:
      position: 1
      prefix: --rmTags
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
    doc: Reverted SAM/BAM file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
