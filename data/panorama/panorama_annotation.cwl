cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama annotation
label: panorama_annotation
doc: "Perform annotation of pangenomes using various sources like tables or HMM profiles.\n\
  \nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    default: false
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: hmm
    type:
      - 'null'
      - File
    doc: 'A tab-separated file with HMM information and path.Note: Use panorama utils
      --hmm to create the HMM list file'
    inputBinding:
      position: 101
      prefix: --hmm
  - id: k_best_hit
    type:
      - 'null'
      - int
    doc: Keep the k best annotation hit per gene family.If not specified, all 
      hit will be kept.
    inputBinding:
      position: 101
      prefix: --k_best_hit
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep the temporary files. Useful for debugging in sensitive or profile 
      mode.
    default: false
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    default: stdout
    inputBinding:
      position: 101
      prefix: --log
  - id: mode
    type:
      - 'null'
      - string
    doc: Choose the mode use to align HMM database and gene families. Fast will 
      align the reference sequence of gene family against HMM.Profile will 
      create an HMM profile for each gene family and this profile will be 
      aligned.Sensitive will align HMM to all genes in families.
    default: None
    inputBinding:
      position: 101
      prefix: --mode
  - id: msa
    type:
      - 'null'
      - File
    doc: To create a HMM profile for families, you can give a msa of each gene 
      in families.This msa could be gotten from ppanggolin (See ppanggolin msa).
      If no msa provide Panorama will launch one.
    inputBinding:
      position: 101
      prefix: --msa
  - id: only_best_hit
    type:
      - 'null'
      - boolean
    doc: alias to keep only the best hit for each gene family.
    default: false
    inputBinding:
      position: 101
      prefix: --only_best_hit
  - id: pangenomes
    type: File
    doc: A list of pangenome.h5 files in .tsv file
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: save_hits
    type:
      - 'null'
      - type: array
        items: string
    doc: Save HMM alignment results in tabular format. Option are the same than 
      in HMMSearch.
    inputBinding:
      position: 101
      prefix: --save_hits
  - id: source
    type: string
    doc: Name of the annotation source.
    inputBinding:
      position: 101
      prefix: --source
  - id: table
    type:
      - 'null'
      - File
    doc: A list of tab-separated file, containing annotation of gene 
      families.Expected format is pangenome name in first column and path to the
      TSV with annotation in second column.
    inputBinding:
      position: 101
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Path to temporary directory, defaults path is /tmp/panorama
    default: /tmp/panorama
    inputBinding:
      position: 101
      prefix: --tmp
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    default: 1
    inputBinding:
      position: 101
      prefix: --verbose
  - id: z
    type:
      - 'null'
      - int
    doc: 'From HMMER: Assert that the total number of targets in your searches is
      <x>, for the purposes of per-sequence E-value calculations, rather than the
      actual number of targets seen.'
    inputBinding:
      position: 101
      prefix: --Z
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory to write HMM results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
