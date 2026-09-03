cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kallisto
  - inspect
label: kallisto_inspect
doc: Inspect a kallisto index file
inputs:
  - id: index_file
    type: File
    doc: kallisto index file
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
stdout: kallisto_inspect.out
s:url: https://pachterlab.github.io/kallisto
$namespaces:
  s: https://schema.org/
