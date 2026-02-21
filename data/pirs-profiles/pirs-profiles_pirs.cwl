cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pirs
  - profiles
label: pirs-profiles_pirs
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or fetch a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pirs-profiles:v2.0.2dfsg-8-deb_cv1
stdout: pirs-profiles_pirs.out
