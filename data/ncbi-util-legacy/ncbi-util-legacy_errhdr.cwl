cwlVersion: v1.2
class: CommandLineTool
baseCommand: errhdr
label: ncbi-util-legacy_errhdr
doc: "Produce a C header file (error code defines) from an NCBI error message file. The message file must be named <module>.msg and start with a MODULE line; the module name is passed to errhdr.\n\nTool homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs:
  - id: code_subcode_tuples
    type:
      - 'null'
      - boolean
    doc: for code,subcode tuples
    inputBinding:
      position: 1
      prefix: '-2'
  - id: short_subcode_defines
    type:
      - 'null'
      - boolean
    doc: for short subcode defines
    inputBinding:
      position: 1
      prefix: -s
  - id: msgfile
    type: File
    doc: Message file (<module>.msg); staged in the working directory and given to errhdr by module name.
    inputBinding:
      position: 2
      valueFrom: $(self.nameroot)
  - id: hdrfile
    type:
      - 'null'
      - string
    doc: Header file to write (default is standard output).
    inputBinding:
      position: 3
outputs:
  - id: header
    type:
      - 'null'
      - File
    doc: Header file written when hdrfile is given.
    outputBinding:
      glob: $(inputs.hdrfile)
  - id: stdout
    type: stdout
    doc: Standard output (the header when hdrfile is not given).
stdout: ncbi-util-legacy_errhdr.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.msgfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
