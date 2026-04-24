cwlVersion: v1.2
class: CommandLineTool
baseCommand: CompareErrorType
label: rdp-alignment_compare-error-type
doc: "Compare error types in alignments\n\nTool homepage: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations"
inputs:
  - id: ref_nucl
    type: File
    doc: Reference nucleotide sequence file
    inputBinding:
      position: 1
  - id: query_nucl
    type: File
    doc: Query nucleotide sequence file
    inputBinding:
      position: 2
  - id: query_nucl_qual
    type:
      - 'null'
      - File
    doc: Query nucleotide quality file
    inputBinding:
      position: 3
  - id: stem
    type:
      - 'null'
      - string
    doc: Output stem
    inputBinding:
      position: 104
      prefix: --stem
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
stdout: rdp-alignment_compare-error-type.out
