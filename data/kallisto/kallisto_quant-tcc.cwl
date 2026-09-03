cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kallisto
  - quant-tcc
label: kallisto_quant-tcc
doc: Quantifies abundance from pre-computed transcript-compatibility counts
inputs:
  - id: tcc_file
    type: File
    doc: transcript-compatibility-counts-file
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: Directory to write output to
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: index
    type:
      - 'null'
      - File
    doc: Filename for the kallisto index to be used (required if file with names
      of transcripts not supplied)
    inputBinding:
      position: 102
      prefix: --index
  - id: txnames
    type:
      - 'null'
      - File
    doc: File with names of transcripts (required if index file not supplied)
    inputBinding:
      position: 102
      prefix: --txnames
  - id: ec_file
    type:
      - 'null'
      - File
    doc: 'File containing equivalence classes (default: equivalence classes are taken
      from the index)'
    inputBinding:
      position: 102
      prefix: --ec-file
  - id: fragment_file
    type:
      - 'null'
      - File
    doc: 'File containing fragment length distribution (default: effective length
      normalization is not performed)'
    inputBinding:
      position: 102
      prefix: --fragment-file
  - id: long
    type:
      - 'null'
      - boolean
    doc: Use version of EM for long reads
    inputBinding:
      position: 102
      prefix: --long
  - id: platform
    type:
      - 'null'
      - string
    doc: '[PacBio or ONT] used for sequencing'
    inputBinding:
      position: 102
      prefix: --platform
  - id: fragment_length
    type:
      - 'null'
      - float
    doc: Estimated average fragment length
    inputBinding:
      position: 102
      prefix: --fragment-length
  - id: sd
    type:
      - 'null'
      - float
    doc: Estimated standard deviation of fragment length
    inputBinding:
      position: 102
      prefix: --sd
  - id: priors
    type:
      - 'null'
      - boolean
    doc: Priors for the EM algorithm, either as raw counts or as probabilities.
    inputBinding:
      position: 102
      prefix: --priors
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: genemap
    type:
      - 'null'
      - File
    doc: File for mapping transcripts to genes (required for obtaining 
      gene-level abundances)
    inputBinding:
      position: 102
      prefix: --genemap
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file for transcriptome information (can be used instead of 
      --genemap for obtaining gene-level abundances)
    inputBinding:
      position: 102
      prefix: --gtf
  - id: bootstrap_samples
    type:
      - 'null'
      - int
    doc: Number of bootstrap samples
    inputBinding:
      position: 102
      prefix: --bootstrap-samples
  - id: matrix_to_files
    type:
      - 'null'
      - boolean
    doc: Reorganize matrix output into abundance tsv files
    inputBinding:
      position: 102
      prefix: --matrix-to-files
  - id: matrix_to_directories
    type:
      - 'null'
      - boolean
    doc: Reorganize matrix output into abundance tsv files across multiple 
      directories
    inputBinding:
      position: 102
      prefix: --matrix-to-directories
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the bootstrap sampling
    inputBinding:
      position: 102
      prefix: --seed
  - id: plaintext
    type:
      - 'null'
      - boolean
    doc: Output plaintext only, not HDF5
    inputBinding:
      position: 102
      prefix: --plaintext
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
