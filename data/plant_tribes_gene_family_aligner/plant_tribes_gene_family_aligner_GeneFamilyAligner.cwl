cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyAligner
label: plant_tribes_gene_family_aligner_GeneFamilyAligner
doc: "Align gene family sequences: build multiple sequence alignments (protein and optionally codon) for gene family orthogroup fasta files with MAFFT or PASTA. Results are written to the geneFamilyAlignments_dir folder in the working directory.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: orthogroup_faa
    type: Directory
    doc: 'Directory containing gene family classification orthogroup protein fasta files (and CDS fasta files for codon alignments)'
    inputBinding:
      position: 101
      prefix: --orthogroup_faa
      valueFrom: $(self.path)
  - id: alignment_method
    type: string
    doc: 'Multiple sequence alignment method: mafft or pasta'
    inputBinding:
      position: 101
      prefix: --alignment_method
  - id: codon_alignments
    type:
      - 'null'
      - boolean
    doc: 'Construct orthogroup multiple codon alignments (CDS fasta files must be in the same directory)'
    inputBinding:
      position: 101
      prefix: --codon_alignments
  - id: automated_trimming
    type:
      - 'null'
      - boolean
    doc: 'Trim alignments using trimAl''s ML heuristic trimming approach (incompatible with gap_trimming)'
    inputBinding:
      position: 101
      prefix: --automated_trimming
  - id: gap_trimming
    type:
      - 'null'
      - float
    doc: 'Remove gappy sites in alignments, 0.0 to 1.0 (0.1 removes sites with 90% gaps)'
    inputBinding:
      position: 101
      prefix: --gap_trimming
  - id: remove_sequences
    type:
      - 'null'
      - float
    doc: 'Remove gappy sequences in alignments, 0.1 to 1.0 (requires automated_trimming or gap_trimming)'
    inputBinding:
      position: 101
      prefix: --remove_sequences
  - id: iterative_realignment
    type:
      - 'null'
      - int
    doc: 'Iterative orthogroups realignment, trimming and filtering: maximum number of iterations (requires remove_sequences)'
    inputBinding:
      position: 101
      prefix: --iterative_realignment
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads (CPUs) for external utilities (MAFFT and PASTA), default 1'
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: max_memory
    type:
      - 'null'
      - int
    doc: 'maximum memory (in mb) available to PASTA''s java tools (requires pasta), default 256'
    inputBinding:
      position: 101
      prefix: --max_memory
  - id: pasta_iter_limit
    type:
      - 'null'
      - int
    doc: 'Maximum number of iterations that PASTA will run (requires pasta), default 3'
    inputBinding:
      position: 101
      prefix: --pasta_iter_limit
  - id: pasta_script_path
    type:
      - 'null'
      - string
    doc: 'Optional path to the run_pasta.py script'
    inputBinding:
      position: 101
      prefix: --pasta_script_path
outputs:
  - id: alignments_dir
    type: Directory
    doc: 'Gene family alignments'
    outputBinding:
      glob: 'geneFamilyAlignments_dir'
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_aligner:1.0.4--hdfd78af_1
stdout: GeneFamilyAligner.log
