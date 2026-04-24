cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem microbial_fraction
label: singlem_microbial_fraction
doc: "Estimate the fraction of reads from a metagenome that are assigned to Bacteria
  and Archaea compared to e.g. eukaryote or phage. Also estimate average genome size.
  [deprecated; use prokaryotic_fraction]\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: accept_missing_samples
    type:
      - 'null'
      - boolean
    doc: If a sample is missing from the input-metagenome-sizes file, skip 
      analysis of it without croaking.
    inputBinding:
      position: 101
      prefix: --accept-missing-samples
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: input_metagenome_sizes
    type:
      - 'null'
      - File
    doc: TSV file with 'sample' and 'num_bases' as a header, where sample 
      matches the input profile name, and num_reads is the total number 
      (forward+reverse) of bases in the metagenome that was analysed with 
      'pipe'. These must be the same reads that were used to generate the input 
      profile.
    inputBinding:
      position: 101
      prefix: --input-metagenome-sizes
  - id: input_profile
    type: File
    doc: Input taxonomic profile file [required]
    inputBinding:
      position: 101
      prefix: --input-profile
  - id: metapackage
    type:
      - 'null'
      - string
    doc: 'Metapackage containing genome lengths [default: Use genome lengths from
      the default metapackage]'
    inputBinding:
      position: 101
      prefix: --metapackage
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sequence_file_forward
    type:
      - 'null'
      - type: array
        items: File
    doc: nucleotide read sequence(s) (forward or unpaired) to be searched. Can 
      be FASTA or FASTQ format, GZIP-compressed or not. These must be the same 
      ones that were used to generate the input profile.
    inputBinding:
      position: 101
      prefix: --forward
  - id: sequence_file_reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: reverse reads to be searched. Can be FASTA or FASTQ format, 
      GZIP-compressed or not. These must be the same reads that were used to 
      generate the input profile.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: taxon_genome_lengths_file
    type:
      - 'null'
      - File
    doc: "TSV file with 'rank' and 'genome_size' as headers [default: Use genome lengths
      from the default metapackage]"
    inputBinding:
      position: 101
      prefix: --taxon-genome-lengths-file
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: 'Output file [default: stdout]'
    outputBinding:
      glob: $(inputs.output_tsv)
  - id: output_per_taxon_read_fractions
    type:
      - 'null'
      - File
    doc: 'Output a fraction for each taxon to this TSV [default: Do not output anything]'
    outputBinding:
      glob: $(inputs.output_per_taxon_read_fractions)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
