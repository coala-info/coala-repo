cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_splicing
label: mason_mason_splicing
doc: "Create transcripts from IN.fa using the annotations from IN.gff. The resulting transcripts are written to OUT.fa.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs:
  - id: input_reference
    type: File
    doc: "Path to FASTA file to read the reference from."
    inputBinding:
      position: 101
      prefix: --input-reference
  - id: in_gff
    type: File
    doc: "Path to input GFF or GTF file, must be sorted by reference name."
    inputBinding:
      position: 101
      prefix: --in-gff
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: "Path to the VCF file with variants to apply (transcripts are built from the haplotypes of the first individual)."
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: version_check
    type:
      - 'null'
      - string
    doc: "Turn this option off to disable version update notifications of the application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO."
    inputBinding:
      position: 101
      prefix: --version-check
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Low verbosity."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Higher verbosity."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: "Highest verbosity."
    inputBinding:
      position: 101
      prefix: --very-verbose
  - id: seed
    type:
      - 'null'
      - long
    doc: "Seed for random number generation. Default: 0."
    inputBinding:
      position: 101
      prefix: --seed
  - id: haplotype_name_sep
    type:
      - 'null'
      - string
    doc: "String separating contig name from haplotype number. Default: /."
    inputBinding:
      position: 101
      prefix: --haplotype-name-sep
  - id: gff_type
    type:
      - 'null'
      - string
    doc: "Splicing will filter to the records that have this type. Default: exon."
    inputBinding:
      position: 101
      prefix: --gff-type
  - id: gff_group_by
    type:
      - 'null'
      - string
    doc: "Assign features to their parent using the tag with this name. Default: Parent."
    inputBinding:
      position: 101
      prefix: --gff-group-by
  - id: out_path
    type: string
    doc: "Output of the transcripts (FASTA)."
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type: File
    doc: Transcripts FASTA.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
