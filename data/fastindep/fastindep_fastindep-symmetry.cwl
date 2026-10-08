cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastindep-symmetry
label: fastindep_fastindep-symmetry
doc: "Checks a FastIndep data file: that the matrix is symmetric, the names match and every line has the right length.\n\nTool homepage: https://github.com/endrebak/fastindep"
arguments:
  - position: 1
    valueFrom: $(inputs.datafile.basename)
inputs:
  - id: datafile
    type: File
    doc: Data file. Line 1 holds the element names; each next line holds an element name followed by its correlation values.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.datafile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastindep:1.0.0--h9948957_7
stdout: fastindep_fastindep-symmetry.out
