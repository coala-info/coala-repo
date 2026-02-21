cwlVersion: v1.2
class: CommandLineTool
baseCommand: screed
label: screed
doc: "A tool for reading and manipulating biological sequence files (FASTA/FASTQ).
  Note: The provided text is a container runtime error log (Apptainer/Singularity)
  indicating a 'no space left on device' failure during image extraction, and does
  not contain CLI help text or argument definitions.\n\nTool homepage: http://github.com/dib-lab/screed/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screed:1.0.4--py_0
stdout: screed.out
