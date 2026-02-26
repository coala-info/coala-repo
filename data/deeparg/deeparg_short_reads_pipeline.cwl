cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeparg short_reads_pipeline
label: deeparg_short_reads_pipeline
doc: "Pipeline for short reads to predict ARGs and 16S rRNA genes.\n\nTool homepage:
  https://bitbucket.org/gusphdproj/deeparg-ss/"
inputs:
  - id: bowtie_16s_identity
    type:
      - 'null'
      - float
    doc: minimum identity a read as a 16s rRNA gene
    default: 0.8
    inputBinding:
      position: 101
      prefix: --bowtie_16s_identity
  - id: deeparg_data_path
    type:
      - 'null'
      - Directory
    doc: Path where data was downloaded [see deeparg download- data --help for 
      details]
    inputBinding:
      position: 101
      prefix: --deeparg_data_path
  - id: deeparg_evalue
    type:
      - 'null'
      - string
    doc: minimum e-value for ARG alignments
    default: '1e-10'
    inputBinding:
      position: 101
      prefix: --deeparg_evalue
  - id: deeparg_identity
    type:
      - 'null'
      - int
    doc: minimum identity for ARG alignments
    default: 80
    inputBinding:
      position: 101
      prefix: --deeparg_identity
  - id: deeparg_probability
    type:
      - 'null'
      - float
    doc: minimum probability for considering a reads as ARG-like
    default: 0.8
    inputBinding:
      position: 101
      prefix: --deeparg_probability
  - id: forward_pe_file
    type: File
    doc: forward mate from paired end library
    inputBinding:
      position: 101
      prefix: --forward_pe_file
  - id: gene_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage required for considering a full gene in percentage. 
      This parameter looks at the full gene and all hits that align to the gene.
      If the overlap of all hits is below the threshold the gene is discarded. 
      Use with caution
    default: 1
    inputBinding:
      position: 101
      prefix: --gene_coverage
  - id: reverse_pe_file
    type: File
    doc: reverse mate from paired end library
    inputBinding:
      position: 101
      prefix: --reverse_pe_file
outputs:
  - id: output_file
    type: File
    doc: save results to this file prefix
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
