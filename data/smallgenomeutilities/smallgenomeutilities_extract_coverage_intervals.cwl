cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_coverage_intervals
label: smallgenomeutilities_extract_coverage_intervals
doc: "Script to extract coverage windows for ShoRAH\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: based
    type:
      - 'null'
      - string
    doc: Specifies whether the input TSV is 0-based (as used by python tools 
      such as pysamm, or in BED files) or 1-based (as standard notation in 
      genetics, or in VCF files), and thus should be converted before outputing 
      the 0-based output.are interpreted using 0-based indexing, and a half-open
      interval is used, i.e, [start:end)
    inputBinding:
      position: 102
      prefix: --based
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: File containing coverage per locus per sample. Samples are expected as 
      columns and loci as rows. This option is not compatible with the 
      read-window overlap thresholding
    inputBinding:
      position: 102
      prefix: --coverage-file
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum read depth per window
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Patient/sample identifiers as comma separated strings
    inputBinding:
      position: 102
      prefix: --names
  - id: no_shorah
    type:
      - 'null'
      - boolean
    doc: Inidcate whether to report regions with sufficient coverage rather than
      windows for SNV calling using ShoRAH
    inputBinding:
      position: 102
      prefix: --no-shorah
  - id: region
    type:
      - 'null'
      - string
    doc: Region of interested in BED format, e.g. HXB2:2253-3869. Loci are 
      interpreted using 0-based indexing, and a half-open interval is used, i.e,
      [start:end). If the input TSV isn't 0-based, see option -b below
    inputBinding:
      position: 102
      prefix: --region
  - id: right_offset
    type:
      - 'null'
      - boolean
    doc: Indicate whether to apply a more liberal shift on intervals' 
      right-endpoint
    inputBinding:
      position: 102
      prefix: --right-offset
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: window_lenght
    type:
      - 'null'
      - type: array
        items: string
    doc: Window length used by ShoRAH
    inputBinding:
      position: 102
      prefix: --window-lenght
  - id: window_overlap
    type:
      - 'null'
      - float
    doc: Threshold on the overlap between each read and the window
    inputBinding:
      position: 102
      prefix: --window-overlap
  - id: window_shift
    type:
      - 'null'
      - type: array
        items: string
    doc: Window shifts used by ShoRAH
    inputBinding:
      position: 102
      prefix: --window-shift
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
