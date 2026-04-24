cwlVersion: v1.2
class: CommandLineTool
baseCommand: drprg build
label: drprg_build
doc: "Build an index to predict resistance from\n\nTool homepage: https://github.com/mbhall88/drprg"
inputs:
  - id: bcftools_executable
    type:
      - 'null'
      - File
    doc: Path to bcftools executable. Will try in src/ext or $PATH if not given
    inputBinding:
      position: 101
      prefix: --bcftools
  - id: fasta_file
    type: File
    doc: Reference genome in FASTA format (must be indexed with samtools faidx)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff_file
    type: File
    doc: Annotation file that will be used to gather information about genes in 
      catalogue
    inputBinding:
      position: 101
      prefix: --gff
  - id: mafft_executable
    type:
      - 'null'
      - File
    doc: Path to MAFFT executable. Will try in src/ext or $PATH if not given
    inputBinding:
      position: 101
      prefix: --mafft
  - id: makeprg_executable
    type:
      - 'null'
      - File
    doc: Path to make_prg executable. Will try in src/ext or $PATH if not given
    inputBinding:
      position: 101
      prefix: --makeprg
  - id: match_len
    type:
      - 'null'
      - int
    doc: Minimum number of consecutive characters which must be identical for a 
      match in make_prg
    inputBinding:
      position: 101
      prefix: --match-len
  - id: max_nesting
    type:
      - 'null'
      - int
    doc: Maximum nesting level when constructing the reference graph with 
      make_prg
    inputBinding:
      position: 101
      prefix: --max-nesting
  - id: no_fasta_index
    type:
      - 'null'
      - boolean
    doc: Don't index --fasta if an index doesn't exist
    inputBinding:
      position: 101
      prefix: --no-fai
  - id: no_vcf_index
    type:
      - 'null'
      - boolean
    doc: Don't index --vcf if an index doesn't exist
    inputBinding:
      position: 101
      prefix: --no-csi
  - id: padding
    type:
      - 'null'
      - int
    doc: Number of bases of padding to add to start and end of each gene
    inputBinding:
      position: 101
      prefix: --padding
  - id: pandora_executable
    type:
      - 'null'
      - File
    doc: Path to pandora executable. Will try in src/ext or $PATH if not given
    inputBinding:
      position: 101
      prefix: --pandora
  - id: pandora_kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size to use for pandora
    inputBinding:
      position: 101
      prefix: --pandora-k
  - id: pandora_window_size
    type:
      - 'null'
      - int
    doc: Window size to use for pandora
    inputBinding:
      position: 101
      prefix: --pandora-w
  - id: panel_file
    type: File
    doc: Panel/catalogue to build index for
    inputBinding:
      position: 101
      prefix: --panel
  - id: prebuilt_prg_directory
    type:
      - 'null'
      - Directory
    doc: "A prebuilt PRG to use.\n          \n          Only build the panel VCF and
      reference sequences - not the PRG. This directory MUST contain a PRG file named
      `dr.prg`, along, with a directory called `msas/` that contains an MSA fasta
      file for each gene `<gene>.fa`. There can optionally also be a pandora index
      file, but if not, the indexing will be performed by drprg. Note: the PRG is
      expected to contain the reference sequence for each gene according to the annotation
      and reference genome given (along with padding) and must be in the forward strand
      orientation."
    inputBinding:
      position: 101
      prefix: --prebuilt-prg
  - id: rules_file
    type:
      - 'null'
      - File
    doc: "\"Expert rules\" to be applied in addition to the catalogue.\n         \
      \ \n          CSV file with blanket rules that describe resistance (or susceptibility).
      The columns are <variant type>,<gene>,<start>,<end>,<drug(s)>. See the docs
      for a detailed explanation."
    inputBinding:
      position: 101
      prefix: --rules
  - id: threads
    type:
      - 'null'
      - int
    doc: "Maximum number of threads to use\n          \n          Use 0 to select
      the number automatically"
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: An indexed VCF to build the index PRG from. If not provided, then a 
      prebuilt PRG must be given. See `--prebuilt-prg`
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to place output
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drprg:0.1.1--h5076881_1
