cwlVersion: v1.2
class: CommandLineTool
baseCommand: TranscriptClean.py
label: transcriptclean
doc: "TranscriptClean is a Python program that corrects SMRT-seq reads for mismatches,
  microindels, and non-canonical splice junctions.\n\nTool homepage: https://github.com/mortazavilab/TranscriptClean"
inputs:
  - id: canon_only
    type:
      - 'null'
      - boolean
    doc: If this option is set, TranscriptClean will only output transcripts 
      that are canonical or match the provided splice annotation.
    inputBinding:
      position: 101
      prefix: --canonOnly
  - id: genome
    type: File
    doc: Reference genome fasta file.
    inputBinding:
      position: 101
      prefix: --genome
  - id: max_len_indel
    type:
      - 'null'
      - int
    doc: 'Maximum size indel to correct (Default: 5 bp).'
    default: 5
    inputBinding:
      position: 101
      prefix: --maxLenIndel
  - id: max_num_mismatches
    type:
      - 'null'
      - int
    doc: 'Maximum number of mismatches to correct (Default: 2).'
    default: 2
    inputBinding:
      position: 101
      prefix: --maxNumMismatches
  - id: mismatch_annot
    type:
      - 'null'
      - File
    doc: 'Optional: Mismatch annotation file (produced by TranscriptClean helper script).'
    inputBinding:
      position: 101
      prefix: --mismatchAnnot
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: If this option is set, TranscriptClean will only output primary 
      alignments.
    inputBinding:
      position: 101
      prefix: --primaryOnly
  - id: sam
    type: File
    doc: Input SAM file containing transcripts to clean.
    inputBinding:
      position: 101
      prefix: --sam
  - id: spliceannot
    type:
      - 'null'
      - File
    doc: 'Optional: GTF file containing known splice junctions.'
    inputBinding:
      position: 101
      prefix: --spliceannot
  - id: ss
    type:
      - 'null'
      - File
    doc: 'Optional: Splicing annotation file (produced by TranscriptClean helper script).'
    inputBinding:
      position: 101
      prefix: --ss
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: variant_file
    type:
      - 'null'
      - File
    doc: VCF file containing known variants.
    inputBinding:
      position: 101
      prefix: --variantFile
outputs:
  - id: outprefix
    type: File
    doc: Prefix for output files.
    outputBinding:
      glob: $(inputs.outprefix)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transcriptclean:v2.0.2_cv1
