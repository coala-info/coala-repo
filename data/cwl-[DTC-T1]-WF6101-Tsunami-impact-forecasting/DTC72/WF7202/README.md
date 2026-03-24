# WF7202 Workflow Files

This directory contains workflow files generated from the spreadsheet description of WF7202 using a [custom tool](https://github.com/Marco-Salvi/dt-geo-converter). These files provide an initial starting point, **manual verification and updates are required** to ensure accuracy.

## File Overview

- **\*.dot Files**  
  These are visual representations of the generated CWL files. Use [Graphviz](https://dreampuf.github.io/GraphvizOnline/) to render and review the workflow steps.

- **ST\*.cwl Files**  
  These files represent the CWL steps extracted from the spreadsheets. They reflect the provided data, but some details might be missing or the spreadsheets description might have had errors. **Action:** Review and complete the missing information.

- **WF\*.cwl File**  
  This is the main entry point of the workflow. It defines the global inputs, outputs, and the connections between the steps. A corresponding DOT file (wf\*.dot) is also available for visualization. **Action:** Review and complete the missing information.

- **ro-crate-metadata.json**  
  A metadata template generated from the CWL description. It should list all the entities in the workflow. **Action:** Manually compile any missing details. If the CWL files are incorrect, update this file to reflect the changes. 

## Detected Issues


The following issues were detected during the conversion process of the files from the spreadsheets description. These issues might be derived from errors in the spreadsheets descriptions of the workflows:
``` log
[WARNING] [Inner step ST720205 has no inputs or outputs; please verify its configuration]
[WARNING] [Inner step ST720202 has no inputs or outputs; please verify its configuration]
[WARNING] [Inner step ST720202 has no inputs or outputs; please verify its configuration]
[WARNING] [Inner step ST720203 has no inputs or outputs; please verify its configuration]
[WARNING] [Step ST720211 has no inputs or outputs]
[WARNING] [Step ST720202 has no inputs or outputs]
[WARNING] [Step ST720208 has no inputs or outputs]
[WARNING] [Step ST720201 has no inputs or outputs]
[WARNING] [Step ST720210 has no inputs or outputs]
[WARNING] [Step ST720203 has no inputs or outputs]
[WARNING] [Step ST720205 has no inputs or outputs]
[WARNING] [Step ST720207 has no inputs or outputs]
[WARNING] [Step ST720204 has no inputs or outputs]
[WARNING] [Step ST720206 has no inputs or outputs]
[WARNING] [Step ST720209 has no inputs or outputs]
```



For complete details, please refer to the [log file](./workflows/WF7202)


## Next Steps

Carefully review the issues above and double-check the corresponding CWL files to ensure that all steps are correctly defined. Adjust any errors or omissions as necessary.

