cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - annotate
label: bcftools_annotate
doc: Annotate and edit VCF/BCF files.
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: annotations
    type:
      - 'null'
      - File
    doc: 'VCF file or tabix-indexed FILE with annotations: CHR\tPOS[\tVALUE]+'
    inputBinding:
      position: 102
      prefix: --annotations
  - id: columns
    type:
      - 'null'
      - string
    doc: List of columns in the annotation file, e.g. 
      CHROM,POS,REF,ALT,-,INFO/TAG.
    inputBinding:
      position: 102
      prefix: --columns
  - id: columns_file
    type:
      - 'null'
      - File
    doc: 'Read -c columns from FILE, one name per row, with optional --merge-logic
      TYPE: NAME[ TYPE]'
    inputBinding:
      position: 102
      prefix: --columns-file
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --exclude
  - id: force
    type:
      - 'null'
      - boolean
    doc: Continue despite parsing error (at your own risk!)
    inputBinding:
      position: 102
      prefix: --force
  - id: header_line
    type:
      - 'null'
      - type: array
        items: string
    doc: Header line which should be appended to the VCF header, can be given 
      multiple times
    inputBinding:
      position: 102
      prefix: --header-line
  - id: header_lines
    type:
      - 'null'
      - File
    doc: Lines which should be appended to the VCF header
    inputBinding:
      position: 102
      prefix: --header-lines
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --include
  - id: keep_sites
    type:
      - 'null'
      - boolean
    doc: Leave -i/-e sites unchanged instead of discarding them
    inputBinding:
      position: 102
      prefix: --keep-sites
  - id: mark_sites
    type:
      - 'null'
      - string
    doc: Add INFO/TAG flag to sites which are ("+") or are not ("-") listed in 
      the -a file
    inputBinding:
      position: 102
      prefix: --mark-sites
  - id: merge_logic
    type:
      - 'null'
      - string
    doc: Merge logic for multiple overlapping regions
    inputBinding:
      position: 102
      prefix: --merge-logic
  - id: min_overlap
    type: string
    doc: Required overlap as a fraction of variant in the -a file (ANN), the VCF
      (:VCF), or reciprocal (ANN:VCF)
    inputBinding:
      position: 102
      prefix: --min-overlap
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
  - id: pair_logic
    type:
      - 'null'
      - string
    doc: Matching records by <snps|indels|both|all|some|exact|id>
    inputBinding:
      position: 102
      prefix: --pair-logic
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
    doc: Restrict to regions listed in FILE
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
  - id: remove
    type:
      - 'null'
      - string
    doc: List of annotations (e.g. ID,INFO/DP,FORMAT/DP,FILTER) to remove (or 
      keep with "^" prefix)
    inputBinding:
      position: 102
      prefix: --remove
  - id: rename_annots
    type:
      - 'null'
      - File
    doc: 'Rename annotations: TYPE/old\tnew, where TYPE is one of FILTER,INFO,FORMAT'
    inputBinding:
      position: 102
      prefix: --rename-annots
  - id: rename_chrs
    type:
      - 'null'
      - File
    doc: 'Rename sequences according to the mapping: old\tnew'
    inputBinding:
      position: 102
      prefix: --rename-chrs
  - id: samples
    type:
      - 'null'
      - string
    doc: Comma separated list of samples to annotate (or exclude with "^" 
      prefix)
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to annotate (or exclude with "^" prefix)
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: set_id
    type:
      - 'null'
      - string
    doc: Set ID column using a `bcftools query`-like expression
    inputBinding:
      position: 102
      prefix: --set-id
  - id: single_overlaps
    type:
      - 'null'
      - boolean
    doc: Keep memory low by avoiding complexities arising from handling multiple
      overlapping intervals
    inputBinding:
      position: 102
      prefix: --single-overlaps
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of extra output compression threads
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
