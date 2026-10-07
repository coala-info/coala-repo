cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - UniprotFinder
label: chewbbaca_UniprotFinder
doc: "Retrieve annotations for loci in a schema.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: schema_directory
    type: Directory
    doc: "Path to the schema's directory."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: output_directory
    type: string
    doc: "Path to the output directory where the process will store intermediate files and save the final TSV file with the loci annotations."
    default: "uniprot_out"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: genes_list
    type:
      - 'null'
      - File
    doc: "Path to a file with the list of loci in the schema that the process should find annotations for (one per line, full paths or loci IDs)."
    inputBinding:
      position: 1
      prefix: --genes-list
  - id: protein_table
    type:
      - 'null'
      - File
    doc: "Path to the TSV file with coding sequence (CDS) coordinate data, \"cds_coordinates.tsv\", created by the CreateSchema process."
    inputBinding:
      position: 1
      prefix: --protein-table
  - id: bsr
    type:
      - 'null'
      - float
    doc: "BLAST Score Ratio value, used only when taxa names are provided to --taxa. (default: 0.6)"
    inputBinding:
      position: 1
      prefix: --bsr
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of scientific names for a set of taxa. The process downloads reference proteomes from UniProt for these taxa."
    inputBinding:
      position: 1
      prefix: --taxa
  - id: pm
    type:
      - 'null'
      - int
    doc: "Maximum number of proteome matches to report. (default: 1)"
    inputBinding:
      position: 1
      prefix: --pm
  - id: no_sparql
    type:
      - 'null'
      - boolean
    doc: "Do not search for annotations through the UniProt SPARQL endpoint."
    inputBinding:
      position: 1
      prefix: --no-sparql
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "If provided, intermediate files generated during process execution are not removed at the end."
    inputBinding:
      position: 1
      prefix: --no-cleanup
  - id: blast_path
    type:
      - 'null'
      - Directory
    doc: "Path to the directory that contains the BLAST executables."
    inputBinding:
      position: 1
      prefix: --blast-path
outputs:
  - id: results_dir
    type: Directory
    doc: "Directory with the loci annotations TSV file."
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
