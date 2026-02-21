cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracer
  - TopologyTracer
label: tracer_TopologyTracer
doc: "The provided text contains system error logs regarding a container build failure
  and does not include the help text for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: http://beast.community/tracer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracer:1.7.2--hdfd78af_0
stdout: tracer_TopologyTracer.out
