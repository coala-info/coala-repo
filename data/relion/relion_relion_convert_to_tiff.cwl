cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_convert_to_tiff
label: relion_relion_convert_to_tiff
doc: "Compress movies (MRC, MRCS or EER) to TIFF files.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input movie to be compressed (an MRC/MRCS file or a list of movies as .star or .lst)
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type:
      - 'null'
      - string
    doc: 'Directory for output TIFF files (RELION default: ./)'
    inputBinding:
      position: 101
      prefix: --o
    default: converted/
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only process non-converted movies.
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (useful only for --estimate_gain) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: gain
    type:
      - 'null'
      - File
    doc: Estimated gain map and its reliablity map (read)
    inputBinding:
      position: 101
      prefix: --gain
  - id: thresh
    type:
      - 'null'
      - int
    doc: 'Number of success needed to consider a pixel reliable (RELION default: 50)'
    inputBinding:
      position: 101
      prefix: --thresh
  - id: estimate_gain
    type:
      - 'null'
      - boolean
    doc: Estimate gain
    inputBinding:
      position: 101
      prefix: --estimate_gain
  - id: eer_grouping
    type:
      - 'null'
      - int
    doc: 'EER grouping (RELION default: 40)'
    inputBinding:
      position: 101
      prefix: --eer_grouping
  - id: eer_upsampling
    type:
      - 'null'
      - int
    doc: 'EER upsampling (1 = physical or 2 = 2x super-resolution) (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --eer_upsampling
  - id: short
    type:
      - 'null'
      - boolean
    doc: use unsigned short instead of signed byte for EER rendering
    inputBinding:
      position: 101
      prefix: --short
  - id: compression
    type:
      - 'null'
      - string
    doc: 'compression type (none, auto, deflate (= zip), lzw) (RELION default: auto)'
    inputBinding:
      position: 101
      prefix: --compression
  - id: deflate_level
    type:
      - 'null'
      - int
    doc: 'deflate level. 1 (fast) to 9 (slowest but best compression) (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --deflate_level
  - id: ignore_error
    type:
      - 'null'
      - boolean
    doc: Don't die on un-expected defect pixels (can be dangerous)
    inputBinding:
      position: 101
      prefix: --ignore_error
  - id: line_by_line
    type:
      - 'null'
      - boolean
    doc: Use one strip per row
    inputBinding:
      position: 101
      prefix: --line_by_line
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the TIFF movies
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_convert_to_tiff.out
