cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruby
label: ruby
doc: "The provided text appears to be a container engine log (Apptainer/Singularity)
  rather than the help text for the Ruby programming language. No command-line arguments,
  flags, or options were found in the provided text.\n\nTool homepage: https://github.com/krahets/hello-algo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruby:2.2.3--1
stdout: ruby.out
