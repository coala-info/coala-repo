cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycrac_pyAdapterTrimmer.py
label: pycrac_pyAdapterTrimmer.py
doc: "A tool for trimming adapters from sequencing data. (Note: The provided text
  appears to be a container runtime error log rather than the tool's help output,
  so no arguments could be extracted.)\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
stdout: pycrac_pyAdapterTrimmer.py.out
