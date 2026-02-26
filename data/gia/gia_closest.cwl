cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia closest
label: gia_closest
doc: "Finds the closest interval in a secondary BED file for all intervals in a primary
  BED file\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Compression level to use for output files if applicable\n\n          [default:
      6]"
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: "Compression threads to use for output files if applicable\n\n          [default:
      1]"
    default: 1
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: downstream
    type:
      - 'null'
      - boolean
    doc: Report only the closest downstream interval
    inputBinding:
      position: 101
      prefix: --downstream
  - id: primary_bed_file
    type:
      - 'null'
      - File
    doc: Primary BED file to use (default=stdin)
    default: stdin
    inputBinding:
      position: 101
      prefix: --a
  - id: secondary_bed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Secondary BED file(s) to use\n\n          Multiple BED files can be provided,
      mixed format input will be demoted to the lowest rank BED provided."
    inputBinding:
      position: 101
      prefix: --b
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Specify that the input files are already presorted
    inputBinding:
      position: 101
      prefix: --sorted
  - id: strandedness
    type:
      - 'null'
      - string
    doc: "Strand-specificity of closest intervals\n\n          [default: i]\n    \
      \      [possible values: i, m, o]"
    default: i
    inputBinding:
      position: 101
      prefix: --strandedness
  - id: upstream
    type:
      - 'null'
      - boolean
    doc: Report only the closest upstream interval
    inputBinding:
      position: 101
      prefix: --upstream
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file to write to (default=stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
