cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - polishBam
label: bamutil_polishBam
doc: "adds/updates header lines & adds the RG tag to each record\n\nTool homepage:\
  \ http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: input BAM file
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: output BAM file
    inputBinding:
      position: 1
      prefix: --out
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: turn on verbose mode
    inputBinding:
      position: 1
      prefix: -v
  - id: log
    type:
      - 'null'
      - string
    doc: writes logfile with specified name.
    inputBinding:
      position: 1
      prefix: --log
  - id: hd
    type:
      - 'null'
      - string
    doc: add @HD header line
    inputBinding:
      position: 1
      prefix: --HD
  - id: rg
    type:
      - 'null'
      - string
    doc: add @RG header line
    inputBinding:
      position: 1
      prefix: --RG
  - id: pg
    type:
      - 'null'
      - string
    doc: add @PG header line
    inputBinding:
      position: 1
      prefix: --PG
  - id: co
    type:
      - 'null'
      - string
    doc: add @CO header line
    inputBinding:
      position: 1
      prefix: --CO
  - id: fasta
    type:
      - 'null'
      - File
    doc: fasta reference file to compute MD5sums and update SQ tags
    inputBinding:
      position: 1
      prefix: --fasta
  - id: as
    type:
      - 'null'
      - string
    doc: AS tag for genome assembly identifier
    inputBinding:
      position: 1
      prefix: --AS
  - id: ur
    type:
      - 'null'
      - string
    doc: UR tag for @SQ tag (if different from --fasta)
    inputBinding:
      position: 1
      prefix: --UR
  - id: sp
    type:
      - 'null'
      - string
    doc: SP tag for @SQ tag
    inputBinding:
      position: 1
      prefix: --SP
  - id: check_sq
    type:
      - 'null'
      - boolean
    doc: check the consistency of SQ tags (SN and LN) with existing header lines.
      Must be used with --fasta option
    inputBinding:
      position: 1
      prefix: --checkSQ
outputs:
  - id: output_file
    type: File
    doc: Polished BAM file
    outputBinding:
      glob: $(inputs.out)
  - id: log_file
    type: File?
    doc: Log file
    outputBinding:
      glob: '$(inputs.log ? inputs.log : ''_none_'')'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
