cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capCpileup2binned
label: capc-map_capCpileup2binned
doc: "Bin and/or normalize a capture pile-up bedGraph (one or more of bin_window or totalreads must be given).\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: pileupfile
    type: File
    doc: "is the input pile-up file name"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "is the file name for the output bedGraph"
    inputBinding:
      position: 1
      prefix: -o
  - id: chromsizes
    type: File
    doc: "is the file name for the list of chromosome sizes"
    inputBinding:
      position: 1
      prefix: -c
  - id: target
    type: string
    doc: "is the name of the target"
    inputBinding:
      position: 1
      prefix: -t
  - id: bin_window
    type:
      - 'null'
      - type: array
        items: int
    doc: "two values 'bin wind': pile-up will be put into sliding window bins with step size of 'bin' and window width of 'wind'"
    inputBinding:
      position: 1
      prefix: -b
  - id: totalreads
    type:
      - 'null'
      - long
    doc: "pile-up will be normalized to reads per million genome wide; requires total number of reads (available from capC main process report file; includes both inter and intra chromosomal)."
    inputBinding:
      position: 1
      prefix: -n
outputs:
  - id: binned_bedgraph
    type: File
    doc: "binned and/or normalized bedGraph"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
