cwlVersion: v1.2
class: CommandLineTool
baseCommand: fununifrac_compute_fununifrac.py
label: fununifrac_compute_fununifrac.py
doc: "A tool to compute Functional UniFrac. (Note: The provided text contains system
  error messages regarding container execution and does not include the actual help
  documentation or argument definitions).\n\nTool homepage: https://github.com/KoslickiLab/FunUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
stdout: fununifrac_compute_fununifrac.py.out
