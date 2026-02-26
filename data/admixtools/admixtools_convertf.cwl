cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertf
label: admixtools_convertf
doc: "A tool from the AdmixTools suite used to convert between different genetic data
  formats (e.g., EIGENSTRAT, PACKEDANCESTRYMAP, PED, etc.) using a parameter file.\n\
  \nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: parameter_file
    type: File
    doc: The parameter file containing input/output file paths and format 
      specifications.
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_convertf.out
