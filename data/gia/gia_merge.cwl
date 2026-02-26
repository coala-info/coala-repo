cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia_merge
label: gia_merge
doc: "Merges intervals of a BED file with overlapping regions\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use for output files if applicable
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Compression threads to use for output files if applicable
    default: 1
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: demote
    type:
      - 'null'
      - boolean
    doc: Demote all merged intervals into BED3 format if they are not already in
      that format
    inputBinding:
      position: 101
      prefix: --demote
  - id: field_format
    type:
      - 'null'
      - string
    doc: Allow for non-integer chromosome names
    inputBinding:
      position: 101
      prefix: --field-format
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input BED file to process
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: Format of input file
    inputBinding:
      position: 101
      prefix: --input-format
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Assume input is sorted
    default: false
    inputBinding:
      position: 101
      prefix: --sorted
  - id: specific_strand
    type:
      - 'null'
      - string
    doc: Only merge intervals that belong to a specific strand (will ignore all 
      intervals that do not share the specified strand)
    inputBinding:
      position: 101
      prefix: --specific
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: Only merge intervals that share strandedness (will ignore intervals 
      that have unknown strand)
    inputBinding:
      position: 101
      prefix: --stranded
  - id: stream
    type:
      - 'null'
      - boolean
    doc: "Stream the input file instead of loading it into memory\n          \n  \
      \        Note that this requires the input file to be sorted and will result
      in undefined behavior if it is not.\n          \n          Currently does not
      support non-integer chromosome names."
    inputBinding:
      position: 101
      prefix: --stream
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file to write to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
