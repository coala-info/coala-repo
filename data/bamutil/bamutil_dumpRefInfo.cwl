cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - dumpRefInfo
label: bamutil_dumpRefInfo
doc: "Print SAM/BAM Reference Name Information\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the SAM/BAM file to be read
    inputBinding:
      position: 1
      prefix: --in
  - id: print_record_refs
    type:
      - 'null'
      - boolean
    doc: print the reference information for the records in the file (grouped by reference).
    inputBinding:
      position: 1
      prefix: --printRecordRefs
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
  - id: ref_info
    type: stdout
    doc: Reference name information
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stdout: bamutil_dumpRefInfo.txt
