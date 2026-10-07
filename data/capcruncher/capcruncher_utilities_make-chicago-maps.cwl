cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - utilities
  - make-chicago-maps
label: capcruncher_utilities_make-chicago-maps
doc: "Make CHiCAGO restriction map (.rmap) and bait map (.baitmap) files from a restriction fragment file and a viewpoints file.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: fragments
    type: File
    doc: "Path to fragments file"
    inputBinding:
      position: 2
      prefix: --fragments
  - id: viewpoints
    type: File
    doc: "Path to viewpoints file used for capcruncher"
    inputBinding:
      position: 2
      prefix: --viewpoints
  - id: outputdir
    type: string
    default: chicago_maps
    doc: "Path to output directory"
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: maps_dir
    type: Directory
    doc: "Directory with the .rmap and .baitmap files"
    outputBinding:
      glob: $(inputs.outputdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
