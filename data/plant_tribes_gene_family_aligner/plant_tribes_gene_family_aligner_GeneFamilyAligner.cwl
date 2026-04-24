cwlVersion: v1.2
class: CommandLineTool
baseCommand: plant_tribes_gene_family_aligner_GeneFamilyAligner
label: plant_tribes_gene_family_aligner_GeneFamilyAligner
doc: "ALIGN GENE FAMILY SEQUENCES\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs:
  - id: alignment_method
    type: string
    doc: 'Multiple sequence alignment method: If MAFFT algorithm: mafft If PASTA algorithm:
      pasta'
    inputBinding:
      position: 101
      prefix: --alignment_method
  - id: automated_trimming
    type:
      - 'null'
      - boolean
    doc: Trims alignments using trimAl's ML heuristic trimming approach - 
      incompatible "--gap_trimming"
    inputBinding:
      position: 101
      prefix: --automated_trimming
  - id: codon_alignments
    type:
      - 'null'
      - boolean
    doc: Construct orthogroup multiple codon alignments - corresponding gene 
      family classification orthogroups CDS fasta files should be in the same 
      directory with input orthogroups protein fasta files.
    inputBinding:
      position: 101
      prefix: --codon_alignments
  - id: gap_trimming
    type:
      - 'null'
      - float
    doc: 'Removes gappy sites in alignments (i.e. 0.1 removes sites with 90% gaps):
      [0.0 to 1.0]'
    inputBinding:
      position: 101
      prefix: --gap_trimming
  - id: iterative_realignment
    type:
      - 'null'
      - int
    doc: Iterative orthogroups realignment, trimming and fitering - requires 
      "--remove_sequences" (maximum number of iterations)
    inputBinding:
      position: 101
      prefix: --iterative_realignment
  - id: max_memory
    type:
      - 'null'
      - int
    doc: maximum memory (in mb) available to PASTA's java tools - requires 
      "--alignment_method = pasta"
    inputBinding:
      position: 101
      prefix: --max_memory
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to assign to external utilities (MAFFT and 
      PASTA)
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: orthogroup_faa
    type: Directory
    doc: Directory containing gene family classification orthogroup protein 
      fasta files
    inputBinding:
      position: 101
      prefix: --orthogroup_faa
  - id: pasta_iter_limit
    type:
      - 'null'
      - int
    doc: Maximum number of iteration that the PASTA algorithm will run - 
      requires "--alignment_method = pasta"
    inputBinding:
      position: 101
      prefix: --pasta_iter_limit
  - id: pasta_script_path
    type:
      - 'null'
      - string
    doc: Optional path to the location of the run_pasta.py script. which is used
      for running PASTA from the command line (useful since the script is a .py 
      file). Using this will override the default defined in 
      ~home/config/plantTribes.
    inputBinding:
      position: 101
      prefix: --pasta_script_path
  - id: remove_sequences
    type:
      - 'null'
      - float
    doc: 'Removes gappy sequences in alignments (i.e. 0.7 removes sequences with more
      than 30% gaps): [0.1 to 1.0] - requires either "--automated_trimming" or "--gap_trimming"'
    inputBinding:
      position: 101
      prefix: --remove_sequences
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/plant_tribes_gene_family_aligner:1.0.4--hdfd78af_1
stdout: plant_tribes_gene_family_aligner_GeneFamilyAligner.out
