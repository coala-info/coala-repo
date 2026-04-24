cwlVersion: v1.2
class: CommandLineTool
baseCommand: bleties milcor
label: bleties_milcor
doc: "MILCOR - Method of IES Long-read CORrelation\n\nTool homepage: https://github.com/Swart-lab/bleties"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file containing mapping, must be sorted and indexed
    inputBinding:
      position: 101
      prefix: --bam
  - id: bin
    type:
      - 'null'
      - boolean
    doc: Bin reads into likely MIC and MAC origin and output Fasta files
    inputBinding:
      position: 101
      prefix: --bin
  - id: bin_threshold
    type:
      - 'null'
      - float
    doc: IES retention/excision threshold for binning to MIC or MAC respecitvely
    inputBinding:
      position: 101
      prefix: --bin_threshold
  - id: contig
    type:
      - 'null'
      - string
    doc: Only process alignments from this contig
    inputBinding:
      position: 101
      prefix: --contig
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Dump contents of IES correlation objects to JSON file, for 
      troubleshooting
    inputBinding:
      position: 101
      prefix: --dump
  - id: ies_file
    type:
      - 'null'
      - File
    doc: GFF3 file containing coordinates of IES junctions in MAC genome
    inputBinding:
      position: 101
      prefix: --ies
  - id: length_threshold
    type:
      - 'null'
      - float
    doc: Length threshold to count matching IES length, if option 
      --use_ies_lengths is applied
    inputBinding:
      position: 101
      prefix: --length_threshold
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output filename prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: start
    type:
      - 'null'
      - int
    doc: Start coordinate (1-based, inclusive) from contig to process
    inputBinding:
      position: 101
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: Stop coordinate (1-based, inclusive) from contig to process
    inputBinding:
      position: 101
      prefix: --stop
  - id: use_ies_lengths
    type:
      - 'null'
      - boolean
    doc: Only count inserts that match IES lengths reported in the input GFF 
      file. This assumes that the input GFF file is produced by BleTIES MILRAA
    inputBinding:
      position: 101
      prefix: --use_ies_lengths
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
stdout: bleties_milcor.out
