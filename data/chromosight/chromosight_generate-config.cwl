cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosight
  - generate-config
label: chromosight_generate-config
doc: "Generate pre-filled config files to use for detect and quantify. A config consists
  of a JSON file describing parameters for the analysis and path pointing to kernel
  matrices files (tsv files with numeric values used as kernel for convolution).\n\n\
  Tool homepage: https://github.com/koszullab/chromosight"
inputs:
  - id: prefix
    type: string
    doc: Path prefix for config files. If prefix is a/b, files a/b.json and 
      a/b.1.txt will be generated. If a given pattern has N kernel matrices, N 
      txt files are created they will be named a/b.[1-N].txt.
    inputBinding:
      position: 2
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Generate a preset config for the given pattern. Preset configs available
      are "loops" and "borders". [default: loops]'
    inputBinding:
      position: 1
      prefix: --preset
  - id: norm
    type:
      - 'null'
      - string
    doc: 'Normalization / balancing behaviour: auto, raw or force. [default: auto]'
    inputBinding:
      position: 1
      prefix: --norm
  - id: win_size
    type:
      - 'null'
      - string
    doc: 'Window size (width), in pixels, to use for the kernel. The pattern kernel
      will be resized to match this size. [default: auto]'
    inputBinding:
      position: 1
      prefix: --win-size
  - id: n_mads
    type:
      - 'null'
      - int
    doc: 'Maximum number of median absolute deviations below the median of the bin
      sums distribution allowed to consider detectable bins. [default: 5]'
    inputBinding:
      position: 1
      prefix: --n-mads
  - id: inter
    type:
      - 'null'
      - boolean
    doc: 'Enable to consider interchromosomal contacts. Warning: Experimental feature
      with high memory consumption, only use with small matrices.'
    inputBinding:
      position: 1
      prefix: --inter
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPUs to use in parallel. [default: 1]'
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Displays the logo.
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: config_json
    type: File
    doc: JSON config file (prefix.json)
    outputBinding:
      glob: $(inputs.prefix).json
  - id: kernel_files
    type:
      type: array
      items: File
    doc: Kernel matrix files (prefix.[1-N].txt)
    outputBinding:
      glob: $(inputs.prefix).*.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
