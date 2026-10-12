cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-msa
label: panaroo_msa
doc: "Generate multiple sequence alignments of core or pan genes after a Panaroo run. The Panaroo output directory is updated in place.

Tool homepage: https://gtonkinhill.github.io/panaroo"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.out_dir)
        writable: true
inputs:
  - id: out_dir
    type: Directory
    doc: "Location of the Panaroo output directory (updated in place)."
    inputBinding:
      prefix: --out_dir
  - id: alignment
    type:
      - 'null'
      - string
    doc: "Output alignments of core genes or all genes: 'core' or 'pan'. Default: none."
    inputBinding:
      prefix: --alignment
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Aligner to use: 'prank', 'clustal' or 'mafft' (default 'mafft')."
    inputBinding:
      prefix: --aligner
  - id: codons
    type:
      - 'null'
      - boolean
    doc: "Generate codon alignments by aligning sequences at the protein level."
    inputBinding:
      prefix: --codons
  - id: core_threshold
    type:
      - 'null'
      - float
    doc: "Core-genome sample threshold (default 0.95)."
    inputBinding:
      prefix: --core_threshold
  - id: core_subset
    type:
      - 'null'
      - int
    doc: "Randomly subset the core genome to this many genes (default all)."
    inputBinding:
      prefix: --core_subset
  - id: core_entropy_filter
    type:
      - 'null'
      - float
    doc: "Manually set the Block Mapping and Gathering with Entropy (BMGE) filter, between 0.0 and 1.0. Default: Tukey outlier method."
    inputBinding:
      prefix: --core_entropy_filter
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default 1)."
    inputBinding:
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print additional output."
    inputBinding:
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "The Panaroo output directory with the new alignments."
    outputBinding:
      glob: $(inputs.out_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_msa.out
