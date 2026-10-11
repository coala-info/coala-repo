cwlVersion: v1.2
class: CommandLineTool
baseCommand: oases
label: oases
doc: "De novo transcriptome assembler for the Velvet package\n\nTool homepage: https://github.com/dzerbino/oases"
inputs:
  - id: directory
    type: Directory
    doc: working directory name (a Velvet output directory made with velveth and 
      velvetg -read_trkg yes; Oases writes its results into it)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: alignments
    type:
      - 'null'
      - string
    doc: export a summary of contig alignment to the reference sequences
    inputBinding:
      position: 102
      prefix: -alignments
  - id: amos_file
    type:
      - 'null'
      - string
    doc: export assembly to AMOS file
    inputBinding:
      position: 102
      prefix: -amos_file
  - id: cov_cutoff
    type:
      - 'null'
      - float
    doc: removal of low coverage nodes AFTER tour bus or allow the system to 
      infer it
    inputBinding:
      position: 102
      prefix: -cov_cutoff
  - id: degree_cutoff
    type:
      - 'null'
      - int
    doc: Maximum allowed degree on either end of a contigg to consider it 
      'unique'
    inputBinding:
      position: 102
      prefix: -degree_cutoff
  - id: edge_fraction_cutoff
    type:
      - 'null'
      - float
    doc: Remove edges which represent less than that fraction of a nodes 
      outgoing flow
    inputBinding:
      position: 102
      prefix: -edgeFractionCutoff
  - id: ins_length
    type:
      - 'null'
      - int
    doc: expected distance between two paired-end reads in the first short-read 
      dataset
    inputBinding:
      position: 102
      prefix: -ins_length
  - id: ins_length_sd
    type:
      - 'null'
      - int
    doc: est. standard deviation of the first short-read dataset
    inputBinding:
      position: 102
      prefix: -ins_length_sd
  - id: ins_length2
    type:
      - 'null'
      - int
    doc: expected distance between two paired-end reads in the second short-read
      dataset
    inputBinding:
      position: 102
      prefix: -ins_length2
  - id: ins_length2_sd
    type:
      - 'null'
      - int
    doc: est. standard deviation of respective dataset
    inputBinding:
      position: 102
      prefix: -ins_length2_sd
  - id: ins_length_long
    type:
      - 'null'
      - int
    doc: expected distance between two long paired-end reads
    inputBinding:
      position: 102
      prefix: -ins_length_long
  - id: ins_length_long_sd
    type:
      - 'null'
      - int
    doc: est. standard deviation of respective dataset
    inputBinding:
      position: 102
      prefix: -ins_length_long_sd
  - id: merge
    type:
      - 'null'
      - string
    doc: Preserve contigs mapping onto long sequences to be preserved from 
      coverage cutoff
    inputBinding:
      position: 102
      prefix: -merge
  - id: min_pair_count
    type:
      - 'null'
      - int
    doc: minimum number of paired end connections to justify the scaffolding of 
      two long contigs
    inputBinding:
      position: 102
      prefix: -min_pair_count
  - id: min_trans_lgth
    type:
      - 'null'
      - int
    doc: Minimum length of output transcripts
    inputBinding:
      position: 102
      prefix: -min_trans_lgth
  - id: paired_cutoff
    type:
      - 'null'
      - float
    doc: minimum ratio allowed between the numbers of observed and estimated 
      connecting read pairs
    inputBinding:
      position: 102
      prefix: -paired_cutoff
  - id: scaffolding
    type:
      - 'null'
      - string
    doc: Allow gaps in transcripts
    inputBinding:
      position: 102
      prefix: -scaffolding
  - id: unused_reads
    type:
      - 'null'
      - string
    doc: export unused reads in UnusedReads.fa file
    inputBinding:
      position: 102
      prefix: -unused_reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: transcripts
    type:
      - 'null'
      - File
    doc: Assembled transcripts (directory/transcripts.fa)
    outputBinding:
      glob: $(inputs.directory.basename)/transcripts.fa
  - id: contig_ordering
    type:
      - 'null'
      - File
    doc: Contig ordering of the transcripts (directory/contig-ordering.txt)
    outputBinding:
      glob: $(inputs.directory.basename)/contig-ordering.txt
  - id: output_directory
    type: Directory
    doc: The working directory with all Oases output files
    outputBinding:
      glob: $(inputs.directory.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oases:0.2.09--h7b50bb2_2
stdout: oases.out
