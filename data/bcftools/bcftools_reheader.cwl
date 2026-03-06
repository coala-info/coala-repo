cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- reheader
label: bcftools_reheader
doc: Modify header of VCF/BCF files, change sample names.
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
- id: fai
  type: File?
  doc: Update sequences and their lengths from the .fai file
  inputBinding:
    position: 102
    prefix: --fai
- id: header
  type: File?
  doc: New header
  inputBinding:
    position: 102
    prefix: --header
- id: output
  type: string
  doc: Write output to a file [standard output]
  inputBinding:
    position: 102
    prefix: --output
- id: samples_file
  type: File?
  doc: New sample names in a file, see the man page for details
  inputBinding:
    position: 102
    prefix: --samples-file
- id: samples_list
  type: string?
  doc: New sample names given as a comma-separated list
  inputBinding:
    position: 102
    prefix: --samples-list
- id: temp_prefix
  type: Directory?
  doc: Ignored; was template for temporary file name
  inputBinding:
    position: 102
    prefix: --temp-prefix
- id: threads
  type: int?
  doc: Use multithreading with INT worker threads (BCF only)
  inputBinding:
    position: 102
    prefix: --threads
outputs:
- id: output_output
  type: File
  doc: Write output to a file [standard output]
  outputBinding:
    glob: $(inputs.output)
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
