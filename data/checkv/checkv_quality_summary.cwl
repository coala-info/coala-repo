cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkv
  - quality_summary
label: checkv_quality_summary
doc: "Summarize results across modules\n\nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs:
  - id: input
    type: File
    doc: Input viral sequences in FASTA format
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: remove_tmp
    type:
      - 'null'
      - boolean
    doc: Delete intermediate files from the output directory
    inputBinding:
      position: 102
      prefix: --remove_tmp
outputs:
  - id: out_output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
