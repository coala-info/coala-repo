cwlVersion: v1.2
class: CommandLineTool
baseCommand: gem
label: ruby_gem
doc: "RubyGems is a sophisticated package manager for Ruby. This is a basic help message
  containing pointers to more information.\n\nTool homepage: https://github.com/krahets/hello-algo"
inputs:
  - id: command
    type: string
    doc: A gem command to execute
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the gem command
    inputBinding:
      position: 2
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the gem command
    inputBinding:
      position: 3
  - id: help_topic
    type:
      - 'null'
      - string
    doc: Show help on a specific topic or command
    inputBinding:
      position: 104
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruby:2.2.3--1
stdout: ruby_gem.out
