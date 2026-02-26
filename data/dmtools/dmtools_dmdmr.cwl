cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools
label: dmtools_dmdmr
doc: "A collection of tools for DNA methylation analysis.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: mode
    type: string
    doc: 'The mode of operation for dmtools. Available modes: index, align, bam2dm,
      mr2dm, view, merge, ebsrate, viewheader, overlap, regionstats, bodystats, profile,
      chromstats, chrmeth, addzm, stats, dmDMR, bw'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options specific to the chosen mode.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools_dmdmr.out
