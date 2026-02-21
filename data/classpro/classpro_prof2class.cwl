cwlVersion: v1.2
class: CommandLineTool
baseCommand: classpro_prof2class
label: classpro_prof2class
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/yoshihikosuzuki/ClassPro/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/classpro:1.0.2--hda11466_1
stdout: classpro_prof2class.out
