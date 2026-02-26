cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - debarcer.py
  - plot
label: debarcer_plot
doc: "Plotting tool for debarcer results.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the config file
    inputBinding:
      position: 101
      prefix: --Config
  - id: directory
    type: Directory
    doc: Directory with subdirectories ConsFiles and Datafiles
    inputBinding:
      position: 101
      prefix: --Directory
  - id: extension
    type:
      - 'null'
      - string
    doc: Figure format. Does not generate a report if pdf, even with -r True. 
      Default is png
    inputBinding:
      position: 101
      prefix: --Extension
  - id: min_children
    type:
      - 'null'
      - int
    doc: Minimum children umi count. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinChildren
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage value. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinCov
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: Minimum children to parent umi ratio. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinRatio
  - id: min_umis
    type:
      - 'null'
      - int
    doc: Minimum umi count. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinUmis
  - id: ref_threshold
    type:
      - 'null'
      - float
    doc: Cut Y axis at non-ref frequency, the minimum frequency to consider a 
      position variable
    inputBinding:
      position: 101
      prefix: --RefThreshold
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate a report if activated. Default is True
    default: 'True'
    inputBinding:
      position: 101
      prefix: --Report
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name to apear in the report is reporting flag activated. 
      Optional
    inputBinding:
      position: 101
      prefix: --Sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
stdout: debarcer_plot.out
