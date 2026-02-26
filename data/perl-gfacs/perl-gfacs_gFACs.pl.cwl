cwlVersion: v1.2
class: CommandLineTool
baseCommand: gFACs.pl
label: perl-gfacs_gFACs.pl
doc: "gFACs, the one stop destination to understand what your annotation or alignment
  is secretly telling you. The script gFACs.pl is a task-assigning script that calls
  upon many different scripts to analyze your .gff3, .gff, or .gtf files by creating
  a median format called gene_table.txt. From here, statisitcs can be calculated and
  distribution tables created. Mutliple filter paramteters can be used to create an
  annotation or alignment you can be proud of.\n\nTool homepage: https://gitlab.com/PlantGenomicsLab/gFACs"
inputs:
  - id: input_file
    type: File
    doc: .gff3, .gtf, or .gff as the LAST argument.
    inputBinding:
      position: 1
  - id: allow_alternate_starts
    type:
      - 'null'
      - boolean
    doc: Allow alternate start codons (requires FASTA)
    inputBinding:
      position: 102
      prefix: --allow-alternate-starts
  - id: allowed_inframe_stop_codons
    type:
      - 'null'
      - int
    doc: Number of allowed in-frame stop codons (requires FASTA)
    inputBinding:
      position: 102
      prefix: --allowed-inframe-stop-codons
  - id: annotated_all_genes_only
    type:
      - 'null'
      - boolean
    doc: Keep only all annotated genes (requires entap annotation)
    inputBinding:
      position: 102
      prefix: --annotated-all-genes-only
  - id: annotated_ss_genes_only
    type:
      - 'null'
      - boolean
    doc: Keep only genes with annotated splice sites (requires entap annotation)
    inputBinding:
      position: 102
      prefix: --annotated-ss-genes-only
  - id: canonical_only
    type:
      - 'null'
      - boolean
    doc: Keep only canonical splice sites (requires FASTA)
    inputBinding:
      position: 102
      prefix: --canonical-only
  - id: compatibility
    type:
      - 'null'
      - type: array
        items: string
    doc: Output compatibility options (requires FASTA)
    inputBinding:
      position: 102
      prefix: --compatibility
  - id: create_gff3
    type:
      - 'null'
      - boolean
    doc: Create GFF3 output (requires FASTA)
    inputBinding:
      position: 102
      prefix: --create-gff3
  - id: create_gtf
    type:
      - 'null'
      - boolean
    doc: Create GTF output (requires FASTA)
    inputBinding:
      position: 102
      prefix: --create-gtf
  - id: create_simple_gtf
    type:
      - 'null'
      - boolean
    doc: Create simple GTF output (requires FASTA)
    inputBinding:
      position: 102
      prefix: --create-simple-gtf
  - id: distributions
    type:
      - 'null'
      - type: array
        items: string
    doc: Create distribution tables
    inputBinding:
      position: 102
      prefix: --distributions
  - id: entap_annotation
    type:
      - 'null'
      - File
    doc: Path to entap annotation TSV file
    inputBinding:
      position: 102
      prefix: --entap-annotation
  - id: false_run
    type:
      - 'null'
      - boolean
    doc: Perform a false run
    inputBinding:
      position: 102
      prefix: --false-run
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to nucleotide FASTA file
    inputBinding:
      position: 102
      prefix: --fasta
  - id: format
    type: string
    doc: 'Specifying a format: A mandatory step to call upon the right script.'
    inputBinding:
      position: 102
      prefix: -f
  - id: get_fasta
    type:
      - 'null'
      - boolean
    doc: Extract FASTA sequences (requires FASTA)
    inputBinding:
      position: 102
      prefix: --get-fasta
  - id: get_protein_fasta
    type:
      - 'null'
      - boolean
    doc: Extract protein FASTA sequences (requires FASTA)
    inputBinding:
      position: 102
      prefix: --get-protein-fasta
  - id: min_CDS_size
    type:
      - 'null'
      - int
    doc: Minimum CDS size in nucleotides
    inputBinding:
      position: 102
      prefix: --min-CDS-size
  - id: min_exon_size
    type:
      - 'null'
      - int
    doc: Minimum exon size in nucleotides
    inputBinding:
      position: 102
      prefix: --min-exon-size
  - id: min_intron_size
    type:
      - 'null'
      - int
    doc: Minimum intron size in nucleotides
    inputBinding:
      position: 102
      prefix: --min-intron-size
  - id: no_gene_redefining
    type:
      - 'null'
      - boolean
    doc: Disable gene redefining
    inputBinding:
      position: 102
      prefix: --no-gene-redefining
  - id: no_processing
    type:
      - 'null'
      - boolean
    doc: Disable processing
    inputBinding:
      position: 102
      prefix: --no-processing
  - id: nt_content
    type:
      - 'null'
      - boolean
    doc: Calculate nucleotide content (requires FASTA)
    inputBinding:
      position: 102
      prefix: --nt-content
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: -O
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 102
      prefix: -p
  - id: rem_3prime_incompletes
    type:
      - 'null'
      - boolean
    doc: Remove 3' incomplete features
    inputBinding:
      position: 102
      prefix: --rem-3prime-incompletes
  - id: rem_5prime_3prime_incompletes
    type:
      - 'null'
      - boolean
    doc: Remove both 5' and 3' incomplete features
    inputBinding:
      position: 102
      prefix: --rem-5prime-3prime-incompletes
  - id: rem_5prime_incompletes
    type:
      - 'null'
      - boolean
    doc: Remove 5' incomplete features
    inputBinding:
      position: 102
      prefix: --rem-5prime-incompletes
  - id: rem_all_incompletes
    type:
      - 'null'
      - boolean
    doc: Remove all incomplete features
    inputBinding:
      position: 102
      prefix: --rem-all-incompletes
  - id: rem_genes_without_start_and_stop_codon
    type:
      - 'null'
      - boolean
    doc: Remove genes without start and stop codons (requires FASTA)
    inputBinding:
      position: 102
      prefix: --rem-genes-without-start-and-stop-codon
  - id: rem_genes_without_start_codon
    type:
      - 'null'
      - boolean
    doc: Remove genes without a start codon (requires FASTA)
    inputBinding:
      position: 102
      prefix: --rem-genes-without-start-codon
  - id: rem_genes_without_stop_codon
    type:
      - 'null'
      - boolean
    doc: Remove genes without a stop codon (requires FASTA)
    inputBinding:
      position: 102
      prefix: --rem-genes-without-stop-codon
  - id: rem_monoexonics
    type:
      - 'null'
      - boolean
    doc: Remove monoexonic features
    inputBinding:
      position: 102
      prefix: --rem-monoexonics
  - id: rem_multiexonics
    type:
      - 'null'
      - boolean
    doc: Remove multiexonic features
    inputBinding:
      position: 102
      prefix: --rem-multiexonics
  - id: sort_by_chromosome
    type:
      - 'null'
      - boolean
    doc: Sort output by chromosome
    inputBinding:
      position: 102
      prefix: --sort-by-chromosome
  - id: splice_table
    type:
      - 'null'
      - boolean
    doc: Create a splice table (requires FASTA)
    inputBinding:
      position: 102
      prefix: --splice-table
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: Calculate statistics
    inputBinding:
      position: 102
      prefix: --statistics
  - id: statistics_at_every_step
    type:
      - 'null'
      - boolean
    doc: Calculate statistics at every step
    inputBinding:
      position: 102
      prefix: --statistics-at-every-step
  - id: unique_genes_only
    type:
      - 'null'
      - boolean
    doc: Keep only unique genes
    inputBinding:
      position: 102
      prefix: --unique-genes-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gfacs:1.1.1--hdfd78af_1
stdout: perl-gfacs_gFACs.pl.out
