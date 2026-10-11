cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smap
  - grm
label: ngs-smap_smap_grm
doc: "Convert the haplotype table from SMAP haplotype-sites or SMAP haplotype- windows into a genetic similarity/distance matrix and/or a locus information matrix.\n\nTool homepage: https://gitlab.com/truttink/smap"
inputs:
  - id: table
    type: File
    doc: "Name of the haplotypes table retrieved from SMAP haplotype-sites or SMAP haplotype-windows in the input directory."
    inputBinding:
      position: 10
      prefix: --table
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: "Input directory containing the haplotypes table, the --samples text file, and/or the --loci text file (default = current directory)."
    inputBinding:
      position: 10
      prefix: --input_directory
  - id: samples
    type:
      - 'null'
      - File
    doc: "Name of a tab-delimited text file in the input directory defining the order of the (new) sample IDs in the matrix: first column = old IDs, second column (optional) = new IDs (default = no list provided, the order of sample IDs in the matrix equals their order in the haplotypes table)."
    inputBinding:
      position: 10
      prefix: --samples
  - id: loci
    type:
      - 'null'
      - File
    doc: "Name of a tab-delimited text file in the input directory containing a one-column list of locus IDs formatted as in the haplotypes table (default = no list provided)."
    inputBinding:
      position: 10
      prefix: --loci
  - id: locus_completeness
    type:
      - 'null'
      - float
    doc: "Minimum proportion of samples with haplotype data in a locus. Loci with less data are removed (default = all loci are included)."
    inputBinding:
      position: 10
      prefix: --locus_completeness
  - id: sample_completeness
    type:
      - 'null'
      - int
    doc: "Minimum number of loci with haplotype data in a sample. Samples with less data are removed (default = all samples are included)."
    inputBinding:
      position: 10
      prefix: --sample_completeness
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes used by the script (default = 1)."
    inputBinding:
      position: 10
      prefix: --processes
  - id: excel
    type:
      - 'null'
      - boolean
    doc: "Write the GRM output to excel"
    inputBinding:
      position: 10
      prefix: --excel
  - id: distance
    type:
      - 'null'
      - string
    doc: "Convert genetic similarity estimates into genetic distances (default = no conversion to distances). Type 'd' for normal distance and 'i' for inversed distance"
    inputBinding:
      position: 10
      prefix: --distance
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "Output directory (default = current directory)."
    inputBinding:
      position: 10
      prefix: --output_directory
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix added to all output file names (default = no prefix added)."
    inputBinding:
      position: 10
      prefix: --prefix
  - id: informative_loci
    type:
      - 'null'
      - boolean
    doc: "Print locus information to the output directory."
    inputBinding:
      position: 10
      prefix: --informative_loci
  - id: plot_format
    type:
      - 'null'
      - string
    doc: "File format of plots (default = pdf, other options are png, svg, jpg, jpeg, tif, and tiff)."
    inputBinding:
      position: 10
      prefix: --plot_format
  - id: mask
    type:
      - 'null'
      - string
    doc: "Mask values on the main diagonal of each matrix and above (upper) or below (lower) the main diagonal (default = Lower, other options are: upper (mask upper half) and None (No masking)."
    inputBinding:
      position: 10
      prefix: --mask
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: "Create a clustered matrix. The order provided in the samples file is ignored."
    inputBinding:
      position: 10
      prefix: --cluster
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable verbose logging"
    inputBinding:
      position: 10
      prefix: --debug
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Genetic relatedness matrices and plots written by SMAP grm"
    outputBinding:
      glob:
        - "*.tsv"
        - "*.png"
        - "*.pdf"
        - "*.xlsx"
        - "*.txt"
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory given with --output_directory
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
