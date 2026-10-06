cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiffcomment
label: bftools_tiffcomment
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.files)
        writable: true
doc: "This tool requires an ImageDescription tag to be present in the TIFF file.\n\
  \nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: TIFF file(s) to process.
    inputBinding:
      position: 1
  - id: edit
    type:
      - 'null'
      - boolean
    doc: Edit the TIFF comment.
    inputBinding:
      position: 102
      prefix: -edit
  - id: set_comment
    type:
      - 'null'
      - string
    doc: Set the TIFF comment. The new comment can be text, a filename, or '-' 
      for stdin.
    inputBinding:
      position: 102
      prefix: -set
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the TIFF comment when no option is given)
  - id: updated_files
    type:
      type: array
      items: File
    doc: The TIFF file(s), changed in place when set_comment is given
    outputBinding:
      glob: $(inputs.files.map(function(f) { return f.basename; }))
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_tiffcomment.out
