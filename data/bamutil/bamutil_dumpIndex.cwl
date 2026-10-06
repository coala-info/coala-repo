cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - dumpIndex
label: bamutil_dumpIndex
doc: "Print BAM Index File in English\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: bam_index
    type: File
    doc: the path/name of the bam index file to display
    inputBinding:
      position: 1
      prefix: --bamIndex
  - id: ref_id
    type:
      - 'null'
      - int
    doc: the reference ID to read, defaults to print all
    inputBinding:
      position: 1
      prefix: --refID
  - id: summary
    type:
      - 'null'
      - boolean
    doc: only print a summary - 1 line per reference.
    inputBinding:
      position: 1
      prefix: --summary
  - id: params
    type:
      - 'null'
      - boolean
    doc: print the parameter settings
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
  - id: index_dump
    type: stdout
    doc: BAM index content in readable form
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stdout: bamutil_dumpIndex.txt
