cwlVersion: v1.2
class: CommandLineTool
baseCommand: vulcan
label: vulcan
doc: "map long reads and prosper🖖, a long read mapping pipeline that melds minimap2
  and NGMLR\n\nTool homepage: https://gitlab.com/treangenlab/vulcan"
inputs:
  - id: anylongread
    type:
      - 'null'
      - boolean
    doc: Don't know which kind of long read
    inputBinding:
      position: 101
      prefix: --anylongread
  - id: custom_cmd
    type:
      - 'null'
      - boolean
    doc: Use minimap2 and NGMLR with user's own parameter setting
    inputBinding:
      position: 101
      prefix: --custom_cmd
  - id: dry
    type:
      - 'null'
      - boolean
    doc: only generate config
    inputBinding:
      position: 101
      prefix: --dry
  - id: full
    type:
      - 'null'
      - boolean
    doc: keep all temp file
    inputBinding:
      position: 101
      prefix: --full
  - id: humanclr
    type:
      - 'null'
      - boolean
    doc: Human pacbio CLR read
    inputBinding:
      position: 101
      prefix: --humanclr
  - id: humanhifi
    type:
      - 'null'
      - boolean
    doc: Human pacbio hifi reads
    inputBinding:
      position: 101
      prefix: --humanhifi
  - id: humannanopore
    type:
      - 'null'
      - boolean
    doc: Human Nanopore reads
    inputBinding:
      position: 101
      prefix: --humannanopore
  - id: input
    type:
      type: array
      items: File
    doc: input read path, can accept multiple files
    inputBinding:
      position: 101
      prefix: --input
  - id: minimap2
    type:
      - 'null'
      - File
    doc: use existing minimap2 output as input
    inputBinding:
      position: 101
      prefix: --minimap2
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Input reads is Nanopore reads
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: pacbio_clr
    type:
      - 'null'
      - boolean
    doc: Input reads is pacbio CLR reads
    inputBinding:
      position: 101
      prefix: --pacbio_clr
  - id: pacbio_hifi
    type:
      - 'null'
      - boolean
    doc: Input reads is pacbio hifi reads
    inputBinding:
      position: 101
      prefix: --pacbio_hifi
  - id: percentile
    type:
      - 'null'
      - type: array
        items: float
    doc: percentile of cut-off
    inputBinding:
      position: 101
      prefix: --percentile
  - id: raw_edit_distance
    type:
      - 'null'
      - boolean
    doc: Use raw edit distance to do the cut-off
    inputBinding:
      position: 101
      prefix: --raw_edit_distance
  - id: reference
    type: File
    doc: reference path
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Directory of work, store temp files
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: output
    type: File
    doc: vulcan's output's prefix, the output will be prefix_{percentile}.bam
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vulcan:1.0.3--hdfd78af_0
