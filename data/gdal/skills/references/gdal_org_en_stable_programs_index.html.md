[![Logo](../_static/gdalicon.png)](../index.html)

* [Download](../download.html)
* Programs
  + ["gdal" application](#gdal-application)
    - [General](#general)
      * [Main `gdal` entry point](gdal.html)
      * [Syntax for commands of `gdal` program](gdal_syntax.html)
      * [Migration guide to `gdal` command line interface](migration_guide_to_gdal_cli.html)
      * [Bash completion for `gdal`](gdal_bash_completion.html)
      * [How to use `gdal` CLI algorithms from C](gdal_cli_from_c.html)
      * [How to use `gdal` CLI algorithms from C++](gdal_cli_from_cpp.html)
      * [How to use `gdal` CLI algorithms from Python](gdal_cli_from_python.html)
      * [.gdalg files to replay serialized `gdal` commands](gdal_cli_gdalg.html)
    - [Commands working with raster or vector inputs](#commands-working-with-raster-or-vector-inputs)
      * [`gdal info`](gdal_info.html)
      * [`gdal convert`](gdal_convert.html)
      * [`gdal pipeline`](gdal_pipeline.html)
    - [Raster commands](#raster-commands)
      * [`gdal raster`](gdal_raster.html)
      * [`gdal raster info`](gdal_raster_info.html)
      * [`gdal raster as-features`](gdal_raster_as_features.html)
      * [`gdal raster aspect`](gdal_raster_aspect.html)
      * [`gdal raster blend`](gdal_raster_blend.html)
      * [`gdal raster calc`](gdal_raster_calc.html)
      * [`gdal raster clean-collar`](gdal_raster_clean_collar.html)
      * [`gdal raster clip`](gdal_raster_clip.html)
      * [`gdal raster color-map`](gdal_raster_color_map.html)
      * [`gdal raster contour`](gdal_raster_contour.html)
      * [`gdal raster compare`](gdal_raster_compare.html)
      * [`gdal raster convert`](gdal_raster_convert.html)
      * [`gdal raster create`](gdal_raster_create.html)
      * [`gdal raster edit`](gdal_raster_edit.html)
      * [`gdal raster footprint`](gdal_raster_footprint.html)
      * [`gdal raster fill-nodata`](gdal_raster_fill_nodata.html)
      * [`gdal raster hillshade`](gdal_raster_hillshade.html)
      * [`gdal raster index`](gdal_raster_index.html)
      * [`gdal raster materialize`](gdal_raster_materialize.html)
      * [`gdal raster mosaic`](gdal_raster_mosaic.html)
      * [`gdal raster neighbors`](gdal_raster_neighbors.html)
      * [`gdal raster nodata-to-alpha`](gdal_raster_nodata_to_alpha.html)
      * [`gdal raster overview`](gdal_raster_overview.html)
      * [`gdal raster overview add`](gdal_raster_overview_add.html)
      * [`gdal raster overview delete`](gdal_raster_overview_delete.html)
      * [`gdal raster overview refresh`](gdal_raster_overview_refresh.html)
      * [`gdal raster pansharpen`](gdal_raster_pansharpen.html)
      * [`gdal raster pipeline`](gdal_raster_pipeline.html)
      * [`gdal raster pixel-info`](gdal_raster_pixel_info.html)
      * [`gdal raster polygonize`](gdal_raster_polygonize.html)
      * [`gdal raster proximity`](gdal_raster_proximity.html)
      * [`gdal raster reclassify`](gdal_raster_reclassify.html)
      * [`gdal raster reproject`](gdal_raster_reproject.html)
      * [`gdal raster resize`](gdal_raster_resize.html)
      * [`gdal raster rgb-to-palette`](gdal_raster_rgb_to_palette.html)
      * [`gdal raster roughness`](gdal_raster_roughness.html)
      * [`gdal raster scale`](gdal_raster_scale.html)
      * [`gdal raster select`](gdal_raster_select.html)
      * [`gdal raster set-type`](gdal_raster_set_type.html)
      * [`gdal raster slope`](gdal_raster_slope.html)
      * [`gdal raster sieve`](gdal_raster_sieve.html)
      * [`gdal raster stack`](gdal_raster_stack.html)
      * [`gdal raster tile`](gdal_raster_tile.html)
      * [`gdal raster tpi`](gdal_raster_tpi.html)
      * [`gdal raster tri`](gdal_raster_tri.html)
      * [`gdal raster unscale`](gdal_raster_unscale.html)
      * [`gdal raster update`](gdal_raster_update.html)
      * [`gdal raster viewshed`](gdal_raster_viewshed.html)
      * [`gdal raster zonal-stats`](gdal_raster_zonal_stats.html)
    - [Vector commands](#vector-commands)
      * [`gdal vector`](gdal_vector.html)
      * [`gdal vector buffer`](gdal_vector_buffer.html)
      * [`gdal vector check-coverage`](gdal_vector_check_coverage.html)
      * [`gdal vector check-geometry`](gdal_vector_check_geometry.html)
      * [`gdal vector clean-coverage`](gdal_vector_clean_coverage.html)
      * [`gdal vector clip`](gdal_vector_clip.html)
      * [`gdal vector concat`](gdal_vector_concat.html)
      * [`gdal vector convert`](gdal_vector_convert.html)
      * [`gdal vector edit`](gdal_vector_edit.html)
      * [`gdal vector filter`](gdal_vector_filter.html)
      * [`gdal vector info`](gdal_vector_info.html)
      * [`gdal vector explode-collections`](gdal_vector_explode_collections.html)
      * [`gdal vector grid`](gdal_vector_grid.html)
      * [`gdal vector index`](gdal_vector_index.html)
      * [`gdal vector layer-algebra`](gdal_vector_layer_algebra.html)
      * [`gdal vector make-point`](gdal_vector_make_point.html)
      * [`gdal vector make-valid`](gdal_vector_make_valid.html)
      * [`gdal vector materialize`](gdal_vector_materialize.html)
      * [`gdal vector partition`](gdal_vector_partition.html)
      * [`gdal vector pipeline`](gdal_vector_pipeline.html)
      * [`gdal vector rasterize`](gdal_vector_rasterize.html)
      * [`gdal vector reproject`](gdal_vector_reproject.html)
      * [`gdal vector select`](gdal_vector_select.html)
      * [`gdal vector segmentize`](gdal_vector_segmentize.html)
      * [`gdal vector set-field-type`](gdal_vector_set_field_type.html)
      * [`gdal vector set-geom-type`](gdal_vector_set_geom_type.html)
      * [`gdal vector simplify`](gdal_vector_simplify.html)
      * [`gdal vector simplify-coverage`](gdal_vector_simplify_coverage.html)
      * [`gdal vector sql`](gdal_vector_sql.html)
      * [`gdal vector swap-xy`](gdal_vector_swap_xy.html)
    - [Multidimensional raster commands](#multidimensional-raster-commands)
      * [`gdal mdim`](gdal_mdim.html)
      * [`gdal mdim info`](gdal_mdim_info.html)
      * [`gdal mdim convert`](gdal_mdim_convert.html)
      * [`gdal mdim mosaic`](gdal_mdim_mosaic.html)
    - [Dataset management commands](#dataset-management-commands)
      * [`gdal dataset`](gdal_dataset.html)
      * [`gdal dataset identify`](gdal_dataset_identify.html)
      * [`gdal dataset copy`](gdal_dataset_copy.html)
      * [`gdal dataset rename`](gdal_dataset_rename.html)
      * [`gdal dataset delete`](gdal_dataset_delete.html)
    - [Virtual System Interface (VSI) commands](#virtual-system-interface-vsi-commands)
      * [`gdal vsi`](gdal_vsi.html)
      * [`gdal vsi copy`](gdal_vsi_copy.html)
      * [`gdal vsi delete`](gdal_vsi_delete.html)
      * [`gdal vsi list`](gdal_vsi_list.html)
      * [`gdal vsi move`](gdal_vsi_move.html)
      * [`gdal vsi sync`](gdal_vsi_sync.html)
      * [`gdal vsi sozip`](gdal_vsi_sozip.html)
    - [Driver specific commands](#driver-specific-commands)
      * [`gdal driver gpkg repack`](gdal_driver_gpkg_repack.html)
      * [`gdal driver gti create`](gdal_driver_gti_create.html)
      * [`gdal driver openfilegdb repack`](gdal_driver_openfilegdb_repack.html)
      * [`gdal driver pdf list-layer`](gdal_driver_pdf_list_layers.html)
  + ["Traditional" applications](#traditional-applications)
    - [General](#id2)
      * [Syntax of arguments of command-line utilities](argument_syntax.html)
    - [Raster programs](#raster-programs)
      * [Common options](raster_common_options.html)
      * [gdal-config (Unix)](gdal-config.html)
      * [gdal2tiles](gdal2tiles.html)
      * [gdal2xyz](gdal2xyz.html)
      * [gdal\_calc](gdal_calc.html)
      * [gdal\_contour](gdal_contour.html)
      * [gdal\_create](gdal_create.html)
      * [gdal\_edit](gdal_edit.html)
      * [gdal\_fillnodata](gdal_fillnodata.html)
      * [gdal\_footprint](gdal_footprint.html)
      * [gdal\_grid](gdal_grid.html)
      * [gdal\_merge](gdal_merge.html)
      * [gdal\_pansharpen](gdal_pansharpen.html)
      * [gdal\_polygonize](gdal_polygonize.html)
      * [gdal\_proximity](gdal_proximity.html)
      * [gdal\_rasterize](gdal_rasterize.html)
      * [gdal\_retile](gdal_retile.html)
      * [gdal\_sieve](gdal_sieve.html)
      * [gdal\_translate](gdal_translate.html)
      * [gdal\_viewshed](gdal_viewshed.html)
      * [gdaladdo](gdaladdo.html)
      * [gdalattachpct](gdalattachpct.html)
      * [gdalbuildvrt](gdalbuildvrt.html)
      * [gdalcompare](gdalcompare.html)
      * [gdaldem](gdaldem.html)
      * [gdalenhance](gdalenhance.html)
      * [gdalinfo](gdalinfo.html)
      * [gdallocationinfo](gdallocationinfo.html)
      * [gdalmanage](gdalmanage.html)
      * [gdalmove](gdalmove.html)
      * [gdalsrsinfo](gdalsrsinfo.html)
      * [gdaltindex](gdaltindex.html)
      * [gdaltransform](gdaltransform.html)
      * [gdalwarp](gdalwarp.html)
      * [nearblack](nearblack.html)
      * [pct2rgb](pct2rgb.html)
      * [rgb2pct](rgb2pct.html)
    - [Multidimensional Raster programs](#multidimensional-raster-programs)
      * [gdalmdiminfo](gdalmdiminfo.html)
      * [gdalmdimtranslate](gdalmdimtranslate.html)
    - [Vector programs](#vector-programs)
      * [Common options](vector_common_options.html)
      * [ogrinfo](ogrinfo.html)
      * [ogr2ogr](ogr2ogr.html)
      * [ogrtindex](ogrtindex.html)
      * [ogrlineref](ogrlineref.html)
      * [ogrmerge](ogrmerge.html)
      * [ogr\_layer\_algebra](ogr_layer_algebra.html)
    - [Geographic network programs](#geographic-network-programs)
      * [gnmmanage](gnmmanage.html)
      * [gnmanalyse](gnmanalyse.html)
    - [Other utilities](#other-utilities)
      * [sozip](sozip.html)
* [Raster drivers](../drivers/raster/index.html)
* [Vector drivers](../drivers/vector/index.html)
* [User](../user/index.html)
* [API](../api/index.html)
* [Tutorials](../tutorials/index.html)
* [Development](../development/index.html)
* [Community](../community/index.html)
* [Sponsors](../sponsors/index.html)
* [How to contribute?](../contributing/index.html)
* [FAQ](../faq.html)
* [Glossary](../glossary.html)
* [License](../license.html)
* [Thanks](../thanks.html)

[GDAL](../index.html)

* [GDAL documentation](../index.html)  »
* Programs
* [Edit on GitHub](https://github.com/OSGeo/gdal/edit/master/doc/source/programs/index.rst)

[Next](gdal.html "Main gdal entry point")
 [Previous](../download.html "Download")

---

# Programs[](#programs "Link to this heading")

## "gdal" application[](#gdal-application "Link to this heading")

Added in version 3.11.

Starting with GDAL 3.11, parts of the GDAL utilities are available from a new
single **gdal** program that accepts commands and subcommands.

As an introduction, you can follow the webinar given on June 3, 2025 about the
GDAL Command Line Interface Modernization as a [PDF slide deck](https://download.osgeo.org/gdal/presentations/GDAL%20CLI%20Modernization.pdf)
or the [recording of the video](https://www.youtube.com/watch?v=ZKdrYm3TiBU).

Warning

The **gdal** command is provisionally provided as an alternative
interface to GDAL and OGR command line utilities. The project reserves the
right to modify, rename, reorganize, and change the behavior of the utility
until it is officially frozen via PSC vote in a future major GDAL release.
The utility needs time to mature, benefit from incremental feedback, and
explore enhancements without carrying the burden of full backward compatibility.
Your usage of it should have no expectation of compatibility until that time.

### General[](#general "Link to this heading")

* [Main gdal entry point](gdal.html#gdal-program): Main `gdal` entry point
* [Syntax for commands of gdal program](gdal_syntax.html#gdal-syntax)
* [Migration guide to gdal command line interface](migration_guide_to_gdal_cli.html#migration-guide-to-gdal-cli)
* [Bash completion for gdal](gdal_bash_completion.html#gdal-bash-completion)
* [How to use gdal CLI algorithms from C](gdal_cli_from_c.html#gdal-cli-from-c)
* [How to use gdal CLI algorithms from C++](gdal_cli_from_cpp.html#gdal-cli-from-cpp)
* [How to use gdal CLI algorithms from Python](gdal_cli_from_python.html#gdal-cli-from-python)
* [.gdalg files to replay serialized gdal commands](gdal_cli_gdalg.html#gdal-cli-gdalg)

### Commands working with raster or vector inputs[](#commands-working-with-raster-or-vector-inputs "Link to this heading")

* [gdal info](gdal_info.html#gdal-info): Get information on a dataset
* [gdal convert](gdal_convert.html#gdal-convert): Convert a dataset
* [gdal pipeline](gdal_pipeline.html#gdal-pipeline): Process a dataset applying several steps

### Raster commands[](#raster-commands "Link to this heading")

Single operations:

* [gdal raster](gdal_raster.html#gdal-raster): Entry point for raster commands
* [gdal raster info](gdal_raster_info.html#gdal-raster-info): Get information on a raster dataset
* [gdal raster as-features](gdal_raster_as_features.html#gdal-raster-as-features): Create features representing raster pixels
* [gdal raster aspect](gdal_raster_aspect.html#gdal-raster-aspect): Generate an aspect map.
* [gdal raster blend](gdal_raster_blend.html#gdal-raster-blend): Blend/compose two raster datasets
* [gdal raster calc](gdal_raster_calc.html#gdal-raster-calc): Perform raster algebra
* [gdal raster clean-collar](gdal_raster_clean_collar.html#gdal-raster-clean-collar): Clean the collar of a raster dataset, removing noise
* [gdal raster clip](gdal_raster_clip.html#gdal-raster-clip): Clip a raster dataset
* [gdal raster color-map](gdal_raster_color_map.html#gdal-raster-color-map): Use a grayscale raster to replace the intensity of a RGB/RGBA dataset
* [gdal raster compare](gdal_raster_compare.html#gdal-raster-compare): Compare two raster datasets
* [gdal raster convert](gdal_raster_convert.html#gdal-raster-convert): Convert a raster dataset
* [gdal raster contour](gdal_raster_contour.html#gdal-raster-contour): Builds vector contour lines from a raster elevation model
* [gdal raster create](gdal_raster_create.html#gdal-raster-create): Create a new raster dataset
* [gdal raster edit](gdal_raster_edit.html#gdal-raster-edit): Edit in place a raster dataset
* [gdal raster footprint](gdal_raster_footprint.html#gdal-raster-footprint): Compute the footprint of a raster dataset.
* [gdal raster fill-nodata](gdal_raster_fill_nodata.html#gdal-raster-fill-nodata): Fill raster regions by interpolation from edges.
* [gdal raster hillshade](gdal_raster_hillshade.html#gdal-raster-hillshade): Generate a shaded relief map
* [gdal raster index](gdal_raster_index.html#gdal-raster-index): Create a vector index of raster datasets
* [gdal raster materialize](gdal_raster_materialize.html#gdal-raster-materialize): Materialize a piped dataset on disk to increase the efficiency of the following steps
* [gdal raster mosaic](gdal_raster_mosaic.html#gdal-raster-mosaic): Build a mosaic, either virtual (VRT) or materialized.
* [gdal raster neighbors](gdal_raster_neighbors.html#gdal-raster-neighbors): Compute the value of each pixel from its neighbors (focal statistics).
* [gdal raster noda