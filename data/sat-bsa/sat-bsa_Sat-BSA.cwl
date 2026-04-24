cwlVersion: v1.2
class: CommandLineTool
baseCommand: sat-bsa
label: sat-bsa_Sat-BSA
doc: "Sat-BSA is a package used for applying local de novo assembly and identifying
  the structural variants in the assembled contigs.\n\nTool homepage: https://github.com/SegawaTenta/Sat-BSA"
inputs:
  - id: command
    type: string
    doc: The specific command to execute (e.g., Local_reads_selection, 
      Local_de_novo_assembly, Long_reads_alignment, SVs_detection, Graph)
    inputBinding:
      position: 1
  - id: aligned_read_list_file
    type: File
    doc: Full path of aligned_read_list.txt listing sequence reads applied to 
      Minimap2 (Input format 3).
    inputBinding:
      position: 102
      prefix: -f
  - id: bam_list_file
    type: File
    doc: Full path of bam_list.txt listing bam files (Input format 1).
    inputBinding:
      position: 102
      prefix: -b
  - id: canu_output_dir
    type: Directory
    doc: Full path of Canu output directory.
    inputBinding:
      position: 102
      prefix: -d
  - id: chromosome
    type: string
    doc: Chromosome name for selecting the aligned reads.
    inputBinding:
      position: 102
      prefix: -c
  - id: end_position
    type: int
    doc: End position for selecting the aligned reads.
    inputBinding:
      position: 102
      prefix: -e
  - id: fasta_list_file
    type: File
    doc: Full path of fa_list.txt listing fasta.gz files (Input format 2).
    inputBinding:
      position: 102
      prefix: -f
  - id: genome_size_mb
    type:
      - 'null'
      - int
    doc: Genome size in Mb set in Canu.
    inputBinding:
      position: 102
      prefix: -g
  - id: graph_data_file
    type: File
    doc: Full path of graph_data.txt listing the path to directory constructed 
      by SVs_detection command and color used for the line of graph (Input 
      format 6).
    inputBinding:
      position: 102
      prefix: -c
  - id: gtf_file
    type: File
    doc: Full path of gtf file (Input format 4).
    inputBinding:
      position: 102
      prefix: -g
  - id: mapping_quality_threshold
    type:
      - 'null'
      - int
    doc: The mapping quality value excluded from analysis.
    inputBinding:
      position: 102
      prefix: -q
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: The minimum length of insertion or deletion applied for analysis.
    inputBinding:
      position: 102
      prefix: -f
  - id: p_value_threshold
    type:
      - 'null'
      - float
    doc: Threshold for P-value from Fishers exact test.
    inputBinding:
      position: 102
      prefix: -v
  - id: promoter_size
    type:
      - 'null'
      - int
    doc: Defining promoter size applied for identifying SVs.
    inputBinding:
      position: 102
      prefix: -p
  - id: read_status
    type:
      - 'null'
      - string
    doc: Read status set in Canu.
    inputBinding:
      position: 102
      prefix: -r
  - id: read_type
    type:
      - 'null'
      - string
    doc: The used sequence reads type (Oxford Nanopore Technologies[ont] or 
      PacBio[pb]).
    inputBinding:
      position: 102
      prefix: -i
  - id: reference_fasta
    type: File
    doc: Full path of fasta file used as reference.
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_genome_fasta
    type: File
    doc: Full path of fasta files used as refarence genome.
    inputBinding:
      position: 102
      prefix: -r
  - id: samples_file
    type: File
    doc: Full path of samples.txt listing the compared samples (Input format 5).
    inputBinding:
      position: 102
      prefix: -c
  - id: start_position
    type: int
    doc: Start position for selecting the aligned reads.
    inputBinding:
      position: 102
      prefix: -s
  - id: sv_detection_result_file
    type: File
    doc: Full path of result.txt which is an output from SVs_detection command.
    inputBinding:
      position: 102
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sat-bsa:1.12--hdfd78af_1
stdout: sat-bsa_Sat-BSA.out
