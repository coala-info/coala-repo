cwlVersion: v1.2
class: CommandLineTool
baseCommand: el_gato_el_gato.py
label: el_gato_el_gato.py
doc: "The provided text does not contain help information, but rather error logs related
  to a container environment failure (no space left on device).\n\nTool homepage:
  https://github.com/appliedbinf/el_gato"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
stdout: el_gato_el_gato.py.out
