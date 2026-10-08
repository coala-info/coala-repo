cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_overlap_stats.pl
label: eval_get_overlap_stats.pl
doc: "Computes overlap statistics using the Eval package. Inputs are gtf list files (or GTF files with -g).\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: list_member_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named inside the list files (staged beside the lists so the names resolve); not used with -g"
  - id: mode
    type:
      - 'null'
      - int
    doc: "Overlap mode (1-11): 1 Transcript_Exact_Overlap, 2 Transcript_Coding_Overlap, 3 Transcript_Region_Overlap, 4 Transcript_80p_Region_Overlap, 5 Transcript_80p_Both_Region_Overlap, 6 Transcript_Exact_Exon_Overlap, 7 Transcript_Exact_Intron_Overlap, 8 Exon_Exact_Overlap, 9 Exon_One_Base_Overlap, 10 Exon_80p_Overlap, 11 Exon_80p_Both_Overlap (default 1)"
    inputBinding:
      position: 1
      prefix: -m
  - id: gtf_input
    type:
      - 'null'
      - boolean
    doc: "Input files are in GTF format"
    inputBinding:
      position: 2
      prefix: -g
  - id: quick_load
    type:
      - 'null'
      - boolean
    doc: "Quick load the gtf file. Do not check them for errors."
    inputBinding:
      position: 3
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode"
    inputBinding:
      position: 4
      prefix: -v
  - id: lists
    type:
      type: array
      items: File
    doc: "GTF set list files (or GTF files with -g); two or more"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: Overlap statistics
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_member_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_get_overlap_stats.pl.out
