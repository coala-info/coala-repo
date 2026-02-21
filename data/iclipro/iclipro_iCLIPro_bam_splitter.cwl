cwlVersion: v1.2
class: CommandLineTool
baseCommand: iCLIPro_bam_splitter
label: iclipro_iCLIPro_bam_splitter
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding a container runtime (Apptainer/Singularity)
  failing due to insufficient disk space.\n\nTool homepage: http://www.biolab.si/iCLIPro/doc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iclipro:0.1.1--py27_0
stdout: iclipro_iCLIPro_bam_splitter.out
