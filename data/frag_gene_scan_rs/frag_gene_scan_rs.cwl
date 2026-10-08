cwlVersion: v1.2
class: CommandLineTool
baseCommand: FragGeneScanRs
label: frag_gene_scan_rs
doc: "FragGeneScanRs is a faster implementation of FragGeneScan for predicting genes\
  \ in short and error-prone DNA reads.\n\nTool homepage: https://github.com/unipept/FragGeneScanRs"
inputs:
  - id: train_file_name
    type: string
    doc: 'File name that contains model parameters; this file should be in the -r
      directory or one of: complete, sanger_5, sanger_10, 454_5, 454_10, 454_30, illumina_1,
      illumina_5, illumina_10'
    inputBinding:
      position: 101
      prefix: --training-file
  - id: seq_file_name
    type:
      - 'null'
      - File
    doc: Sequence file name including the full path. Without it the tool reads standard
      input.
    inputBinding:
      position: 101
      prefix: --seq-file-name
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output metadata (.out and .gff), proteins (.faa) and genes (.ffn) to files
      with this prefix.
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: aa_file
    type:
      - 'null'
      - string
    doc: Output predicted proteins to this file (supersedes -o).
    inputBinding:
      position: 101
      prefix: --aa-file
  - id: nucleotide_file
    type:
      - 'null'
      - string
    doc: Output predicted genes to this file (supersedes -o).
    inputBinding:
      position: 101
      prefix: --nucleotide-file
  - id: meta_file
    type:
      - 'null'
      - string
    doc: Output metadata to this file (supersedes -o).
    inputBinding:
      position: 101
      prefix: --meta-file
  - id: gff_file
    type:
      - 'null'
      - string
    doc: Output metadata to this gff formatted file (supersedes -o).
    inputBinding:
      position: 101
      prefix: --gff-file
  - id: complete
    type:
      - 'null'
      - int
    doc: The input sequence has complete genomic sequences; not short sequence reads
      (1 or 0). [default 0]
    inputBinding:
      position: 101
      prefix: --complete
  - id: formatted
    type:
      - 'null'
      - boolean
    doc: Format the DNA output.
    inputBinding:
      position: 101
      prefix: --formatted
  - id: unordered
    type:
      - 'null'
      - boolean
    doc: Do not preserve record order in output (faster).
    inputBinding:
      position: 101
      prefix: --unordered
  - id: thread_num
    type:
      - 'null'
      - int
    doc: The number of threads used by FragGeneScan++. [default 1]
    inputBinding:
      position: 101
      prefix: --thread-num
  - id: train_file_dir
    type:
      - 'null'
      - Directory
    doc: Full path of the directory containing the training model files.
    inputBinding:
      position: 101
      prefix: --train-file-dir
outputs:
  - id: gff_out
    type:
      - 'null'
      - File
    doc: Predicted genes in GFF format (<output_prefix>.gff, or the --gff-file name)
    outputBinding:
      glob: ${ if (inputs.gff_file) { return inputs.gff_file; } return inputs.output_prefix
        + '.gff'; }
  - id: faa_out
    type:
      - 'null'
      - File
    doc: Predicted proteins (<output_prefix>.faa, or the --aa-file name)
    outputBinding:
      glob: ${ if (inputs.aa_file) { return inputs.aa_file; } return inputs.output_prefix
        + '.faa'; }
  - id: ffn_out
    type:
      - 'null'
      - File
    doc: Predicted gene sequences (<output_prefix>.ffn, or the --nucleotide-file name)
    outputBinding:
      glob: ${ if (inputs.nucleotide_file) { return inputs.nucleotide_file; } return
        inputs.output_prefix + '.ffn'; }
  - id: out_file
    type:
      - 'null'
      - File
    doc: Predicted gene metadata (<output_prefix>.out, or the --meta-file name)
    outputBinding:
      glob: ${ if (inputs.meta_file) { return inputs.meta_file; } return inputs.output_prefix
        + '.out'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frag_gene_scan_rs:1.1.0--h4349ce8_0
