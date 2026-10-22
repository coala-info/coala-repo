cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svclone
  - annotate
label: svclone_annotate
doc: "Extract directions and SV classifications\n\nTool homepage: https://github.com/mcmero/SVclone"
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
    doc: "Structural variants input file. See README for input format."
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
    doc: "Sample name. Output is written to <out_dir>/<sample>_svin.txt."
    inputBinding:
      position: 101
      prefix: --sample
  - id: out
    type:
      - 'null'
      - string
    doc: "Output directory. Sample name by default."
    inputBinding:
      position: 101
      prefix: --out
  - id: sv_format
    type:
      - 'null'
      - string
    doc: "Possible SV input formats: vcf, simple, socrates."
    inputBinding:
      position: 101
      prefix: --sv_format
  - id: blacklist
    type:
      - 'null'
      - File
    doc: "Takes a file in BED format as an argument. Skip processing of any break-pairs where either SV break-end overlaps an interval specified in the supplied bed file."
    inputBinding:
      position: 101
      prefix: --blacklist
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
  - id: svin
    type: File
    doc: Annotated structural variants (<sample>_svin.txt).
    outputBinding:
      glob: '$((inputs.out ? inputs.out : inputs.sample) + "/" + inputs.sample + "_svin.txt")'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
