#!/usr/bin/env cwltool

cwlVersion: v1.2
class: Workflow

inputs:
  job: File

outputs:
  out:
    type: File?
    outputSource: slurm/out
  err:
    type: File?
    outputSource: slurm/err

steps:
  slurm:
    in:
      job: job
    run:
      class: CommandLineTool

      inputs:
        job:
          type: File
          inputBinding:
            position: 1

      outputs:
        out:
          type: File?
          outputBinding:
            glob: cwl.out
        err:
          type: File?
          outputBinding:
            glob: '*.err'

      baseCommand: sh
    out:
    - out
    - err
