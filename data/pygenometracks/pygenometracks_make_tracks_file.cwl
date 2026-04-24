cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_tracks_file
label: pygenometracks_make_tracks_file
doc: "Facilitates the creation of a configuration file for pyGenomeTracks. The program
  takes a list of files and does the boilerplate for the configuration file.\n\nTool
  homepage: //github.com/maxplanck-ie/pyGenomeTracks"
inputs:
- id: trackFiles
  type:
    type: array
    items: File
  doc: Files to use in for the tracks. The ending of the file is used to define 
    the type of track. E.g. `.bw` for bigwig, `.bed` for bed etc. For a arcs or 
    links file, the file ending recognized is `.arcs` or `.links`
  inputBinding:
    position: 101
    prefix: --trackFiles
outputs:
- id: output_file
  type:
  - 'null'
  - File
  doc: File to save the tracks
  outputBinding:
    glob: $(inputs.output_file)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/pygenometracks:3.9--pyhdfd78af_0
