cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPartition
label: ucsc-pslpartition
doc: "split PSL files into non-overlapping sets for use in cluster jobs, limiting memory usage, etc.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: out_levels
    type:
      - 'null'
      - int
    doc: "Number of output subdirectory levels (default 0); 2 creates files in the form outDir/0/0/00.psl."
    inputBinding:
      position: 0
      prefix: "-outLevels="
      separate: false
  - id: part_size
    type:
      - 'null'
      - int
    doc: "Combine non-overlapping partitions, keeping them under this number of PSLs (default 20000); 0 creates a PSL file per set of overlapping PSLs."
    inputBinding:
      position: 0
      prefix: "-partSize="
      separate: false
  - id: drop_contained
    type:
      - 'null'
      - boolean
    doc: "Drop PSLs that are completely contained in a block of another PSL."
    inputBinding:
      position: 0
      prefix: "-dropContained"
  - id: parallel
    type:
      - 'null'
      - int
    doc: "Use this many cores for parallel sorting."
    inputBinding:
      position: 0
      prefix: "-parallel="
      separate: false
  - id: psl_file
    type: File
    doc: "Input PSL file (may be compressed; no ordering assumed)."
    inputBinding:
      position: 1
  - id: out_dir
    type: string
    doc: "Output directory name."
    inputBinding:
      position: 2
outputs:
  - id: out_directory
    type: Directory
    doc: "Directory with the partitioned PSL files."
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpartition:482--h0b57e2e_0
stderr: ucsc-pslpartition.err
