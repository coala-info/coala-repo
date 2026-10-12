cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PanACoTA
  - align
label: panacota_align
doc: "Align core or persistent families: align proteins with mafft, back-translate to nucleotides and concatenate by genome.

Tool homepage: https://github.com/gem-pasteur/PanACoTA"
inputs:
  - id: corepers
    type: File
    doc: "Core or persistent genome whose families are aligned."
    inputBinding:
      prefix: -c
  - id: list_genomes
    type: File
    doc: "File with the genomes to align (first column is the genome name), for example the LSTINFO file of the annotate module."
    inputBinding:
      prefix: -l
  - id: dataset_name
    type: string
    doc: "Name of the dataset. Used to name the alignment file."
    inputBinding:
      prefix: -n
  - id: dbpath
    type: Directory
    doc: "Folder with the 'Proteins' and 'Genes' folders created by the annotate module."
    inputBinding:
      prefix: -d
  - id: outdir
    type: string
    doc: "Output directory, where all results are saved."
    inputBinding:
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 1). Use 0 for all threads."
    inputBinding:
      prefix: --threads
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Redo all alignments, even if the result files already exist."
    inputBinding:
      prefix: --force
  - id: prot_aln
    type:
      - 'null'
      - boolean
    doc: "Also write the protein alignment of the concatenated persistent proteins."
    inputBinding:
      prefix: -P
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
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the family alignments and the concatenated alignment file."
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota_align.out
