cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - validate
label: bamutil_validate
doc: "Validate a SAM/BAM File\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to be validated
    inputBinding:
      position: 1
      prefix: --in
  - id: ref_file
    type:
      - 'null'
      - File
    doc: the reference file
    inputBinding:
      position: 1
      prefix: --refFile
  - id: so_flag
    type:
      - 'null'
      - boolean
    doc: validate the file is sorted based on the header's @HD SO flag.
    inputBinding:
      position: 1
      prefix: --so_flag
  - id: so_coord
    type:
      - 'null'
      - boolean
    doc: validate the file is sorted based on the coordinate.
    inputBinding:
      position: 1
      prefix: --so_coord
  - id: so_query
    type:
      - 'null'
      - boolean
    doc: validate the file is sorted based on the query name.
    inputBinding:
      position: 1
      prefix: --so_query
  - id: max_errors
    type:
      - 'null'
      - int
    doc: 'Number of records with errors/invalids to allow before quiting (-1 default:
      validate entire file).'
    inputBinding:
      position: 1
      prefix: --maxErrors
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print specific error details rather than just a summary
    inputBinding:
      position: 1
      prefix: --verbose
  - id: printable_errors
    type:
      - 'null'
      - int
    doc: Maximum number of records with errors to print the details of (defaults to
      100)
    inputBinding:
      position: 1
      prefix: --printableErrors
  - id: disable_statistics
    type:
      - 'null'
      - boolean
    doc: Turn off statistic generation
    inputBinding:
      position: 1
      prefix: --disableStatistics
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
  - id: report
    type: stderr
    doc: Validation report and statistics
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stderr: bamutil_validate.txt
