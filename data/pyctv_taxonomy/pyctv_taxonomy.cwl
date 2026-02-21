cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyctv_taxonomy
label: pyctv_taxonomy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool 'pyctv_taxonomy'.\n
  \nTool homepage: https://github.com/linsalrob/pyctv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyctv_taxonomy:0.25--pyhdfd78af_0
stdout: pyctv_taxonomy.out
