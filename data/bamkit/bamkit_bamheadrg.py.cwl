cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamheadrg.py
label: bamkit_bamheadrg.py
doc: "Inject readgroup info\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs:
  - id: recipient
    type:
      - 'null'
      - File
    doc: SAM file to inject header lines into. If '-' or absent then defaults to
      stdin.
    inputBinding:
      position: 1
  - id: donor
    type: File
    doc: Donor BAM/SAM file to extract read group info
    inputBinding:
      position: 102
      prefix: --donor
  - id: donor_is_sam
    type:
      - 'null'
      - boolean
    doc: Donor file is SAM
    inputBinding:
      position: 102
      prefix: --donor_is_sam
  - id: readgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: Read group(s) to extract (comma separated)
    inputBinding:
      position: 102
      prefix: --readgroup
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamheadrg.py.out
