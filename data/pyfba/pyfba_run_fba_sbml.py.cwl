cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba_run_fba_sbml.py
label: pyfba_run_fba_sbml.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch a Docker image.\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_run_fba_sbml.py.out
