cwlVersion: v1.0
class: CommandLineTool
id: beacon-oneshot
label: beacon-oneshot

hints:
    DockerRequirement:
        dockerPull: hutchstack/beacon-omop-worker:latest

baseCommand: [beacon-omop-worker]
arguments: ["individuals"]
inputs:
    filters:
        type: string?
        inputBinding:
            position: 2
            prefix: -f

outputs:
    output_file:
        type: File
        outputBinding:
            glob: "output.json"
