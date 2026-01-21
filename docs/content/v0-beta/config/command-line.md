---
---

# Command Line Flags and Args {anchor=false}

```
$ ./mlrd --help
Usage: mlrd [flags] [table_config_file...]

Flags:
  -debug
    	debug log level
  -initcheck
    	initialize and exit
  -sys string
    	sys config file
  -version
    	print version and exit
```

## Flags

Flags must be specified first (before arguments).
Short (`-version`) and long (`--version`) syntaxes work.
All flags are optional.

## Args

Arguments must be specified _after_ flags.
Every argument is interpreted as a [table config file]({{< ref "table" >}}).

## Signals

`mlrd` does a clean shutdown on interrupt and term signals.

## Exit Status

Standard Unix exit status: 0 = no errors; non-zero = error (see log)
