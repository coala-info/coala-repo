cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - annotate
  - seqvars
label: mehari_annotate_seqvars
doc: "Annotate sequence variant VCF files\n\nTool homepage: https://github.com/varfish-org/mehari"
inputs:
  - id: path_input_vcf
    type: File
    doc: "Path to the input VCF file"
    inputBinding:
      position: 1
      prefix: --path-input-vcf
  - id: path_output_vcf
    type:
      - 'null'
      - string
    doc: "Path to the output VCF file (give this or path_output_tsv)"
    inputBinding:
      position: 2
      prefix: --path-output-vcf
  - id: path_output_tsv
    type:
      - 'null'
      - string
    doc: "Path to the output TSV file (for import into VarFish) (give this or path_output_vcf)"
    inputBinding:
      position: 3
      prefix: --path-output-tsv
  - id: transcripts
    type:
      - 'null'
      - File
    doc: "Transcript database containing the transcript information"
    inputBinding:
      position: 4
      prefix: --transcripts
  - id: frequencies
    type:
      - 'null'
      - Directory
    doc: "Frequency database"
    inputBinding:
      position: 5
      prefix: --frequencies
  - id: clinvar
    type:
      - 'null'
      - Directory
    doc: "ClinVar database"
    inputBinding:
      position: 6
      prefix: --clinvar
  - id: genome_release
    type:
      - 'null'
      - string
    doc: "Genome release to use, default is to auto-detect (grch37, grch38)"
    inputBinding:
      position: 7
      prefix: --genome-release
  - id: reference
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file (with accompanying index)"
    inputBinding:
      position: 8
      prefix: --reference
  - id: in_memory_reference
    type:
      - 'null'
      - boolean
    doc: "Read the reference genome into memory"
    inputBinding:
      position: 9
      prefix: --in-memory-reference
  - id: path_input_ped
    type:
      - 'null'
      - File
    doc: "Path to the input PED file"
    inputBinding:
      position: 10
      prefix: --path-input-ped
  - id: max_var_count
    type:
      - 'null'
      - int
    doc: "For debug purposes, maximal number of variants to annotate"
    inputBinding:
      position: 11
      prefix: --max-var-count
  - id: hgnc
    type:
      - 'null'
      - File
    doc: "Path to HGNC TSV file"
    inputBinding:
      position: 12
      prefix: --hgnc
  - id: transcript_source
    type:
      - 'null'
      - string
    doc: "The transcript source (ensembl, ref-seq, both; default: both)"
    inputBinding:
      position: 13
      prefix: --transcript-source
  - id: report_most_severe_consequence_by
    type:
      - 'null'
      - string
    doc: "Whether to report only the most severe consequence, grouped by gene, transcript, or allele"
    inputBinding:
      position: 14
      prefix: --report-most-severe-consequence-by
  - id: pick_transcript
    type:
      - 'null'
      - string
    doc: "Which kind of transcript to pick / restrict to (mane-select, mane-select-backport, mane-plus-clinical, mane-plus-clinical-backport, length, ensembl-canonical, ensembl-canonical-backport, ref-seq-select, ref-seq-select-backport, gencode-primary, gencode-primary-backport, basic, basic-backport). Default is not to pick at all"
    inputBinding:
      position: 15
      prefix: --pick-transcript
  - id: pick_transcript_mode
    type:
      - 'null'
      - string
    doc: "How to handle multiple transcripts: first or all (default: all)"
    inputBinding:
      position: 16
      prefix: --pick-transcript-mode
  - id: keep_intergenic
    type:
      - 'null'
      - boolean
    doc: "Whether to keep intergenic variants"
    inputBinding:
      position: 17
      prefix: --keep-intergenic
  - id: discard_utr_splice_variants
    type:
      - 'null'
      - boolean
    doc: "Whether to report splice variants in UTRs"
    inputBinding:
      position: 18
      prefix: --discard-utr-splice-variants
  - id: tsv_contig_style
    type:
      - 'null'
      - string
    doc: "Style for contig names in TSV output: passthrough, with-chr, without-chr, auto (default: auto)"
    inputBinding:
      position: 19
      prefix: --tsv-contig-style
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase logging verbosity"
    inputBinding:
      position: 20
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease logging verbosity"
    inputBinding:
      position: 21
      prefix: --quiet
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: "Annotated VCF file"
    outputBinding:
      glob: $(inputs.path_output_vcf)
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: "Annotated TSV file"
    outputBinding:
      glob: $(inputs.path_output_tsv)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_annotate_seqvars.out
