cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmstat
label: hmmer_hmmstat
doc: display summary statistics for a profile file
inputs:
  - id: hmmfile
    type: File
    doc: Input HMM profile file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
stdout: hmmer_hmmstat.out
s:url: http://hmmer.org/
$namespaces:
  s: https://schema.org/
