cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crispritz.py
  - scores
label: crispritz_scores
doc: "Calculate the CFD score (and Doench score) for a list of targets. Scores are
  written beside the targets file, so that file is staged into the working directory.\n  \nTool homepage: https://github.com/InfOmics/CRISPRitz"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.results_file)
        writable: true
inputs:
  - id: results_file
    type: File
    doc: Targets file containing all genomic targets for the guides set
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: pam_file
    type: File
    doc: Text file containing the PAM sequence (including a number of Ns equal 
      to the guide length) and a space separated number indicating the length 
      of the PAM sequence
    inputBinding:
      position: 2
  - id: guides_file
    type: File
    doc: Text file containing one or more guides (including a number of Ns 
      equal to the length of the PAM sequence)
    inputBinding:
      position: 3
  - id: genome_dir
    type: Directory
    doc: Directory containing the genome in .fa or .fasta format, necessary to 
      extract sequences for Doench Score Function
    inputBinding:
      position: 4
outputs:
  - id: scores
    type:
      - 'null'
      - File
    doc: Per-guide CFD and Doench scores
    outputBinding:
      glob: $(inputs.results_file.basename.split('.targets.txt')[0]).scores.txt
  - id: targets_cfd
    type:
      - 'null'
      - File
    doc: Targets with their CFD score
    outputBinding:
      glob: $(inputs.results_file.basename.split('.targets.txt')[0]).targets.CFD.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
