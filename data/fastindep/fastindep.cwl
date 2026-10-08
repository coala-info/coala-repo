cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastindep
label: fastindep
doc: "Finds maximal independent sets on an undirected graph defined by thresholding a matrix of correlation values. Needs a datafile and a parameter input file.\n\nTool homepage: https://github.com/endrebak/fastindep"
arguments:
  - position: 1
    valueFrom: $(inputs.datafile.basename)
  - position: 2
    valueFrom: $(inputs.parameter_input_file.basename)
inputs:
  - id: datafile
    type: File
    doc: Data file. Line 1 holds the element names; each next line holds an element name followed by its correlation values (symmetric, non-negative, diagonal 10000).
  - id: parameter_input_file
    type: File
    doc: Parameter file. Line 1 is the threshold (0 to 1) below which elements are unrelated, line 2 is the number of runs, optional line 3 is the random seed.
outputs:
  - id: outfile
    type: File
    doc: Independent sets found by the run (written as outfile.txt in the working directory).
    outputBinding:
      glob: outfile.txt
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.datafile)
      - $(inputs.parameter_input_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastindep:1.0.0--h9948957_7
stdout: fastindep.out
