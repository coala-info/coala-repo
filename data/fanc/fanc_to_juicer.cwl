cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - to-juicer
label: fanc_to_juicer
doc: "Convert FAN-C ReadPairs files to Juicer .hic format. Needs juicer_tools.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Input .pairs file(s), FAN-C format."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output Juicer file."
    inputBinding:
      position: 2
  - id: juicer_tools_jar
    type:
      - 'null'
      - File
    doc: "Path to juicer jar. You can also specify this in fanc.conf"
    inputBinding:
      position: 20
      prefix: --juicer-tools-jar
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
  - id: resolutions
    type:
      - 'null'
      - type: array
        items: int
    doc: "Resolutions in bp at which to \"zoom\" the juicer matrix."
    inputBinding:
      position: 20
      prefix: --resolutions
outputs:
  - id: juicer_hic
    type: File
    doc: "Juicer .hic file."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
