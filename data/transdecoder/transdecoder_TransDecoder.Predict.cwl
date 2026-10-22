cwlVersion: v1.2
class: CommandLineTool
baseCommand: TransDecoder.Predict
label: transdecoder_TransDecoder.Predict
doc: "TransDecoder.Predict predicts the likely coding regions among the long ORFs found by TransDecoder.LongOrfs, using a Markov model trained on the longest ORFs and optional Pfam or blastp evidence.\n\nTool homepage: https://transdecoder.github.io"
inputs:
  - id: transcripts
    type: File
    doc: transcripts.fasta (the same file given to TransDecoder.LongOrfs)
    inputBinding:
      position: 1
      prefix: -t
  - id: longorfs_dir
    type: Directory
    doc: Output directory of TransDecoder.LongOrfs. It is staged in the working directory under the name given in output_dir.
  - id: output_dir
    type: string
    doc: Name of the TransDecoder.LongOrfs output directory (same output directory from the TransDecoder.LongOrfs)
    inputBinding:
      position: 2
      prefix: --output_dir
  - id: retain_long_orfs_mode
    type:
      - 'null'
      - string
    doc: "dynamic or strict (default: dynamic). In dynamic mode, sets range according to 1%FDR in random sequence of same GC content."
    inputBinding:
      position: 3
      prefix: --retain_long_orfs_mode
  - id: retain_long_orfs_length
    type:
      - 'null'
      - int
    doc: "under strict mode, retain all ORFs found that are equal or longer than these many nucleotides even if no other evidence marks it as coding (default: 1000000)"
    inputBinding:
      position: 3
      prefix: --retain_long_orfs_length
  - id: retain_pfam_hits
    type:
      - 'null'
      - File
    doc: domain table output file from running hmmscan to search Pfam. Any ORF with a pfam domain hit will be retained in the final output.
    inputBinding:
      position: 3
      prefix: --retain_pfam_hits
  - id: retain_blastp_hits
    type:
      - 'null'
      - File
    doc: "blastp output in -outfmt 6 format. Any ORF with a blast match will be retained in the final output."
    inputBinding:
      position: 3
      prefix: --retain_blastp_hits
  - id: single_best_only
    type:
      - 'null'
      - boolean
    doc: Retain only the single best orf per transcript (prioritized by homology then orf length)
    inputBinding:
      position: 3
      prefix: --single_best_only
  - id: no_refine_starts
    type:
      - 'null'
      - boolean
    doc: start refinement identifies potential start codons for 5' partial ORFs using a PWM, process on by default.
    inputBinding:
      position: 3
      prefix: --no_refine_starts
  - id: top_longest_orfs
    type:
      - 'null'
      - int
    doc: "Top longest ORFs to train Markov Model (hexamer stats) (default: 500)"
    inputBinding:
      position: 3
      prefix: -T
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: "genetic code (default: universal; options: Euplotes, Tetrahymena, Candida, Acetabularia, ...)"
    inputBinding:
      position: 3
      prefix: --genetic_code
outputs:
  - id: predicted_pep
    type: File
    doc: Predicted protein sequences
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.transcripts.basename).transdecoder.pep
  - id: predicted_cds
    type: File
    doc: Predicted coding sequences
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.transcripts.basename).transdecoder.cds
  - id: predicted_gff3
    type: File
    doc: Predicted ORFs in GFF3 format
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.transcripts.basename).transdecoder.gff3
  - id: predicted_bed
    type: File
    doc: Predicted ORFs in BED format
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.transcripts.basename).transdecoder.bed
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.longorfs_dir)
        entryname: $(inputs.output_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
