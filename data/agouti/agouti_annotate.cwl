cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agouti
  - annotate
label: agouti_annotate
doc: "Annotate BED or custom column-based files using a database created with agouti
  create_db.\n\nTool homepage: https://github.com/zywicki-lab/agouti"
inputs:
  - id: annotate_relative_location
    type:
      - 'null'
      - boolean
    doc: annotate the relative location of the interval within the feature. 
      Designed to work with –transcriptomic mode
    inputBinding:
      position: 101
      prefix: --annotate_relative_location
  - id: combine
    type:
      - 'null'
      - string
    doc: 'list of specific feature-attribute combinations to be reported (format:
      feature1-attribute1:attribute2,feature2-attribute1).'
    inputBinding:
      position: 101
      prefix: --combine
  - id: completly_within
    type:
      - 'null'
      - boolean
    doc: the annotated BED interval must be located entirely within the GTF/GFF3
      feature.
    inputBinding:
      position: 101
      prefix: --completly_within
  - id: coordinates
    type:
      - 'null'
      - int
    doc: indicate the coordinate system used in the input file (BED/CUSTOM). 
      Either 0 (0-based) or 1 (1-based).
    default: 0
    inputBinding:
      position: 101
      prefix: --coordinates
  - id: custom
    type:
      - 'null'
      - string
    doc: 'the input text file is in custom format, other than BED. Provide column
      indexes: "id,chr,s,e[,strand]".'
    inputBinding:
      position: 101
      prefix: --custom
  - id: database
    type: File
    doc: database file created with the agouti create_db run mode
    inputBinding:
      position: 101
      prefix: --database
  - id: header_lines
    type:
      - 'null'
      - int
    doc: the number of header lines in the input file.
    default: 0
    inputBinding:
      position: 101
      prefix: --header_lines
  - id: input
    type: File
    doc: input file in BED or another column-based format (see --custom).
    inputBinding:
      position: 101
      prefix: --input
  - id: level
    type:
      - 'null'
      - int
    doc: annotate results on a specific level (1 for gene level, 2 for mRNA, 
      tRNA level, etc.).
    default: 2
    inputBinding:
      position: 101
      prefix: --level
  - id: select_attributes
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated list of attribute names to be reported, e.g., 
      "ID,description".
    inputBinding:
      position: 101
      prefix: --select_attributes
  - id: select_features
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated list of feature names to be reported, e.g., "mRNA,CDS".
    inputBinding:
      position: 101
      prefix: --select_features
  - id: separator
    type:
      - 'null'
      - string
    doc: field separator to be used with the --custom option.
    default: \t
    inputBinding:
      position: 101
      prefix: --separator
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: calculate additional feature statistics. Those will be displayed on the
      stderr
    inputBinding:
      position: 101
      prefix: --statistics
  - id: stats_only
    type:
      - 'null'
      - boolean
    doc: calculate and display only feature statistics. No annotation will be 
      performed.
    inputBinding:
      position: 101
      prefix: --stats_only
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: strand-specific search
    inputBinding:
      position: 101
      prefix: --strand_specific
  - id: transcriptomic
    type:
      - 'null'
      - boolean
    doc: transcriptomic annotation mode. Transcript IDs are expected in the 
      first column.
    inputBinding:
      position: 101
      prefix: --transcriptomic
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agouti:1.0.3--pyhdfd78af_0
stdout: agouti_annotate.out
