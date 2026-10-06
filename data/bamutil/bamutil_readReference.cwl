cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - readReference
label: bamutil_readReference
doc: "Print the reference string for the specified region\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: ref_file
    type: File
    doc: the reference
    inputBinding:
      position: 1
      prefix: --refFile
  - id: ref_name
    type: string
    doc: the SAM/BAM reference Name to read
    inputBinding:
      position: 1
      prefix: --refName
  - id: start
    type: int
    doc: inclusive 0-based start position
    inputBinding:
      position: 1
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: exclusive 0-based end position (give this or numBases)
    inputBinding:
      position: 1
      prefix: --end
  - id: num_bases
    type:
      - 'null'
      - int
    doc: number of bases from start to display (give this or end)
    inputBinding:
      position: 1
      prefix: --numBases
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
  - id: sequence
    type: stdout
    doc: Reference bases of the region
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stdout: bamutil_readReference.txt
