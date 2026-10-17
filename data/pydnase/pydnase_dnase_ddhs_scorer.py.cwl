cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnase_ddhs_scorer.py
label: pydnase_dnase_ddhs_scorer.py
doc: "Annotates a set of DHSs with the dDHS score (He et al. 2012).\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "The set of BED files you wish to annotate with dDHS scores"
    inputBinding:
      position: 1
  - id: treat_dhs
    type: File
    doc: "The DHSs belonging to the Treatment"
    inputBinding:
      position: 2
  - id: control_dhs
    type: File
    doc: "The DHSs belonging to the control"
    inputBinding:
      position: 3
  - id: reads_treat
    type: File
    doc: "The BAM file containing the Treatment DNase-seq data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 4
  - id: reads_control
    type: File
    doc: "The BAM file containing the Control DNase-seq data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 5
  - id: output
    type: string
    doc: "filename to write the output to"
    inputBinding:
      position: 6
  - id: low_ram
    type:
      - 'null'
      - boolean
    doc: "low RAM mode (disables caching) (Default: False)."
    inputBinding:
      position: 20
      prefix: -l
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
outputs:
  - id: ddhs_scores
    type: File
    doc: "DHSs annotated with dDHS scores."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
