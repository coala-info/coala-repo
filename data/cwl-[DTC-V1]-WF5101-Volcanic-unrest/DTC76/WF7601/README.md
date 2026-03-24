# WF7601 Workflow Files

This directory contains workflow files generated from the spreadsheet description of WF7601 using a [custom tool](https://github.com/Marco-Salvi/dt-geo-converter). These files provide an initial starting point, **manual verification and updates are required** to ensure accuracy.

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
[WARNING] [Inner step ST760104 has no inputs or outputs; please verify its configuration]
[WARNING] [Inner step ST760105 has no inputs or outputs; please verify its configuration]
[WARNING] [Inner step ST760106 has no inputs or outputs; please verify its configuration]
[WARNING] [Inner step ST760102 has no inputs or outputs; please verify its configuration]
[WARNING] [Step ST760108 has no inputs or outputs]
[WARNING] [Step ST760101 has no inputs or outputs]
[WARNING] [Step ST760105 has no inputs or outputs]
[WARNING] [Step ST760106 has no inputs or outputs]
[WARNING] [Step ST760109 has no inputs or outputs]
[WARNING] [Step ST760111 has no inputs or outputs]
[WARNING] [Step ST760103 has no inputs or outputs]
[WARNING] [Step ST760104 has no inputs or outputs]
[WARNING] [Step ST760107 has no inputs or outputs]
[WARNING] [Step ST760110 has no inputs or outputs]
[WARNING] [Step ST760102 has no inputs or outputs]
```



For complete details, please refer to the [log file](./workflows/WF7601)


## Next Steps

Carefully review the issues above and double-check the corresponding CWL files to ensure that all steps are correctly defined. Adjust any errors or omissions as necessary.

