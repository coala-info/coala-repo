cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtdbtk
  - trim_msa
label: gtdbtk_trim_msa
doc: "Trims an MSA based on a mask file or reference mask.\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: gtdbtk_data
    type: Directory
    doc: GTDB-Tk reference data directory (sets GTDBTK_DATA_PATH)
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: mask_file
    type:
      - 'null'
      - File
    doc: path to a custom mask file for trimming the MSA
    inputBinding:
      position: 101
      prefix: --mask_file
  - id: reference_mask
    type:
      - 'null'
      - string
    doc: reference mask already present in GTDB-Tk (arc or bac); use either this or mask_file
    inputBinding:
      position: 101
      prefix: --reference_mask
  - id: untrimmed_msa
    type: File
    doc: path to the untrimmed MSA file
    inputBinding:
      position: 101
      prefix: --untrimmed_msa
  - id: output_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: GTDBTK_DATA_PATH
        envValue: $(inputs.gtdbtk_data.path)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
