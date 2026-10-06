cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - VCFCompare
label: atlas_vcfcompare
doc: "Comparing genotype calls of two samples in two VCF files.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
arguments:
  - prefix: --vcf
    valueFrom: $(inputs.vcf_file1.path),$(inputs.vcf_file2.path)
    position: 1
inputs:
  - id: vcf_file1
    type: File
    doc: "First VCF file."
  - id: vcf_file2
    type: File
    doc: "Second VCF file."
  - id: samples
    type: string
    doc: "Comma-separated sample names, one per VCF, e.g. \"ind1,ind2\"."
    inputBinding:
      position: 1
      prefix: --samples
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_VCFCompare"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: genotypes
    type: File
    doc: "Counts of calls for every pair of genotypes."
    outputBinding:
      glob: $(inputs.out_prefix)_*_Genotypes.txt
  - id: calls
    type: File
    doc: "Counts of calls for every pair of alleles."
    outputBinding:
      glob: $(inputs.out_prefix)_*_Calls.txt
  - id: diff_table
    type:
      - 'null'
      - File
    doc: "Pairwise genotype difference table."
    outputBinding:
      glob: $(inputs.out_prefix)_diffTable.txt
  - id: summary
    type:
      - 'null'
      - File
    doc: "Comparison summary."
    outputBinding:
      glob: $(inputs.out_prefix).txt
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_vcfcompare.log
