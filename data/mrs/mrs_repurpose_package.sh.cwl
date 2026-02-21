cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_repurpose_package.sh
label: mrs_repurpose_package.sh
doc: "A tool for repurposing packages. Note: The provided input text is an error log
  regarding a container build failure and does not contain usage instructions or argument
  definitions.\n\nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_repurpose_package.sh.out
