cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ctseq
  - make_methyl_ref
label: ctseq_make_methyl_ref
doc: "Build a reference methylation genome.\n\nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: ref_dir
    type: Directory
    doc: Path to the directory where you want to build your reference 
      methylation genome. Must contain a reference file for your intended 
      targets with extension (.fa). If this flag is not used, it is assumed that
      your current working directory contains your reference file and that you 
      want to build your reference in your current working directory.
    inputBinding:
      position: 101
      prefix: --refDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: methyl_ref_dir
    type: Directory
    doc: Reference directory with the Bismark bisulfite genome (Bisulfite_Genome)
    outputBinding:
      glob: $(inputs.ref_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_make_methyl_ref.out
