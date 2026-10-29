cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_mrc2vtk
label: relion_relion_mrc2vtk
doc: "Convert an MRC, MRCS, TIFF or SPIDER map into a VTK file.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_map)
        writable: true
inputs:
  - id: input_map
    type: File
    doc: Input image or map (mrc, mrcs, tiff or spi); the output is written beside it as <name>.vtk
    inputBinding:
      position: 1
outputs:
  - id: vtk_file
    type: File
    doc: Converted VTK file
    outputBinding:
      glob: $(inputs.input_map.nameroot).vtk
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_mrc2vtk.out
