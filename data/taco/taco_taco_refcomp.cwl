cwlVersion: v1.2
class: CommandLineTool
baseCommand: taco_refcomp
label: taco_taco_refcomp
doc: "Reference comparison tool for taco\n\nTool homepage: https://github.com/tacorna/taco"
inputs:
  - id: cpat
    type:
      - 'null'
      - boolean
    doc: 'Run CPAT tool to for coding potential scoring. (CPAT function currently
      only supports Human, Mouse, and Zebrafish) (WARNING: The CPAT tool can take
      over an hour)'
    inputBinding:
      position: 101
      prefix: --cpat
  - id: cpat_genome
    type:
      - 'null'
      - File
    doc: Provide a genome fasta for the genome used to produce assemblies being 
      compared. Required if "--cpat" used. CPAT uses this to obtain sequence for
      the provided transcripts
    inputBinding:
      position: 101
      prefix: --cpat-genome
  - id: cpat_species
    type:
      - 'null'
      - string
    doc: 'Select either: human, mouse, zebrafish'
    inputBinding:
      position: 101
      prefix: --cpat-species
  - id: num_cores
    type:
      - 'null'
      - int
    doc: 'Run tool in parallel with N processes. (note: each core processes 1 chromosome)'
    inputBinding:
      position: 101
      prefix: --num-processes
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory for reference comparison output
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: ref_gtf_file
    type:
      - 'null'
      - File
    doc: Reference GTF file to compare against
    inputBinding:
      position: 101
      prefix: --ref-gtf
  - id: test_gtf_file
    type:
      - 'null'
      - File
    doc: GTF file used for comparison
    inputBinding:
      position: 101
      prefix: --test-gtf
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taco:0.7.3--py27_0
stdout: taco_taco_refcomp.out
