cwlVersion: v1.2
class: CommandLineTool
baseCommand: masurca
label: masurca
doc: "Create the assembly script from a MaSuRCA configuration file. A sample configuration
  file can be generated with the -g switch. The assembly script assemble.sh will run
  the assembly proper. For a quick run without creating a configuration file, and
  with two Illumina paired end reads files (forward/reverse) and (optionally) a long
  reads (Nanopore/PacBio) file use -i switch, setting the number of threads with -t:\n\
  \nTool homepage: http://masurca.blogspot.co.uk/"
inputs:
  - id: generate
    type:
      - 'null'
      - boolean
    doc: Generate example configuration file
    inputBinding:
      position: 101
      prefix: --generate
  - id: illumina
    type:
      - 'null'
      - string
    doc: Run assembly without creating configuration file, argument can be 
      illumina_paired_end_forward_reads or 
      illumina_paired_end_forward_reads,illumina_paired_end_reverse_reads. 
      Illumina read file names must be comma-separated, without a space in the 
      middle. Illumina read files must be fastq, with valid quality values, can 
      be gzipped.
    inputBinding:
      position: 101
      prefix: --illumina
  - id: ld_library_path
    type:
      - 'null'
      - string
    doc: Prepend to LD_LIBRARY_PATH in assembly script
    inputBinding:
      position: 101
      prefix: --ld-library-path
  - id: output
    type:
      - 'null'
      - string
    doc: Assembly script (assemble.sh)
    inputBinding:
      position: 101
      prefix: --output
  - id: path
    type:
      - 'null'
      - string
    doc: Prepend to PATH in assembly script
    inputBinding:
      position: 101
      prefix: --path
  - id: reads
    type:
      - 'null'
      - string
    doc: ONLY to use with -i option, single long reads file for hybrid assembly,
      can be Nanopore or PacBio, fasta or fastq, can be gzipped
    inputBinding:
      position: 101
      prefix: --reads
  - id: skip_checking
    type:
      - 'null'
      - boolean
    doc: Skip checking availability of other executables
    inputBinding:
      position: 101
      prefix: --skip-checking
  - id: threads
    type:
      - 'null'
      - int
    doc: ONLY to use with -i option, number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/masurca:4.1.4--h6b3f7d6_0
stdout: masurca.out
