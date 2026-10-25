cwlVersion: v1.2
class: CommandLineTool
baseCommand: subChar
label: ucsc-subchar
doc: "Substitute one character for another throughout a file. oldChar and newChar can be single letter literal characters, or two digit hexadecimal ascii codes. The files are changed in place, so they are staged as writable copies.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.files)
        writable: true
inputs:
  - id: old_char
    type: string
    doc: The character to be replaced (single letter or two digit hex code).
    inputBinding:
      position: 1
  - id: new_char
    type: string
    doc: The character to substitute in (single letter or two digit hex code).
    inputBinding:
      position: 2
  - id: files
    type:
      type: array
      items: File
    doc: The file(s) to process. They are modified in place (copies are changed).
    inputBinding:
      position: 3
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: changed_files
    type:
      type: array
      items: File
    doc: The changed files
    outputBinding:
      glob: $(inputs.files.map(function(f) { return f.basename; }))
  - id: log
    type: stdout
    doc: Messages from the tool
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-subchar:482--h0b57e2e_0
stdout: ucsc-subchar.out
