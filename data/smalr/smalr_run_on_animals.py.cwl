cwlVersion: v1.2
class: CommandLineTool
baseCommand: smalr_run_on_animals.py
label: smalr_run_on_animals.py
doc: "A tool from the SMALR (Single Molecule Analysis of Lipid Rafts) suite, likely
  used for processing animal-related data.\n\nTool homepage: https://github.com/silviazuffi/smalr_online"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/smalr:v1.1dfsg-2-deb_cv1
stdout: smalr_run_on_animals.py.out
