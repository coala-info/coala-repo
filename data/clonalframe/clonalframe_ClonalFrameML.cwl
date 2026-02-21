cwlVersion: v1.2
class: CommandLineTool
baseCommand: ClonalFrameML
label: clonalframe_ClonalFrameML
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to extract the
  image due to lack of disk space. No arguments could be parsed.\n\nTool homepage:
  https://github.com/xavierdidelot/ClonalFrameML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clonalframe:v1.2-9-deb_cv1
stdout: clonalframe_ClonalFrameML.out
