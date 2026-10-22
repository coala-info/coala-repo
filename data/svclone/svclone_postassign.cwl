cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svclone
  - postassign
label: svclone_postassign
doc: "Run post-assign step\n\nTool homepage: https://github.com/mcmero/SVclone"
inputs:
  - id: sample
    type: string
    doc: "Sample name."
    inputBinding:
      position: 101
      prefix: --sample
  - id: out
    type:
      - 'null'
      - string
    doc: "Output directory. Default: <sample>/ccube_out/post_assign."
    inputBinding:
      position: 101
      prefix: --out
  - id: sample_dir
    type: Directory
    doc: Sample directory written by the cluster step (<sample>/ccube_out/...). It is staged writable under the sample name.
  - id: joint
    type:
      - 'null'
      - boolean
    doc: "Indicates that variants will be post-assigned to a joint SV + SNV model."
    inputBinding:
      position: 101
      prefix: --joint
  - id: svs
    type:
      - 'null'
      - File
    doc: "SV RData file from postassign step output."
    inputBinding:
      position: 101
      prefix: --svs
  - id: snvs
    type:
      - 'null'
      - File
    doc: "SNV RData file from postassign step output."
    inputBinding:
      position: 101
      prefix: --snvs
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory (the --out value, or <sample>/ccube_out/post_assign by default).
    outputBinding:
      glob: '$(inputs.out ? inputs.out : inputs.sample + "/ccube_out/post_assign")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.sample)
        entry: $(inputs.sample_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
