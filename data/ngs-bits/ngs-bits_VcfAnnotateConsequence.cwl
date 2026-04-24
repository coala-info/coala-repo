cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateConsequence
label: ngs-bits_VcfAnnotateConsequence
doc: "Adds transcript-specific consequence predictions to a VCF file.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: all_transcripts
    type:
      - 'null'
      - boolean
    doc: If set, all transcripts are used for annotation. The default is to skip
      transcripts not labeled with 'gencode_basic' and not labeled with 
      'RefSeq'/'BestRefSeq' origin for Refseq.
    inputBinding:
      position: 101
      prefix: --all
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of lines processed in one chunk.
    inputBinding:
      position: 101
      prefix: -block_size
  - id: consequence_tag
    type:
      - 'null'
      - string
    doc: Tag that is used for the consequence annotation.
    inputBinding:
      position: 101
      prefix: -tag
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: gff_file
    type: File
    doc: Ensembl-style GFF file with transcripts, e.g. from 
      https://ftp.ensembl.org/pub/release-115/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz.
    inputBinding:
      position: 101
      prefix: -gff
  - id: gff_source
    type:
      - 'null'
      - string
    doc: GFF source.
    inputBinding:
      position: 101
      prefix: -source
  - id: input_vcf
    type: File
    doc: Input VCF file to annotate.
    inputBinding:
      position: 101
      prefix: -in
  - id: max_distance_to_transcript
    type:
      - 'null'
      - int
    doc: Maximum distance between variant and transcript.
    inputBinding:
      position: 101
      prefix: -max_dist_to_trans
  - id: prefetch
    type:
      - 'null'
      - int
    doc: Maximum number of blocks that may be pre-fetched into memory.
    inputBinding:
      position: 101
      prefix: -prefetch
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file. If unset 'reference_genome' from the 
      'settings.ini' file is used.
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: skip_not_hgnc
    type:
      - 'null'
      - boolean
    doc: Skip genes that do not have a HGNC identifier.
    inputBinding:
      position: 101
      prefix: --skip_not_hgnc
  - id: splice_region_exon_boundary
    type:
      - 'null'
      - int
    doc: Number of bases at exon boundaries that are considered to be part of 
      the splice region.
    inputBinding:
      position: 101
      prefix: -splice_region_ex
  - id: splice_region_intron_3_boundary
    type:
      - 'null'
      - int
    doc: Number of bases at intron boundaries (3') that are considered to be 
      part of the splice region.
    inputBinding:
      position: 101
      prefix: -splice_region_in3
  - id: splice_region_intron_5_boundary
    type:
      - 'null'
      - int
    doc: Number of bases at intron boundaries (5') that are considered to be 
      part of the splice region.
    inputBinding:
      position: 101
      prefix: -splice_region_in5
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads used to read, process and write files.
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file annotated with predicted consequences for each variant.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
