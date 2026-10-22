cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SigProfilerMatrixGenerator
  - matrix_generator
label: sigprofilermatrixgenerator_matrix_generator
doc: "Create mutational matrices for all types of somatic mutations (SBS, DBS and
  INDEL). The results are written to the input directory.\n\nTool homepage: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator"
inputs:
  - id: exome
    type:
      - 'null'
      - boolean
    doc: Downsamples mutational matrices to the exome regions of the genome.
    inputBinding:
      position: 1
      prefix: --exome
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Downsamples mutational matrices to custom regions of the genome. A BED
      file header is required.
    inputBinding:
      position: 1
      prefix: --bed_file
  - id: chrom_based
    type:
      - 'null'
      - boolean
    doc: Outputs chromosome-based matrices.
    inputBinding:
      position: 1
      prefix: --chrom_based
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Integrates with SigProfilerPlotting to output visualizations for each
      matrix.
    inputBinding:
      position: 1
      prefix: --plot
  - id: tsb_stat
    type:
      - 'null'
      - boolean
    doc: Outputs the results of a transcriptional strand bias test for the
      respective matrices.
    inputBinding:
      position: 1
      prefix: --tsb_stat
  - id: seq_info
    type:
      - 'null'
      - boolean
    doc: Outputs original mutations into a text file with the
      SigProfilerMatrixGenerator classification for each mutation.
    inputBinding:
      position: 1
      prefix: --seqInfo
  - id: cushion
    type:
      - 'null'
      - int
    doc: Adds an Xbp cushion to the exome/bed_file ranges for downsampling
      mutations. Default is 100.
    inputBinding:
      position: 1
      prefix: --cushion
  - id: volume
    type:
      - 'null'
      - Directory
    doc: Directory with the installed reference genomes (output of the install
      step)
    inputBinding:
      position: 1
      prefix: --volume
  - id: project
    type: string
    doc: The name of the project.
    inputBinding:
      position: 3
  - id: reference_genome
    type: string
    doc: "The name of the reference genome. Supported values {c_elegans, dog, ebv,
      GRCh37, GRCh38, mm9, mm10, mm39, rn6, rn7, yeast}."
    inputBinding:
      position: 4
  - id: path_to_input_files
    type: Directory
    doc: The directory with the input files (VCF, MAF, text or other supported
      formats). Output is written inside it.
    inputBinding:
      position: 5
outputs:
  - id: results
    type: Directory
    doc: Input directory with the output, input and logs sub-directories
    outputBinding:
      glob: $(inputs.path_to_input_files.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.path_to_input_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
stdout: sigprofilermatrixgenerator_matrix_generator.out
