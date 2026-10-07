cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - canu
  - -trim-assemble
label: canu_trim-assemble
doc: "Canu trim-assemble stage (-trim-assemble): generate trimmed reads and then assemble them. Canu is a de novo assembler for long reads (PacBio, Nanopore, PacBio HiFi). The run is computed in the -d <assembly-directory>, with output files named using the -p <assembly-prefix>.\n\nTool homepage: https://github.com/marbl/canu"
inputs:
  - id: assembly_specifications_file
    type:
      - 'null'
      - File
    doc: "Assembly specifications file (options, one per line)"
    inputBinding:
      position: 1
      prefix: -s
  - id: assembly_prefix
    type: string
    doc: "Assembly prefix for output files"
    inputBinding:
      position: 2
      prefix: -p
  - id: assembly_directory
    type: string
    doc: "Assembly directory for output files (created if needed)"
    inputBinding:
      position: 3
      prefix: -d
  - id: genome_size
    type: string
    doc: "Estimated haploid genome size (e.g., 1g, 4.7m, 4700000)"
    inputBinding:
      position: 4
      prefix: genomeSize=
      separate: false
  - id: use_grid
    type:
      - 'null'
      - string
    doc: "Run under grid control (true), locally (false), or set up for grid control but don't submit any jobs (remote)"
    inputBinding:
      position: 5
      prefix: useGrid=
      separate: false
  - id: raw_error_rate
    type:
      - 'null'
      - float
    doc: "The allowed difference in an overlap between two raw uncorrected reads. Defaults are 0.300 for PacBio reads and 0.500 for Nanopore reads."
    inputBinding:
      position: 5
      prefix: rawErrorRate=
      separate: false
  - id: corrected_error_rate
    type:
      - 'null'
      - float
    doc: "The allowed difference in an overlap between two corrected reads. Defaults are 0.045 for PacBio reads and 0.144 for Nanopore reads."
    inputBinding:
      position: 5
      prefix: correctedErrorRate=
      separate: false
  - id: grid_options
    type:
      - 'null'
      - string
    doc: "Pass string to the command used to submit jobs to the grid."
    inputBinding:
      position: 5
      prefix: gridOptions=
      separate: false
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: "Ignore reads shorter than 'number' bases long. Default: 1000."
    inputBinding:
      position: 5
      prefix: minReadLength=
      separate: false
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: "Ignore read-to-read overlaps shorter than 'number' bases long. Default: 500."
    inputBinding:
      position: 5
      prefix: minOverlapLength=
      separate: false
  - id: max_memory
    type:
      - 'null'
      - string
    doc: "Maximum memory to use by any component of the assembler (listed by canu -options)"
    inputBinding:
      position: 5
      prefix: maxMemory=
      separate: false
  - id: max_threads
    type:
      - 'null'
      - int
    doc: "Maximum number of compute threads to use by any component of the assembler (listed by canu -options)"
    inputBinding:
      position: 5
      prefix: maxThreads=
      separate: false
  - id: other_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Other canu options as key=value words (listed by canu -options), for example stopOnLowCoverage=5
    inputBinding:
      position: 6
  - id: corrected
    type:
      - 'null'
      - boolean
    doc: "Reads are corrected"
    inputBinding:
      position: 95
      prefix: -corrected
  - id: trimmed
    type:
      - 'null'
      - boolean
    doc: "Reads are trimmed"
    inputBinding:
      position: 95
      prefix: -trimmed
  - id: pacbio_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio read files (FASTA or FASTQ, uncompressed or gz/bz2/xz)
    inputBinding:
      position: 100
      prefix: -pacbio
  - id: nanopore_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Nanopore read files (FASTA or FASTQ, uncompressed or gz/bz2/xz)
    inputBinding:
      position: 100
      prefix: -nanopore
  - id: pacbio_hifi_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio HiFi read files (FASTA or FASTQ, uncompressed or gz/bz2/xz)
    inputBinding:
      position: 100
      prefix: -pacbio-hifi
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: assembly_directory_dir
    type: Directory
    doc: Assembly directory with all output files
    outputBinding:
      glob: $(inputs.assembly_directory)
  - id: report
    type:
      - 'null'
      - File
    doc: Canu run report
    outputBinding:
      glob: $(inputs.assembly_directory)/$(inputs.assembly_prefix).report
  - id: contigs
    type:
      - 'null'
      - File
    doc: Assembled contigs
    outputBinding:
      glob: $(inputs.assembly_directory)/$(inputs.assembly_prefix).contigs.fasta
  - id: unassembled
    type:
      - 'null'
      - File
    doc: Reads and low-coverage contigs not in the assembly
    outputBinding:
      glob: $(inputs.assembly_directory)/$(inputs.assembly_prefix).unassembled.fasta
  - id: contigs_tiginfo
    type:
      - 'null'
      - File
    doc: Contig layout summary (tigInfo)
    outputBinding:
      glob: $(inputs.assembly_directory)/$(inputs.assembly_prefix).contigs.layout.tigInfo
  - id: trimmed_reads
    type:
      - 'null'
      - File
    doc: Trimmed reads
    outputBinding:
      glob: $(inputs.assembly_directory)/$(inputs.assembly_prefix).trimmedReads.fasta.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canu:2.3--h3fb4750_2
stdout: canu_trim-assemble.out
