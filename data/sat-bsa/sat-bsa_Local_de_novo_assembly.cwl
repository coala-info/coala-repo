cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Sat-BSA
  - -w
  - Local_de_novo_assembly
label: sat-bsa_Local_de_novo_assembly
doc: "Select long reads aligned at a target region and assemble them with Canu.\n\nTool homepage: https://github.com/SegawaTenta/Sat-BSA"
inputs:
  - id: chromosome
    type: string
    doc: Chromosome name for selecting the aligned reads.
    inputBinding:
      position: 1
      prefix: -c
  - id: start_position
    type: int
    doc: Start position for selecting the aligned reads.
    inputBinding:
      position: 2
      prefix: -s
  - id: end_position
    type: int
    doc: End position for selecting the aligned reads.
    inputBinding:
      position: 3
      prefix: -e
  - id: bam_list
    type: File
    doc: Full path of bam_list.txt listing bam files (Input format 1).
    inputBinding:
      position: 4
      prefix: -b
  - id: fa_list
    type: File
    doc: Full path of fa_list.txt listing fasta.gz files (Input format 2).
    inputBinding:
      position: 5
      prefix: -f
  - id: canu_path
    type: string
    doc: Full path of the Canu executable (Canu is not part of the image).
    inputBinding:
      position: 6
      prefix: -d
  - id: genome_size_mb
    type:
      - 'null'
      - int
    doc: Genome size in Mb set in Canu.
    inputBinding:
      position: 7
      prefix: -g
  - id: read_status
    type:
      - 'null'
      - string
    doc: Read status set in Canu. Default is -nanopore-raw.
    inputBinding:
      position: 8
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number.
    inputBinding:
      position: 9
      prefix: -t
  - id: data_files
    type:
      type: array
      items: File
    doc: Files named in the list files (bam, fasta, fastq, reference, gtf). They are staged into the working directory /work, so list files must name them as /work/<file name>.
outputs:
  - id: selected_reads
    type:
      type: array
      items: File
    doc: Multi-FASTA of the long reads aligned at the region, one file per sample
    outputBinding:
      glob: aligned_*.fa
  - id: selected_stats
    type:
      type: array
      items: File
    doc: Summary of the selected long reads, one file per sample
    outputBinding:
      glob: aligned_*.stat.txt
  - id: assembly_dirs
    type:
      type: array
      items: Directory
    doc: Canu assembly result directory for each sample
    outputBinding:
      glob: Local_de_novo_assembly_*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sat-bsa:1.12--hdfd78af_1
    dockerOutputDirectory: /work
