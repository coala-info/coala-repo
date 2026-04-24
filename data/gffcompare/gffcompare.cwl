cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffcompare
label: gffcompare
doc: "Compare and annotate GFF/GTF files against a reference annotation, or compare
  them to each other.\n\nTool homepage: https://ccb.jhu.edu/software/stringtie/gffcompare.shtml"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more GFF/GTF files to compare.
    inputBinding:
      position: 1
  - id: genome_path
    type:
      - 'null'
      - Directory
    doc: Path to a directory containing genome sequences (FASTA files).
    inputBinding:
      position: 102
      prefix: -s
  - id: ignore_non_overlapping_query
    type:
      - 'null'
      - boolean
    doc: Discard multi-exon query transcripts that do not overlap any reference transcript.
    inputBinding:
      position: 102
      prefix: -M
  - id: ignore_non_overlapping_reference
    type:
      - 'null'
      - boolean
    doc: Ignore reference transcripts that are not overlapped by any query transcript.
    inputBinding:
      position: 102
      prefix: -R
  - id: input_list
    type:
      - 'null'
      - File
    doc: A text file containing a list of query GFF/GTF files to compare.
    inputBinding:
      position: 102
      prefix: -i
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance (range) for grouping transcript start/end sites.
    inputBinding:
      position: 102
      prefix: -d
  - id: no_comparison
    type:
      - 'null'
      - boolean
    doc: Do not run the comparison (only generate the merged GFF).
    inputBinding:
      position: 102
      prefix: -T
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Do not merge/collapse similar query transcripts.
    inputBinding:
      position: 102
      prefix: -N
  - id: reference_annotation
    type:
      - 'null'
      - File
    doc: Reference annotation file (GFF/GTF) to compare query files against.
    inputBinding:
      position: 102
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (show messages about progress).
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffcompare:0.12.10--h9948957_0
