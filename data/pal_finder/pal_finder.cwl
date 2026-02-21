cwlVersion: v1.2
class: CommandLineTool
baseCommand: pal_finder
label: pal_finder
doc: "A tool for finding microsatellite repeats and designing primers from NGS data.
  The tool requires a configuration file containing necessary parameters.\n\nTool
  homepage: http://sourceforge.net/projects/palfinder/"
inputs:
  - id: config_file
    type: File
    doc: Path to the configuration file (e.g., pal_finder.cfg) containing run parameters
      such as 'findPrimers'.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pal_finder:0.02.04--2
stdout: pal_finder.out
