cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadarida-c_seuils_analyse.r
label: tadarida-c_seuils_analyse.r
doc: "The provided text does not contain help information for the tool, but appears
  to be a fatal error log from a container execution environment (Singularity/Apptainer)
  failing to fetch the image.\n\nTool homepage: https://github.com/YvesBas/Tadarida-C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadarida-c:1.2--r3.4.1_0
stdout: tadarida-c_seuils_analyse.r.out
