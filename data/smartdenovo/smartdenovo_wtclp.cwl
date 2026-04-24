cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtclp
label: smartdenovo_wtclp
doc: "Maximizing legal overlap by clipping long reads\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size
    inputBinding:
      position: 101
      prefix: -k
  - id: chimera_detection_window_size
    type:
      - 'null'
      - int
    doc: Window size used in chimera detection
    inputBinding:
      position: 101
      prefix: -w
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: 'For debug. 1: chimera checking; 2: conntection checking; 4: clip high error
      ending'
    inputBinding:
      position: 101
      prefix: -x
  - id: disable_special_reservation
    type:
      - 'null'
      - boolean
    doc: "Trun off specical reservation for reads contained by others\n          \
      \   Default: one read (A) will not be trimmed when it is contained by another
      read (B)."
    inputBinding:
      position: 101
      prefix: -C
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file
    inputBinding:
      position: 101
      prefix: -f
  - id: keep_full_length_or_clip_all
    type:
      - 'null'
      - boolean
    doc: Keep full length or clip all
    inputBinding:
      position: 101
      prefix: -F
  - id: max_iteration_turns
    type:
      - 'null'
      - int
    doc: Max turns of iterations
    inputBinding:
      position: 101
      prefix: -n
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Minimum length of alignment
    inputBinding:
      position: 101
      prefix: -s
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity of alignment
    inputBinding:
      position: 101
      prefix: -m
  - id: min_solid_overlaps_for_chimeric_rejection
    type:
      - 'null'
      - int
    doc: Min number of solid overlaps in a suspecting region to reject chimeric
    inputBinding:
      position: 101
      prefix: -d
  - id: overlap_file
    type:
      - 'null'
      - string
    doc: "Overlap file from wtzmo, +, *\n             Format: reads1\t+/-\tlen1\t\
      beg1\tend1\treads2\t+/-\tlen2\tbeg2\tend2\tscore\tidentity<float>\tmat\tmis\t\
      ins\tdel\tcigar"
    inputBinding:
      position: 101
      prefix: -i
  - id: retained_region_file
    type:
      - 'null'
      - string
    doc: "Long reads retained region, often from wtobt/wtcyc, +\n             Format:
      read_name\toffset\tlength\toriginal_len"
    inputBinding:
      position: 101
      prefix: -b
  - id: special_read_message
    type:
      - 'null'
      - string
    doc: Print message for special read
    inputBinding:
      position: 101
      prefix: '-8'
  - id: treat_read_as_path
    type:
      - 'null'
      - boolean
    doc: "Treat read as a path of many blocks broken by possible chimeric sites, and
      test whether the path is valid\n             will disable iteration, connection
      checking"
    inputBinding:
      position: 101
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_regions
    type:
      - 'null'
      - File
    doc: "Ouput of reads' regions after clipping, -:stdout, *\n             Format:
      read_name\toffset\tlength"
    outputBinding:
      glob: $(inputs.output_regions)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
