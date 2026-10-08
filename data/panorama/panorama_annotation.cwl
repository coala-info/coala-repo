cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - annotation
label: panorama_annotation
doc: "Annotate pangenome gene families with HMM profiles or annotation tables; the\
  \ annotation is written into the pangenome .h5 files.\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
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
  - id: hmm_files
    type:
      - 'null'
      - type: array
        items: File
    doc: HMM files named in the HMM list file. They are staged in the working directory,
      so the list must name them by file name.
  - id: k_best_hit
    type:
      - 'null'
      - int
    doc: Keep the k best annotation hit per gene family.If not specified, all hit
      will be kept.
    inputBinding:
      position: 101
      prefix: --k_best_hit
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep the temporary files. Useful for debugging in sensitive or profile mode.
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - string
    doc: Log output file name
    inputBinding:
      position: 101
      prefix: --log
  - id: mode
    type:
      - 'null'
      - string
    doc: Choose the mode use to align HMM database and gene families. Fast will align
      the reference sequence of gene family against HMM.Profile will create an HMM
      profile for each gene family and this profile will be aligned.Sensitive will
      align HMM to all genes in families.
    inputBinding:
      position: 101
      prefix: --mode
  - id: msa
    type:
      - 'null'
      - File
    doc: To create a HMM profile for families, you can give a msa of each gene in
      families.This msa could be gotten from ppanggolin (See ppanggolin msa). If no
      msa provide Panorama will launch one.
    inputBinding:
      position: 101
      prefix: --msa
  - id: only_best_hit
    type:
      - 'null'
      - boolean
    doc: alias to keep only the best hit for each gene family.
    inputBinding:
      position: 101
      prefix: --only_best_hit
  - id: pangenomes
    type: File
    doc: A list of pangenome.h5 files in .tsv file
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: pangenome_files
    type:
      type: array
      items: File
    doc: Pangenome .h5 files named in the pangenomes list. They are staged in the
      working directory, so the list must name them by file name (second column).
  - id: save_hits
    type:
      - 'null'
      - type: array
        items: string
    doc: Save HMM alignment results in tabular format. Option are the same than in
      HMMSearch.
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
    doc: A list of tab-separated file, containing annotation of gene families.Expected
      format is pangenome name in first column and path to the TSV with annotation
      in second column.
    inputBinding:
      position: 101
      prefix: --table
  - id: table_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Annotation TSV files named in the --table list. They are staged in the working
      directory, so the list must name them by file name.
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - string
    doc: Path to temporary directory, defaults path is /tmp/panorama
    inputBinding:
      position: 101
      prefix: --tmp
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 for
      debug)
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
  - id: output_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --output
    doc: Output directory to write HMM results
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory to write HMM results
    outputBinding:
      glob: $(inputs.output_path)
  - id: pangenomes_out
    type:
      type: array
      items: File
    doc: Pangenome .h5 files with the new annotation source
    outputBinding:
      glob: $(inputs.pangenome_files.map(function(f){ return f.basename; }))
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file (with log)
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.pangenome_files)
        writable: true
      - $(inputs.hmm_files)
      - $(inputs.table_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
