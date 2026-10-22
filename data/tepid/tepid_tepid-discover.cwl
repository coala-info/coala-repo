cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid-discover
label: tepid_tepid-discover
doc: "TEPID -- transposable element polymorphism identification. Finds TE
  insertions and deletions from bowtie2 (concordant) and yaha (split read)
  alignments.\n\nTool homepage: https://github.com/ListerLab/TEPID"
inputs:
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep all intermediate files
    inputBinding:
      position: 101
      prefix: --keep
  - id: deletions_only
    type:
      - 'null'
      - boolean
    doc: find deletions only
    inputBinding:
      position: 101
      prefix: --deletions
  - id: insertions_only
    type:
      - 'null'
      - boolean
    doc: find insertions only
    inputBinding:
      position: 101
      prefix: --insertions
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Report high-confidence variants only
    inputBinding:
      position: 101
      prefix: --strict
  - id: mask
    type:
      - 'null'
      - string
    doc: Mask chromosomes in comma separated list or file
    inputBinding:
      position: 101
      prefix: --mask
  - id: discordant
    type:
      - 'null'
      - File
    doc: Supply discordant reads bam file
    inputBinding:
      position: 101
      prefix: --discordant
  - id: proc
    type:
      - 'null'
      - int
    doc: number of processors
    inputBinding:
      position: 101
      prefix: --proc
  - id: sample_name
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: --name
  - id: conc
    type: File
    doc: bam file from bowtie2
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: --conc
  - id: split
    type: File
    doc: split reads bam file from yaha
    inputBinding:
      position: 101
      prefix: --split
  - id: te
    type: File
    doc: TE annotation bedfile
    inputBinding:
      position: 101
      prefix: --te
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Run in single-end mode
    inputBinding:
      position: 101
      prefix: --se
outputs:
  - id: insertions
    type:
      - 'null'
      - File
    doc: TE insertions bed file
    outputBinding:
      glob: insertions_$(inputs.sample_name).bed
  - id: deletions
    type:
      - 'null'
      - File
    doc: TE deletions bed file (TE present in reference but not in sample)
    outputBinding:
      glob: deletions_$(inputs.sample_name).bed
  - id: insertion_reads
    type:
      - 'null'
      - File
    doc: names of reads providing evidence for insertions
    outputBinding:
      glob: insertion_reads_$(inputs.sample_name).txt
  - id: deletion_reads
    type:
      - 'null'
      - File
    doc: names of reads providing evidence for deletions
    outputBinding:
      glob: deletion_reads_$(inputs.sample_name).txt
  - id: log_file
    type:
      - 'null'
      - File
    doc: tepid-discover log
    outputBinding:
      glob: tepid_discover_log_$(inputs.sample_name).txt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.conc)
        writable: true
      - entry: $(inputs.split)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
