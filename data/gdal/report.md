# gdal CWL Generation Report

## gdal_gdalinfo

### Tool Description
Prints information about a GDAL dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/gdal:2.4.0
- **Homepage**: https://github.com/OSGeo/gdal
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gdal/overview
- **Total Downloads**: 20.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/OSGeo/gdal
- **Stars**: N/A
### Original Help Text
```text
Usage: gdalinfo [--help-general] [-json] [-mm] [-stats] [-hist] [-nogcp] [-nomd]
                [-norat] [-noct] [-nofl] [-checksum] [-proj4]
                [-listmdd] [-mdd domain|`all`]*
                [-sd subdataset] [-oo NAME=VALUE]* datasetname
```


## gdal_ogrinfo

### Tool Description
Prints detailed information about OGR data sources and layers.

### Metadata
- **Docker Image**: quay.io/biocontainers/gdal:2.4.0
- **Homepage**: https://github.com/OSGeo/gdal
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: ogrinfo [--help-general] [-ro] [-q] [-where restricted_where|@filename]
               [-spat xmin ymin xmax ymax] [-geomfield field] [-fid fid]
               [-sql statement|@filename] [-dialect sql_dialect] [-al] [-rl] [-so] [-fields={YES/NO}]
               [-geom={YES/NO/SUMMARY}] [[-oo NAME=VALUE] ...]
               [-nomd] [-listmdd] [-mdd domain|`all`]*
               [-nocount] [-noextent]
               datasource_name [layer [layer ...]]
```


## gdal_gdal_translate

### Tool Description
Translate a raster file to another format, with optional resampling, scaling, etc.

### Metadata
- **Docker Image**: quay.io/biocontainers/gdal:2.4.0
- **Homepage**: https://github.com/OSGeo/gdal
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: gdal_translate [--help-general] [--long-usage]
       [-ot {Byte/Int16/UInt16/UInt32/Int32/Float32/Float64/
             CInt16/CInt32/CFloat32/CFloat64}] [-strict]
       [-of format] [-b band] [-mask band] [-expand {gray|rgb|rgba}]
       [-outsize xsize[%]|0 ysize[%]|0] [-tr xres yres]
       [-r {nearest,bilinear,cubic,cubicspline,lanczos,average,mode}]
       [-unscale] [-scale[_bn] [src_min src_max [dst_min dst_max]]]* [-exponent[_bn] exp_val]*
       [-srcwin xoff yoff xsize ysize] [-epo] [-eco]
       [-projwin ulx uly lrx lry] [-projwin_srs srs_def]
       [-a_srs srs_def] [-a_ullr ulx uly lrx lry] [-a_nodata value]
       [-a_scale value] [-a_offset value]
       [-gcp pixel line easting northing [elevation]]*
       |-colorinterp{_bn} {red|green|blue|alpha|gray|undefined}]
       |-colorinterp {red|green|blue|alpha|gray|undefined},...]
       [-mo "META-TAG=VALUE"]* [-q] [-sds]
       [-co "NAME=VALUE"]* [-stats] [-norat]
       [-oo NAME=VALUE]*
       src_dataset dst_dataset
```


## gdal_ogr2ogr

### Tool Description
Convert data between vector formats

### Metadata
- **Docker Image**: quay.io/biocontainers/gdal:2.4.0
- **Homepage**: https://github.com/OSGeo/gdal
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: ogr2ogr [--help-general] [-skipfailures] [-append] [-update]
               [-select field_list] [-where restricted_where|@filename]
               [-progress] [-sql <sql statement>|@filename] [-dialect dialect]
               [-preserve_fid] [-fid FID] [-limit nb_features]
               [-spat xmin ymin xmax ymax] [-spat_srs srs_def] [-geomfield field]
               [-a_srs srs_def] [-t_srs srs_def] [-s_srs srs_def]
               [-f format_name] [-overwrite] [[-dsco NAME=VALUE] ...]
               dst_datasource_name src_datasource_name
               [-lco NAME=VALUE] [-nln name] 
               [-nlt type|PROMOTE_TO_MULTI|CONVERT_TO_LINEAR|CONVERT_TO_CURVE]
               [-dim XY|XYZ|XYM|XYZM|layer_dim] [layer [layer ...]]

Advanced options :
               [-gt n] [-ds_transaction]
               [[-oo NAME=VALUE] ...] [[-doo NAME=VALUE] ...]
               [-clipsrc [xmin ymin xmax ymax]|WKT|datasource|spat_extent]
               [-clipsrcsql sql_statement] [-clipsrclayer layer]
               [-clipsrcwhere expression]
               [-clipdst [xmin ymin xmax ymax]|WKT|datasource]
               [-clipdstsql sql_statement] [-clipdstlayer layer]
               [-clipdstwhere expression]
               [-wrapdateline][-datelineoffset val]
               [[-simplify tolerance] | [-segmentize max_dist]]
               [-addfields] [-unsetFid]
               [-relaxedFieldNameMatch] [-forceNullable] [-unsetDefault]
               [-fieldTypeToString All|(type1[,type2]*)] [-unsetFieldWidth]
               [-mapFieldType srctype|All=dsttype[,srctype2=dsttype2]*]
               [-fieldmap identity | index1[,index2]*]
               [-splitlistfields] [-maxsubfields val]
               [-explodecollections] [-zfield field_name]
               [-gcp ungeoref_x ungeoref_y georef_x georef_y [elevation]]* [-order n | -tps]
               [-nomd] [-mo "META-TAG=VALUE"]* [-noNativeData]

Note: ogr2ogr --long-usage for full help.
```


## gdal_gdalwarp

### Tool Description
Reprojects a raster dataset to match a given projection, resolution and extent.

### Metadata
- **Docker Image**: quay.io/biocontainers/gdal:2.4.0
- **Homepage**: https://github.com/OSGeo/gdal
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: gdalwarp [--help-general] [--formats]
    [-s_srs srs_def] [-t_srs srs_def] [-to "NAME=VALUE"]* [-novshiftgrid]
    [-order n | -tps | -rpc | -geoloc] [-et err_threshold]
    [-refine_gcps tolerance [minimum_gcps]]
    [-te xmin ymin xmax ymax] [-tr xres yres] [-tap] [-ts width height]
    [-ovr level|AUTO|AUTO-n|NONE] [-wo "NAME=VALUE"] [-ot Byte/Int16/...] [-wt Byte/Int16]
    [-srcnodata "value [value...]"] [-dstnodata "value [value...]"] -dstalpha
    [-r resampling_method] [-wm memory_in_mb] [-multi] [-q]
    [-cutline datasource] [-cl layer] [-cwhere expression]
    [-csql statement] [-cblend dist_in_pixels] [-crop_to_cutline]
    [-of format] [-co "NAME=VALUE"]* [-overwrite]
    [-nomd] [-cvmd meta_conflict_value] [-setci] [-oo NAME=VALUE]*
    [-doo NAME=VALUE]*
    srcfile* dstfile

Available resampling methods:
    near (default), bilinear, cubic, cubicspline, lanczos, average, mode,  max, min, med, Q1, Q3.
```


## gdal_gdalbuildvrt

### Tool Description
Builds a virtual raster (VRT) from a list of input GDAL datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/gdal:2.4.0
- **Homepage**: https://github.com/OSGeo/gdal
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: gdalbuildvrt [-tileindex field_name]
                    [-resolution {highest|lowest|average|user}]
                    [-te xmin ymin xmax ymax] [-tr xres yres] [-tap]
                    [-separate] [-b band] [-sd subdataset]
                    [-allow_projection_difference] [-q]
                    [-addalpha] [-hidenodata]
                    [-srcnodata "value [value...]"] [-vrtnodata "value [value...]"] 
                    [-a_srs srs_def]
                    [-r {nearest,bilinear,cubic,cubicspline,lanczos,average,mode}]
                    [-oo NAME=VALUE]*
                    [-input_file_list my_list.txt] [-overwrite] output.vrt [gdalfile]*

e.g.
  % gdalbuildvrt doq_index.vrt doq/*.tif
  % gdalbuildvrt -input_file_list my_list.txt doq_index.vrt

NOTES:
  o With -separate, each files goes into a separate band in the VRT band.
    Otherwise, the files are considered as tiles of a larger mosaic.
  o -b option selects a band to add into vrt.  Multiple bands can be listed.
    By default all bands are queried.
  o The default tile index field is 'location' unless otherwise specified by
    -tileindex.
  o In case the resolution of all input files is not the same, the -resolution
    flag enable the user to control the way the output resolution is computed.
    Average is the default.
  o Input files may be any valid GDAL dataset or a GDAL raster tile index.
  o For a GDAL raster tile index, all entries will be added to the VRT.
  o If one GDAL dataset is made of several subdatasets and has 0 raster bands,
    its datasets will be added to the VRT rather than the dataset itself.
    Single subdataset could be selected by its number using the -sd option.
  o By default, only datasets of same projection and band characteristics
    may be added to the VRT.
```

