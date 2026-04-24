cwlVersion: v1.2
class: CommandLineTool
baseCommand: hint tl
label: hint_tl
doc: "interchromosomal translocations and breakpoints detection from Hi-C inter-chromosomal
  interaction matrices.\n\nTool homepage: https://github.com/suwangbio/HiNT_py3"
inputs:
  - id: background_dir
    type: Directory
    doc: Path to the directory of backgroundInterchromMatrixDir, can be 
      downloaded from 
      https://www.dropbox.com/sh/2ufsyu4wvrboxxp/AABk5-_Fwy7jdM_t0vIsgYf4a?dl=0.,
      named as backgroundMatrices, e,g. path_to_/backgroundMatrices/genome
    inputBinding:
      position: 101
      prefix: --backdir
  - id: chimeric
    type:
      - 'null'
      - File
    doc: Chimeric read pairs with .pairsam format. If no chimeric reads 
      provided, breakpoints in 100kb resolution will be output only
    inputBinding:
      position: 101
      prefix: --chimeric
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Cutoff of the rank product for chromosomal pairs to select candidate 
      translocated chromosomal pairs, default = 0.05
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: enzyme
    type:
      - 'null'
      - string
    doc: 'Enzyme used in Hi-C experiment, DEFAULT: MboI'
    inputBinding:
      position: 101
      prefix: --enzyme
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format for the output contact matrix, DEFAULT: cooler'
    inputBinding:
      position: 101
      prefix: --format
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Specify your species, choose form hg38, hg19, and mm10. DEFAULT: hg19'
    inputBinding:
      position: 101
      prefix: --genome
  - id: matrixfile
    type: File
    doc: The matrix compressed file contains 1Mb and 100kb resolutions Hi-C 
      contact matrix (.hic format), or 1Mb and 100kb resolution files seperate 
      with ',', like /path/to/data_1Mb.cool,/path/to/data_100kb.cool or the 
      directory that contain Hi-C interaction matrix in sparse or dense matrix 
      format, interchromosomal interaction matrices only. Absolute path is 
      required
    inputBinding:
      position: 101
      prefix: --matrixfile
  - id: name
    type:
      - 'null'
      - string
    doc: Prefix for the result files. If not set, 'NA' will be used instead
    inputBinding:
      position: 101
      prefix: --name
  - id: pairix_path
    type: string
    doc: Path for pairix, use 'which pairix' to get the path
    inputBinding:
      position: 101
      prefix: --ppath
  - id: refdir
    type: Directory
    doc: the reference directory that downloaded from dropbox dropbox. 
      (https://www.dropbox.com/sh/2ufsyu4wvrboxxp/AABk5-_Fwy7jdM_t0vIsgYf4a?dl=0.)
    inputBinding:
      position: 101
      prefix: --refdir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for running HiNT-tl translocation breakpoints detection
      part, DEFAULT: 16'
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory, where you want to store all the output 
      files, if not set, the current directory will be used
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hint:2.2.8--py_1
