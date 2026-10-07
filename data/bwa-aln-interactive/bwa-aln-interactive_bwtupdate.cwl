cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-aln-interactive
  - bwtupdate
label: bwa-aln-interactive_bwtupdate
doc: "Update or regenerate the BWT (Burrows-Wheeler Transform) file.\n\nTool homepage:
  https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: bwt_file
    type: File
    doc: The BWT file to update (rewritten in place)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: updated_bwt
    type: File
    doc: The BWT file in the new format (with occurrence counts)
    outputBinding:
      glob: $(inputs.bwt_file.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bwt_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_bwtupdate.out
