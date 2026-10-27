cwlVersion: v1.2
class: CommandLineTool
baseCommand: verkko
label: verkko
doc: "Verkko is a hybrid genome assembler designed for telomere-to-telomere assembly
  of genomes using HiFi and Oxford Nanopore reads.\n\nTool homepage: https://github.com/marbl/verkko"
inputs:
  - id: output_directory_path
    type: string
    doc: Directory to use for verkko intermediate and final results. Created if needed.
    inputBinding:
      position: 100
      prefix: -d
  - id: hifi_reads
    type:
      type: array
      items: File
    doc: List of files containing PacBio HiFi reads (FASTA/FASTQ, optionally compressed)
    inputBinding:
      position: 101
      prefix: --hifi
  - id: nano_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files containing Oxford Nanopore reads (FASTA/FASTQ/SAM/BAM, optionally compressed)
    inputBinding:
      position: 101
      prefix: --nano
  - id: no_nano
    type:
      - 'null'
      - boolean
    doc: Assemble without ONT data
    inputBinding:
      position: 101
      prefix: --no-nano
  - id: no_correction
    type:
      - 'null'
      - boolean
    doc: Do not perform Canu correction on the HiFi reads
    inputBinding:
      position: 101
      prefix: --no-correction
  - id: hic1_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files containing left Hi-C reads
    inputBinding:
      position: 101
      prefix: --hic1
  - id: hic2_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files containing right Hi-C reads
    inputBinding:
      position: 101
      prefix: --hic2
  - id: porec_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files containing Pore-C reads
    inputBinding:
      position: 101
      prefix: --porec
  - id: no_rdna_tangle
    type:
      - 'null'
      - boolean
    doc: Switch off the option that helps to proceed large rDNA tangles
    inputBinding:
      position: 101
      prefix: --no-rdna-tangle
  - id: telomere_motif
    type:
      - 'null'
      - string
    doc: Switch to a user-supplied telomere motif
    inputBinding:
      position: 101
      prefix: --telomere-motif
  - id: ref
    type:
      - 'null'
      - File
    doc: Path to an optional reference, used only as guidance during scaffolding
    inputBinding:
      position: 101
      prefix: --ref
  - id: uneven_depth
    type:
      - 'null'
      - boolean
    doc: Disable coverage-based heuristics in homozygous node detection for Hi-C/Pore-C phasing
    inputBinding:
      position: 101
      prefix: --uneven-depth
  - id: haplo_divergence
    type:
      - 'null'
      - float
    doc: Maximum divergence between haplotypes, used only with Hi-C/Pore-C data (default 0.05, min 0, max 0.2)
    inputBinding:
      position: 101
      prefix: --haplo-divergence
  - id: screen_human_contaminants
    type:
      - 'null'
      - boolean
    doc: Screen typical contaminants of human assemblies (rDNA, mitochondria, EBV)
    inputBinding:
      position: 101
      prefix: --screen-human-contaminants
  - id: paths
    type:
      - 'null'
      - File
    doc: GAF file with user-provided paths through the assembly graph (requires an existing assembly and input reads)
    inputBinding:
      position: 101
      prefix: --paths
  - id: assembly
    type:
      - 'null'
      - Directory
    doc: Existing assembly directory used with --paths
    inputBinding:
      position: 101
      prefix: --assembly
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Remove intermediate results
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Retain intermediate results (default)
    inputBinding:
      position: 101
      prefix: --no-cleanup
  - id: local_memory
    type:
      - 'null'
      - int
    doc: Upper limit on memory to use, in GB (default 64)
    inputBinding:
      position: 101
      prefix: --local-memory
  - id: local_cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (default all)
    inputBinding:
      position: 101
      prefix: --local-cpus
  - id: snakeopts
    type:
      - 'null'
      - string
    doc: Snakemake options, appended to the snakemake command
    inputBinding:
      position: 101
      prefix: --snakeopts
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory for the assembly (assembly.fasta, assembly.gfa and intermediate files)
    outputBinding:
      glob: $(inputs.output_directory_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verkko:2.3--h03b467c_1
