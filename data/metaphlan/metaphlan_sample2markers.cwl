cwlVersion: v1.2
class: CommandLineTool
baseCommand: sample2markers.py
label: metaphlan_sample2markers
doc: "Reconstruct the consensus marker sequences of each sample from SAM or BAM files (input of StrainPhlAn).\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "The input samples as SAM or BAM files"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_dir
    type: string
    doc: "The output directory (created before the run)"
    inputBinding:
      position: 101
      prefix: "--output_dir"
  - id: database
    type:
      - 'null'
      - File
    doc: "The input MetaPhlAn database (path to the pkl file; the .fna.bz2 file of the same name must sit beside it)"
    inputBinding:
      position: 101
      prefix: "--database"
  - id: clades
    type:
      - 'null'
      - type: array
        items: string
    doc: "Restricts the reconstruction of the markers to the specified clades"
    inputBinding:
      position: 101
      prefix: "--clades"
  - id: input_format
    type:
      - 'null'
      - string
    doc: "The input samples format {bam, sam, bz2} (default: bz2)"
    inputBinding:
      position: 101
      prefix: "--input_format"
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: "Whether the BAM input files are sorted"
    inputBinding:
      position: 101
      prefix: "--sorted"
  - id: min_reads_aligning
    type:
      - 'null'
      - int
    doc: "The minimum number of reads to cover a marker. Default 8 for bowtie2, 1 for minimap2 and 1 otherwise."
    inputBinding:
      position: 101
      prefix: "--min_reads_aligning"
  - id: min_base_coverage
    type:
      - 'null'
      - int
    doc: "The minimum depth of coverage for a base to be considered (default: 1)"
    inputBinding:
      position: 101
      prefix: "--min_base_coverage"
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: "The minimum quality for a base to be considered. This is performed BEFORE --min_base_coverage (default: 30)"
    inputBinding:
      position: 101
      prefix: "--min_base_quality"
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: "The minimum quality for a mapping of the read to be considered. Default 10 for bowtie2, 50 for minimap2 and 0 otherwise."
    inputBinding:
      position: 101
      prefix: "--min_mapping_quality"
  - id: max_gcsd
    type:
      - 'null'
      - float
    doc: "The maximum gap-compressed sequence divergence threshold to use in case of Minimap2 mapper (default: 0.1)"
    inputBinding:
      position: 101
      prefix: "--max_gcsd"
  - id: dominant_frq_threshold
    type:
      - 'null'
      - float
    doc: "The cutoff for degree of 'allele dominance' for a position to be considered polymorphic (default: 0.8)"
    inputBinding:
      position: 101
      prefix: "--dominant_frq_threshold"
  - id: quasi_marker_frac
    type:
      - 'null'
      - float
    doc: "Fraction [0-1] of markers with a hit of an external SGB to disqualify a quasi-marker (default: 0.33)"
    inputBinding:
      position: 101
      prefix: "--quasi_marker_frac"
  - id: depth_avg_q
    type:
      - 'null'
      - float
    doc: "A quantile to cut from both ends of the coverage distributions to calculate robust average (default: 0.2)"
    inputBinding:
      position: 101
      prefix: "--depth_avg_q"
  - id: tmp
    type:
      - 'null'
      - string
    doc: "If specified, the directory where to store the temporary files. Otherwise the output directory will be used."
    inputBinding:
      position: 101
      prefix: "--tmp"
  - id: breadth_threshold
    type:
      - 'null'
      - int
    doc: "The breadth of coverage threshold for the consensus markers (default: 80)"
    inputBinding:
      position: 101
      prefix: "--breadth_threshold"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "If specified, StrainPhlAn will not remove the temporary folder. Not available with inputs in BAM format"
    inputBinding:
      position: 101
      prefix: "--debug"
  - id: nprocs
    type:
      - 'null'
      - int
    doc: "The number of threads to execute the script (default: 1)"
    inputBinding:
      position: 101
      prefix: "--nprocs"
outputs:
  - id: markers_dir
    type: Directory
    doc: "Output folder with the reconstructed markers of each sample"
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_sample2markers.out
