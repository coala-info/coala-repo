cwlVersion: v1.2
class: CommandLineTool
baseCommand: efishent
label: efishent
doc: "1meFISHent 🎣 🧬 to design all your probes.\n\nTool homepage: https://github.com/bbquercus/eFISHent/"
inputs:
  - id: analyze_probeset
    type:
      - 'null'
      - File
    doc: "Path to the workflow's output fasta file. Will analyze the probe set in
      more detail and create a PDF. Note: reference genome, target gene of interest,
      and (optional) count table will still have to be provided!"
    inputBinding:
      position: 101
      prefix: --analyze-probeset
  - id: build_indices
    type:
      - 'null'
      - boolean
    doc: Build indices for reference genome only.
    inputBinding:
      position: 101
      prefix: --build-indices
  - id: encode_count_table
    type:
      - 'null'
      - File
    doc: Path to the ENCODE RNAseq count table provided as TSV, CSV, or TXT 
      format. The first two columns have to be `gene_id` and `normalized_value` 
      respectively. Specific column names are not required. `gene_id` have to be
      ensemble IDs of the respective genes. `normalized_value` have to be 
      normalized count values (RPKM, FPKM, TPM, DeSeq2-norm, etc).
    inputBinding:
      position: 101
      prefix: --encode-count-table
  - id: ensembl_id
    type:
      - 'null'
      - string
    doc: Ensembl ID of the gene of interest. Can be used instead of gene and 
      organism name to download the gene of interest. Used to filter out the 
      gene of interest from FPKM based filtering - will do an automated 
      blast-based filtering if not passed.
    inputBinding:
      position: 101
      prefix: --ensembl-id
  - id: formamide_concentration
    type:
      - 'null'
      - float
    doc: Formamide concentration as a percentage of the total buffer.
    inputBinding:
      position: 101
      prefix: --formamide-concentration
  - id: gene_name
    type:
      - 'null'
      - string
    doc: Gene name.
    inputBinding:
      position: 101
      prefix: --gene-name
  - id: is_endogenous
    type:
      - 'null'
      - boolean
    doc: Is the probe endogenous?
    inputBinding:
      position: 101
      prefix: --is-endogenous
  - id: is_plus_strand
    type:
      - 'null'
      - boolean
    doc: "Is the probe targeting the plus strand? Note: Entrez downloads will download
      the gene 5'-3'. Specifying the strand is therefore not required."
    inputBinding:
      position: 101
      prefix: --is-plus-strand
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Length of k-mer used to filter probe sequences.
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: max_deltag
    type:
      - 'null'
      - float
    doc: 'Maximum predicted deltaG in kcal/mol. Note: deltaGs range from 0 (no secondary
      structures) to increasingly negative values!'
    inputBinding:
      position: 101
      prefix: --max-deltag
  - id: max_expression_percentage
    type:
      - 'null'
      - float
    doc: Remove any off-target genes expressed more highly than 
      `max-expression-percentage` percentage of all genes. Genes to remove are 
      based on ENCODE RNAseq count table provided in `encode-count-table`. Only 
      used if `encode-count-table` and `reference-annotation` are provided.
    inputBinding:
      position: 101
      prefix: --max-expression-percentage
  - id: max_gc
    type:
      - 'null'
      - float
    doc: Maximum GC content in percentage.
    inputBinding:
      position: 101
      prefix: --max-gc
  - id: max_kmers
    type:
      - 'null'
      - int
    doc: Highest count of sub-k-mers found in reference genome.
    inputBinding:
      position: 101
      prefix: --max-kmers
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum probe length in nucleotides.
    inputBinding:
      position: 101
      prefix: --max-length
  - id: max_off_targets
    type:
      - 'null'
      - int
    doc: Maximum number of off-targets binding anywhere BUT the gene of interest
      in the genome.
    inputBinding:
      position: 101
      prefix: --max-off-targets
  - id: max_tm
    type:
      - 'null'
      - float
    doc: Maximum melting temperature in degrees C (see minimum).
    inputBinding:
      position: 101
      prefix: --max-tm
  - id: min_gc
    type:
      - 'null'
      - float
    doc: Minimum GC content in percentage.
    inputBinding:
      position: 101
      prefix: --min-gc
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum probe length in nucleotides.
    inputBinding:
      position: 101
      prefix: --min-length
  - id: min_tm
    type:
      - 'null'
      - float
    doc: Minimum melting temperature in degrees C. Formamide and Na 
      concentration will affect melting temperature!
    inputBinding:
      position: 101
      prefix: --min-tm
  - id: na_concentration
    type:
      - 'null'
      - float
    doc: Na concentration in mM.
    inputBinding:
      position: 101
      prefix: --na-concentration
  - id: optimization_method
    type:
      - 'null'
      - string
    doc: Optimization method to use. Greedy will procedurally select the next 
      longest probe. Optimal will optimize probes for maximum gene coverage - 
      slow if many overlaps are present (typically with non-stringent parameter 
      settings).
    inputBinding:
      position: 101
      prefix: --optimization-method
  - id: optimization_time_limit
    type:
      - 'null'
      - int
    doc: Time limit for optimization in seconds. Only used if optimization 
      method is set to 'optimal'.
    inputBinding:
      position: 101
      prefix: --optimization-time-limit
  - id: organism_name
    type:
      - 'null'
      - string
    doc: Latin name of the organism. Can be passed together with `ensembl_id` to
      narrow search.
    inputBinding:
      position: 101
      prefix: --organism-name
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory. If not specified, will use the current 
      directory.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: reference_annotation
    type:
      - 'null'
      - File
    doc: Path to reference genome annotation (gene transfer format / gtf) file.
    inputBinding:
      position: 101
      prefix: --reference-annotation
  - id: reference_genome
    type: File
    doc: Path to reference genome fasta/fa file.
    inputBinding:
      position: 101
      prefix: --reference-genome
  - id: save_intermediates
    type:
      - 'null'
      - boolean
    doc: Save intermediate files?
    inputBinding:
      position: 101
      prefix: --save-intermediates
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: Path to the gene's sequence file. Use this if the sequence can't be 
      easily downloaded or if only certain regions should be targeted.
    inputBinding:
      position: 101
      prefix: --sequence-file
  - id: sequence_similarity
    type:
      - 'null'
      - float
    doc: Maximum percentage probes can be similar. Applied to their complements 
      and reverse complements only. Ensures probes don't falsely bind to 
      eachother. Setting any value above 0 could add multiple minute of runtime!
      The lower the value (above 0) the fewer potential probes.
    inputBinding:
      position: 101
      prefix: --sequence-similarity
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Change the program output to silent hiding information on progress.
    inputBinding:
      position: 101
      prefix: --silent
  - id: spacing
    type:
      - 'null'
      - int
    doc: Minimum distance in nucleotides between probes.
    inputBinding:
      position: 101
      prefix: --spacing
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to launch.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/efishent:0.0.5--pyhdfd78af_0
stdout: efishent.out
