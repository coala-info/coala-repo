cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_ctffind_wrapper
label: relion-bin-plusmpi-plusgui_relion_ctffind_wrapper
doc: "A wrapper for the CTFFIND program within the RELION software suite. Note: The
  provided help text contains only container runtime log errors and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion_ctffind_wrapper.out
