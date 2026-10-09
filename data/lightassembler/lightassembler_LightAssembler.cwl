cwlVersion: v1.2
class: CommandLineTool
baseCommand: LightAssembler
label: lightassembler_LightAssembler
doc: "Light Version of an assembly algorithm for short reads in FASTA/FASTQ/FASTA.gz/FASTQ.gz
  formats.\n\nTool homepage: https://github.com/SaraEl-Metwally/LightAssembler"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        return inputs.input_files.map(function(f, i) {
          return {class: 'File', location: f.location, basename: 'r' + i + f.basename.replace(/^[^.]*/, '')};
        });
      }
arguments:
  - position: 1
    valueFrom: |
      ${
        return inputs.input_files.map(function(f, i) {
          return 'r' + i + f.basename.replace(/^[^.]*/, '');
        });
      }
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: FASTA/FASTQ/FASTA.gz/FASTQ.gz files (staged in the working directory with short names,
      because LightAssembler cannot read file paths longer than about 15 characters)
  - id: expected_error_rate
    type:
      - 'null'
      - float
    doc: expected error rate
    inputBinding:
      position: 102
      prefix: -e
  - id: gap_size
    type:
      - 'null'
      - string
    doc: gap size
    inputBinding:
      position: 102
      prefix: -g
  - id: genome_size
    type:
      - 'null'
      - int
    doc: genome size
    inputBinding:
      position: 102
      prefix: -G
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    inputBinding:
      position: 102
      prefix: -k
  - id: output_file
    type:
      - 'null'
      - string
    doc: output file name
    inputBinding:
      position: 102
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: contigs
    type:
      - 'null'
      - File
    doc: Assembled contigs in FASTA format (<output_file>.contigs.fasta).
    outputBinding:
      glob: '*.contigs.fasta'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightassembler:1.0--h077b44d_8
stdout: lightassembler_LightAssembler.out
