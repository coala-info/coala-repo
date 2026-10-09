cwlVersion: v1.2
class: CommandLineTool
baseCommand: peakCenters
label: hiddendomains_peakCenters
doc: "Take an _analysis.bed or _vis.bed file (output from hiddenDomains) and a ChIP-seq
  BAM (or BED) file and identify the center of peaks. Requires bedtools.\n\nTool homepage:
  http://hiddendomains.sourceforge.net/"
inputs:
  - id: domains_bed
    type: File
    doc: An _analysis.bed or _vis.bed file from hiddenDomains
    inputBinding:
      position: 2
  - id: chipseq_reads
    type: File
    doc: ChIP-seq reads in BAM or BED format
    inputBinding:
      position: 3
  - id: extend_bases
    type:
      - 'null'
      - int
    doc: Add NUMBER bases before and after the start and stop coordinates of the
      peak. The default value is 100. Set it to 0 for just the peak coordinates.
    inputBinding:
      position: 1
      prefix: -n
  - id: process_vis
    type:
      - 'null'
      - boolean
    doc: Process a _vis.bed file instead of an _analysis.bed file
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: domains_centers
    type: stdout
    doc: BED file with the peak centers (domains_centers.bed)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.domains_bed)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: $(inputs.domains_bed.nameroot)_centers.bed
