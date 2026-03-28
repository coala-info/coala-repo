## Crate crux\_kv

## [crux\_kv](../crux_kv/index.html)0.9.0

* [All Items](all.html)

### [Crate Items](#modules)

* [Modules](#modules "Modules")
* [Structs](#structs "Structs")
* [Enums](#enums "Enums")

# Crate crux\_kv Copy item path

[Source](../src/crux_kv/lib.rs.html#1-439)

Expand description

A basic Key-Value store for use with Crux

`crux_kv` allows Crux apps to store and retrieve arbitrary data by asking the Shell to
persist the data using platform native capabilities (e.g. disk or web localStorage)

## Modules[§](#modules)

[command](command/index.html "mod crux_kv::command")
:   The Command based API for `crux_kv`

[error](error/index.html "mod crux_kv::error")

[value](value/index.html "mod crux_kv::value")

## Structs[§](#structs)

[KeyValue](struct.KeyValue.html "struct crux_kv::KeyValue")

## Enums[§](#enums)

[KeyValueOperation](enum.KeyValueOperation.html "enum crux_kv::KeyValueOperation")
:   Supported operations

[KeyValueResponse](enum.KeyValueResponse.html "enum crux_kv::KeyValueResponse")

[KeyValueResult](enum.KeyValueResult.html "enum crux_kv::KeyValueResult")
:   The result of an operation on the store.