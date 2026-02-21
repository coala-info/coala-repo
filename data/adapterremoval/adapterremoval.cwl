cwlVersion: v1.2
class: CommandLineTool
baseCommand: adapterremoval
label: adapterremoval
doc: "AdapterRemoval searches for and removes remnant adapter sequences from High-Throughput
  Sequencing (HTS) data and (optionally) trims low quality bases.\n\nTool homepage:
  https://github.com/MikkelSchubert/adapterremoval"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adapterremoval:2.3.4--pl5321haf24da9_2
stdout: adapterremoval.out
