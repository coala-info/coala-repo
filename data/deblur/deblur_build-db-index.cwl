cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - build-db-index
label: deblur_build-db-index
doc: "Preapare the artifacts database\n\nTool homepage: https://github.com/biocore/deblur"
inputs:
  - id: ref_fp
    type: File
    doc: the fasta sequence database for artifact removal
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: the directory to where to write the indexed database
    inputBinding:
      position: 2
  - id: log_file
    type:
      - 'null'
      - string
    doc: log file name
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - int
    doc: Level of messages for log file (range 1-debug to 5-critical)
    inputBinding:
      position: 103
      prefix: --log-level
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: "$(inputs.log_file ? inputs.log_file : 'deblur.log')"
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type: Directory
    doc: the directory to where to write the indexed database
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
stdout: deblur_build-db-index.out
