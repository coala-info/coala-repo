cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - vcf_to_rtab
label: pangwas_vcf_to_rtab
doc: "Convert a VCF file to an Rtab file.\n\nTakes as input a VCF file to convert to a SNPs Rtab file.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: vcf
    type: File
    doc: "VCF file."
    inputBinding:
      position: 101
      prefix: --vcf
  - id: bed
    type:
      - 'null'
      - File
    doc: "BED file with names by coordinates."
    inputBinding:
      position: 101
      prefix: --bed
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: rtab
    type: File
    doc: "Rtab file of SNPs"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'output.Rtab')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
