cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fade
  - out
label: fade_out
doc: "Fragmentase Artifact Detection and Elimination. Removes all reads and mates for reads containing the artifact (used after annotate) or, with the -c flag, hard clips out artifact sequence from reads. It is recommended that the input SAM/BAM be queryname sorted.\n\nThe alignments are written to standard output as SAM, or as BAM with --bam or uncompressed BAM with --ubam.\n\nTool homepage: https://github.com/blachlylab/fade"
inputs:
  - id: input_bam_sam
    type: File
    doc: Input annotated BAM/SAM file
    inputBinding:
      position: 1
  - id: clip
    type:
      - 'null'
      - boolean
    doc: clip reads instead of filtering them
    inputBinding:
      position: 102
      prefix: --clip
  - id: threads
    type:
      - 'null'
      - int
    doc: extra threads for parsing the bam file
    inputBinding:
      position: 102
      prefix: --threads
  - id: bam
    type:
      - 'null'
      - boolean
    doc: output bam
    inputBinding:
      position: 103
      prefix: --bam
  - id: ubam
    type:
      - 'null'
      - boolean
    doc: output uncompressed bam
    inputBinding:
      position: 104
      prefix: --ubam
  - id: output_name
    type: string
    default: filtered.sam
    doc: File name for the filtered alignments (standard output); use a .bam 
      name with --bam or --ubam
outputs:
  - id: filtered
    type: stdout
    doc: Filtered or clipped alignments (standard output)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
