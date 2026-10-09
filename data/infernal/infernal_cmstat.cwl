cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmstat
label: infernal_cmstat
doc: "display summary statistics for CMs\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: 'Covariance model file'
    inputBinding:
      position: 200
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'print bit scores that correspond to E-value threshold of <x>'
    inputBinding:
      position: 101
      prefix: -E
  - id: evalue_p
    type:
      - 'null'
      - float
    doc: 'print bit scores that correspond to E-value threshold of <x>'
    inputBinding:
      position: 101
      prefix: -P
  - id: score
    type:
      - 'null'
      - float
    doc: 'print E-values that correspond to bit score threshold of <x>'
    inputBinding:
      position: 101
      prefix: -T
  - id: search_space_mb
    type:
      - 'null'
      - float
    doc: 'set database size in *Mb* to <x> for E-value calculations [10]'
    inputBinding:
      position: 101
      prefix: -Z
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: 'print E-values that correspond to GA bit score thresholds'
    inputBinding:
      position: 101
      prefix: --cut_ga
  - id: cut_nc
    type:
      - 'null'
      - boolean
    doc: 'print E-values that correspond to NC bit score thresholds'
    inputBinding:
      position: 101
      prefix: --cut_nc
  - id: cut_tc
    type:
      - 'null'
      - boolean
    doc: 'print E-values that correspond to TC bit score thresholds'
    inputBinding:
      position: 101
      prefix: --cut_tc
  - id: key
    type:
      - 'null'
      - string
    doc: 'only print statistics for CM with name or accession <s>'
    inputBinding:
      position: 101
      prefix: --key
  - id: hmmonly
    type:
      - 'null'
      - boolean
    doc: 'print filter HMM bit scores/E-values, not CM ones'
    inputBinding:
      position: 101
      prefix: --hmmonly
  - id: nohmmonly
    type:
      - 'null'
      - boolean
    doc: 'print CM bit scores/E-values, even for models with 0 basepairs'
    inputBinding:
      position: 101
      prefix: --nohmmonly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmstat.out
