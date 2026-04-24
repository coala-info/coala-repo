cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeparg predict
label: deeparg_predict
doc: "Predicts antimicrobial resistance genes from sequence data.\n\nTool homepage:
  https://bitbucket.org/gusphdproj/deeparg-ss/"
inputs:
  - id: arg_alignment_evalue
    type:
      - 'null'
      - float
    doc: Evalue cutoff
    inputBinding:
      position: 101
      prefix: --arg-alignment-evalue
  - id: arg_alignment_identity
    type:
      - 'null'
      - float
    doc: Identity cutoff for sequence alignment in percent
    inputBinding:
      position: 101
      prefix: --arg-alignment-identity
  - id: arg_alignment_overlap
    type:
      - 'null'
      - float
    doc: Alignment overlap cutoff between read and genes
    inputBinding:
      position: 101
      prefix: --arg-alignment-overlap
  - id: arg_num_alignments_per_entry
    type:
      - 'null'
      - int
    doc: Diamond, minimum number of alignments per entry
    inputBinding:
      position: 101
      prefix: --arg-num-alignments-per-entry
  - id: data_path
    type:
      - 'null'
      - Directory
    doc: Path where data was downloaded [see deeparg download-data --help for 
      details]
    inputBinding:
      position: 101
      prefix: --data-path
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file (Fasta input file)
    inputBinding:
      position: 101
      prefix: --input-file
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum probability cutoff
    inputBinding:
      position: 101
      prefix: --min-prob
  - id: model
    type: string
    doc: Select model to use (short sequences for reads | long sequences for 
      genes) SS|LS
    inputBinding:
      position: 101
      prefix: --model
  - id: model_version
    type:
      - 'null'
      - string
    doc: Model deepARG version
    inputBinding:
      position: 101
      prefix: --model-version
  - id: type
    type:
      - 'null'
      - string
    doc: Molecular data type prot/nucl
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output_file
    type: File
    doc: Output file where to store results
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
