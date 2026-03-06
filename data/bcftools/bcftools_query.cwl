cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- query
label: bcftools_query
doc: Extracts fields from VCF/BCF file and prints them in user-defined format
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
inputs:
- id: input_files
  type: File[]
  doc: Input VCF/BCF file(s)
  inputBinding:
    position: 103
- id: allow_undef_tags
  type: boolean?
  default: true
  doc: Print "." for undefined tags
  inputBinding:
    position: 102
    prefix: --allow-undef-tags
- id: disable_automatic_newline
  type: boolean?
  doc: Disable automatic addition of newline character when not present
  inputBinding:
    position: 102
    prefix: --disable-automatic-newline
- id: exclude
  type: string?
  doc: Exclude sites for which the expression is true
  inputBinding:
    position: 102
    prefix: --exclude
- id: force_samples
  type: boolean?
  doc: Only warn about unknown subset samples
  inputBinding:
    position: 102
    prefix: --force-samples
- id: format
  type: string
  doc: See man page for details. Required for bcftools query.
  inputBinding:
    position: 102
    prefix: --format
- id: include
  type: string?
  doc: Select sites for which the expression is true
  inputBinding:
    position: 102
    prefix: --include
- id: list_samples
  type: boolean?
  doc: Print the list of samples and exit
  inputBinding:
    position: 102
    prefix: --list-samples
- id: output
  type: string
  doc: Output file name [stdout]
  inputBinding:
    position: 102
    prefix: --output
- id: print_filtered
  type: string?
  doc: Output STR for samples failing the -i/-e filtering expression
  inputBinding:
    position: 102
    prefix: --print-filtered
- id: print_header
  type: boolean?
  doc: Print header, -HH to omit column indices
  inputBinding:
    position: 102
    prefix: --print-header
- id: regions
  type: string?
  doc: Restrict to comma-separated list of regions
  inputBinding:
    position: 102
    prefix: --regions
- id: regions_file
  type: File?
  doc: Restrict to regions listed in a file
  inputBinding:
    position: 102
    prefix: --regions-file
- id: regions_overlap
  type: int?
  doc: Include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --regions-overlap
- id: samples
  type: string?
  doc: List of samples to include
  inputBinding:
    position: 102
    prefix: --samples
- id: samples_file
  type: File?
  doc: File of samples to include
  inputBinding:
    position: 102
    prefix: --samples-file
- id: targets
  type: string?
  doc: Similar to -r but streams rather than index-jumps
  inputBinding:
    position: 102
    prefix: --targets
- id: targets_file
  type: File?
  doc: Similar to -R but streams rather than index-jumps
  inputBinding:
    position: 102
    prefix: --targets-file
- id: targets_overlap
  type: int?
  doc: Include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --targets-overlap
- id: vcf_list
  type: File?
  doc: Process multiple VCFs listed in the file
  inputBinding:
    position: 102
    prefix: --vcf-list
outputs:
- id: output_output
  type: File
  doc: Output file
  outputBinding:
    glob: $(inputs.output)
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
