cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- head
label: bcftools_head
doc: Displays VCF/BCF headers and optionally the first few variant records
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_file
  type: File
  doc: Input VCF/BCF file
  inputBinding:
    position: 103
- id: headers
  type: int?
  doc: Display INT header lines [all]
  inputBinding:
    position: 102
    prefix: --headers
- id: records
  type: int?
  doc: Display INT variant record lines [none]
  inputBinding:
    position: 102
    prefix: --records
- id: samples
  type: int?
  doc: 'Display INT records starting with the #CHROM header line [none]'
  inputBinding:
    position: 102
    prefix: --samples
outputs:
- id: stdout
  type: stdout
  doc: Standard output
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
stdout: bcftools_head.out
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
