cwlVersion: v1.2
class: CommandLineTool
baseCommand: [correct-cnv]
label: neoloop_correct-cnv
doc: "Remove copy number variation effect from cancer Hi-C. A bias vector is written
  into the 'sweight' column of the bins table of the cool file.\n\nTool homepage:
  https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: hic
    type: File
    doc: Cool file (balanced with cooler balance). It is copied into the working directory and modified in place.
    inputBinding:
      position: 101
      prefix: --hic
      valueFrom: "$(self.basename)$(inputs.hic_group ? inputs.hic_group : '')"
  - id: hic_group
    type:
      - 'null'
      - string
    doc: Group inside an .mcool file appended to the cool URI, for example ::resolutions/25000.
  - id: cnv_file
    type: File
    doc: Copy number segmentation in bedGraph format.
    inputBinding:
      position: 101
      prefix: --cnv-file
  - id: mad_max
    type:
      - 'null'
      - int
    doc: Ignore bins using the MAD-max filter (default 5). 0 disables the filter.
    inputBinding:
      position: 101
      prefix: --mad-max
  - id: min_nnz
    type:
      - 'null'
      - int
    doc: Ignore bins whose marginal number of nonzeros is less than this number (default 10).
    inputBinding:
      position: 101
      prefix: --min-nnz
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: Number of diagonals of the contact matrix to ignore (default 1).
    inputBinding:
      position: 101
      prefix: --ignore-diags
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes (default 1).
    inputBinding:
      position: 101
      prefix: --nproc
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the target bias vector sweight if it already exists.
    inputBinding:
      position: 101
      prefix: --force
  - id: log_file
    type:
      - 'null'
      - string
    doc: Logging file name (default cnv-norm.log).
    inputBinding:
      position: 101
      prefix: --logFile
outputs:
  - id: corrected_cool
    type: File
    doc: The input cool file with the sweight bias vector added.
    outputBinding:
      glob: $(inputs.hic.basename)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: |-
        ${ return inputs.log_file ? inputs.log_file : 'cnv-norm.log'; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hic)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
