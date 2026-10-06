cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - convert
label: bamutil_convert
doc: "Convert SAM/BAM to SAM/BAM\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to be read
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: the SAM/BAM file to be written (.sam, .bam or .ubam for uncompressed bam)
    inputBinding:
      position: 1
      prefix: --out
  - id: ref_file
    type:
      - 'null'
      - File
    doc: reference file name
    inputBinding:
      position: 1
      prefix: --refFile
  - id: lshift
    type:
      - 'null'
      - boolean
    doc: left shift indels when writing records
    inputBinding:
      position: 1
      prefix: --lshift
  - id: recover
    type:
      - 'null'
      - boolean
    doc: attempt error recovery while reading a bam file
    inputBinding:
      position: 1
      prefix: --recover
  - id: use_orig_seq
    type:
      - 'null'
      - boolean
    doc: Leave the sequence as is (default & used if reference is not specified)
    inputBinding:
      position: 1
      prefix: --useOrigSeq
  - id: use_bases
    type:
      - 'null'
      - boolean
    doc: Convert any '=' in the sequence to the appropriate base using the reference
      (requires --refFile)
    inputBinding:
      position: 1
      prefix: --useBases
  - id: use_equals
    type:
      - 'null'
      - boolean
    doc: Convert any bases that match the reference to '=' (requires --refFile)
    inputBinding:
      position: 1
      prefix: --useEquals
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
    doc: Converted SAM/BAM file
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
