cwlVersion: v1.2
class: CommandLineTool
baseCommand: cargo
label: rust_cargo
doc: "Rust's package manager\n\nTool homepage: https://github.com/rust-lang/rust"
inputs:
  - id: command
    type: string
    doc: The cargo command to run
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the cargo command
    inputBinding:
      position: 2
  - id: color
    type:
      - 'null'
      - string
    doc: 'Coloring: auto, always, never'
    inputBinding:
      position: 103
      prefix: --color
  - id: explain
    type:
      - 'null'
      - string
    doc: Run `rustc --explain CODE`
    inputBinding:
      position: 103
      prefix: --explain
  - id: frozen
    type:
      - 'null'
      - boolean
    doc: Require Cargo.lock and cache are up to date
    inputBinding:
      position: 103
      prefix: --frozen
  - id: list
    type:
      - 'null'
      - boolean
    doc: List installed commands
    inputBinding:
      position: 103
      prefix: --list
  - id: locked
    type:
      - 'null'
      - boolean
    doc: Require Cargo.lock is up to date
    inputBinding:
      position: 103
      prefix: --locked
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No output printed to stdout
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Use verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust_cargo.out
