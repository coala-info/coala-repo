cwlVersion: v1.2
class: CommandLineTool
baseCommand: malder
label: malder
doc: "ALDER computes weighted LD decay curves, performs curve-fitting to infer admixture
  dates, and uses the results to test for admixture.\n\nTool homepage: https://github.com/joepickrell/malder"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
inputs:
  - id: data_files
    type:
      type: array
      items: File
    doc: Genotype (.geno), SNP (.snp), individual (.ind) and other files that the
      parameter file names by bare file name. They are staged in the working directory.
  - id: parameter_file
    type: File
    doc: parameter file
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: raw_curves
    type:
      type: array
      items: File
    doc: Raw weighted LD curve files written when raw_outname is set to a name that
      contains "raw" in the parameter file
    outputBinding:
      glob: '*raw*'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malder:1.0.1e83d4e--he3c7034_8
stdout: malder.out
