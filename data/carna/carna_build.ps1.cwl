cwlVersion: v1.2
class: CommandLineTool
baseCommand: carna_build.ps1
label: carna_build.ps1
doc: "A script to build a SIF (Singularity Image Format) container for CARNA from
  a Docker/OCI source.\n\nTool homepage: https://github.com/Code52/carnac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carna:1.3.3--1
stdout: carna_build.ps1.out
