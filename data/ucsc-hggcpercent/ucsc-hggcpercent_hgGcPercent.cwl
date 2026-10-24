cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgGcPercent
label: ucsc-hggcpercent_hgGcPercent
doc: "Calculate GC percentage in 20kb windows. Loads the gcPercent table with counts from sequence unless -noLoad or -file is given.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: win
    type: ['null', int]
    doc: Change the window size (default 20000)
    inputBinding:
      prefix: -win=
      separate: false
      position: 1
  - id: no_load
    type: ['null', boolean]
    doc: Do not load the mysql table, create a bed file
    inputBinding:
      prefix: -noLoad
      position: 2
  - id: file
    type: ['null', string]
    doc: Output file name (implies -noLoad)
    inputBinding:
      prefix: -file=
      separate: false
      position: 3
  - id: chr
    type: ['null', string]
    doc: Process only this chromosome from the nibDir
    inputBinding:
      prefix: -chr=
      separate: false
      position: 4
  - id: no_random
    type: ['null', boolean]
    doc: Ignore random chromosomes from the nibDir
    inputBinding:
      prefix: -noRandom
      position: 5
  - id: no_dots
    type: ['null', boolean]
    doc: Do not display ... progress during processing
    inputBinding:
      prefix: -noDots
      position: 6
  - id: do_gaps
    type: ['null', boolean]
    doc: Process gaps correctly (default is that gaps are not counted as GC)
    inputBinding:
      prefix: -doGaps
      position: 7
  - id: wig_out
    type: ['null', boolean]
    doc: Output wiggle ascii data ready to pipe to wigEncode
    inputBinding:
      prefix: -wigOut
      position: 8
  - id: overlap
    type: ['null', int]
    doc: Overlap windows by N bases (default 0)
    inputBinding:
      prefix: -overlap=
      separate: false
      position: 9
  - id: verbose
    type: ['null', int]
    doc: Display details to stderr during processing
    inputBinding:
      prefix: -verbose=
      separate: false
      position: 10
  - id: bed_region_in
    type: ['null', File]
    doc: Read in a bed file for GC content in specific regions
    inputBinding:
      prefix: -bedRegionIn=
      separate: false
      position: 11
  - id: bed_region_out
    type: ['null', string]
    doc: Write a bed file of GC content in the regions from bedRegionIn
    inputBinding:
      prefix: -bedRegionOut=
      separate: false
      position: 12
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 20
  - id: nib_dir
    type: File
    doc: Genome sequence as a .2bit file
    inputBinding:
      position: 21
outputs:
  - id: output_file
    type: ['null', File]
    doc: Output written with -file
    outputBinding:
      glob: $(inputs.file)
  - id: bed_region_out_file
    type: ['null', File]
    doc: GC content of the regions from bedRegionIn
    outputBinding:
      glob: $(inputs.bed_region_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hggcpercent:482--h0b57e2e_0
