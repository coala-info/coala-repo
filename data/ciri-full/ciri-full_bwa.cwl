cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa
label: ciri-full_bwa
doc: "alignment via Burrows-Wheeler transformation\n\nTool homepage: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html"
inputs:
  - id: command
    type: string
    doc: Command to execute (index, mem, fastmap, pemerge, aln, samse, sampe, 
      bwasw, shm, fa2pac, pac2bwt, pac2bwtgen, bwtupdate, bwt2sa)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the selected command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciri-full:2.1.2--hdfd78af_1
stdout: ciri-full_bwa.out
