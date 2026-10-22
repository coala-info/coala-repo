cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - vcfpaste
label: svtools_vcfpaste
doc: 'Paste VCF files from multiple samples into one VCF.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: vcf_list
    type: File
    doc: File containing a line-delimited list of VCF files to paste (required)
    inputBinding:
      position: 101
      prefix: --vcf-list
  - id: listed_vcf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files named in the --vcf-list file; staged in the working directory so
      the listed names resolve
  - id: master
    type:
      - 'null'
      - File
    doc: VCF file to set first 8 columns of variant info (otherwise first file in
      --vcf-list)
    inputBinding:
      position: 101
      prefix: --master
  - id: sum_quals
    type:
      - 'null'
      - boolean
    doc: Sum QUAL scores of input VCFs as output QUAL score
    inputBinding:
      position: 101
      prefix: --sum-quals
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory for temp file downloads
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: out_vcf
    type: stdout
    doc: Pasted VCF
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.listed_vcf_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_vcfpaste.vcf
