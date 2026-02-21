cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath_runMegaPath.sh
label: megapath_runMegaPath.sh
doc: "MegaPath is a tool for pathogen detection. (Note: The provided help text contains
  only system error messages regarding container image conversion and disk space,
  and does not list command-line arguments.)\n\nTool homepage: https://github.com/edwwlui/MegaPath"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath:2--h43eeafb_4
stdout: megapath_runMegaPath.sh.out
