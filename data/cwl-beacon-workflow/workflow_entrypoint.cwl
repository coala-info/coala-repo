cwlVersion: v1.0
class: Workflow
id: beacon_workflow
label: beacon-workflow

inputs:
    filters:
        type: string?

outputs:
    output_file:
        type: File
        outputSource: beacon-oneshot/output_file

steps:
    beacon-oneshot:
        run: ./beacon-omop-worker.cwl
        in:
            filters: filters
            
        out: [output_file]