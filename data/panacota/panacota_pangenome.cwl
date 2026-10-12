cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PanACoTA
  - pangenome
label: panacota_pangenome
doc: "Generate a pan-genome of your dataset: cluster all proteins with MMseqs2 and write one line per protein family.

Tool homepage: https://github.com/gem-pasteur/PanACoTA"
requirements:
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbpath)
        writable: true
arguments:
  - position: 1000
    shellQuote: false
    valueFrom: "&& find $(inputs.outdir) -type l -delete"
inputs:
  - id: lstinfo_file
    type: File
    doc: "File with the genomes to include (first column 'gembase_name'), for example the LSTINFO file of the annotate module."
    inputBinding:
      prefix: -l
  - id: dataset_name
    type: string
    doc: "Name of the dataset (for example SAEN1234). Used to name the protein databank and the pan-genome files."
    inputBinding:
      prefix: -n
  - id: dbpath
    type: Directory
    doc: "Folder with the protein files of all genomes (the 'Proteins' folder of the annotate module)."
    inputBinding:
      prefix: -d
  - id: outdir
    type: string
    doc: "Output directory, where all results are saved (including the tmp folder)."
    inputBinding:
      prefix: -o
  - id: min_id
    type:
      - 'null'
      - float
    doc: "Minimum sequence identity to be in the same cluster (0 to 1, default 0.8)."
    inputBinding:
      prefix: -i
  - id: outfile
    type:
      - 'null'
      - string
    doc: "Name of the pan-genome output file, without path."
    inputBinding:
      prefix: -f
  - id: clust_mode
    type:
      - 'null'
      - int
    doc: "Clustering mode: 0 'set cover', 1 'single-linkage' (default), 2 'CD-Hit'."
    inputBinding:
      prefix: -c
  - id: spedir
    type:
      - 'null'
      - string
    doc: "Folder where the concatenated protein databank is saved (default: the protein folder)."
    inputBinding:
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 1). Use 0 for all threads."
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
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the PanGenome file and the protein databank."
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota_pangenome.out
