cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnftools
  - es2et
label: rnftools_es2et
doc: "todo\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: input_es_file
    type: File
    doc: Input ES file (evaluated segments, - for standard input).
    inputBinding:
      position: 101
      prefix: --es
outputs:
  - id: output_et_file
    type: File
    doc: Output ET file (evaluated read tuples, - for standard output).
    outputBinding:
      glob: $(inputs.output_et_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
