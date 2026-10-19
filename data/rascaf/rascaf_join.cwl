cwlVersion: v1.2
class: CommandLineTool
baseCommand: rascaf-join
label: rascaf_join
doc: "rascaf-join builds scaffolds from the contig connections found by rascaf and,
  if applicable, combines connections from different data sets.\n\nTool homepage:
  https://github.com/mourisl/Rascaf"
inputs:
  - id: rascaf_output
    type:
      type: array
      items: File
      inputBinding:
        prefix: -r
    doc: the path to the rascaf output. Can use multiple of -r.
    inputBinding:
      position: 101
  - id: assembly_fasta
    type: File
    doc: The assembly FASTA that rascaf was run on. rascaf-join reads the paths of the rascaf input files from the connection file, so the files must be present under the same names.
  - id: alignment_bams
    type:
      type: array
      items: File
    doc: The BAM files that rascaf was run on (one per connection file), same names as in the rascaf runs.
  - id: ignore_gap
    type:
      - 'null'
      - boolean
    doc: ignore the gap size, which do not consider the number of Ns between 
      contigs
    inputBinding:
      position: 101
      prefix: -ignoreGap
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum support alignments for the connection
    inputBinding:
      position: 101
      prefix: -ms
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: the prefix of the output file
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix (scaffold FASTA and
      info file)
    outputBinding:
      glob: $((inputs.output_prefix || 'rascaf_scaffold') + '*')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.assembly_fasta)
      - $(inputs.alignment_bams)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rascaf:20180710--h5ca1c30_1
    dockerOutputDirectory: /rascaf_work
stdout: rascaf_join_stdout.txt
