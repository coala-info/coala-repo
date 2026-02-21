cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertf
label: eigensoft_convertf
doc: "A tool from the EIGENSOFT package used to convert between different genotype
  file formats (e.g., PACKEDANCESTRYMAP, ANCESTRYMAP, PED, etc.) using a parameter
  file.\n\nTool homepage: https://github.com/DReichLab/EIG"
inputs:
  - id: parameter_file
    type: File
    doc: Name of the parameter file containing input/output file specifications and
      format options.
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigensoft:8.0.0--h75d7a4a_6
stdout: eigensoft_convertf.out
