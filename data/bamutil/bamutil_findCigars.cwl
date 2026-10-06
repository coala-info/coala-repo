cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - findCigars
label: bamutil_findCigars
doc: "Output just the reads that contain any of the specified CIGAR operations.\n\n\
  Tool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
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
  - id: cinsert
    type:
      - 'null'
      - boolean
    doc: output reads that contain insertions ('I').
    inputBinding:
      position: 1
      prefix: --cinsert
  - id: cdel
    type:
      - 'null'
      - boolean
    doc: output reads that contain deletions ('D').
    inputBinding:
      position: 1
      prefix: --cdel
  - id: cpad
    type:
      - 'null'
      - boolean
    doc: output reads that contain pads ('P').
    inputBinding:
      position: 1
      prefix: --cpad
  - id: cskip
    type:
      - 'null'
      - boolean
    doc: output reads that contain skips ('N').
    inputBinding:
      position: 1
      prefix: --cskip
  - id: chard_clip
    type:
      - 'null'
      - boolean
    doc: output reads that contain hard clips ('H').
    inputBinding:
      position: 1
      prefix: --chardClip
  - id: csoft_clip
    type:
      - 'null'
      - boolean
    doc: output reads that contain soft clips ('S').
    inputBinding:
      position: 1
      prefix: --csoftClip
  - id: non_m
    type:
      - 'null'
      - boolean
    doc: output reads that contain any non match/mismatch (anything other than 'M',
      '=', 'X')
    inputBinding:
      position: 1
      prefix: --nonM
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
    doc: SAM/BAM file with the matching reads
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
