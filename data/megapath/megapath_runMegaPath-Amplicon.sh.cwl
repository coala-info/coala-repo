cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath_runMegaPath-Amplicon.sh
label: megapath_runMegaPath-Amplicon.sh
doc: "MegaPath-Amplicon analysis script (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/edwwlui/MegaPath"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath:2--h43eeafb_4
stdout: megapath_runMegaPath-Amplicon.sh.out
