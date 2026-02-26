cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf_extract_ranges_indexed.py
label: bx-python_maf_extract_ranges_indexed.py
doc: "Extract ranges from MAF files.\n\nTool homepage: https://github.com/bxlab/bx-python"
inputs:
  - id: maf_files
    type:
      type: array
      items: File
    doc: MAF file(s) to extract ranges from
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: File containing intervals to extract
    inputBinding:
      position: 2
  - id: chop
    type:
      - 'null'
      - boolean
    doc: Should blocks be chopped to only portion overlapping (no by default)
    inputBinding:
      position: 103
      prefix: --chop
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length (columns) required for alignment to be output
    inputBinding:
      position: 103
      prefix: --mincols
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prepend this to each src before lookup
    inputBinding:
      position: 103
      prefix: --prefix
  - id: src
    type:
      - 'null'
      - string
    doc: Use this src for all intervals
    inputBinding:
      position: 103
      prefix: --src
  - id: strand
    type:
      - 'null'
      - boolean
    doc: Strand is included as an additional column, and the blocks are reverse 
      complemented (if necessary) so that they are always on that strand w/r/t 
      the src species.
    inputBinding:
      position: 103
      prefix: --strand
  - id: use_cache
    type:
      - 'null'
      - boolean
    doc: Use a cache that keeps blocks of the MAF files in memory (requires 
      ~20MB per MAF)
    inputBinding:
      position: 103
      prefix: --usecache
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Write each interval as a separate file in this directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0
