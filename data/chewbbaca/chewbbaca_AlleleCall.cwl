cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - AlleleCall
label: chewbbaca_AlleleCall
doc: "Determine the allelic profiles of a set of genomes.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: input_files
    type: Directory
    doc: "Path to the directory that contains the input FASTA files."
    inputBinding:
      position: 1
      prefix: --input-files
  - id: schema_directory
    type: Directory
    doc: "Path to the schema directory. The schema directory contains the loci FASTA files and a folder named \"short\" that contains the FASTA files with the loci representative alleles. Staged writable because new inferred alleles are added to it."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: output_directory
    type: string
    doc: "Output directory where the process will store intermediate files and allele calling results."
    default: "allelecall_out"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: training_file
    type:
      - 'null'
      - File
    doc: "Path to the Prodigal training file used by Pyrodigal to predict genes. Default is to use the training file included in the schema directory."
    inputBinding:
      position: 1
      prefix: --training-file
  - id: genes_list
    type:
      - 'null'
      - File
    doc: "Path to a file with the list of genes/loci to perform allele calling (full paths to the loci FASTA files or the loci IDs, one per line)."
    inputBinding:
      position: 1
      prefix: --genes-list
  - id: blast_score_ratio
    type:
      - 'null'
      - float
    doc: "BLAST Score Ratio (BSR) value."
    inputBinding:
      position: 1
      prefix: --blast-score-ratio
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: "Minimum sequence length value. Predicted coding sequences (CDSs) shorter than this value are excluded."
    inputBinding:
      position: 1
      prefix: --minimum-length
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Genetic code used to predict genes and to translate coding DNA sequences (CDSs). Ignored if a training file is used."
    inputBinding:
      position: 1
      prefix: --translation-table
  - id: size_threshold
    type:
      - 'null'
      - float
    doc: "Coding sequence (CDS) size variation threshold. At 0.2, CDSs with a size that deviates +-20 percent from the locus length mode are classified as ASM/ALM."
    inputBinding:
      position: 1
      prefix: --size-threshold
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: blast_path
    type:
      - 'null'
      - Directory
    doc: "Path to the directory that contains the BLAST executables."
    inputBinding:
      position: 1
      prefix: --blast-path
  - id: prodigal_mode
    type:
      - 'null'
      - string
    doc: "Prodigal running mode (\"single\" or \"meta\"). (default: single)"
    inputBinding:
      position: 1
      prefix: --prodigal-mode
  - id: cds_input
    type:
      - 'null'
      - boolean
    doc: "If provided, chewBBACA skips the gene prediction step and assumes the input FASTA files contain coding sequences (one FASTA file per strain)."
    inputBinding:
      position: 1
      prefix: --cds-input
  - id: no_inferred
    type:
      - 'null'
      - boolean
    doc: "If provided, the process will not add the sequences of inferred alleles (INF) to the schema."
    inputBinding:
      position: 1
      prefix: --no-inferred
  - id: output_unclassified
    type:
      - 'null'
      - boolean
    doc: "Create a Fasta file with the coding sequences (CDSs) that were not classified."
    inputBinding:
      position: 1
      prefix: --output-unclassified
  - id: output_missing
    type:
      - 'null'
      - boolean
    doc: "Create a Fasta file with coding sequences (CDSs) classified as NIPH, NIPHEM, ASM, ALM, PLOT3, PLOT5 and LOTSC."
    inputBinding:
      position: 1
      prefix: --output-missing
  - id: output_novel
    type:
      - 'null'
      - boolean
    doc: "Create a Fasta file with the novel alleles inferred during allele calling."
    inputBinding:
      position: 1
      prefix: --output-novel
  - id: output_masked
    type:
      - 'null'
      - boolean
    doc: "Create a TSV file with the masked allelic profiles."
    inputBinding:
      position: 1
      prefix: --output-masked
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "If provided, intermediate files generated during process execution are not removed at the end."
    inputBinding:
      position: 1
      prefix: --no-cleanup
  - id: hash_profiles
    type:
      - 'null'
      - string
    doc: "Create a TSV file with hashed allelic profiles, using the named hashlib or zlib algorithm (e.g. sha256, crc32)."
    inputBinding:
      position: 1
      prefix: --hash-profiles
  - id: force_continue
    type:
      - 'null'
      - boolean
    doc: "If provided, chewie will not warn users and ask for permission to continue if any of the provided argument values does not match the values in the config file."
    inputBinding:
      position: 1
      prefix: --force-continue
  - id: mode
    type:
      - 'null'
      - int
    doc: "Execution mode (1: only exact matches at DNA level; 2: exact matches at DNA and Protein level; 3: exact matches and minimizer-based clustering; 4: full process). (default: 4)"
    inputBinding:
      position: 1
      prefix: --mode
outputs:
  - id: results_dir
    type: Directory
    doc: "Allele calling results directory."
    outputBinding:
      glob: $(inputs.output_directory)
  - id: updated_schema
    type: Directory
    doc: "Schema directory, including any inferred alleles added during allele calling."
    outputBinding:
      glob: $(inputs.schema_directory.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.schema_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
