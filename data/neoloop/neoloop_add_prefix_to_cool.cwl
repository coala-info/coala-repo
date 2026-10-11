cwlVersion: v1.2
class: CommandLineTool
baseCommand: [add_prefix_to_cool.py]
label: neoloop_add_prefix_to_cool
doc: "Add the chr prefix to all chromosome names of a cool file, in place. Use it before
  calculate-cnv when the chromosome names have no chr prefix.\n\nTool homepage:
  https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: in_cool
    type: File
    doc: Cool file to modify. It is copied into the working directory and renamed in place.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: renamed_cool
    type: File
    doc: The cool file with chr-prefixed chromosome names.
    outputBinding:
      glob: $(inputs.in_cool.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_cool)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
