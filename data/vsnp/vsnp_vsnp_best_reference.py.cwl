cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_best_reference.py
label: vsnp_vsnp_best_reference.py
doc: "Use oligos to determine the species (Brucella, Mycobacterium bovis or paratuberculosis)\
  \ from reads. Writes best_reference.txt.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: read1
    type: File
    doc: 'Required: single read'
    inputBinding:
      position: 101
      prefix: -r1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Optional: paired read'
    inputBinding:
      position: 101
      prefix: -r2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: best_reference
    type: File
    doc: Oligo counts and species call
    outputBinding:
      glob: best_reference.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_best_reference.py.out
