cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtools
label: variant_tools_vtools
doc: "Variant Tools (vtools) is a software tool for the management and analysis of
  genetic variants. Note: The provided text appears to be a container runtime error
  log rather than help text, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/vatlab/varianttools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variant_tools:3.1.3--py38hd52fbc2_2
stdout: variant_tools_vtools.out
