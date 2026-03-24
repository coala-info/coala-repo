cwlVersion: v1.1
class: Workflow
label: testEntryTitleNew
doc: Cryo-EM processing workflow
inputs: []
outputs: []
steps:
  2_ProtImportMovies:
    label: pwem - import movies
    doc: "*3* Movies imported from /home/irene/testIrene/*.tiff, Is the data phase\
      \ flipped : False, Sampling rate : *1.00* \u212B/px"
    run:
      class: CommandLineTool
      baseCommand: []
      inputs: []
      outputs:
        2.outputMovies:
          type: File
          format: cryoem:CRYOEM_0000096
    out:
    - 2.outputMovies
    in: []
  87_EmpiarDepositor:
    label: empiar - Empiar deposition
    doc: Generated deposition files:, - [[/home/irene/ScipionUserData/projects/testK/Runs/000087_EmpiarDepositor/extra/topFolder/workflow.json][Scipion
      workflow]], - [[Runs/000087_EmpiarDepositor/extra/topFolder/deposition.json][Deposition
      json]]
    run:
      class: CommandLineTool
      baseCommand: []
      inputs:
        2.outputMovies:
          type: File
          format: cryoem:CRYOEM_0000096
      outputs: []
    out: []
    in:
      2.outputMovies:
        source: 2_ProtImportMovies/2.outputMovies
$namespaces:
  cryoem: http://scipion.i2pc.es/ontology/
