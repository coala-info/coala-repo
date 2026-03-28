[Fiona](index.html)

stable

* [Project Information](README.html)
* [Installation](install.html)
* [User Manual](manual.html)
* [API Documentation](modules.html)
  + fiona package
    - [Subpackages](#subpackages)
      * [fiona.fio package](fiona.fio.html)
    - [Submodules](#submodules)
    - [fiona.collection module](#module-fiona.collection)
      * [`BytesCollection`](#fiona.collection.BytesCollection)
      * [`Collection`](#fiona.collection.Collection)
      * [`get_filetype()`](#fiona.collection.get_filetype)
    - [fiona.compat module](#module-fiona.compat)
      * [`strencode()`](#fiona.compat.strencode)
    - [fiona.crs module](#module-fiona.crs)
      * [`CRS`](#fiona.crs.CRS)
      * [`epsg_treats_as_latlong()`](#fiona.crs.epsg_treats_as_latlong)
      * [`epsg_treats_as_northingeasting()`](#fiona.crs.epsg_treats_as_northingeasting)
      * [`from_epsg()`](#fiona.crs.from_epsg)
      * [`from_string()`](#fiona.crs.from_string)
      * [`to_string()`](#fiona.crs.to_string)
    - [fiona.drvsupport module](#module-fiona.drvsupport)
      * [`driver_from_extension()`](#fiona.drvsupport.driver_from_extension)
      * [`vector_driver_extensions()`](#fiona.drvsupport.vector_driver_extensions)
    - [fiona.env module](#module-fiona.env)
      * [`Env`](#fiona.env.Env)
      * [`GDALVersion`](#fiona.env.GDALVersion)
      * [`NullContextManager`](#fiona.env.NullContextManager)
      * [`ThreadEnv`](#fiona.env.ThreadEnv)
      * [`defenv()`](#fiona.env.defenv)
      * [`delenv()`](#fiona.env.delenv)
      * [`ensure_env()`](#fiona.env.ensure_env)
      * [`ensure_env_with_credentials()`](#fiona.env.ensure_env_with_credentials)
      * [`env_ctx_if_needed()`](#fiona.env.env_ctx_if_needed)
      * [`getenv()`](#fiona.env.getenv)
      * [`hascreds()`](#fiona.env.hascreds)
      * [`hasenv()`](#fiona.env.hasenv)
      * [`require_gdal_version()`](#fiona.env.require_gdal_version)
      * [`setenv()`](#fiona.env.setenv)
    - [fiona.errors module](#module-fiona.errors)
      * [`AttributeFilterError`](#fiona.errors.AttributeFilterError)
      * [`CRSError`](#fiona.errors.CRSError)
      * [`DataIOError`](#fiona.errors.DataIOError)
      * [`DatasetDeleteError`](#fiona.errors.DatasetDeleteError)
      * [`DriverError`](#fiona.errors.DriverError)
      * [`DriverIOError`](#fiona.errors.DriverIOError)
      * [`DriverSupportError`](#fiona.errors.DriverSupportError)
      * [`EnvError`](#fiona.errors.EnvError)
      * [`FeatureWarning`](#fiona.errors.FeatureWarning)
      * [`FieldNameEncodeError`](#fiona.errors.FieldNameEncodeError)
      * [`FionaDeprecationWarning`](#fiona.errors.FionaDeprecationWarning)
      * [`FionaError`](#fiona.errors.FionaError)
      * [`FionaValueError`](#fiona.errors.FionaValueError)
      * [`GDALVersionError`](#fiona.errors.GDALVersionError)
      * [`GeometryTypeValidationError`](#fiona.errors.GeometryTypeValidationError)
      * [`OpenerRegistrationError`](#fiona.errors.OpenerRegistrationError)
      * [`PathError`](#fiona.errors.PathError)
      * [`ReduceError`](#fiona.errors.ReduceError)
      * [`SchemaError`](#fiona.errors.SchemaError)
      * [`TransactionError`](#fiona.errors.TransactionError)
      * [`TransformError`](#fiona.errors.TransformError)
      * [`UnsupportedGeometryTypeError`](#fiona.errors.UnsupportedGeometryTypeError)
      * [`UnsupportedOperation`](#fiona.errors.UnsupportedOperation)
    - [fiona.inspector module](#module-fiona.inspector)
      * [`main()`](#fiona.inspector.main)
    - [fiona.io module](#module-fiona.io)
      * [`MemoryFile`](#fiona.io.MemoryFile)
      * [`ZipMemoryFile`](#fiona.io.ZipMemoryFile)
    - [fiona.logutils module](#module-fiona.logutils)
      * [`FieldSkipLogFilter`](#fiona.logutils.FieldSkipLogFilter)
      * [`LogFiltering`](#fiona.logutils.LogFiltering)
    - [fiona.ogrext module](#module-fiona.ogrext)
      * [`AbstractField`](#fiona.ogrext.AbstractField)
      * [`BinaryField`](#fiona.ogrext.BinaryField)
      * [`BooleanField`](#fiona.ogrext.BooleanField)
      * [`DateField`](#fiona.ogrext.DateField)
      * [`DateTimeField`](#fiona.ogrext.DateTimeField)
      * [`FeatureBuilder`](#fiona.ogrext.FeatureBuilder)
      * [`Int16Field`](#fiona.ogrext.Int16Field)
      * [`Integer64Field`](#fiona.ogrext.Integer64Field)
      * [`IntegerField`](#fiona.ogrext.IntegerField)
      * [`ItemsIterator`](#fiona.ogrext.ItemsIterator)
      * [`Iterator`](#fiona.ogrext.Iterator)
      * [`JSONField`](#fiona.ogrext.JSONField)
      * [`KeysIterator`](#fiona.ogrext.KeysIterator)
      * [`MemoryFileBase`](#fiona.ogrext.MemoryFileBase)
      * [`OGRFeatureBuilder`](#fiona.ogrext.OGRFeatureBuilder)
      * [`RealField`](#fiona.ogrext.RealField)
      * [`Session`](#fiona.ogrext.Session)
      * [`StringField`](#fiona.ogrext.StringField)
      * [`StringListField`](#fiona.ogrext.StringListField)
      * [`TZ`](#fiona.ogrext.TZ)
      * [`TimeField`](#fiona.ogrext.TimeField)
      * [`WritingSession`](#fiona.ogrext.WritingSession)
      * [`buffer_to_virtual_file()`](#fiona.ogrext.buffer_to_virtual_file)
      * [`featureRT()`](#fiona.ogrext.featureRT)
      * [`remove_virtual_file()`](#fiona.ogrext.remove_virtual_file)
    - [fiona.path module](#module-fiona.path)
    - [fiona.rfc3339 module](#module-fiona.rfc3339)
      * [`group_accessor`](#fiona.rfc3339.group_accessor)
      * [`parse_date()`](#fiona.rfc3339.parse_date)
      * [`parse_datetime()`](#fiona.rfc3339.parse_datetime)
      * [`parse_time()`](#fiona.rfc3339.parse_time)
    - [fiona.schema module](#module-fiona.schema)
      * [`FionaBinaryType`](#fiona.schema.FionaBinaryType)
      * [`FionaBooleanType`](#fiona.schema.FionaBooleanType)
      * [`FionaDateTimeType`](#fiona.schema.FionaDateTimeType)
      * [`FionaDateType`](#fiona.schema.FionaDateType)
      * [`FionaInt16Type`](#fiona.schema.FionaInt16Type)
      * [`FionaInteger64Type`](#fiona.schema.FionaInteger64Type)
      * [`FionaIntegerType`](#fiona.schema.FionaIntegerType)
      * [`FionaJSONType`](#fiona.schema.FionaJSONType)
      * [`FionaRealType`](#fiona.schema.FionaRealType)
      * [`FionaStringListType`](#fiona.schema.FionaStringListType)
      * [`FionaStringType`](#fiona.schema.FionaStringType)
      * [`FionaTimeType`](#fiona.schema.FionaTimeType)
      * [`normalize_field_type()`](#fiona.schema.normalize_field_type)
    - [fiona.session module](#module-fiona.session)
      * [`AWSSession`](#fiona.session.AWSSession)
      * [`AzureSession`](#fiona.session.AzureSession)
      * [`DummySession`](#fiona.session.DummySession)
      * [`GSSession`](#fiona.session.GSSession)
      * [`OSSSession`](#fiona.session.OSSSession)
      * [`Session`](#fiona.session.Session)
      * [`SwiftSession`](#fiona.session.SwiftSession)
    - [fiona.transform module](#module-fiona.transform)
      * [`transform()`](#fiona.transform.transform)
      * [`transform_geom()`](#fiona.transform.transform_geom)
    - [fiona.vfs module](#module-fiona.vfs)
      * [`is_remote()`](#fiona.vfs.is_remote)
      * [`parse_paths()`](#fiona.vfs.parse_paths)
      * [`valid_vsi()`](#fiona.vfs.valid_vsi)
      * [`vsi_path()`](#fiona.vfs.vsi_path)
    - [fiona module](#module-fiona)
      * [`Feature`](#fiona.Feature)
      * [`Geometry`](#fiona.Geometry)
      * [`Properties`](#fiona.Properties)
      * [`bounds()`](#fiona.bounds)
      * [`listdir()`](#fiona.listdir)
      * [`listlayers()`](#fiona.listlayers)
      * [`open()`](#fiona.open)
      * [`prop_type()`](#fiona.prop_type)
      * [`prop_width()`](#fiona.prop_width)
      * [`remove()`](#fiona.remove)
* [CLI Documentation](cli.html)

[Fiona](index.html)

* [fiona](modules.html)
* fiona package
* [Edit on GitHub](https://github.com/Toblerity/Fiona/blob/f285ccb45a3769b28aff0282b84475b93a153cf7/docs/fiona.rst)

---

# fiona package[](#fiona-package "Link to this heading")

## Subpackages[](#subpackages "Link to this heading")

* [fiona.fio package](fiona.fio.html)
  + [Submodules](fiona.fio.html#submodules)
  + [fiona.fio.bounds module](fiona.fio.html#module-fiona.fio.bounds)
  + [fiona.fio.calc module](fiona.fio.html#module-fiona.fio.calc)
  + [fiona.fio.cat module](fiona.fio.html#module-fiona.fio.cat)
  + [fiona.fio.collect module](fiona.fio.html#module-fiona.fio.collect)
  + [fiona.fio.distrib module](fiona.fio.html#module-fiona.fio.distrib)
  + [fiona.fio.dump module](fiona.fio.html#module-fiona.fio.dump)
  + [fiona.fio.env module](fiona.fio.html#module-fiona.fio.env)
  + [fiona.fio.filter module](fiona.fio.html#fiona-fio-filter-module)
  + [fiona.fio.helpers module](fiona.fio.html#module-fiona.fio.helpers)
    - [`eval_feature_expression()`](fiona.fio.html#fiona.fio.helpers.eval_feature_expression)
    - [`id_record()`](fiona.fio.html#fiona.fio.helpers.id_record)
    - [`make_ld_context()`](fiona.fio.html#fiona.fio.helpers.make_ld_context)
    - [`nullable()`](fiona.fio.html#fiona.fio.helpers.nullable)
    - [`obj_gen()`](fiona.fio.html#fiona.fio.helpers.obj_gen)
    - [`recursive_round()`](fiona.fio.html#fiona.fio.helpers.recursive_round)
  + [fiona.fio.info module](fiona.fio.html#module-fiona.fio.info)
  + [fiona.fio.insp module](fiona.fio.html#module-fiona.fio.insp)
  + [fiona.fio.load module](fiona.fio.html#module-fiona.fio.load)
  + [fiona.fio.ls module](fiona.fio.html#module-fiona.fio.ls)
  + [fiona.fio.main module](fiona.fio.html#module-fiona.fio.main)
    - [`configure_logging()`](fiona.fio.html#fiona.fio.main.configure_logging)
  + [fiona.fio.options module](fiona.fio.html#module-fiona.fio.options)
    - [`cb_key_val()`](fiona.fio.html#fiona.fio.options.cb_key_val)
    - [`cb_layer()`](fiona.fio.html#fiona.fio.options.cb_layer)
    - [`cb_multilayer()`](fiona.fio.html#fiona.fio.options.cb_multilayer)
    - [`validate_multilayer_file_index()`](fiona.fio.html#fiona.fio.options.validate_multilayer_file_index)
  + [fiona.fio.rm module](fiona.fio.html#module-fiona.fio.rm)
  + [Module contents](fiona.fio.html#module-fiona.fio)
    - [`with_context_env()`](fiona.fio.html#fiona.fio.with_context_env)

## Submodules[](#submodules "Link to this heading")

## fiona.collection module[](#module-fiona.collection "Link to this heading")

Collections provide file-like access to feature data.

*class* fiona.collection.BytesCollection(*bytesbuf*, *\*\*kwds*)[](#fiona.collection.BytesCollection "Link to this definition")
:   Bases: [`Collection`](#fiona.collection.Collection "fiona.collection.Collection")

    BytesCollection takes a buffer of bytes and maps that to
    a virtual file that can then be opened by fiona.

    close()[](#fiona.collection.BytesCollection.close "Link to this definition")
    :   Removes the virtual file associated with the class.

*class* fiona.collection.Collection(*path*, *mode='r'*, *driver=None*, *schema=None*, *crs=None*, *encoding=None*, *layer=None*, *vsi=None*, *archive=None*, *enabled\_drivers=None*, *crs\_wkt=None*, *ignore\_fields=None*, *ignore\_geometry=False*, *include\_fields=None*, *wkt\_version=None*, *allow\_unsupported\_drivers=False*, *\*\*kwargs*)[](#fiona.collection.Collection "Link to this definition")
:   Bases: `object`

    A file-like interface to features of a vector dataset

    Python text file objects are iterators over lines of a file. Fiona
    Collections are similar iterators (not lists!) over features
    represented as GeoJSON-like mappings.

    *property* bounds[](#fiona.collection.Collection.bounds "Link to this definition")
    :   Returns (minx, miny, maxx, maxy).

    close()[](#fiona.collection.Collection.close "Link to this definition")
    :   In append or write mode, flushes data to disk, then ends access.

    *property* closed[](#fiona.collection.Collection.closed "Link to this definition")
    :   `False` if data can be accessed, otherwise `True`.

    *property* crs[](#fiona.collection.Collection.crs "Link to this definition")
    :   The coordinate reference system (CRS) of the Collection.

    *property* crs\_wkt[](#fiona.collection.Collection.crs_wkt "Link to this definition")
    :   Returns a WKT string.

    *property* driver[](#fiona.collection.Collection.driver "Link to this definition")
    :   Returns the name of the proper OGR driver.

    filter(*\*args*, *\*\*kwds*)[](#fiona.collection.Collection.filter "Link to this definition")
    :   Returns an iterator over records, but filtered by a test for
        spatial intersection with the provided `bbox`, a (minx, miny,
        maxx, maxy) tuple or a geometry `mask`. An attribute filter can
        be set using an SQL `where` clause, which uses the [OGR SQL dialect](https://gdal.org/user/ogr_sql_dialect.html#where).

        Positional arguments `stop` or `start, stop[, step]` allows
        iteration to skip over items or stop at a specific item.

        Note: spatial filtering using `mask` may be inaccurate and returning
        all features overlapping the envelope of `mask`.

    flush()[](#fiona.collection.Collection.flush "Link to this definition")
    :   Flush the buffer.

    get(*item*)[](#fiona.collection.Collection.get "Link to this definition")

    get\_tag\_item(*key*, *ns=None*)[](#fiona.collection.Collection.get_tag_item "Link to this definition")
    :   Returns tag item value

        Parameters:
        :   * **key** (*str*) – The key for the metadata item to fetch.
            * **ns** (*str**,* *optional*) – Used to select a namespace other than the default.

        Return type:
        :   str

    guard\_driver\_mode()[](#fiona.collection.Collection.guard_driver_mode "Link to this definition")

    items(*\*args*, *\*\*kwds*)[](#fiona.collection.Collection.items "Link to this definition")
    :   Returns an iterator over FID, record pairs, optionally
        filtered by a test for spatial intersection with the provided
        `bbox`, a (minx, miny, maxx, maxy) tuple or a geometry
        `mask`. An attribute filter can be set using an SQL `where`
        clause, which uses the [OGR SQL dialect](https://gdal.org/user/ogr_sql_dialect.html#where).

        Positional arguments `stop` or `start, stop[, step]` allows
        iteration to skip over items or stop at a specific item.

        Note: spatial filtering using `mask` may be inaccurate and returning
        all features overlapping the envelope of `mask`.

    keys(*\*args*, *\*\*kwds*)[](#fiona.collection.Collection.keys "Link to this definition")
    :   Returns an iterator over FIDs, optionally
        filtered by a test for spatial intersection with the provided
        `bbox`, a (minx, miny, maxx, maxy) tuple or a geometry
        `mask`. An attribute filter can be set using an SQL `where`
        clause, which uses the [OGR SQL dialect](https://gdal.org/user/ogr_sql_dialect.html#where).

        Positional arguments `stop` or `start, stop[, step]` allows
        iteration to skip over items or stop at a specific item.

        Note: spatial filtering using `mask` may be inaccurate and returning
        all features overlapping the envelope of `mask`.

   