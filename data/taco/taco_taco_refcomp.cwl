cwlVersion: v1.2
class: CommandLineTool
baseCommand: taco_refcomp
label: taco_taco_refcomp
doc: "The provided text appears to be a container execution error log rather than
  help text. Based on the tool name hint, this refers to the taco_refcomp utility
  from the TACO (Transcriptome Assembly COmparison) suite, used for comparing transcript
  assemblies to a reference annotation.\n\nTool homepage: https://github.com/tacorna/taco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taco:0.7.3--py27_0
stdout: taco_taco_refcomp.out
