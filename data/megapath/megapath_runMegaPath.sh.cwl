cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/runMegaPath.sh
label: megapath_runMegaPath.sh
doc: "Runs the MegaPath pipeline for sequence analysis.\n\nTool homepage: https://github.com/edwwlui/MegaPath"
inputs:
  - id: database_directory
    type:
      - 'null'
      - Directory
    doc: Database directory
    inputBinding:
      position: 101
      prefix: -d
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Max read length
    inputBinding:
      position: 101
      prefix: -L
  - id: nt_score_cutoff
    type:
      - 'null'
      - int
    doc: NT alignment score cutoff
    inputBinding:
      position: 101
      prefix: -c
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: perform_assembly_and_protein_alignment
    type:
      - 'null'
      - boolean
    doc: Perform assembly & protein alignment
    inputBinding:
      position: 101
      prefix: -A
  - id: perform_ribosome_filtering
    type:
      - 'null'
      - boolean
    doc: Perform ribosome filtering
    inputBinding:
      position: 101
      prefix: -S
  - id: read1
    type: File
    doc: First read file (FASTQ format)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2
    type: File
    doc: Second read file (FASTQ format)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: skip_human_filtering
    type:
      - 'null'
      - boolean
    doc: Skip human filtering
    inputBinding:
      position: 101
      prefix: -H
  - id: spike_filter_stdev
    type:
      - 'null'
      - int
    doc: SPIKE filter number of stdev
    inputBinding:
      position: 101
      prefix: -s
  - id: spike_overlap
    type:
      - 'null'
      - float
    doc: SPIKE overlap
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath:2--h43eeafb_4
stdout: megapath_runMegaPath.sh.out
