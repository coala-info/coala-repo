cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - query
label: bcftools_query
doc: "Extracts fields from VCF/BCF file and prints them in user-defined format\n\n\
  Tool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input VCF/BCF file(s)
    inputBinding:
      position: 1
  - id: allow_undef_tags
    type:
      - 'null'
      - boolean
    doc: Print "." for undefined tags
    inputBinding:
      position: 102
      prefix: --allow-undef-tags
  - id: disable_automatic_newline
    type:
      - 'null'
      - boolean
    doc: Disable automatic addition of newline character when not present
    inputBinding:
      position: 102
      prefix: --disable-automatic-newline
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true (see man page for 
      details)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: force_samples
    type:
      - 'null'
      - boolean
    doc: Only warn about unknown subset samples
    inputBinding:
      position: 102
      prefix: --force-samples
  - id: format
    type:
      - 'null'
      - string
    doc: See man page for details
    inputBinding:
      position: 102
      prefix: --format
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true (see man page for 
      details)
    inputBinding:
      position: 102
      prefix: --include
  - id: list_samples
    type:
      - 'null'
      - boolean
    doc: Print the list of samples and exit
    inputBinding:
      position: 102
      prefix: --list-samples
  - id: print_filtered
    type:
      - 'null'
      - string
    doc: Output STR for samples failing the -i/-e filtering expression
    inputBinding:
      position: 102
      prefix: --print-filtered
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print header, -HH to omit column indices
    inputBinding:
      position: 102
      prefix: --print-header
  - id: regions
    type:
      - 'null'
      - string
    doc: Restrict to comma-separated list of regions
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: regions_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 1
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: samples
    type:
      - 'null'
      - string
    doc: List of samples to include
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to include
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: targets_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 0
    inputBinding:
      position: 102
      prefix: --targets-overlap
  - id: vcf_list
    type:
      - 'null'
      - File
    doc: Process multiple VCFs listed in the file
    inputBinding:
      position: 102
      prefix: --vcf-list
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
