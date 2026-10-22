cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svclone
  - count
label: svclone_count
doc: "Count reads from called structural variations\n\nTool homepage: https://github.com/mcmero/SVclone"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "Config file."
    inputBinding:
      position: 101
      prefix: -cfg
  - id: input
    type: File
    doc: "Structural variants input file (output of annotate)."
    inputBinding:
      position: 101
      prefix: --input
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: "Corresponding indexed BAM file."
    inputBinding:
      position: 101
      prefix: --bam
  - id: sample
    type: string
    doc: "Sample name. Output is written to <out_dir>/<sample>_svinfo.txt."
    inputBinding:
      position: 101
      prefix: --sample
  - id: out
    type:
      - 'null'
      - string
    doc: "Output directory. Default: sample name."
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory (the --out value, or the sample name by default).
    outputBinding:
      glob: '$(inputs.out ? inputs.out : inputs.sample)'
  - id: read_params
    type:
      - 'null'
      - File
    doc: Read parameters file (read length, insert size) written by the step.
    outputBinding:
      glob: '$((inputs.out ? inputs.out : inputs.sample) + "/read_params.txt")'
  - id: svinfo
    type: File
    doc: Read counts per structural variant (<sample>_svinfo.txt).
    outputBinding:
      glob: '$((inputs.out ? inputs.out : inputs.sample) + "/" + inputs.sample + "_svinfo.txt")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
