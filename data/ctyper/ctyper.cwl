cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctyper
label: ctyper
doc: "A tool for genotyping and estimating NGS read depth using a matrix database.\n\
  \ \nTool homepage: https://github.com/ChaissonLab/Ctyper"
inputs:
  - id: background
    type:
      - 'null'
      - File
    doc: Background k-mer file to estimate NGS coverage (incompatible with 
      -d/-D).
    inputBinding:
      position: 101
      prefix: --background
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file to restrict region analysis.
    inputBinding:
      position: 101
      prefix: -B
  - id: corr
    type:
      - 'null'
      - int
    doc: Enable NGS k-mer bias correction (0/1).
    inputBinding:
      position: 101
      prefix: --corr
  - id: depth
    type:
      - 'null'
      - float
    doc: Fixed 31-mer depth value (incompatible with -b/--background).
    inputBinding:
      position: 101
      prefix: --depth
  - id: depth_file
    type:
      - 'null'
      - File
    doc: File of depth values corresponding to each input (incompatible with 
      -b/--background).
    inputBinding:
      position: 101
      prefix: --Depth
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --gene
          separate: true
    doc: Target gene name, prefix (ending with '*'), or matrix (starting with 
      '#'). Can be specified multiple times.
    inputBinding:
      position: 101
  - id: genes_file
    type:
      - 'null'
      - File
    doc: File listing target genes or matrices.
    inputBinding:
      position: 101
      prefix: --Genes
  - id: input
    type:
      - 'null'
      - File
    doc: Input NGS file; supports CRAM, BAM, SAM, FASTA, FASTQ, or Jellyfish 
      formats.
    inputBinding:
      position: 101
      prefix: --input
  - id: inputs_list
    type:
      - 'null'
      - File
    doc: Path to a file listing multiple input files.
    inputBinding:
      position: 101
      prefix: --Inputs
  - id: listed_input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files named in the --Inputs and --Profile list files; staged in 
      the working directory so their names resolve.
  - id: matrix
    type: File
    doc: Path to the matrix database (requires <file>.index). If not provided, 
      the tool runs in dry-run mode to only estimate NGS read depth.
    secondaryFiles:
      - .index
      - pattern: .bgd
        required: false
    inputBinding:
      position: 101
      prefix: --matrix
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads to run different samples in parallel.
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: profile
    type:
      - 'null'
      - File
    doc: Input aligned NGS file for profiling.
    inputBinding:
      position: 101
      prefix: --profile
  - id: profile_list
    type:
      - 'null'
      - File
    doc: File listing multiple aligned NGS files for profiling.
    inputBinding:
      position: 101
      prefix: --Profile
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for reading CRAM files.
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: -T
  - id: region
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -r
    doc: Add a specific region for analysis (chr:start-end) or special keys 
      ('gene', 'Unmap', 'HLA').
    inputBinding:
      position: 101
  - id: subthreads
    type:
      - 'null'
      - int
    doc: Number of threads to run each sample.
    inputBinding:
      position: 101
      prefix: --subthreads
  - id: unmap
    type:
      - 'null'
      - int
    doc: Force include:1 or exclude:0 unmapped reads (only valid in target run).
    inputBinding:
      position: 101
      prefix: --unmap
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for k-mer coverage report.
    inputBinding:
      position: 101
      prefix: --window
  - id: outputs_list_file
    type:
      - 'null'
      - File
    doc: Path to a file listing output files corresponding to each input file 
      (relative names are written to the output directory).
    loadContents: true
    inputBinding:
      position: 103
      prefix: --Outputs
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Output file (append if file exits, default: stdout)'
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output file (append if file exits, default: stdout)'
    outputBinding:
      glob: $(inputs.output_path)
  - id: listed_outputs
    type: File[]
    doc: Output files named in the --Outputs list file.
    outputBinding:
      glob: |-
        ${
          if (!inputs.outputs_list_file) return [];
          return inputs.outputs_list_file.contents.split("\n")
            .map(function(x) { return x.trim(); })
            .filter(function(x) { return x.length > 0; })
            .map(function(x) { return x.split("/").pop(); });
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.listed_input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctyper:1.0.5--h5ca1c30_0
