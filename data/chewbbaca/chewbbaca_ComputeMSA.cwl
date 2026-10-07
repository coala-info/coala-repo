cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - ComputeMSA
label: chewbbaca_ComputeMSA
doc: "Compute a Multiple Sequence Alignment based on allele calling results.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: input_path
    type:
      - File
      - Directory
    doc: "Path to a TSV file containing allelic profiles or to a folder containing FASTA files."
    inputBinding:
      position: 1
      prefix: --input-path
  - id: output_directory
    type: string
    doc: "Path to the output directory where the process will store intermediate and final results."
    default: "msa_out"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: schema_directory
    type:
      - 'null'
      - Directory
    doc: "Path to the schema's directory. Required only if the input is a TSV file with allelic profiles."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: dna_msa
    type:
      - 'null'
      - boolean
    doc: "Converts the protein MSA back to DNA to create an additional output file with the DNA MSA."
    inputBinding:
      position: 1
      prefix: --dna-msa
  - id: output_variable
    type:
      - 'null'
      - boolean
    doc: "Output a reduced MSA including only the variable positions."
    inputBinding:
      position: 1
      prefix: --output-variable
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Genetic code used for sequence translation. (default: 11)"
    inputBinding:
      position: 1
      prefix: --translation-table
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: only_loci_msas
    type:
      - 'null'
      - boolean
    doc: "Do not compute the full MSA when the input file is a TSV file containing allelic profiles."
    inputBinding:
      position: 1
      prefix: --only-loci-msas
  - id: gaps
    type:
      - 'null'
      - string
    doc: "How to treat gaps when determining the reduced MSA for the variable positions (\"exclude\" or \"ignore\"). (default: exclude)"
    inputBinding:
      position: 1
      prefix: --gaps
  - id: ambiguous
    type:
      - 'null'
      - string
    doc: "How to treat ambiguous amino acids or nucleotides when determining the reduced MSA (\"exclude\" or \"ignore\"). (default: exclude)"
    inputBinding:
      position: 1
      prefix: --ambiguous
  - id: custom_mafft_params
    type:
      - 'null'
      - string
    doc: "Custom parameters to pass to MAFFT when computing the loci MSAs, as a single string (e.g. \"--retree 1 --maxiterate 0\")."
    inputBinding:
      position: 1
      prefix: --custom-mafft-params
  - id: protein_input
    type:
      - 'null'
      - boolean
    doc: "Input files contain protein sequences (only valid when the input is a directory with FASTA files)."
    inputBinding:
      position: 1
      prefix: --protein-input
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "Keep intermediate files with locus/file MSAs and sample MSAs."
    inputBinding:
      position: 1
      prefix: --no-cleanup
outputs:
  - id: results_dir
    type: Directory
    doc: "MSA results directory."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
