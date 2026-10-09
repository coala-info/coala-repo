cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll-extract-reads
label: krakenhll_extract_reads
doc: "Extract all reads from a FASTA/FASTQ file that were matched to the given taxa by KrakenHLL. Reads are written to standard output.\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs:
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: Input is a FASTA file (default FASTQ)
    inputBinding:
      position: 1
      prefix: -a
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Output in FASTA format
    inputBinding:
      position: 2
      prefix: -f
  - id: invert
    type:
      - 'null'
      - boolean
    doc: "Invert: print all reads not matching the taxon"
    inputBinding:
      position: 3
      prefix: -i
  - id: taxdb
    type:
      - 'null'
      - File
    doc: Include children of the taxonomy IDs, using this TAXDB to find them
    inputBinding:
      position: 4
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 5
      prefix: -v
  - id: paired
    type:
      - 'null'
      - boolean
    doc: "Paired-end reads: the reads argument is a name with a percent sign as placeholder for 1 and 2 (stage both files with paired_files)"
    inputBinding:
      position: 6
      prefix: -p
  - id: taxon
    type: string
    doc: Taxonomy ID, possibly several separated by commas
    inputBinding:
      position: 10
  - id: kraken_file
    type: File
    doc: KrakenHLL result (output) file
    inputBinding:
      position: 11
  - id: reads
    type:
      - 'null'
      - File
    doc: FASTA/FASTQ file, possibly gzipped
    inputBinding:
      position: 12
  - id: paired_pattern
    type:
      - 'null'
      - string
    doc: With paired - read file name with a percent sign in place of 1 and 2 (for example input_%.fq)
    inputBinding:
      position: 12
  - id: paired_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The paired read files (staged in the working directory so the pattern resolves)
outputs:
  - id: extracted_reads
    type: stdout
    doc: Extracted reads
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.paired_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll_extract_reads.out
