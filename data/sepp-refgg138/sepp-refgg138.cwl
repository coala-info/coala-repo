cwlVersion: v1.2
class: CommandLineTool
baseCommand: sepp-refgg138
label: sepp-refgg138
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the tool's image due to insufficient disk space.
  It does not contain help text, usage instructions, or argument definitions.\n\n
  Tool homepage: https://github.com/smirarab/sepp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sepp-refgg138:4.5.1--hdfd78af_1
stdout: sepp-refgg138.out
