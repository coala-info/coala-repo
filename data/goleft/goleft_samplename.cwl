cwlVersion: v1.2
class: CommandLineTool
baseCommand: goleft
label: goleft_samplename
doc: "Extract sample name(s) from a BAM file.\n\nTool homepage: https://github.com/brentp/goleft"
inputs:
  - id: bam
    type: File
    doc: bam for to get sample name(s)
    inputBinding:
      position: 1
  - id: errormulti
    type:
      - 'null'
      - boolean
    doc: return an error if there is not exactly 1 sample in the bam.
    inputBinding:
      position: 102
      prefix: --errormulti
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goleft:0.2.6--he881be0_1
stdout: goleft_samplename.out
