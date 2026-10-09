cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - statistics
label: hicberg_statistics
doc: 'Extract statistics from non ambiguous Hi-C data.


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: genome
    type: File
    doc: Genome FASTA file.
    inputBinding:
      position: 1
  - id: output_folder
    type: Directory
    doc: Result folder created by hicberg create-folder (and filled by the earlier
      stages). It is staged writable; the stage adds its files to it.
    inputBinding:
      position: 100
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
  - id: mode
    type:
      - 'null'
      - string
    doc: Statistical model to use for ambiguous reads assignment. Modes full and density
      need a density map and fail in this version.
    inputBinding:
      position: 104
      prefix: --mode
  - id: kernel_size
    type:
      - 'null'
      - int
    doc: Size of the gaussian kernel for contact density estimation.
    inputBinding:
      position: 104
      prefix: --kernel-size
  - id: deviation
    type:
      - 'null'
      - float
    doc: Standard deviation for contact density estimation.
    inputBinding:
      position: 104
      prefix: --deviation
  - id: rate
    type:
      - 'null'
      - float
    doc: Rate to use for sub-sampling restriction map.
    inputBinding:
      position: 104
      prefix: --rate
  - id: enzyme
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --enzyme
    doc: Enzymes to use for genome digestion (restriction enzyme names such as DpnII,
      or a number for Micro-C fragment size). Give one or more.
    inputBinding:
      position: 104
  - id: circular
    type:
      - 'null'
      - string
    doc: Name of the chromosome to consider as circular.
    inputBinding:
      position: 104
      prefix: --circular
  - id: bins
    type:
      - 'null'
      - int
    doc: Genomic resolution.
    inputBinding:
      position: 104
      prefix: --bins
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    inputBinding:
      position: 104
      prefix: --cpus
  - id: blacklist
    type:
      - 'null'
      - string
    doc: Blacklisted coordinates to exclude reads for statistical learning, as a comma
      separated list in UCSC format (chr:start-end). For a bed file use blacklist_bed.
    inputBinding:
      position: 104
      prefix: --blacklist
  - id: blacklist_bed
    type:
      - 'null'
      - File
    doc: Blacklisted coordinates as a bed file.
    inputBinding:
      position: 104
      prefix: --blacklist
outputs:
  - id: output_folder_out
    type: Directory
    doc: The same result folder with the files this stage wrote.
    outputBinding:
      glob: $(inputs.output_folder.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
