cwlVersion: v1.2
class: CommandLineTool
baseCommand: uropa
label: uropa
doc: "UROPA - Universal RObust Peak Annotator. UROPA is a peak annotation tool facilitating
  the analysis of next-generation sequencing methods such as ChIPseq and ATACseq.
  The advantage of UROPA is that it can accommodate advanced structures of annotation
  requirements. UROPA is developed as an open source analysis pipeline for peaks generated
  from standard peak callers.\n\nTool homepage: https://github.molgen.mpg.de/loosolab/UROPA"
inputs:
  - id: attribute_values
    type:
      - 'null'
      - type: array
        items: string
    doc: Value(s) of attribute corresponding to --filter-attribute
    inputBinding:
      position: 101
      prefix: --attribute-values
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Filename of .bed-file to annotate
    inputBinding:
      position: 101
      prefix: --bed
  - id: chunk
    type:
      - 'null'
      - int
    doc: 'Number of lines per chunk for multiprocessing (default: 1000)'
    default: 1000
    inputBinding:
      position: 101
      prefix: --chunk
  - id: config_file
    type:
      - 'null'
      - File
    doc: Filename of configuration file (keys in this file overwrite 
      command-line arguments about query)
    inputBinding:
      position: 101
      prefix: --input
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print verbose messages (for debugging)
    inputBinding:
      position: 101
      prefix: --debug
  - id: distance
    type:
      - 'null'
      - type: array
        items: int
    doc: Maximum permitted distance from feature (1 or 2 arguments)
    inputBinding:
      position: 101
      prefix: --distance
  - id: feature
    type:
      - 'null'
      - type: array
        items: string
    doc: Feature for annotation
    inputBinding:
      position: 101
      prefix: --feature
  - id: feature_anchor
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific feature anchor to annotate to
    inputBinding:
      position: 101
      prefix: --feature-anchor
  - id: filter_attribute
    type:
      - 'null'
      - boolean
    doc: Filter on 9th column of GTF
    inputBinding:
      position: 101
      prefix: --filter-attribute
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: Filename of .gtf-file with features
    inputBinding:
      position: 101
      prefix: --gtf
  - id: internals
    type:
      - 'null'
      - boolean
    doc: Set minimum overlap fraction for internal feature annotations. 0 
      equates to internals=False and 1 equates to internals=True. Default is 
      False.
    inputBinding:
      position: 101
      prefix: --internals
  - id: log_file
    type:
      - 'null'
      - File
    doc: 'Log file name for messages and warnings (default: log is written to stdout)'
    inputBinding:
      position: 101
      prefix: --log
  - id: output_by_query
    type:
      - 'null'
      - boolean
    doc: Additionally create output files for each named query seperately
    inputBinding:
      position: 101
      prefix: --output-by-query
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for result file names (defaults to basename of .bed-file)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: relative_location
    type:
      - 'null'
      - type: array
        items: string
    doc: Peak location relative to feature location
    inputBinding:
      position: 101
      prefix: --relative-location
  - id: show_attributes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'A list of attributes to show in output (default: all)'
    inputBinding:
      position: 101
      prefix: --show-attributes
  - id: strand
    type:
      - 'null'
      - boolean
    doc: Desired strand of annotated feature relative to peak
    inputBinding:
      position: 101
      prefix: --strand
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Create additional visualisation of results in graphical format
    inputBinding:
      position: 101
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Multiprocessed run: n = number of threads to run annotation process'
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'Output directory for output files (default: current dir)'
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uropa:4.0.3--pyhdfd78af_0
