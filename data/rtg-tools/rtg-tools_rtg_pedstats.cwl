cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - pedstats
label: rtg-tools_rtg_pedstats
doc: 'Output information from pedigree files of various formats. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: 'output id lists using this separator (Default is \n)'
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: dot
    type:
      - 'null'
      - string
    doc: 'output pedigree in Graphviz format, using the supplied text as a title'
    inputBinding:
      position: 101
      prefix: --dot
  - id: families
    type:
      - 'null'
      - boolean
    doc: 'output information about family structures'
    inputBinding:
      position: 101
      prefix: --families
  - id: female_ids
    type:
      - 'null'
      - boolean
    doc: 'output ids of all females'
    inputBinding:
      position: 101
      prefix: --female-ids
  - id: founder_ids
    type:
      - 'null'
      - boolean
    doc: 'output ids of all founders'
    inputBinding:
      position: 101
      prefix: --founder-ids
  - id: male_ids
    type:
      - 'null'
      - boolean
    doc: 'output ids of all males'
    inputBinding:
      position: 101
      prefix: --male-ids
  - id: maternal_ids
    type:
      - 'null'
      - boolean
    doc: 'output ids of maternal individuals'
    inputBinding:
      position: 101
      prefix: --maternal-ids
  - id: paternal_ids
    type:
      - 'null'
      - boolean
    doc: 'output ids of paternal individuals'
    inputBinding:
      position: 101
      prefix: --paternal-ids
  - id: primary_ids
    type:
      - 'null'
      - boolean
    doc: 'output ids of all primary individuals'
    inputBinding:
      position: 101
      prefix: --primary-ids
  - id: simple_dot
    type:
      - 'null'
      - boolean
    doc: 'when outputting Graphviz format, use a layout that looks less like a traditional pedigree diagram but works better with large complex pedigrees'
    inputBinding:
      position: 101
      prefix: --simple-dot
  - id: file
    type: File
    doc: 'the pedigree file to process, may be PED or VCF, use ''-'' to read from stdin'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_pedstats.out
