cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - faidx
label: phykit_faidx
doc: Extracts sequence entry from fasta file. This function works similarly to 
  the faidx function in samtools, but does not requiring an indexing step.
inputs:
  - id: fasta
    type: File
    doc: query fasta file
    inputBinding:
      position: 1
  - id: entry
    type: string
    doc: entry name to be extracted from the inputted fasta file. To obtain 
      multiple entries, input multiple entries separated by a comma (,).
    inputBinding:
      position: 102
      prefix: --entry
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_faidx.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
