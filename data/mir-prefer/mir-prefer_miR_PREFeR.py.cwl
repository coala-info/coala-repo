cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - miR_PREFeR.py
label: mir-prefer_miR_PREFeR.py
doc: "miR-PREFeR is a tool for predicting miRNAs.\n\nTool homepage: https://github.com/hangelwen/miR-PREFeR"
inputs:
  - id: command
    type: string
    doc: 'Command to execute. Could be one of: check, prepare, candidate, fold, predict,
      pipeline, recover.'
    inputBinding:
      position: 1
  - id: configfile
    type: File
    doc: Configuration file
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file (genome FASTA, alignment SAM files, GFF file); they are staged in the working directory so relative paths in the config resolve
  - id: output_folder
    type: string
    doc: Name of the output folder; it must equal OUTFOLDER in the config file
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: After finish the whole pipeline, do not remove the temporary folder 
      that contains the intermidate files.
    inputBinding:
      position: 103
      prefix: --keep-tmp
  - id: log
    type:
      - 'null'
      - boolean
    doc: Generate a log file.
    inputBinding:
      position: 103
      prefix: --log
  - id: output_detail_for_debug
    type:
      - 'null'
      - boolean
    doc: Output detail for debug.
    inputBinding:
      position: 103
      prefix: --output-detail-for-debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output folder with the predicted miRNAs
    outputBinding:
      glob: $(inputs.output_folder)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.input_files ? inputs.input_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mir-prefer:0.24--py27_0
stdout: mir-prefer_miR_PREFeR.py.out
