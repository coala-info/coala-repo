cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - count
label: yasma_count
doc: "Gets counts for all readgroups, loci, strand, and sizes.\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment file input (bam or cram).
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: annotation_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Locus annotations to count in gff, gff3,\n                             \
      \     gtf, bed, or tabular format. Tabular\n                               \
      \   requires contig:start-stop and locus_name in\n                         \
      \         the first two columns (tab-delimited, \"#\"\n                    \
      \              escape char). Defaults to find all gff files\n              \
      \                    associated with annotations."
    inputBinding:
      position: 101
      prefix: --annotation_files
  - id: conditions
    type:
      - 'null'
      - string
    doc: "Values denoting condition groups (sets of\n                            \
      \      replicate libraries) for projects with\n                            \
      \      multiple tissues/treatments/genotypes. Can\n                        \
      \          be entered here as space sparated duplexes,\n                   \
      \               with the library base_name and condition\n                 \
      \                 groups delimited by a colon. E.g.\n                      \
      \            SRR1111111:WT SRR1111112:WT SRR1111113:mut\n                  \
      \                SRR1111114:mut"
    inputBinding:
      position: 101
      prefix: --conditions
  - id: include_zeros
    type:
      - 'null'
      - string
    doc: "Include to save 0-depth rows in the deep\n                             \
      \     counts. By default, these are excluded to\n                          \
      \        save space (except for one entry to make\n                        \
      \          sure downstream analyses will include un-\n                     \
      \             found entries)"
    inputBinding:
      position: 101
      prefix: --include_zeros
  - id: output_directory
    type: Directory
    doc: "Directory name for annotation output.\n                                \
      \  Defaults to the current directory, with this\n                          \
      \        directory name as the project name."
    inputBinding:
      position: 101
      prefix: --output_directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_count.out
