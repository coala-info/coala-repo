cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - scan
label: gimmemotifs-minimal_scan
doc: "Scan for known motifs\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: genome
    type:
      - 'null'
      - File
    doc: "Genome fasta file (staged writable; index files are created next to it)"
    inputBinding:
      position: 1
      prefix: --genome
  - id: pfmfile
    type:
      - 'null'
      - File
    doc: "PFM file with motifs (default: gimme.vertebrate.v5.0.pfm)."
    inputBinding:
      position: 1
      prefix: --pfmfile
  - id: fpr
    type:
      - 'null'
      - float
    doc: "FPR for motif scanning (default 0.01)"
    inputBinding:
      position: 1
      prefix: --fpr
  - id: bgfile
    type:
      - 'null'
      - File
    doc: "background file for threshold"
    inputBinding:
      position: 1
      prefix: --bgfile
  - id: cutoff
    type:
      - 'null'
      - string
    doc: "motif score cutoff or file with cutoffs"
    inputBinding:
      position: 1
      prefix: --cutoff
  - id: nreport
    type:
      - 'null'
      - int
    doc: "report the N best matches (default 1)"
    inputBinding:
      position: 1
      prefix: --nreport
  - id: norc
    type:
      - 'null'
      - boolean
    doc: "don't scan reverse complement (- strand)"
    inputBinding:
      position: 1
      prefix: --norc
  - id: bed
    type:
      - 'null'
      - boolean
    doc: "output bed format"
    inputBinding:
      position: 1
      prefix: --bed
  - id: table
    type:
      - 'null'
      - boolean
    doc: "output counts in tabular format"
    inputBinding:
      position: 1
      prefix: --table
  - id: score_table
    type:
      - 'null'
      - boolean
    doc: "output maximum score in tabular format"
    inputBinding:
      position: 1
      prefix: --score_table
  - id: zscore
    type:
      - 'null'
      - boolean
    doc: "convert pfm logodds score to z-score"
    inputBinding:
      position: 1
      prefix: --zscore
  - id: gc
    type:
      - 'null'
      - boolean
    doc: "use GC frequency normalized z-score"
    inputBinding:
      position: 1
      prefix: --gc
  - id: seed
    type:
      - 'null'
      - int
    doc: "set a random seed (default None)"
    inputBinding:
      position: 1
      prefix: --seed
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of threads (default 12)"
    inputBinding:
      position: 1
      prefix: --nthreads
  - id: input_file
    type: File
    doc: "inputfile (FASTA, BED, regions)"
    inputBinding:
      position: 100
  - id: output_name
    type: string
    doc: "Name of the file that receives the scan result (standard output)"
    default: scan_result.txt
outputs:
  - id: output
    type: File
    doc: "Scan result"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
stdout: $(inputs.output_name)
