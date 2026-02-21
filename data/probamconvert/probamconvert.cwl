cwlVersion: v1.2
class: CommandLineTool
baseCommand: probamconvert
label: probamconvert
doc: "A tool for converting protein-related data to BAM format (proBAM). Note: The
  provided text appears to be a container runtime error log rather than the tool's
  help documentation.\n\nTool homepage: https://github.com/Biobix/proBAMconvert"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probamconvert:1.0.2--py27_1
stdout: probamconvert.out
