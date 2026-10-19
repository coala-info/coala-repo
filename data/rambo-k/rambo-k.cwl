cwlVersion: v1.2
class: CommandLineTool
baseCommand: RAMBOK.py
label: rambo-k
doc: 'RAMBO-K (Read Assignment Method Based On K-mers) separates mixed NGS reads from
  two species (for example host and pathogen) with a Markov-chain k-mer model trained
  on two reference genomes.


  Tool homepage: https://gitlab.com/SimonHTausch/RAMBO-K'
inputs:
  - id: reference_1
    type: File
    doc: Reference file of species 1 in fasta-format. Should pair with name1
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_2
    type: File
    doc: Reference file of species 2 in fasta-format. Should pair with name2
    inputBinding:
      position: 101
      prefix: -R
  - id: name_1
    type:
      - 'null'
      - string
    doc: Name of species 1
    inputBinding:
      position: 101
      prefix: -n
  - id: name_2
    type:
      - 'null'
      - string
    doc: Name of species 2
    inputBinding:
      position: 101
      prefix: -N
  - id: reads_1
    type: File
    doc: Fasta- or fastq-file containing mixed reads.
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reads_2
    type:
      - 'null'
      - File
    doc: Fasta- or fastq-file containing mixed reads, only required in paired end
      mode.
    inputBinding:
      position: 101
      prefix: '-2'
  - id: kmer_sizes
    type:
      - 'null'
      - string
    doc: Order of Markov-Chain/kmer length. Enter as range (e.g. 4:8) or list (e.g.
      4,6,8) or integer (e.g. 8). Default = 8
    inputBinding:
      position: 101
      prefix: -k
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Folder to write results to (default rambok_out; the tool default is $name1_$name2/)
    default: rambok_out
    inputBinding:
      position: 101
      prefix: -o
  - id: amount
    type:
      - 'null'
      - int
    doc: Number of reads to be simulated, default = 50000
    inputBinding:
      position: 101
      prefix: -a
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Size of chunks created at a time for simulation, default = 100000. Only change
      if you know what you are doing!
    inputBinding:
      position: 101
      prefix: -x
  - id: gap_size
    type:
      - 'null'
      - int
    doc: Estimated size of gapsize in case of paired end reads, default = 1
    inputBinding:
      position: 101
      prefix: -g
  - id: cutoff_lower
    type:
      - 'null'
      - string
    doc: 'Lower cutoff: Output only reads with a score lower than or equal to this
      value, use m1 for -1'
    inputBinding:
      position: 101
      prefix: -c
  - id: cutoff_higher
    type:
      - 'null'
      - string
    doc: 'Higher cutoff: Output only reads with a score higher than or equal to this
      value, use m1 for -1'
    inputBinding:
      position: 101
      prefix: -C
  - id: delete_temp
    type:
      - 'null'
      - boolean
    doc: Delete temporary files. Calculations will start from beginning next time.
    inputBinding:
      position: 101
      prefix: -d
  - id: filetype
    type:
      - 'null'
      - string
    doc: Type of your input reads. fasta or fastq, default = fastq
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results_dir
    type: Directory
    doc: Directory with the classified reads and score files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rambo-k:1.21--py36_0
stdout: rambo-k.out
