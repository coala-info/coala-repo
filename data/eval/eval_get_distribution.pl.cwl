cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_distribution.pl
label: eval_get_distribution.pl
doc: "Takes the maximum value to report in the distribution, the size of bins to report
  data in, and one of more gtf sets and creates outputs the distribution to standard
  out.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: max_val
    type: float
    doc: The maximum value to report in the distribution
    inputBinding:
      position: 1
  - id: bin_size
    type: float
    doc: The size of bins to report data in
    inputBinding:
      position: 2
  - id: pred_gtf
    type:
      type: array
      items: File
    doc: One or more GTF sets (or list files if -g is not specified)
    inputBinding:
      position: 3
  - id: gtf_inputs
    type:
      - 'null'
      - boolean
    doc: Inputs are gtf files instead of list files
    inputBinding:
      position: 104
      prefix: -g
  - id: mode
    type:
      - 'null'
      - int
    doc: 'Specify distribution mode. Must be a number selected from the list (1: Transcripts_Per_Gene,
      2: Transcript_Length, 3: Transcript_Coding_Length, 4: Exons_Per_Transcript,
      5: Exon_Length, 6: Exon_Score).'
    inputBinding:
      position: 104
      prefix: -m
  - id: quick_load
    type:
      - 'null'
      - boolean
    doc: Quick load the gtf file. Do not check them for errors.
    inputBinding:
      position: 104
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_get_distribution.pl.out
