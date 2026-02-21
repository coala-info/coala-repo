cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign-full_runner.py
label: kegalign-full_runner.py
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_runner.py.out
