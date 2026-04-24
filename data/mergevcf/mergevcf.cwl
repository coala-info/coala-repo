cwlVersion: v1.2
class: CommandLineTool
baseCommand: mergevcf
label: mergevcf
doc: "Merge calls in VCF files\n\nTool homepage: https://github.com/ljdursi/mergevcf"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input VCF files
    inputBinding:
      position: 1
  - id: filtered
    type:
      - 'null'
      - boolean
    doc: Include records that have failed one or more filters
    inputBinding:
      position: 102
      prefix: --filtered
  - id: labels
    type:
      - 'null'
      - string
    doc: Comma-separated labels for each input VCF file
    inputBinding:
      position: 102
      prefix: --labels
  - id: mincallers
    type:
      - 'null'
      - int
    doc: 'Minimum # of callers for variant to pass'
    inputBinding:
      position: 102
      prefix: --mincallers
  - id: ncallers
    type:
      - 'null'
      - boolean
    doc: Annotate variant with number of callers
    inputBinding:
      position: 102
      prefix: --ncallers
  - id: sv
    type:
      - 'null'
      - boolean
    doc: Force interpretation as SV
    inputBinding:
      position: 102
      prefix: --sv
  - id: svwindow
    type:
      - 'null'
      - int
    doc: Window for comparing breakpoint positions for SVs
    inputBinding:
      position: 102
      prefix: --svwindow
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Specify verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Specify output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mergevcf:1.0.1--py27_0
