cwlVersion: v1.2
class: CommandLineTool
baseCommand: dms_MS-comp-taxa-dynamic
label: dms_MS-comp-taxa-dynamic
doc: "The provided text contains container runtime error messages (Apptainer/Singularity)
  rather than the tool's help documentation. No usage information or arguments could
  be extracted.\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_MS-comp-taxa-dynamic.out
