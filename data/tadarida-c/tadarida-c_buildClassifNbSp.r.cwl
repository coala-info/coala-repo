cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadarida-c_buildClassifNbSp.r
label: tadarida-c_buildClassifNbSp.r
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error logs.\n\nTool homepage: https://github.com/YvesBas/Tadarida-C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadarida-c:1.2--r3.4.1_0
stdout: tadarida-c_buildClassifNbSp.r.out
