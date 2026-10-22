cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suppa.py
  - psiPerEvent
label: suppa_psiPerEvent
doc: "Calculate the PSI value of each alternative splicing event from the transcript expression of the samples.\n\nTool homepage: https://github.com/comprna/SUPPA"
inputs:
  - id: ioe_file
    type: File
    doc: Input file with the event-transcripts equivalence (.ioe format).
    inputBinding:
      position: 1
      prefix: --ioe-file
  - id: expression_file
    type: File
    doc: Input transcript expression file.
    inputBinding:
      position: 1
      prefix: --expression-file
  - id: output_file
    type: string
    doc: Output psi file (the .psi extension is added).
    inputBinding:
      position: 1
      prefix: --output-file
  - id: total_filter
    type:
      - 'null'
      - float
    doc: Minimum total expression of the transcripts involved in the event.
    inputBinding:
      position: 1
      prefix: --total-filter
  - id: save_tpm_events
    type:
      - 'null'
      - boolean
    doc: "If True, save the TPM of the events in an external file."
    inputBinding:
      position: 1
      prefix: --save_tpm_events
  - id: mode
    type:
      - 'null'
      - string
    doc: "to choose from DEBUG, INFO, WARNING, ERROR and CRITICAL"
    inputBinding:
      position: 1
      prefix: --mode
outputs:
  - id: psi_files
    type:
      type: array
      items: File
    doc: PSI values (and event TPM files)
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
