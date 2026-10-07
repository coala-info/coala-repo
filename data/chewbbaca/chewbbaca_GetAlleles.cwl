cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - GetAlleles
label: chewbbaca_GetAlleles
doc: "Create FASTA files containing the alleles identified by the AlleleCall module.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: input_file
    type: File
    doc: "Path to the TSV file containing the allelic profiles."
    inputBinding:
      position: 1
      prefix: --input-file
  - id: schema_directory
    type: Directory
    doc: "Path to the schema directory."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: genes_list
    type:
      - 'null'
      - File
    doc: "Path to a file with the list of genes/loci to create FASTA files for (loci identifiers without the .fasta extension, one per line)."
    inputBinding:
      position: 1
      prefix: --genes-list
  - id: output_directory
    type: string
    doc: "Path to the output directory."
    default: "alleles_out"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: distinct
    type:
      - 'null'
      - boolean
    doc: "Only get distinct alleles."
    inputBinding:
      position: 1
      prefix: --distinct
  - id: translate
    type:
      - 'null'
      - boolean
    doc: "Create FASTA files with the translated alleles."
    inputBinding:
      position: 1
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Genetic code used to translate coding DNA sequences (CDSs). Default: value in the schema config file, else 11."
    inputBinding:
      position: 1
      prefix: --translation-table
outputs:
  - id: results_dir
    type: Directory
    doc: "Directory with one FASTA file per locus."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
