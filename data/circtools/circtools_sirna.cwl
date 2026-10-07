cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - sirna
label: circtools_sirna
doc: "circular RNA siRNA design\n\nTool homepage: https://github.com/dieterich-lab/circtools"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.output_dir) { l.push({"class": "Directory", "basename": inputs.output_dir.replace(/\/+$/, ""), "listing": [], "writable": true}); }
        if (inputs.temp_dir) { l.push({"class": "Directory", "basename": inputs.temp_dir.replace(/\/+$/, ""), "listing": [], "writable": true}); }
        return l;
      }
inputs:
  - id: detect_file
    type: File
    doc: 'CircCoordinates file from circtools detect module'
    inputBinding:
      position: 101
      prefix: -d
  - id: gtf_file
    type: File
    doc: 'GTF file of genome annotation e.g. ENSEMBL'
    inputBinding:
      position: 101
      prefix: -g
  - id: fasta_file
    type: File
    secondaryFiles:
      - .fai
    doc: 'FASTA file with genome sequence (must match annotation)'
    inputBinding:
      position: 101
      prefix: -f
  - id: organism
    type:
      - 'null'
      - string
    doc: 'Organism of the study (used for BLASTing): mm, hs, rn or ss'
    inputBinding:
      position: 101
      prefix: -O
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: 'FASTA file containing the circRNA sequence (exons and introns)'
    inputBinding:
      position: 101
      prefix: -s
  - id: find_parameter
    type:
      - 'null'
      - int
    doc: 'Rule used to find siRNA (0 for Ui-Tei, 1 for Reynolds, 2 for multi-length search mode (Ui-Tei))'
    inputBinding:
      position: 101
      prefix: -fp
  - id: overlap_parameter
    type:
      - 'null'
      - int
    doc: 'Minimum number of base pair overlap over the BSJ for all siRNAs'
    inputBinding:
      position: 101
      prefix: -op
  - id: g_repeat_length
    type:
      - 'null'
      - int
    doc: 'Maximum number of consecutive Gs in an siRNA sequence that will be tolerated'
    inputBinding:
      position: 101
      prefix: -gl
  - id: t_repeat_length
    type:
      - 'null'
      - int
    doc: 'Maximum number of consecutive Ts in an siRNA sequence that will be tolerated'
    inputBinding:
      position: 101
      prefix: -tl
  - id: a_repeat_length
    type:
      - 'null'
      - int
    doc: 'Maximum number of consecutive As in an siRNA sequence that will be tolerated'
    inputBinding:
      position: 101
      prefix: -al
  - id: mismatch_tolerance
    type:
      - 'null'
      - int
    doc: 'Minimum number of mismatches a siRNA has to have against each blast result'
    inputBinding:
      position: 101
      prefix: -mt
  - id: mismatch_threshold
    type:
      - 'null'
      - int
    doc: 'Maximum number of blast results complementary to siRNA (containing fewer mismatches than mismatch tolerance) that will be tolerated'
    inputBinding:
      position: 101
      prefix: -mthr
  - id: seed_mismatch
    type:
      - 'null'
      - boolean
    doc: 'The minimum number of mismatches (mismatch tolerance) must be in the seed region of the siRNA'
    inputBinding:
      position: 101
      prefix: -sm
  - id: overhang_parameter
    type:
      - 'null'
      - int
    doc: 'Type of overhang added to the siRNA (0 for UU overhang, 1 for TT overhang, blank for no overhang)'
    inputBinding:
      position: 101
      prefix: -hp
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output directory (created in the working directory; passed with a trailing slash)'
    inputBinding:
      position: 101
      prefix: -o
      valueFrom: '$(self)/'
  - id: title
    type:
      - 'null'
      - string
    doc: 'Title of the experiment for HTML output and file name'
    inputBinding:
      position: 101
      prefix: -T
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Temporary directory (created in the working directory)'
    inputBinding:
      position: 101
      prefix: -t
      valueFrom: '$(self)/'
  - id: target
    type:
      - 'null'
      - string
    doc: 'Which strand the siRNA should target (ex: supplying anti-sense creates an anti-sense guide RNA targeting the sense strand)'
    inputBinding:
      position: 101
      prefix: -tr
  - id: gene_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of host gene names, e.g. CAMSAP1 RYR2'
    inputBinding:
      position: 101
      prefix: -G
  - id: id_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of circRNA IDs, e.g. CAMSAP1_9_135850137_135850461_-'
    inputBinding:
      position: 101
      prefix: -i
  - id: no_blast
    type:
      - 'null'
      - boolean
    doc: 'Do not BLAST the siRNAs (BLAST uses the NCBI web service)'
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory'
    outputBinding:
      glob: $(inputs.output_dir)
  - id: html_files
    type:
      type: array
      items: File
    doc: HTML reports (written to the working directory when no output directory is given)
    outputBinding:
      glob: '*.html'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_sirna.out
