
master
======

- Added fail() function to force a parser fail in a code block capture
- Added push() function to allow code block captures to push captures
  back on the stack
- Significant performance improvements (delated captures, head fails)

0.18.0
======

- Runtime performance improvements

0.17.1
======

- Bugfix release (removed lingering debug echo)

0.17.0
======

- Various runtime and compiletime performance improvements

0.16.0
======

- Templates can now also be used in libraries
- Added railroad diagram generation with -d:npegGraph
- Improved error reporting

0.15.0
======

- Generic parser API changed: the peg() macro now explicity passes the
  userdata type and identifier.

0.14.1
======

- Added templates / parameterised rules
- Added custom match validation in code block capture
- Added basic types, utf8 and uri libs
- Added global pattern library support
- Proc matchFile() now uses memfiles/mmap for zero copy parsers
- Implemented method to pass user variable to code block captures
- Added AST capture type for building simple abstract syntax trees
- Added Jb() capture for Json booleans

0.13.0
======

- The capture[] variable available inside code block matches now allows access
  to the match offset as well. This is an API change since the type of capture
  changed from seq[string] to seq[Capture].


0.12.0
======

- Documentation updates
- Made some error bounds compile-time configurable
- Fix for more strict Nim compiler checks

0.11.0
======

- Added support for named backreferences
- Added safeguards to prevent grammars growing out of bounds
- Added Graphviz .dot debugging output for parser debugging
- Added `matchLen` and `matchMax` fields to `NPegException`
- Improved pattern syntax error messages

0.10.0
======

- Fixed 'Graph' character class

0.9.0
=====

- Some syntax changes to fix compilation with mainline Nim 0.19.4

0.8.0
=====

- Added syntactic sugar for accessing the captures[] seq in capture
  code blocks with dollar-number variables $1..$9

0.7.0
=====

- Action callbacks (%) dropped in favour of Nim code block callbacks.

0.6.0
=====

- API change: count syntax changed from {n} to [n].

- Optimizations in code generation

0.5.0
=====

- API change: peg() and patt() now return an object of type Parser
  instead of a proc, and the function match(p: Parser) is now used for
  matching the subject. match() can match string and cstring types, 
  matchFile() matches a file using memFile.

- Added builtin atoms Upper, Lower, Digit, HexDigit, Alpha

- Added `@` search operator

- Added `&` and predicate

0.4.0
=====

- Improved tracing output, during trace the originating rule name
  for each instruction is dumped.

- Optimizations