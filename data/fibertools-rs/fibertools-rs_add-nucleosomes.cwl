cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, add-nucleosomes]
label: fibertools-rs_add-nucleosomes
doc: "Add nucleosomes to a bam file with m6a predictions\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: nucleosome_length
    type: ['null', int]
    doc: "Minimum nucleosome length (default 75)."
    inputBinding:
      position: 1
      prefix: -n
  - id: combined_nucleosome_length
    type: ['null', int]
    doc: "Minimum nucleosome length when combining over a single m6A (default 100)."
    inputBinding:
      position: 1
      prefix: -c
  - id: min_distance_added
    type: ['null', int]
    doc: "Minimum distance needed to add to an already existing nucleosome by crossing an m6A (default 25)."
    inputBinding:
      position: 1
      prefix: --min-distance-added
  - id: distance_from_end
    type: ['null', int]
    doc: "Minimum distance from the end of a fiber to call a nucleosome or MSP (default 45)."
    inputBinding:
      position: 1
      prefix: -d
  - id: filter
    type: ['null', int]
    doc: "BAM bit flags to filter on, equivalent to `-F` in samtools view (default 0)."
    inputBinding:
      position: 1
      prefix: -F
  - id: ftx
    type: ['null', string]
    doc: "Filtering expression to use for filtering records, for example \"len(nuc)>150\" or \"len(nuc)<150,len(msp)=30:50\". Supports len() and qual() over msp, nuc, m6a, cpg."
    inputBinding:
      position: 1
      prefix: -x
  - id: ml
    type: ['null', int]
    doc: "Minimum score in the ML tag to use or include in the output (default 125)."
    inputBinding:
      position: 1
      prefix: --ml
  - id: uncompressed
    type: ['null', boolean]
    doc: "Output uncompressed BAM files."
    inputBinding:
      position: 1
      prefix: -u
  - id: threads
    type: ['null', int]
    doc: "Threads (default 8)."
    inputBinding:
      position: 1
      prefix: -t
  - id: verbose
    type: ['null', boolean]
    doc: "Logging level: info. Use ft help for deeper levels."
    inputBinding:
      position: 1
      prefix: -v
  - id: quiet
    type: ['null', boolean]
    doc: "Turn off all logging."
    inputBinding:
      position: 1
      prefix: --quiet
  - id: bam
    type: File
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls."
    inputBinding:
      position: 10
  - id: out_bam
    type: string
    doc: "Output BAM file name, with nucleosome calls."
    default: "add_nucleosomes.bam"
    inputBinding:
      position: 11
outputs:
  - id: output_bam
    type: File
    doc: "Output BAM file with nucleosome calls."
    outputBinding:
      glob: $(inputs.out_bam)
