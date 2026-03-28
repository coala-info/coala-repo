## Crate crux\_time

## [crux\_time](../crux_time/index.html)0.13.0

* [All Items](all.html)

### [Crate Items](#reexports)

* [Re-exports](#reexports "Re-exports")
* [Modules](#modules "Modules")
* [Structs](#structs "Structs")

# Crate crux\_time Copy item path

[Source](../src/crux_time/lib.rs.html#1-308)

Expand description

Current time access for Crux apps

Current time (on a wall clock) is considered a side-effect (although if we were to get pedantic, it’s
more of a side-cause) by Crux, and has to be obtained externally. This capability provides a simple
interface to do so.

## Re-exports[§](#reexports)

`pub use protocol::duration::[Duration](protocol/duration/struct.Duration.html "struct crux_time::protocol::duration::Duration");`

`pub use protocol::instant::[Instant](protocol/instant/struct.Instant.html "struct crux_time::protocol::instant::Instant");`

`pub use protocol::[TimeRequest](protocol/enum.TimeRequest.html "enum crux_time::protocol::TimeRequest");`

`pub use protocol::[TimeResponse](protocol/enum.TimeResponse.html "enum crux_time::protocol::TimeResponse");`

`pub use protocol::[TimerId](protocol/struct.TimerId.html "struct crux_time::protocol::TimerId");`

## Modules[§](#modules)

[command](command/index.html "mod crux_time::command")

[protocol](protocol/index.html "mod crux_time::protocol")

## Structs[§](#structs)

[Time](struct.Time.html "struct crux_time::Time")
:   The Time capability API

[TimerFuture](struct.TimerFuture.html "struct crux_time::TimerFuture")