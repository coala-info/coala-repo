cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk trim_msa
label: gtdbtk_trim_msa
doc: "Trims an MSA based on a mask file or reference mask.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: mask_file
    type: File
    doc: path to a custom mask file for trimming the MSA
    inputBinding:
      position: 101
      prefix: --mask_file
  - id: reference_mask
    type: string
    doc: reference mask already present in GTDB-Tk
    inputBinding:
      position: 101
      prefix: --reference_mask
  - id: untrimmed_msa
    type: File
    doc: path to the untrimmed MSA file
    inputBinding:
      position: 101
      prefix: --untrimmed_msa
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
