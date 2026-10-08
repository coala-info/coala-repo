cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MS-single-to-table
label: dms_MS-single-to-table
doc: "Combine single files to table\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: PREFIX
        envValue: /usr/local
  - class: InitialWorkDirRequirement
    listing: $(inputs.single_files)
inputs:
  - id: input_list
    type: File
    doc: Input files list (sample ID and single-sample file path per line)
    inputBinding:
      position: 101
      prefix: -l
  - id: single_files
    type:
      type: array
      items: File
    doc: Single-sample species files named in the input list; staged in the 
      working directory so the names in the list resolve
  - id: list_prefix
    type:
      - 'null'
      - string
    doc: List file path prefix for '-l'
    inputBinding:
      position: 101
      prefix: -p
  - id: output_name
    type:
      - 'null'
      - string
    doc: Output file name, default is "species.table" (the tool writes 
      <name>.Abd)
    inputBinding:
      position: 101
      prefix: -o
  - id: reverse_table
    type:
      - 'null'
      - string
    doc: If the output table is reversed, T(rue) or F(alse), default is false
    inputBinding:
      position: 101
      prefix: -R
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: abundance_table
    type: File
    doc: Combined abundance table (<output name>.Abd)
    outputBinding:
      glob: '$((inputs.output_name ? inputs.output_name : "species.table") + ".Abd")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_MS-single-to-table.out
