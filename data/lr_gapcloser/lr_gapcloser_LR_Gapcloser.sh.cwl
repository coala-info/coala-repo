cwlVersion: v1.2
class: CommandLineTool
baseCommand: sh LR_Gapcloser.sh
label: lr_gapcloser_LR_Gapcloser.sh
doc: "Close gaps in scaffolds using long reads.\n\nTool homepage: https://github.com/CAFS-bioinformatics/LR_Gapcloser"
inputs:
  - id: corrected_read_file
    type: File
    doc: the raw and error-corrected long reads used to close gaps. The file 
      should be fasta format.
    inputBinding:
      position: 101
      prefix: -l
  - id: coverage_threshold
    type:
      - 'null'
      - float
    doc: the coverage threshold to select high-quality alignments
    inputBinding:
      position: 101
      prefix: -c
  - id: gap_fill_deviation
    type:
      - 'null'
      - float
    doc: the deviation between gap length and filled sequence length
    inputBinding:
      position: 101
      prefix: -a
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iteration
    inputBinding:
      position: 101
      prefix: -r
  - id: max_tag_distance
    type:
      - 'null'
      - int
    doc: to select the reliable tags for gap-closure, the maximal allowed 
      distance from alignment region to gap boundary (bp)
    inputBinding:
      position: 101
      prefix: -m
  - id: min_tag_alignment_length
    type:
      - 'null'
      - int
    doc: the minimal tag alignment length around each boundary of a gap (bp)
    inputBinding:
      position: 101
      prefix: -v
  - id: num_tag_files
    type:
      - 'null'
      - int
    doc: the number of files that all tags were divided into
    inputBinding:
      position: 101
      prefix: -n
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: name of output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: scaffold_file
    type: File
    doc: the scaffold file that contains gaps, represented by a string of N
    inputBinding:
      position: 101
      prefix: -i
  - id: sequencing_platform
    type:
      - 'null'
      - string
    doc: 'sequencing platform: pacbio [p] or nanopore [n]'
    inputBinding:
      position: 101
      prefix: -s
  - id: tag_length
    type:
      - 'null'
      - int
    doc: the length of tags that a long read would be divided into (bp)
    inputBinding:
      position: 101
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (for machines with multiple processors), used in the 
      bwa mem alignment processes and the following coverage filteration.
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lr_gapcloser:1.0--pl5321hdfd78af_0
stdout: lr_gapcloser_LR_Gapcloser.sh.out
