cwlVersion: v1.2
class: CommandLineTool
baseCommand: cenmap
label: cenmap
doc: "(Cen)tromere (M)apping and (A)nnotation (P)ipeline.\n\nTool homepage: https://github.com/logsdon-lab/CenMAP"
inputs:
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Chromosomes to partition outputs. Specifying 'none' will not partition output.
      Format: 'chr[0-9XY]+|none'"
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: config
    type:
      - 'null'
      - File
    doc: Input configfile. If provided, other arguments are ignored. Allows 
      submission of multiple samples or parameter tuning.
    inputBinding:
      position: 101
      prefix: --config
  - id: generate_config
    type:
      - 'null'
      - boolean
    doc: Generate template configfile for --config.
    inputBinding:
      position: 101
      prefix: --generate-config
  - id: hifi
    type:
      - 'null'
      - type: array
        items: File
    doc: Input PacBio HiFi reads for assembly evaluation with NucFlag. Supports 
      BAM, CRAM, or gzipped/uncompressed fastq/fasta files.
    inputBinding:
      position: 101
      prefix: --hifi
  - id: input_asm
    type:
      - 'null'
      - type: array
        items: File
    doc: Input assembly files for one sample. Supports fasta, fasta.gz, fa, or 
      fa.gz.
    inputBinding:
      position: 101
      prefix: --input-asm
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs to run. Requires setting --workflow-profile and one of 
      the snakemake cluster plugins. Minimum of 4 jobs.
    inputBinding:
      position: 101
      prefix: --jobs
  - id: mode
    type:
      - 'null'
      - string
    doc: Species of sample. Either 'human' or non-human primate ('nhp').
    inputBinding:
      position: 101
      prefix: --mode
  - id: omit_repeatmasker
    type:
      - 'null'
      - boolean
    doc: Omit RepeatMasker and its outputs from the workflow. This removes 
      repeat annotations from plots and switches the partial detection algorithm
      to use kmers instead of RepeatMasker repeats. Putative alpha-satellite 
      annotations are produced using srf/trf. Use this option for a substantial 
      speedup in centromere detection.
    inputBinding:
      position: 101
      prefix: --omit-repeatmasker
  - id: ont
    type:
      - 'null'
      - type: array
        items: File
    doc: Input ONT reads with MM and ML tags for CDR detection. Supports BAM and
      gzipped/uncompressed fastq WITH MM and ML tags in header.
    inputBinding:
      position: 101
      prefix: --ont
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to run. Minimum of 4 processes.
    inputBinding:
      position: 101
      prefix: --processes
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to reference assembly used to rename and reorient contigs. 
      Defaults to CHM13 v2.0 and assumes contig names are exact matches to 
      --chromosomes. If not provided and --chromosomes set to 'none', no 
      reference chromosome mapping is performed. Avoid changing unless you know 
      what you're doing.
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name.
    inputBinding:
      position: 101
      prefix: --sample
  - id: snake_opts
    type:
      - 'null'
      - string
    doc: Additional snakemake options.
    inputBinding:
      position: 101
      prefix: --snake-opts
  - id: workflow_profile
    type:
      - 'null'
      - string
    doc: Custom workflow profile for snakemake.
    inputBinding:
      position: 101
      prefix: --workflow-profile
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cenmap:1.2.0--h577a1d6_0
