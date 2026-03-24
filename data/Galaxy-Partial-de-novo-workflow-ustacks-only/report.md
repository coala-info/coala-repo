# Partial de novo workflow: ustacks only CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.org.au/
- **Package**: https://workflowhub.eu/workflows/349
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/349/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 744
- **Last updated**: 2023-01-30
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Partial_de_novo_workflow_ustacks_only.ga` (Main Workflow)
- **Project**: Galaxy Australia
- **Views**: 7586
- **Creators**: Anna Syme

## Description

# workflow-partial-ustacks-only


These workflows are part of a set designed to work for RAD-seq data on the Galaxy platform, using the tools from the Stacks program. 

Galaxy Australia: https://usegalaxy.org.au/

Stacks: http://catchenlab.life.illinois.edu/stacks/


For the full de novo workflow see https://workflowhub.eu/workflows/348

You may want to run ustacks with different batches of samples. 
* To be able to combine these later, there are some necessary steps - we need to keep track of how many samples have already run in ustacks, so that new samples can be labelled with different identifying numbers.  
* In ustacks, under "Processing options" there is an option called "Start identifier at". 
* The default for this is 1, which can be used for the first batch of samples. These will then be labelled as sample 1, sample 2 and so on. 
* For any new batches of samples to process in ustacks, we will want to start numbering these at the next available number. e.g. if there were 10 samples in batch 1, this should then be set to start at 11. 

To combine multiple outputs from ustacks, providing these have been given appropriate starting identifiers:
* Find the ustacks output in the Galaxy history. This will be a list of samples. 
* Click on the cross button next to the filename to delete, but select "Collection only". This releases the items from the list, but they will now be hidden in the Galaxy history.
* In the history panel, click on "hidden" to reveal any hidden files. Unhide the samples. 
* Do this for all the batches of ustacks outputs that are needed. 
* Click on the tick button, tick all the samples needed, then "For all selected" choose "Build dataset list"
* This is now a combined set of samples for input into cstacks.
