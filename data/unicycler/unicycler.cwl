cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicycler
label: unicycler
doc: "Unicycler: an assembly pipeline for bacterial genomes\n\nTool homepage: https://github.com/rrwick/Unicycler"
inputs:
  - id: keep
    type:
      - 'null'
      - int
    doc: "Level of file retention (default: 1)\n                            0 = only
      keep final files: assembly (FASTA,\n                            GFA and log),\n\
      \                            1 = also save graphs at main checkpoints,\n   \
      \                         2 = also keep SAM (enables fast rerun in different
      mode),\n                            3 = keep all temp files and save all graphs
      (for debugging)"
    inputBinding:
      position: 101
      prefix: --keep
  - id: linear_seqs
    type:
      - 'null'
      - int
    doc: "The expected number of linear (i.e. non-circular)\n                    \
      \      sequences in the underlying sequence (default: 0)"
    inputBinding:
      position: 101
      prefix: --linear_seqs
  - id: long
    type:
      - 'null'
      - File
    doc: FASTQ or FASTA file of long reads
    inputBinding:
      position: 101
      prefix: --long
  - id: min_fasta_length
    type:
      - 'null'
      - int
    doc: "Exclude contigs from the FASTA file which are\n                        \
      \  shorter than this length (default: 100)"
    inputBinding:
      position: 101
      prefix: --min_fasta_length
  - id: mode
    type:
      - 'null'
      - string
    doc: "Bridging mode (default: normal)\n                            conservative
      = smaller contigs, lowest misassembly\n                                    \
      \       rate\n                            normal = moderate contig size and
      misassembly rate\n                            bold = longest contigs, higher
      misassembly rate"
    inputBinding:
      position: 101
      prefix: --mode
  - id: short1
    type:
      - 'null'
      - File
    doc: FASTQ file of first short reads in each pair
    inputBinding:
      position: 101
      prefix: --short1
  - id: short2
    type:
      - 'null'
      - File
    doc: FASTQ file of second short reads in each pair
    inputBinding:
      position: 101
      prefix: --short2
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used (default: 8)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: unpaired
    type:
      - 'null'
      - File
    doc: FASTQ file of unpaired short reads
    inputBinding:
      position: 101
      prefix: --unpaired
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of stdout and log file information (default: 1)\n                \
      \            0 = no stdout, 1 = basic progress indicators,\n               \
      \             2 = extra info, 3 = debugging info"
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: out
    type: Directory
    doc: Output directory (required)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicycler:0.5.1--py312hdcc493e_5
