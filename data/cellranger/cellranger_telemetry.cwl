cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellranger
  - telemetry
label: cellranger_telemetry
doc: Configure and inspect telemetry settings and data
inputs:
  - id: command
    type: string
    doc: 'Telemetry action to perform: check (show whether telemetry is enabled and
      config info), disable (disable telemetry collection for this user), enable (enable
      telemetry collection for this user), list (list files containing saved telemetry
      data), or show (display contents of saved telemetry data)'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: cumulusprod/cellranger:10.1.0
stdout: cellranger_telemetry.out
s:url: https://github.com/10XGenomics/cellranger
$namespaces:
  s: https://schema.org/
