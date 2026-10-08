cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalize-entry-names
label: gff3toddbj_normalize-entry-names
doc: "Normalize the entry names (first column) of a DDBJ annotation file: invalid letters (= | > \" space and brackets) are replaced by a colon.\n\nTool homepage: https://github.com/yamaton/gff3toddbj"
inputs:
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Suffix to output filenames (default _renamed)"
    inputBinding:
      position: 1
      prefix: --suffix
  - id: annotation_file
    type: File
    doc: "Input annotation file"
    inputBinding:
      position: 2
outputs:
  - id: renamed_annotation
    type: File?
    doc: "Renamed annotation file, written only when some entry names needed renaming"
    outputBinding:
      glob: "$(inputs.annotation_file.nameroot)$(inputs.suffix || '_renamed')$(inputs.annotation_file.nameext)"
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.annotation_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
stdout: gff3toddbj_normalize-entry-names.out
