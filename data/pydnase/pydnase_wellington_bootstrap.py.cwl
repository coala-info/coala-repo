cwlVersion: v1.2
class: CommandLineTool
baseCommand: wellington_bootstrap.py
label: pydnase_wellington_bootstrap.py
doc: "Scores Differential Footprints using Wellington-Bootstrap.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: treatment_bam
    type: File
    doc: "BAM file for treatment"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 1
  - id: control_bam
    type: File
    doc: "BAM file for control"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: bedsites
    type: File
    doc: "BED file of genomic locations to search in"
    inputBinding:
      position: 3
  - id: treatment_only_output
    type: string
    doc: "File to write treatment specific fooprints scores to"
    inputBinding:
      position: 4
  - id: control_only_output
    type: string
    doc: "File to write control specific footprint scores to"
    inputBinding:
      position: 5
  - id: footprint_sizes
    type:
      - 'null'
      - string
    doc: "Range of footprint sizes to try in format \"from,to,step\" (default: 11,26,2)."
    inputBinding:
      position: 10
      prefix: --footprint-sizes
  - id: fdr_cutoff
    type:
      - 'null'
      - float
    doc: "Detect footprints using the FDR selection method at a specific FDR (default: 0.01)."
    inputBinding:
      position: 11
      prefix: --FDR_cutoff
  - id: fdr_iterations
    type:
      - 'null'
      - int
    doc: "How many randomisations to use when performing FDR calculations (default: 100)."
    inputBinding:
      position: 12
      prefix: --FDR_iterations
  - id: fdr_limit
    type:
      - 'null'
      - int
    doc: "Minimum p-value to be considered significant for FDR calculation (default: -20)."
    inputBinding:
      position: 13
      prefix: --FDR_limit
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes to use (default: uses all CPUs)."
    inputBinding:
      position: 14
      prefix: --processes
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
outputs:
  - id: treatment_only_scores
    type: File
    doc: "Treatment specific footprint scores."
    outputBinding:
      glob: $(inputs.treatment_only_output)
  - id: control_only_scores
    type: File
    doc: "Control specific footprint scores."
    outputBinding:
      glob: $(inputs.control_only_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
