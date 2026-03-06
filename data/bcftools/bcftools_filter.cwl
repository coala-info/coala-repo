cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - filter
label: bcftools_filter
doc: Apply fixed-threshold filters.
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true (see man page for 
      details)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: Include only sites for which the expression is true (see man page for 
      details
    inputBinding:
      position: 102
      prefix: --include
  - id: indel_gap
    type:
      - 'null'
      - int
    doc: Filter clusters of indels separated by <int> or fewer base pairs 
      allowing only one to pass
    inputBinding:
      position: 102
      prefix: --IndelGap
  - id: mask
    type:
      - 'null'
      - string
    doc: Soft filter regions, "^" to negate
    inputBinding:
      position: 102
      prefix: --mask
  - id: mask_file
    type:
      - 'null'
      - File
    doc: Soft filter regions listed in a file, "^" to negate
    inputBinding:
      position: 102
      prefix: --mask-file
  - id: mask_overlap
    type:
      - 'null'
      - int
    doc: Mask if POS in the region (0), record overlaps (1), variant overlaps 
      (2)
    inputBinding:
      position: 102
      prefix: --mask-overlap
  - id: mode
    type:
      - 'null'
      - string
    doc: '"+ ": do not replace but add to existing FILTER; "x": reset filters at sites
      which pass'
    inputBinding:
      position: 102
      prefix: --mode
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: output
    type: string
    doc: Write output to a file [standard output]
    inputBinding:
      position: 102
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    inputBinding:
      position: 102
      prefix: --output-type
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
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: set_gts
    type:
      - 'null'
      - string
    doc: Set genotypes of failed samples to missing (.) or ref (0)
    inputBinding:
      position: 102
      prefix: --set-GTs
  - id: snp_gap
    type:
      - 'null'
      - string
    doc: Filter SNPs within <int> base pairs of an indel (the default) or any 
      combination of indel,mnp,bnd,other,overlap
    inputBinding:
      position: 102
      prefix: --SnpGap
  - id: soft_filter
    type:
      - 'null'
      - string
    doc: Annotate FILTER column with <string> or unique filter name ("Filter%d")
      made up by the program ("+")
    inputBinding:
      position: 102
      prefix: --soft-filter
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
    inputBinding:
      position: 102
      prefix: --targets-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with <int> worker threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files [off]
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Write output to a file [standard output]
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
s:url: https://github.com/samtools/bcftools
$namespaces:
  s: https://schema.org/
