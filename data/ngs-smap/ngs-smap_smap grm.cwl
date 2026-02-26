cwlVersion: v1.2
class: CommandLineTool
baseCommand: smap
label: ngs-smap_smap grm
doc: "Convert the haplotype table from SMAP haplotype-sites or SMAP haplotype-windows
  into a genetic similarity/distance matrix and/or a locus information matrix.\n\n\
  Tool homepage: https://gitlab.com/truttink/smap"
inputs:
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Create a clustered matrix. The order provided in the samples file is 
      ignored.
    inputBinding:
      position: 101
      prefix: --cluster
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: distance
    type:
      - 'null'
      - string
    doc: Convert genetic similarity estimates into genetic distances (default = 
      no conversion to distances). Type 'd' for normal distance and 'i' for 
      inversed distance
    default: no conversion to distances
    inputBinding:
      position: 101
      prefix: --distance
  - id: excel
    type:
      - 'null'
      - boolean
    doc: Write the GRM output to excel
    inputBinding:
      position: 101
      prefix: --excel
  - id: informative_loci
    type:
      - 'null'
      - boolean
    doc: Print locus information to the output directory.
    inputBinding:
      position: 101
      prefix: --informative_loci
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: Input directory containing the haplotypes table, the --samples text 
      file, and/or the --loci text file
    default: current directory
    inputBinding:
      position: 101
      prefix: --input_directory
  - id: loci
    type:
      - 'null'
      - File
    doc: Name of a tab-delimited text file in the input directory containing a 
      one-column list of locus IDs formatted as in the haplotypes table (default
      = no list provided).
    inputBinding:
      position: 101
      prefix: --loci
  - id: locus_completeness
    type:
      - 'null'
      - float
    doc: Minimum proportion of samples with haplotype data in a locus. Loci with
      less data are removed (default = all loci are included).
    inputBinding:
      position: 101
      prefix: --locus_completeness
  - id: mask
    type:
      - 'null'
      - string
    doc: 'Mask values on the main diagonal of each matrix and above (upper) or below
      (lower) the main diagonal (default = Lower, other options are: upper (mask upper
      half) and None (No masking).'
    default: Lower
    inputBinding:
      position: 101
      prefix: --mask
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory (default = current directory).
    default: current directory
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: plot_format
    type:
      - 'null'
      - string
    doc: File format of plots (default = pdf, other options are png, svg, jpg, 
      jpeg, tif, and tiff).
    default: pdf
    inputBinding:
      position: 101
      prefix: --plot_format
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix added to all output file names (default = no prefix added).
    inputBinding:
      position: 101
      prefix: --prefix
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes used by the script (default = 1).
    default: 1
    inputBinding:
      position: 101
      prefix: --processes
  - id: sample_completeness
    type:
      - 'null'
      - int
    doc: Minimum number of loci with haplotype data in a sample. Samples with 
      less data are removed (default = all samples are included).
    inputBinding:
      position: 101
      prefix: --sample_completeness
  - id: samples
    type:
      - 'null'
      - File
    doc: 'Name of a tab-delimited text file in the input directory defining the order
      of the (new) sample IDs in the matrix: first column = old IDs, second column
      (optional) = new IDs (default = no list provided, the order of sample IDs in
      the matrix equals their order in the haplotypes table).'
    inputBinding:
      position: 101
      prefix: --samples
  - id: table
    type: File
    doc: Name of the haplotypes table retrieved from SMAP haplotype-sites or 
      SMAP haplotype-windows in the input directory.
    inputBinding:
      position: 101
      prefix: --table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
stdout: ngs-smap_smap grm.out
