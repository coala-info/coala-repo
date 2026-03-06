cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- sort
label: bcftools_sort
doc: Sort VCF/BCF file.
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
inputs:
- id: input_file
  type: File
  doc: Input VCF/BCF file
  inputBinding:
    position: 1
- id: max_mem
  type: string?
  doc: Maximum memory to use
  inputBinding:
    position: 102
    prefix: --max-mem
- id: output_file
  type: string
  doc: Output file name
  inputBinding:
    position: 103
    prefix: --output
- id: output_type
  type: string?
  doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
  inputBinding:
    position: 104
    prefix: --output-type
- id: temp_dir
  type: Directory?
  doc: Temporary files
  inputBinding:
    position: 105
    prefix: --temp-dir
- id: write_index
  type: string?
  doc: Automatically index the output files
  inputBinding:
    position: 106
    prefix: --write-index
outputs:
- id: output_output_file
  type: File
  doc: Output file name
  outputBinding:
    glob: $(inputs.output_file)
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
