cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CURED_FindREs.py
label: cured_CURED_FindREs.py
doc: "This script is a part of the CURED pipeline. This script is used to find restriction
  enzyme sites in the identified k-mers.\n\nTool homepage: https://github.com/microbialARC/CURED"
inputs:
  - id: case_control_file
    type:
      - 'null'
      - File
    doc: Csv file of cases and controls.
    inputBinding:
      position: 101
      prefix: --case_control_file
  - id: specificity
    type:
      - 'null'
      - float
    doc: Specificity for finding RE sites in controls. Default = 100.
    inputBinding:
      position: 101
      prefix: --specificity
  - id: added_bases
    type:
      - 'null'
      - int
    doc: Number of added bases on either end of the sequence. Default = 20.
    inputBinding:
      position: 101
      prefix: --added_bases
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage threshold for sequence to be considered found in 
      controls. Default = 90.
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: extension
    type:
      - 'null'
      - string
    doc: Extension of input assemblies. Default = fna
    inputBinding:
      position: 101
      prefix: --extension
  - id: pcr_product_upstream
    type:
      - 'null'
      - int
    doc: Number of bases to include upstream of identified k-mer in outputted 
      PCR product.
    inputBinding:
      position: 101
      prefix: --pcr_product_upstream
  - id: pcr_product_downstream
    type:
      - 'null'
      - int
    doc: Number of bases to include downstream of identified k-mer in outputted 
      PCR product.
    inputBinding:
      position: 101
      prefix: --pcr_product_downstream
  - id: compare_coordinates
    type:
      - 'null'
      - boolean
    doc: Mode to compare RE by position to determine uniqueness. Default is to 
      determine uniqueness based on presence/absence.
    inputBinding:
      position: 101
      prefix: --compare_coordinates
  - id: enzymes
    type:
      - 'null'
      - File
    doc: Provide a file of restriction enzymes to be used. Default is all 
      enzymes supplied by NE Biolabs.
    inputBinding:
      position: 101
      prefix: --enzymes
  - id: kmers
    type: File
    doc: List of kmers to be searched.
    inputBinding:
      position: 201
  - id: genomes_folder
    type: Directory
    doc: Path to genomes. Staged writable because the tool writes bwa and 
      samtools indexes beside the genomes.
    inputBinding:
      position: 202
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: unique_enzymes
    type:
      - 'null'
      - File
    doc: Report of unique restriction enzyme sites in the k-mers
    outputBinding:
      glob: CURED_UniqueEnzymes.tsv
  - id: pcr_products
    type:
      - 'null'
      - File
    doc: PCR products for k-mers with a restriction enzyme site unique to the 
      cases
    outputBinding:
      glob: CURED_UniqueEnzymes_PCR_Products.tsv
  - id: findres_summary
    type:
      - 'null'
      - File
    doc: Summary of k-mer, case genome used and control genomes searched or 
      excluded
    outputBinding:
      glob: CURED_FindREs_summary.txt
  - id: findres_controls
    type:
      - 'null'
      - File
    doc: Controls in which a case restriction enzyme site was also found
    outputBinding:
      glob: CURED_FindREs_controls.txt
  - id: logs
    type: File[]
    doc: Log reports
    outputBinding:
      glob: '*.log'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genomes_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cured:1.05--hdfd78af_0
stdout: cured_CURED_FindREs.py.out
