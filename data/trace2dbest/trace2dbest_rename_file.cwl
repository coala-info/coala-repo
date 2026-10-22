cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rename_file.pl
label: trace2dbest_rename_file
doc: "Rename a set of trace files in a directory into the EGTDC style trace name format
  (add text at the start or end of each name, remove or replace text, or reformat
  names to 96 well plate coordinates). The input directory is copied and the renamed
  copy is returned.\n\nTool homepage: https://sourceforge.net/projects/trace2dbest/"
inputs:
  - id: trace_dir
    type: Directory
    doc: Directory of trace files (a writable copy is renamed)
  - id: add
    type: ['null', string]
    doc: Text added to the beginning of each trace file name in the directory
    inputBinding:
      position: 2
      prefix: -add
  - id: end
    type: ['null', string]
    doc: Text added to the end of each trace file name
    inputBinding:
      position: 3
      prefix: -end
  - id: txt
    type: ['null', string]
    doc: Text (regular expression) removed from each file name
    inputBinding:
      position: 4
      prefix: -txt
  - id: sub
    type: ['null', string]
    doc: Text that replaces the -txt text (only with -txt set)
    inputBinding:
      position: 5
      prefix: -sub
  - id: format
    type: ['null', boolean]
    doc: Reformat trace names to correct 96 well nomenclature (single digits become
      double digits, row ID upper case; sequential numbers become plate coordinates)
    inputBinding:
      position: 6
      prefix: -format
outputs:
  - id: renamed_dir
    type: Directory
    doc: Directory with the renamed trace files
    outputBinding:
      glob: $(inputs.trace_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output (the list of files processed)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.trace_dir)
        writable: true
arguments:
  - position: 1
    prefix: -dir
    valueFrom: $(inputs.trace_dir.basename)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/trace2dbest:v3.0.1-1-deb_cv1
stdout: trace2dbest_rename_file.out
