cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - coanc
label: pastrami_coanc
doc: "Calculate copying matrices for reference and query haplotypes\n\nTool homepage:
  https://github.com/healthdisparities/pastrami"
inputs:
  - id: haplotypes
    type: File
    doc: File of haplotype positions
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: log_file
    type:
      - 'null'
      - File
    doc: File containing log information
    inputBinding:
      position: 101
      prefix: --log-file
  - id: query_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the query TPED/TFAM input files
    inputBinding:
      position: 101
      prefix: --query-prefix
  - id: reference_prefix
    type: File
    doc: Prefix for the reference TPED/TFAM input files
    inputBinding:
      position: 101
      prefix: --reference-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print program progress information on screen
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: reference_out
    type:
      - 'null'
      - File
    doc: The reference v. reference copying matrix output
    outputBinding:
      glob: $(inputs.reference_out)
  - id: query_out
    type:
      - 'null'
      - File
    doc: The query v. reference copying matrix output
    outputBinding:
      glob: $(inputs.query_out)
  - id: combined_out
    type:
      - 'null'
      - File
    doc: The all v. reference copying matrix output
    outputBinding:
      glob: $(inputs.combined_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
