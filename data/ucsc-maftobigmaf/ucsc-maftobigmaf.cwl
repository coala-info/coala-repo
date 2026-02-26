cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToBigMaf
label: ucsc-maftobigmaf
doc: "Convert a MAF file to a bigMaf file (a type of bigBed file) for use with the
  UCSC Genome Browser.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_maf
    type: File
    doc: Input MAF file to be converted.
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: A file containing chromosome names and sizes (typically a chrom.sizes 
      file).
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: The resulting bigMaf output file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftobigmaf:482--h0b57e2e_0
