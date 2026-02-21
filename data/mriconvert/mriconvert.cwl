cwlVersion: v1.2
class: CommandLineTool
baseCommand: mriconvert
label: mriconvert
doc: "A medical image conversion utility used to convert DICOM files to other formats
  (such as NIfTI, Analyze, or SPM).\n\nTool homepage: https://github.com/Shotgunosine/mriconvert_minified"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mriconvert:v1-2.1.0-3-deb_cv1
stdout: mriconvert.out
