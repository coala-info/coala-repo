cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PanACoTA
  - corepers
label: panacota_corepers
doc: "Compute a core or persistent genome of your dataset from a pan-genome file.

Tool homepage: https://github.com/gem-pasteur/PanACoTA"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.pangenome)
        writable: true
inputs:
  - id: pangenome
    type: File
    doc: "Pan-genome file (one line per family, first column is the family number)."
    inputBinding:
      prefix: -p
  - id: outputdir
    type: string
    doc: "Output directory for the core/persistent genome."
    inputBinding:
      prefix: -o
  - id: tol
    type:
      - 'null'
      - float
    doc: "Minimum fraction of genomes with at least one member in a family to call it persistent (0 to 1, default 1 = core genome)."
    inputBinding:
      prefix: --tol
  - id: multi
    type:
      - 'null'
      - boolean
    doc: "Allow several members in any genome of a family."
    inputBinding:
      prefix: -M
  - id: mixed
    type:
      - 'null'
      - boolean
    doc: "Allow families with several members only in '1-tol' of the genomes. Not compatible with multi."
    inputBinding:
      prefix: -X
  - id: floor
    type:
      - 'null'
      - boolean
    doc: "Use floor(tol*N) instead of ceil(tol*N) as the minimum number of genomes."
    inputBinding:
      prefix: -F
  - id: lstinfo_file
    type:
      - 'null'
      - File
    doc: "File with a subset of genomes (first column is the genome name)."
    inputBinding:
      prefix: -l
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
    doc: "Output directory with the core or persistent genome file."
    outputBinding:
      glob: $(inputs.outputdir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
stdout: panacota_corepers.out
