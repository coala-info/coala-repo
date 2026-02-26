cwlVersion: v1.2
class: CommandLineTool
baseCommand: aci
label: aci
doc: "Amplicon Coverage Inspector (aci) for analyzing coverage across amplicons using
  BAM and BED files.\n\nTool homepage: https://github.com/erinyoung/ACI"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: input bam file(s). Supports wildcards or space-separated lists.
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed
    type: File
    doc: amplicon bedfile (4-column format)
    inputBinding:
      position: 101
      prefix: --bed
  - id: fail_percentage
    type:
      - 'null'
      - int
    doc: Percentage of samples that must fail for an amplicon to be flagged
    default: 50
    inputBinding:
      position: 101
      prefix: --fail-percentage
  - id: fail_threshold
    type:
      - 'null'
      - int
    doc: Minimum depth to consider an amplicon 'passed'
    default: 10
    inputBinding:
      position: 101
      prefix: --fail-threshold
  - id: loglevel
    type:
      - 'null'
      - string
    doc: logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
    default: INFO
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: threads
    type:
      - 'null'
      - int
    doc: specifies number of threads to use for sorting and counting
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: 'custom directory for temporary files (default: system tmp)'
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: directory for results
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aci:1.45.251125--pyhdfd78af_0
