cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertf
label: eigensoft_convertf
doc: "A tool from the EIGENSOFT package used to convert between different genotype
  file formats (e.g., PACKEDANCESTRYMAP, ANCESTRYMAP, PED, etc.) using a parameter
  file.\n\nTool homepage: https://github.com/DReichLab/EIG"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Genotype, SNP and individual files named in the parameter file 
      (genotypename, snpname, indivname, ...); staged in the working directory 
      under their own names
  - id: output_files
    type:
      type: array
      items: string
    doc: Output file names set in the parameter file (genotypeoutname, 
      snpoutname, indivoutname); collected as outputs (not passed to convertf)
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
  - id: converted_files
    type:
      type: array
      items: File
    doc: Converted genotype, SNP and individual files
    outputBinding:
      glob: $(inputs.output_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigensoft:8.0.0--h75d7a4a_6
stdout: eigensoft_convertf.out
