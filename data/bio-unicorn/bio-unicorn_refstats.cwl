cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - refstats
label: bio-unicorn_refstats
doc: "Compute per reference statistics such as # alignments, # reads, mean read length,
  etc.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: input_bam
    type: File
    doc: input bam|sam|cram
    inputBinding:
      position: 1
      prefix: -b
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix; writes <prefix>.stats.txt and <prefix>.bam with the 
      references that pass the filters (statistics go to stdout when not set)
    inputBinding:
      position: 1
      prefix: -o
  - id: minrefl
    type:
      - 'null'
      - int
    doc: Minimum reference length to consider [0]
    inputBinding:
      position: 1
      prefix: --minrefl
  - id: minreads
    type:
      - 'null'
      - int
    doc: Minimum number of reads to consider [1]
    inputBinding:
      position: 1
      prefix: --minreads
outputs:
  - id: stats_stdout
    type: stdout
    doc: Per-reference statistics table (when no output prefix is given)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Per-reference statistics table <prefix>.stats.txt
    outputBinding:
      glob: "${ return inputs.output_prefix ? inputs.output_prefix + '.stats.txt' : []; }"
  - id: filtered_bam
    type:
      - 'null'
      - File
    doc: Alignments to the references that pass the filters <prefix>.bam
    outputBinding:
      glob: "${ return inputs.output_prefix ? inputs.output_prefix + '.bam' : []; }"
stdout: bio-unicorn_refstats.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
