cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa
label: athena_meta_bwa
doc: "alignment via Burrows-Wheeler transformation\n\nTool homepage: https://github.com/abishara/athena_meta/"
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
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/athena_meta:1.3--py27_0
stdout: athena_meta_bwa.out
