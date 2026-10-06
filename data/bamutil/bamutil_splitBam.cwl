cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - splitBam
label: bamutil_splitBam
doc: "Split a BAM file into multiple BAM files based on ReadGroup\n\nTool homepage:\
  \ http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: Original BAM file containing readGroup info
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: prefix of output bam files of [outprefix].[RGID].bam
    inputBinding:
      position: 1
      prefix: --out
  - id: log
    type:
      - 'null'
      - string
    doc: log file name. default is listFile.log
    inputBinding:
      position: 1
      prefix: --log
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: turn on verbose mode
    inputBinding:
      position: 1
      prefix: --verbose
  - id: noeof
    type:
      - 'null'
      - boolean
    doc: turn off the check for an EOF block at the end of a bam file
    inputBinding:
      position: 1
      prefix: --noeof
outputs:
  - id: read_group_bams
    type: File[]
    doc: One BAM file per read group, [outprefix].[RGID].bam
    outputBinding:
      glob: $(inputs.out).*.bam
  - id: log_file
    type: File[]
    doc: Log file
    outputBinding:
      glob: '*.log'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
