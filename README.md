```
@author:       Michael Denzel
@license:      GNU General Public License 2.0 or later
```

# A brief evaluation of some programming languages

## Rust
\+ "type-safe", concurrency, similar C/C++/Java, tools: cargo (lib pinning, enforced documentation, version control...), compatible with C (binaries, libraries)<br/>
\- unstable version system, inflexible compiler, no asynchronous I/O, no overloading, lifetimes of objects can be very tricky and annoying, String vs str

## Python
\+ beginner friendly, concurrency (ThreadPool/ProcessPool), networking, quick to write<br/>
\- missing closing brackets leads to errors, two-version system is confusing (version 2 vs version 3), global interpreter lock, dynamically typed, language security (difficult to sandbox)

## Go
\+ concurrency, webserver/http<br/>
\- networking, low-level programming, no generics, no overloading, kind of restricted in favour of "simplicity"

## Groovy
\+ beginner friendly (very similar to Java), no imports<br/>
\- VERY VERY slow, feels like sloppy Java (return statements, semicolons, "public",... are optional), documentation is worse than Java API

## Perl
\+ quick to write (I guess)<br/>
\- hard to read, difficult for beginners, threads complicated, parameters of subroutine hidden in code

## Lua
\+ C integration, networking<br/>
\- documentation is bad, syntax not intuitive, no native thread support

## Ocaml
\+ "type-safe", multiple concepts (functional, object orientation etc.)<br/>
\- Ocaml runtime is not thread-safe, documentation is not good, confusing: use of "no line-endings", ";;", and ";", sometimes "end"-statement is omitted

## Erlang
\+ concurrency<br/>
\- no executables(?), lacks good documentation, very steep learning curve,
  lacks good tutorials

## Haskell (added by [hoheinzollern](https://github.com/hoheinzollern))
\+ "type-safe", concurrency<br/>
\- hard to read (recursion), difficult for beginners, no loops, overuse of lists



# TODO
- C++ 2014 (threads!)
- Java
- Ruby - tryruby.org
- Pascal/Ada/Delphi
- COBOL
- Swift
- Fortran
- Lisp/Clojure/Scheme/Racket
- Scala
- C#?
- Crystal (-not win/arm?)
- Kotlin
- Elm
- Elixir (+fault tolerant restarts)
- Dart

Tests:
- client-server
- concurrency/parallelism
- interaction with commandline
- library support
