cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crispritz.py
  - generate-report
label: crispritz_generate-report
doc: "Generate a graphical report for a specific guide.\n\nTool homepage: https://github.com/InfOmics/CRISPRitz"
inputs:
  - id: guide
    type:
      - 'null'
      - string
    doc: A guide present in the analyzed set
    inputBinding:
      position: 1
  - id: mismatches
    type: int
    doc: Number of mismatches to analyze
    inputBinding:
      position: 2
      prefix: -mm
  - id: annotation
    type: File
    doc: Count files for genomic annotations (annotation summary file)
    inputBinding:
      position: 2
      prefix: -annotation
  - id: extprofile
    type: File
    doc: Extended profile file
    inputBinding:
      position: 2
      prefix: -extprofile
  - id: gecko
    type:
      - 'null'
      - boolean
    doc: Tag to activate gecko dataset comparison
    inputBinding:
      position: 2
      prefix: -gecko
  - id: sumref
    type: File
    doc: Reference annotation summary file. Create a barplot comparing reference
      genome results with enriched genome results. If the <guide> option is 
      used, the barplot will take into account only the targets found with that
      specific guide. The help calls it optional, but radar_chart.py in this 
      version always opens it and fails without it.
    inputBinding:
      position: 2
      prefix: -sumref
outputs:
  - id: report
    type:
      type: array
      items: File
    doc: Report plots (summary_single_guide_<guide>_<mm>mm.pdf)
    outputBinding:
      glob: summary_single_guide_*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
