cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - hairpin
label: yasma_hairpin
doc: "Evaluates annotated loci for hairpin or miRNA structures.\n\nTool homepage:
  https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Alignment file input (bam or cram).
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: annotation_folder
    type:
      - 'null'
      - Directory
    doc: location for the yasma annotation used in this analysis.
    inputBinding:
      position: 101
      prefix: --annotation_folder
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores/processes used in analyzing hairpins.
    inputBinding:
      position: 101
      prefix: --cores
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Genome or assembly which was used for the original alignment.
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: ignore_replication
    type:
      - 'null'
      - boolean
    doc: Evaluate all readgroups together, ignoring if a miRNA is replicated
    inputBinding:
      position: 101
      prefix: --ignore_replication
  - id: ignore_subhairpins
    type:
      - 'null'
      - boolean
    doc: This prevents folding of sub-hairpins in long stranded loci
    inputBinding:
      position: 101
      prefix: --ignore_subhairpins
  - id: matures
    type:
      - 'null'
      - File
    doc: location for a fasta of mature miRNAs which will be used to spot 
      orthologs.
    inputBinding:
      position: 101
      prefix: --matures
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum hairpin size. Longer loci will not be considered for miRNA 
      analysis.
    inputBinding:
      position: 101
      prefix: --max_length
  - id: name
    type:
      - 'null'
      - string
    doc: name for sub folder where hairpin analysis is deposited
    inputBinding:
      position: 101
      prefix: --name
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory name for annotation output.
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silences printing hairpin analysis to terminal. Useful when lots of 
      loci are found.
    inputBinding:
      position: 101
      prefix: --silent
  - id: trim_hairpins
    type:
      - 'null'
      - boolean
    doc: With this flag, candidate hairpins are retrimmed. This is useful for 
      loci which may be arbitrarily sized. Warning, this is very likely to 
      produce false positives for miRNAs, as it artificially enhances precision.
    inputBinding:
      position: 101
      prefix: --trim_hairpins
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_hairpin.out
