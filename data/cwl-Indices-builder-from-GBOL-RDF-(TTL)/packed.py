# Script to generate packed workflows

import os
import logging

logging.basicConfig(level=logging.INFO)

def list_workflows():
    workflows = "./workflows/"
    for workflow in os.listdir(workflows):
        logging.info("Packing workflow: " + workflow)
        if workflow.endswith(".cwl"):
            workflow_file_path = workflows + workflow
            command = "cwltool --quiet --pack " + workflow_file_path + " > ./packed/" + workflow.replace(".cwl", "_packed.cwl")
            exit = os.system(command)
            if exit != 0:
                os.remove("./packed/" + workflow.replace(".cwl", "_packed.cwl"))


if '__main__' == __name__:
    list_workflows()