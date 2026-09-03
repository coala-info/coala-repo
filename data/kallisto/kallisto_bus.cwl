cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kallisto
  - bus
label: kallisto_bus
doc: Generates BUS files for single-cell sequencing
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: FASTQ files to process
    inputBinding:
      position: 1
  - id: index
    type:
      - 'null'
      - File
    doc: Filename for the kallisto index to be used for pseudoalignment
    inputBinding:
      position: 102
      prefix: --index
  - id: output_dir
    type: string
    doc: Directory to write output to
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: technology
    type:
      - 'null'
      - string
    doc: Single-cell technology used
    inputBinding:
      position: 102
      prefix: --technology
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all single-cell technologies supported
    inputBinding:
      position: 102
      prefix: --list
  - id: batch
    type:
      - 'null'
      - File
    doc: Process files listed in FILE
    inputBinding:
      position: 102
      prefix: --batch
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Input file is a BAM file
    inputBinding:
      position: 102
      prefix: --bam
  - id: num
    type:
      - 'null'
      - boolean
    doc: Output number of read in flag column (incompatible with --bam)
    inputBinding:
      position: 102
      prefix: --num
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to process from supplied input
    inputBinding:
      position: 102
      prefix: --numReads
  - id: tag
    type:
      - 'null'
      - string
    doc: 5′ tag sequence to identify UMI reads for certain technologies
    inputBinding:
      position: 102
      prefix: --tag
  - id: fr_stranded
    type:
      - 'null'
      - boolean
    doc: Strand specific reads for UMI-tagged reads, first read forward
    inputBinding:
      position: 102
      prefix: --fr-stranded
  - id: rf_stranded
    type:
      - 'null'
      - boolean
    doc: Strand specific reads for UMI-tagged reads, first read reverse
    inputBinding:
      position: 102
      prefix: --rf-stranded
  - id: unstranded
    type:
      - 'null'
      - boolean
    doc: Treat all read as non-strand-specific
    inputBinding:
      position: 102
      prefix: --unstranded
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Treat reads as paired
    inputBinding:
      position: 102
      prefix: --paired
  - id: long
    type:
      - 'null'
      - boolean
    doc: Treat reads as long
    inputBinding:
      position: 102
      prefix: --long
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for rate of unmapped kmers per read
    inputBinding:
      position: 102
      prefix: --threshold
  - id: aa
    type:
      - 'null'
      - boolean
    doc: Align to index generated from a FASTA-file containing amino acid 
      sequences
    inputBinding:
      position: 102
      prefix: --aa
  - id: inleaved
    type:
      - 'null'
      - boolean
    doc: Specifies that input is an interleaved FASTQ file
    inputBinding:
      position: 102
      prefix: --inleaved
  - id: batch_barcodes
    type:
      - 'null'
      - boolean
    doc: Records both batch and extracted barcode in BUS file
    inputBinding:
      position: 102
      prefix: --batch-barcodes
  - id: genomebam
    type:
      - 'null'
      - boolean
    doc: Project pseudoalignments to genome sorted BAM file
    inputBinding:
      position: 102
      prefix: --genomebam
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file for transcriptome information (required for --genomebam)
    inputBinding:
      position: 102
      prefix: --gtf
  - id: chromosomes
    type:
      - 'null'
      - File
    doc: Tab separated file with chromosome names and lengths (optional for 
      --genomebam, but recommended)
    inputBinding:
      position: 102
      prefix: --chromosomes
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write output to
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
s:url: https://pachterlab.github.io/kallisto
$namespaces:
  s: https://schema.org/
