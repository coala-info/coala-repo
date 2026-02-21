cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaboliteidconverter
label: metaboliteidconverter
doc: "A tool for converting metabolite identifiers between different databases.\n\n
  Tool homepage: https://github.com/phnmnl/container-MetaboliteIDConverter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metaboliteidconverter:phenomenal-v0.5.1_cv1.2.31
stdout: metaboliteidconverter.out
