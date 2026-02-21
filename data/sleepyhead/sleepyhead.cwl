cwlVersion: v1.2
class: CommandLineTool
baseCommand: sleepyhead
label: sleepyhead
doc: "Sleep analysis software for reviewing and exploring data produced by CPAP and
  related machines.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sleepyhead:v1.0.0-beta-2dfsg-6-deb_cv1
stdout: sleepyhead.out
