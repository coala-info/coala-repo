cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PanACoTA
  - annotate
label: panacota_annotate
doc: "Quality control and annotation of genomes with prokka or prodigal, and formatting of the results (Genes, Proteins, Replicons and LSTINFO folders).

Tool homepage: https://github.com/gem-pasteur/PanACoTA"
inputs:
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: "Folder containing all multi-fasta genome files."
    inputBinding:
      prefix: -d
  - id: res_path
    type: string
    doc: "Folder where the annotated genomes are saved."
    inputBinding:
      prefix: -r
  - id: list_file
    type:
      - 'null'
      - File
    doc: "File with the genome file names to annotate (one per line). A line can be 'genome_name :: name.date'."
    inputBinding:
      prefix: -l
  - id: name
    type:
      - 'null'
      - string
    doc: "Name for the annotated genomes: 4 alphanumeric characters (for example ESCO)."
    inputBinding:
      prefix: -n
  - id: qc_only
    type:
      - 'null'
      - boolean
    doc: "Only do the quality control (cut at N, L90, number of contigs) and plot the distributions."
    inputBinding:
      prefix: -Q
  - id: from_info
    type:
      - 'null'
      - File
    doc: "Info file from the 'prepare' module with columns 'to_annotate', 'gsize', 'nb_conts' and 'L90'. Go directly to annotation."
    inputBinding:
      prefix: --info
  - id: prodigal
    type:
      - 'null'
      - boolean
    doc: "Only syntactical annotation with prodigal, not functional annotation with prokka."
    inputBinding:
      prefix: --prodigal
  - id: small
    type:
      - 'null'
      - boolean
    doc: "With prodigal: use the 'meta' procedure for sequences shorter than 20000 characters."
    inputBinding:
      prefix: --small
  - id: l90
    type:
      - 'null'
      - int
    doc: "Maximum L90 allowed to keep a genome (default 100)."
    inputBinding:
      prefix: --l90
  - id: nbcont
    type:
      - 'null'
      - int
    doc: "Maximum number of contigs allowed to keep a genome (default 999)."
    inputBinding:
      prefix: --nbcont
  - id: cutn
    type:
      - 'null'
      - int
    doc: "Cut genomes into new contigs at this number of 'N' in a row (default 5; 0 for no cutting)."
    inputBinding:
      prefix: --cutn
  - id: date
    type:
      - 'null'
      - string
    doc: "Date (MMYY, 4 characters) given to the annotated genomes (default: today)."
    inputBinding:
      prefix: --date
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Folder for temporary files (default: res_path/tmp_files)."
    inputBinding:
      prefix: --tmp
  - id: annot_dir
    type:
      - 'null'
      - string
    doc: "Folder for the prokka/prodigal output (default: the temporary folder)."
    inputBinding:
      prefix: --annot_dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force run: override existing results."
    inputBinding:
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 1)."
    inputBinding:
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity in stdout/stderr and log files."
    inputBinding:
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not display anything to stdout/stderr. Log files are still created."
    inputBinding:
      prefix: --quiet
outputs:
  - id: res_dir
    type:
      - 'null'
      - Directory
    doc: "Result directory with Genes, Proteins, Replicons, LSTINFO and the LSTINFO list file."
    outputBinding:
      glob: $(inputs.res_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota_annotate.out
