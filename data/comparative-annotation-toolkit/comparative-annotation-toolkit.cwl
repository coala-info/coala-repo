cwlVersion: v1.2
class: CommandLineTool
baseCommand: comparative-annotation-toolkit
label: comparative-annotation-toolkit
doc: "The provided text is an error log indicating a failure to pull or run the Singularity/Docker
  container (no space left on device) and does not contain help documentation or argument
  definitions.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/comparative-annotation-toolkit:0.1--pyh2407274_1
stdout: comparative-annotation-toolkit.out
