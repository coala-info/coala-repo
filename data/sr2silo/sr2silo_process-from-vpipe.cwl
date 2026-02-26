cwlVersion: v1.2
class: CommandLineTool
baseCommand: sr2silo process-from-vpipe
label: sr2silo_process-from-vpipe
doc: "V-PIPE to SILO conversion with amino acids and special metadata. Processing
  only - use 'submit-to-loculus' command to upload and submit to SILO.\n\nTool homepage:
  https://github.com/cbg-ethz/sr2silo"
inputs:
  - id: aa_ref
    type:
      - 'null'
      - File
    doc: Path to amino acid reference FASTA file. If not provided, fetched from 
      LAPIS or loaded from cache.
    inputBinding:
      position: 101
      prefix: --aa-ref
  - id: input_file
    type: File
    doc: Path to the input file.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: lapis_url
    type:
      - 'null'
      - string
    doc: URL of LAPIS instance, hosting SILO database. Used to fetch the 
      nucleotide / amino acid reference. References are cached to 
      ~/.cache/sr2silo/ref…
    inputBinding:
      position: 101
      prefix: --lapis-url
  - id: no_skip_merge
    type:
      - 'null'
      - boolean
    doc: Skip merging of paired-end reads.
    default: true
    inputBinding:
      position: 101
      prefix: --no-skip-merge
  - id: nuc_ref
    type:
      - 'null'
      - File
    doc: Path to nucleotide reference FASTA file. If not provided, fetched from 
      LAPIS or loaded from cache.
    inputBinding:
      position: 101
      prefix: --nuc-ref
  - id: organism
    type:
      - 'null'
      - string
    doc: Organism identifier (e.g., 'covid', 'rsva'). Used to locate local 
      reference files at resources/references… Falls back to LAPIS URL if 
      provided. Can also be set via ORGANISM environment variable.
    inputBinding:
      position: 101
      prefix: --organism
  - id: reference_accession
    type:
      - 'null'
      - string
    doc: 'Filter reads to only include those aligned to this reference accession.
      Should match @SQ SN field in BAM header (find with: samtools view -H file.bam
      | grep @SQ). If not specified, all reads are processed.'
    inputBinding:
      position: 101
      prefix: --reference-accession
  - id: sample_id
    type: string
    doc: Sample ID to use for metadata.
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: skip_merge
    type:
      - 'null'
      - boolean
    doc: Skip merging of paired-end reads.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-merge
  - id: timeline_file
    type: File
    doc: Path to the timeline file.
    inputBinding:
      position: 101
      prefix: --timeline-file
outputs:
  - id: output_fp
    type: File
    doc: Path to the output file. Must end with .ndjson.
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sr2silo:1.8.0--pyhdfd78af_0
