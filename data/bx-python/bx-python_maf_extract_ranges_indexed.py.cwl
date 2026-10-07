cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maf_extract_ranges_indexed.py
label: bx-python_maf_extract_ranges_indexed.py
doc: "Extract ranges from MAF files.\n\nTool homepage: https://github.com/bxlab/bx-python"
inputs:
  - id: maf_files
    type:
      type: array
      items: File
    secondaryFiles:
      - .index
    doc: MAF file(s) to extract ranges from, each with its maf_fname.index file 
      (from maf_build_index.py) beside it
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: File containing intervals to extract (src start end [strand]; read 
      from standard input)
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
  - id: output_dir_path
    type:
      - 'null'
      - string
    doc: Write each interval as a separate file in this directory
    inputBinding:
      position: 103
      prefix: --dir
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory with one MAF file per interval (when --dir is given)
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: stdout
    type: stdout
    doc: Extracted MAF blocks (when --dir is not given)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        if (!inputs.output_dir_path) { return []; }
        return [{"class": "Directory", "basename": inputs.output_dir_path, "listing": [], "writable": true}];
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0
stdin: $(inputs.interval_file.path)
stdout: bx-python_maf_extract_ranges_indexed.py.maf
