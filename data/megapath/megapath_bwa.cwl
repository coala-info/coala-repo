cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa
label: megapath_bwa
doc: "alignment via Burrows-Wheeler transformation\n\nTool homepage: https://github.com/edwwlui/MegaPath"
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
    dockerPull: quay.io/biocontainers/megapath:2--h43eeafb_4
stdout: megapath_bwa.out
