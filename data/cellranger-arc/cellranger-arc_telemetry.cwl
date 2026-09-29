cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger-arc
  - telemetry
label: cellranger-arc_telemetry
doc: Manage and inspect telemetry data collection for Cell Ranger ARC
inputs:
  - id: action
    type: string
    doc: 'Telemetry action to perform: collect, check, disable, enable, list, or show'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger-arc:2.2.0
stdout: cellranger-arc_telemetry.out
s:url: https://github.com/mattgalbraith/cellrangerARC-docker-singularity
$namespaces:
  s: https://schema.org/
