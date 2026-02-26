# vpt-cellpose2 CWL Generation Report

## vpt-cellpose2_vpt

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vpt-cellpose2:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/Vizgen/vpt-plugin-cellpose2
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/vpt-cellpose2/overview
- **Total Downloads**: 290
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/Vizgen/vpt-plugin-cellpose2
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/vpt", line 6, in <module>
    from vpt.vizgen_postprocess import entry_point
  File "/usr/local/lib/python3.10/site-packages/vpt/vizgen_postprocess.py", line 11, in <module>
    from vpt.app.context import Context
  File "/usr/local/lib/python3.10/site-packages/vpt/app/context.py", line 10, in <module>
    from vpt.app.task import Task
  File "/usr/local/lib/python3.10/site-packages/vpt/app/task.py", line 4, in <module>
    from vpt.cmd_args import get_cmd_entrypoint
  File "/usr/local/lib/python3.10/site-packages/vpt/cmd_args.py", line 4, in <module>
    from vpt.compile_tile_segmentation import get_parser as get_compile_tile_segmentation_parser
  File "/usr/local/lib/python3.10/site-packages/vpt/compile_tile_segmentation/__init__.py", line 3, in <module>
    import vpt.compile_tile_segmentation.cmd_args as cmd_args
  File "/usr/local/lib/python3.10/site-packages/vpt/compile_tile_segmentation/cmd_args.py", line 4, in <module>
    from vpt_core.io.output_tools import MIN_ROW_GROUP_SIZE
  File "/usr/local/lib/python3.10/site-packages/vpt_core/io/output_tools.py", line 14, in <module>
    from vpt_core.segmentation.seg_result import SegmentationResult
  File "/usr/local/lib/python3.10/site-packages/vpt_core/segmentation/seg_result.py", line 14, in <module>
    from vpt_core.segmentation.geometry_utils import get_valid_geometry, convert_to_multipoly
  File "/usr/local/lib/python3.10/site-packages/vpt_core/segmentation/geometry_utils.py", line 1, in <module>
    import cv2
ImportError: libGL.so.1: cannot open shared object file: No such file or directory
```

