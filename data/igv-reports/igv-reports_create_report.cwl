cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - create_report
label: igv-reports_create_report
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/igvteam/igv-reports"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igv-reports:1.16.0--pyh7e72e81_0
stdout: igv-reports_create_report.out
