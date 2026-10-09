cwlVersion: v1.2
class: CommandLineTool
baseCommand: bPTR
label: irep_bPTR
doc: "Calculate peak-to-trough ratio (PTR) to estimate microbial growth rates from
  metagenomic data.\n\nTool homepage: https://github.com/christophertbrown/iRep"
inputs:
  - id: fasta
    type:
      type: array
      items: File
    doc: fasta file(s) of complete genomes
    inputBinding:
      position: 1
      prefix: -f
  - id: sam_files
    type:
      type: array
      items: File
    doc: sorted sam file(s) for each sample (e.g. bowtie2 --reorder)
    inputBinding:
      position: 2
      prefix: -s
  - id: method
    type: string
    doc: method for detecting Ori/Ter of replication, gc_skew or coverage
    inputBinding:
      position: 3
      prefix: -m
  - id: output_table
    type: string
    doc: filename for output table
    inputBinding:
      position: 4
      prefix: -o
  - id: precomputed_pickle
    type:
      - 'null'
      - File
    doc: pre-computed data from growth_ptr.py (pickle file)
    inputBinding:
      position: 5
      prefix: -c
  - id: output_pickle
    type:
      - 'null'
      - string
    doc: filename for output pickle file
    inputBinding:
      position: 6
      prefix: -pickle
  - id: plot_file
    type:
      - 'null'
      - string
    doc: 'filename for coverage profile plots (default: no plots)'
    inputBinding:
      position: 7
      prefix: -plot
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'maximum number of mapping mismatches allowed (default: no limit)'
    inputBinding:
      position: 8
      prefix: -mm
  - id: permutations
    type:
      - 'null'
      - int
    doc: 'number of permutations to perform (default: None)'
    inputBinding:
      position: 9
      prefix: -p
  - id: sort_sam
    type:
      - 'null'
      - boolean
    doc: sort the sam file
    inputBinding:
      position: 10
      prefix: --sort
  - id: sort_memory_gb
    type:
      - 'null'
      - int
    doc: 'max memory (GB) for sorting sam (default: 100)'
    inputBinding:
      position: 11
      prefix: -b
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite files
    inputBinding:
      position: 12
      prefix: -ff
  - id: threads
    type:
      - 'null'
      - int
    doc: 'threads (default: 6)'
    inputBinding:
      position: 13
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_table_file
    type: File
    doc: output table of peak-to-trough ratios
    outputBinding:
      glob: $(inputs.output_table)
  - id: plot_output
    type:
      - 'null'
      - File
    doc: coverage profile plots (pdf)
    outputBinding:
      glob: $(inputs.plot_file || "bptr_no_plot_requested")
  - id: pickle_output
    type:
      - 'null'
      - File
    doc: output pickle file
    outputBinding:
      glob: $(inputs.output_pickle || "bptr_no_pickle_requested")
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
stdout: bPTR.out
