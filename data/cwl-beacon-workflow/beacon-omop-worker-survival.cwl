cwlVersion: v1.0
class: CommandLineTool
id: beacon-omop-worker-survival
label: beacon-omop-worker-survival

hints:
    DockerRequirement:
        dockerPull: hutchstack/beacon-omop-worker:latest

baseCommand: [beacon-omop-worker]
arguments: ["survival"]

inputs:
    vocabulary:
        type: string
        inputBinding:
            position: 1
            prefix: -v
    output_name:
        type: string
        inputBinding:
            position: 2
            prefix: -o
    strata:
        type: string?
        inputBinding:
            position: 3
            prefix: -s


outputs:
    output_file:
        type: File
        outputBinding:
            glob: "$(inputs.output_name)"