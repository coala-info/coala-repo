cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phu
  - screen
label: phu_screen
doc: "Screen contigs for protein families using HMMER on predicted CDS.\n\nTool homepage:
  https://github.com/camilogarciabotero/phu"
inputs:
  - id: hmms
    type:
      type: array
      items: File
    doc: HMM files (supports wildcards like *.hmm)
    inputBinding:
      position: 1
  - id: combine_mode
    type:
      - 'null'
      - string
    doc: 'How to combine hits from multiple HMMs: any|all|threshold'
    inputBinding:
      position: 102
  - id: hmm_mode
    type:
      - 'null'
      - string
    doc: "HMM file type: 'pure' (one model per file) or 'mixed' (pressed/concatenated
      HMMs)"
    inputBinding:
      position: 102
  - id: input_contigs
    type: File
    doc: Input contigs FASTA
    inputBinding:
      position: 102
      prefix: -i
  - id: keep_domtbl
    type:
      - 'null'
      - boolean
    doc: Keep raw domtblout from hmmsearch
    inputBinding:
      position: 102
      prefix: --keep-domtbl
  - id: keep_proteins
    type:
      - 'null'
      - boolean
    doc: Keep the protein FASTA used for searching
    inputBinding:
      position: 102
      prefix: --keep-proteins
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: Maximum independent E-value to keep a domain hit
    inputBinding:
      position: 102
  - id: min_bitscore
    type:
      - 'null'
      - float
    doc: Minimum bitscore to keep a domain hit
    inputBinding:
      position: 102
  - id: min_gene_len
    type:
      - 'null'
      - int
    doc: Minimum gene length for pyrodigal (nt)
    inputBinding:
      position: 102
  - id: min_hmm_hits
    type:
      - 'null'
      - int
    doc: Minimum number of HMMs that must hit a contig (for threshold mode)
    inputBinding:
      position: 102
  - id: mode
    type:
      - 'null'
      - string
    doc: 'pyrodigal mode: meta|single'
    inputBinding:
      position: 102
  - id: no_keep_domtbl
    type:
      - 'null'
      - boolean
    doc: Do not keep raw domtblout from hmmsearch
    inputBinding:
      position: 102
      prefix: --no-keep-domtbl
  - id: no_keep_proteins
    type:
      - 'null'
      - boolean
    doc: Do not keep the protein FASTA used for searching
    inputBinding:
      position: 102
      prefix: --no-keep-proteins
  - id: no_save_target_hmms
    type:
      - 'null'
      - boolean
    doc: Do not save HMMs built from target proteins in target_hmms/ subfolder
    inputBinding:
      position: 102
      prefix: --no-save-target-hmms
  - id: no_save_target_proteins
    type:
      - 'null'
      - boolean
    doc: Do not save matched proteins per HMM model in target_proteins/ 
      subfolder
    inputBinding:
      position: 102
      prefix: --no-save-target-proteins
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: -o
  - id: save_target_hmms
    type:
      - 'null'
      - boolean
    doc: Save HMMs built from target proteins in target_hmms/ subfolder
    inputBinding:
      position: 102
      prefix: --save-target-hmms
  - id: save_target_proteins
    type:
      - 'null'
      - boolean
    doc: Save matched proteins per HMM model in target_proteins/ subfolder
    inputBinding:
      position: 102
      prefix: --save-target-proteins
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for both pyrodigal and hmmsearch
    inputBinding:
      position: 102
      prefix: -t
  - id: top_per_contig
    type:
      - 'null'
      - int
    doc: Keep top-N hits per contig (by bitscore)
    inputBinding:
      position: 102
  - id: ttable
    type:
      - 'null'
      - int
    doc: NCBI translation table for coding sequences
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0
stdout: phu_screen.out
