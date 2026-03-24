cwlVersion: v1.0
class: Workflow
id: beacon_workflow
label: beacon-workflow

inputs:
    vocabulary:
        type: string
    strata:
        type: string?
    output_name:
        type: string

outputs:
    survival_output_file:
        type: File
        outputSource: beacon-survival/output_file

steps:
    beacon-survival:
        run: ./beacon-omop-worker-survival.cwl
        in:
            vocabulary: vocabulary
            strata: strata
            output_name: output_name
        out: [output_file]