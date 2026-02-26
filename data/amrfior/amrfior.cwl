cwlVersion: v1.2
class: CommandLineTool
baseCommand: amrfior
label: amrfior
doc: "AMRfíor v0.5.1 - The Multi-Tool AMR Gene Detection Toolkit.\n\nTool homepage:
  https://github.com/NickJD/AMRfior"
inputs:
  - id: databases
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specify which AMR gene databases to use (default: resfinder and card)'
    inputBinding:
      position: 101
      prefix: --databases
  - id: detection_min_base_depth
    type:
      - 'null'
      - float
    doc: Minimum average base depth for detection - calculated against regions 
      of the detected gene with at least one read hit
    default: 1.0
    inputBinding:
      position: 101
      prefix: --detection-min-base-depth
  - id: detection_min_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage threshold in percent
    default: 80.0
    inputBinding:
      position: 101
      prefix: --detection-min-coverage
  - id: detection_min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity threshold in percent
    default: 80.0
    inputBinding:
      position: 101
      prefix: --detection-min-identity
  - id: detection_min_num_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads required for detection
    default: 1
    inputBinding:
      position: 101
      prefix: --detection-min-num-reads
  - id: dna_only
    type:
      - 'null'
      - boolean
    doc: Run only DNA-based tools
    inputBinding:
      position: 101
      prefix: --dna-only
  - id: input
    type:
      type: array
      items: File
    doc: Input FASTA/FASTAQ file(s) with sequences to analyse - Separate FASTQ 
      R1 and R2 with a comma for Paired-FASTQ or single file path for 
      Single-FASTA - .gz files accepted
    inputBinding:
      position: 101
      prefix: --input
  - id: minimap2_preset
    type:
      - 'null'
      - string
    doc: 'Minimap2 preset: sr=short reads, map-ont=Oxford Nanopore, map-pb=PacBio,
      map-hifi=PacBio HiFi'
    default: sr
    inputBinding:
      position: 101
      prefix: --minimap2-preset
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Do not clean up temporary files
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: protein_only
    type:
      - 'null'
      - boolean
    doc: Run only protein-based tools
    inputBinding:
      position: 101
      prefix: --protein-only
  - id: query_min_coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage threshold in percent
    default: 40.0
    inputBinding:
      position: 101
      prefix: --query-min-coverage
  - id: report_fasta
    type:
      - 'null'
      - string
    doc: Specify whether to output sequences that "mapped" to genes. "all" 
      should only be used for deep investigation/debugging. "detected" will 
      report the reads that passed detection thresholds for each detected gene. 
      "detected-all" will report all reads for each detected gene.
    default: None
    inputBinding:
      position: 101
      prefix: --report-fasta
  - id: sensitivity
    type:
      - 'null'
      - string
    doc: Preset sensitivity levels - default means each tool uses its own 
      default settings
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: sequence_type
    type: string
    doc: 'Specify the input Sequence Type: Single-FASTA or Paired-FASTQ (R1+R2)'
    inputBinding:
      position: 101
      prefix: --sequence-type
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Path to temporary to place input FASTA/Q file(s) for faster IO during 
      BLAST - Path will also be used for all temporary files
    inputBinding:
      position: 101
      prefix: --temp-directory
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: tools
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specify which tools to run - "all" will run all tools (default: all except
      blastx/n as it is very slow!!)'
    inputBinding:
      position: 101
      prefix: --tools
  - id: user_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing user-provided databases (required if 
      --databases includes "user-provided")
    inputBinding:
      position: 101
      prefix: --user-db-path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory for results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amrfior:0.5.1--pyhdfd78af_0
