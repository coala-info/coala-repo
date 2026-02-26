cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytocad
label: cytocad
doc: "CytoCAD is a tool for discovering large genomic copy-number variation through
  coverage anormaly detection (CAD) using low-depth whole-genome sequencing data.\n\
  \nTool homepage: https://github.com/cytham/cytocad"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: "path to mapped BAM file.\n                        Format: .bam"
    inputBinding:
      position: 1
  - id: work_directory
    type:
      - 'null'
      - Directory
    doc: "path to work directory. Directory will be created \n                   \
      \     if it does not exist."
    inputBinding:
      position: 2
  - id: add_plots
    type:
      - 'null'
      - boolean
    doc: output additional coverage plots in 'fig' directory
    inputBinding:
      position: 103
      prefix: --add_plots
  - id: buffer
    type:
      - 'null'
      - int
    doc: buffer window size of each point, in bp
    default: 10
    inputBinding:
      position: 103
      prefix: --buffer
  - id: build
    type:
      - 'null'
      - string
    doc: build version of human reference genome assembly
    default: hg38
    inputBinding:
      position: 103
      prefix: --build
  - id: colors
    type:
      - 'null'
      - type: array
        items: string
    doc: "hex color for neutral, gain, and loss CNVs on chromosome\n             \
      \           ideograms respectively separated by space"
    default:
      - '#a6a6a6'
      - '#990000'
      - '#000099'
    inputBinding:
      position: 103
      prefix: --colors
  - id: debug
    type:
      - 'null'
      - boolean
    doc: run in debug mode
    inputBinding:
      position: 103
      prefix: --debug
  - id: format
    type:
      - 'null'
      - string
    doc: Output format of chromosome illustration figure
    default: png
    inputBinding:
      position: 103
      prefix: --format
  - id: interval
    type:
      - 'null'
      - int
    doc: "spread between each point in a chromosome where \"\n                   \
      \     coverage is enquired, in bp. Minimum CNV sensitive \n                \
      \        detection size ~= interval*rolling"
    default: 50000
    inputBinding:
      position: 103
      prefix: --interval
  - id: penalty
    type:
      - 'null'
      - int
    doc: "Linear kernel penalty value for change \n                        point detection
      using Ruptures"
    default: 500
    inputBinding:
      position: 103
      prefix: --penalty
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: hide verbose
    inputBinding:
      position: 103
      prefix: --quiet
  - id: rolling
    type:
      - 'null'
      - int
    doc: rolling mean window size
    default: 10
    inputBinding:
      position: 103
      prefix: --rolling
  - id: scale
    type:
      - 'null'
      - float
    doc: "proportion of mean coverage to be used for \n                        buffering
      to call hetero- and homozygous CNVs \n                        (E.g. a heterozygous
      loss is where a coverage (c) \n                        satisfies: mean-mean*scale
      <= c < mean+mean*scale"
    default: 0.25
    inputBinding:
      position: 103
      prefix: --scale
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytocad:1.0.3--py310h4b81fae_2
stdout: cytocad.out
