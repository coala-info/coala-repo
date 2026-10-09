cwlVersion: v1.2
class: CommandLineTool
baseCommand: iRep
label: irep_iRep
doc: "Calculate the Index of Replication (iRep) of bacteria from draft-quality genomes
  and sorted SAM mapping files.\n\nTool homepage: https://github.com/christophertbrown/iRep"
inputs:
  - id: fasta
    type:
      type: array
      items: File
    doc: fasta file(s) of the genomes
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
  - id: output_prefix
    type: string
    doc: prefix for output files (table and plots)
    inputBinding:
      position: 3
      prefix: -o
  - id: save_pickle
    type:
      - 'null'
      - boolean
    doc: save pickle file
    inputBinding:
      position: 4
      prefix: --pickle
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: 'max. # of read mismatches allowed (default: 1)'
    inputBinding:
      position: 5
      prefix: -mm
  - id: sort_sam
    type:
      - 'null'
      - boolean
    doc: sort the sam file
    inputBinding:
      position: 6
      prefix: --sort
  - id: sort_memory_gb
    type:
      - 'null'
      - int
    doc: 'max. memory (GB) for sorting sam (default: 100)'
    inputBinding:
      position: 7
      prefix: -M
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: do not plot output
    inputBinding:
      position: 8
      prefix: --no-plot
  - id: no_gc_correction
    type:
      - 'null'
      - boolean
    doc: do not correct coverage for GC bias before calculating iRep
    inputBinding:
      position: 9
      prefix: --no-gc-correction
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite files
    inputBinding:
      position: 10
      prefix: -ff
  - id: threads
    type:
      - 'null'
      - int
    doc: 'threads (default: 6)'
    inputBinding:
      position: 11
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Output table (.tsv), plots (.pdf) and pickle file written with the prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
stdout: iRep.out
