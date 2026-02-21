cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - isec
label: bcftools_isec
doc: "Create intersections, unions and complements of VCF files.\n\nTool homepage:
  https://github.com/samtools/bcftools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input VCF/BCF files
    inputBinding:
      position: 1
  - id: apply_filters
    type:
      - 'null'
      - string
    doc: Require at least one of the listed FILTER strings (e.g. "PASS,.")
    inputBinding:
      position: 102
      prefix: --apply-filters
  - id: collapse
    type:
      - 'null'
      - string
    doc: Treat as identical records with <snps|indels|both|all|some|none|id>
    default: none
    inputBinding:
      position: 102
      prefix: --collapse
  - id: complement
    type:
      - 'null'
      - boolean
    doc: Output positions present only in the first file but missing in the 
      others
    inputBinding:
      position: 102
      prefix: --complement
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --exclude
  - id: file_list
    type:
      - 'null'
      - File
    doc: Read the input file names from the file
    inputBinding:
      position: 102
      prefix: --file-list
  - id: include
    type:
      - 'null'
      - string
    doc: Include only sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --include
  - id: nfiles
    type:
      - 'null'
      - string
    doc: Output positions present in this many (=), this many or more (+), this 
      many or fewer (-), the exact (~) files
    inputBinding:
      position: 102
      prefix: --nfiles
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    default: v
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
    default: 1
    inputBinding:
      position: 102
      prefix: --regions-overlap
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with INT worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write
    type:
      - 'null'
      - string
    doc: List of files to write with -p given as 1-based indexes. By default, 
      all files are written
    inputBinding:
      position: 102
      prefix: --write
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files [off]
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to a file [standard output]
    outputBinding:
      glob: $(inputs.output)
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: If given, subset each of the input files accordingly, see also -w
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
