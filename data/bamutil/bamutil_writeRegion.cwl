cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - writeRegion
label: bamutil_writeRegion
doc: "Write a file with reads in the specified region and/or have the specified read\
  \ name\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the BAM file to be read (index .bai beside it for region queries)
    inputBinding:
      position: 1
      prefix: --in
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: out
    type: string
    doc: the SAM/BAM file to write to
    inputBinding:
      position: 1
      prefix: --out
  - id: bam_index
    type:
      - 'null'
      - File
    doc: the path/name of the bam index file (if not specified, uses the --in value
      + ".bai")
    inputBinding:
      position: 1
      prefix: --bamIndex
  - id: ref_name
    type:
      - 'null'
      - string
    doc: the BAM reference Name to read. Defaults to all references.
    inputBinding:
      position: 1
      prefix: --refName
  - id: ref_id
    type:
      - 'null'
      - int
    doc: the BAM reference ID to read (-1 for unmapped). Defaults to all references.
    inputBinding:
      position: 1
      prefix: --refID
  - id: start
    type:
      - 'null'
      - int
    doc: inclusive 0-based start position (only with refName/refID)
    inputBinding:
      position: 1
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: exclusive 0-based end position (only with refName/refID)
    inputBinding:
      position: 1
      prefix: --end
  - id: bed
    type:
      - 'null'
      - File
    doc: use the specified bed file for regions.
    inputBinding:
      position: 1
      prefix: --bed
  - id: within_reg
    type:
      - 'null'
      - boolean
    doc: only print reads fully enclosed within the region.
    inputBinding:
      position: 1
      prefix: --withinReg
  - id: read_name
    type:
      - 'null'
      - string
    doc: only print reads with this read name.
    inputBinding:
      position: 1
      prefix: --readName
  - id: rn_file
    type:
      - 'null'
      - File
    doc: only print reads with read names found in the specified file
    inputBinding:
      position: 1
      prefix: --rnFile
  - id: lshift
    type:
      - 'null'
      - boolean
    doc: left shift indels when writing records
    inputBinding:
      position: 1
      prefix: --lshift
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
    doc: SAM/BAM file with the selected reads
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
