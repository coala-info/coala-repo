cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - reassign
label: enhjoerning_unicorn_reassign
doc: "Filter alignments via EM algorithm.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: bam
    type: File
    doc: "Input BAM or SAM file"
    inputBinding:
      position: 101
      prefix: -b
  - id: outbam
    type:
      - 'null'
      - string
    doc: "Output BAM file [stdout]"
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use [4]"
    inputBinding:
      position: 101
      prefix: -t
  - id: alpha
    type:
      - 'null'
      - float
    doc: "Score retention scaling factor (0.0, 1.0] [0.80]"
    inputBinding:
      position: 101
      prefix: --alpha
  - id: niter
    type:
      - 'null'
      - int
    doc: "Max number of EM algorithm iterations [5]"
    inputBinding:
      position: 101
      prefix: --niter
  - id: scale_type
    type:
      - 'null'
      - string
    doc: "Scaling type subject weights [LENGTH]. Available types: NONE (no subject weight scaling), LENGTH (scale by subject length), SQRTLEN (scale by square root of subject length)"
    inputBinding:
      position: 101
      prefix: --scale-type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print libunicorn's messages."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: "BAM written to the standard output when --outbam is not given"
  - id: out_bam
    type:
      - 'null'
      - File
    doc: "Output BAM file"
    outputBinding:
      glob: $(inputs.outbam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning_unicorn_reassign.out
