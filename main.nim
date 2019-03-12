
import npeg
import os


when false:
  block:
    let s = peg "aap":
      a <- "a"
      aap <- a * *('(' * aap * ')')
    echo s("a(a)((a))")


when false:
  block:
    let s = peg "http":
      space                 <- ' '
      crlf                  <- '\n' | "\r\n"
      meth                  <- "GET" | "POST" | "PUT"
      proto                 <- "HTTP"
      version               <- "1.0" | "1.1"
      alpha                 <- {'a'..'z','A'..'Z'}
      digit                 <- {'0'..'9'}
      url                   <- +alpha
      eof                   <- -{}

      req                   <- meth * space * url * space * proto * "/" * version

      header_content_length <- i"Content-Length: " * +digit
      header_other          <- +(alpha | '-') * ": " * +({}-crlf)
    
      header                <- header_content_length | header_other
      http                  <- req * crlf * *(header * crlf) * eof

    echo s """
POST flop HTTP/1.1
Content-Type: text/plain
content-length: 23
"""


when false:
  block:
    let s = peg "flop":
      flop <- "a" * *"a" * -{}
    npegTrace = true
    echo s("aaaa")

when false:
  block:
    let s = peg "line":
      ws       <- *' '
      digit    <- {'0'..'9'} * ws
      number   <- +digit * ws
      termOp   <- {'+', '-'} * ws
      factorOp <- {'*', '/'} * ws
      open     <- '(' * ws
      close    <- ')' * ws
      eol      <- -{}
      exp      <- term * *(termOp * term)
      term     <- factor * *(factorOp * factor)
      factor   <- number | (open * exp * close)
      line     <- ws * exp * eol
    echo s("13 + 5 * (2+1)")

when true:
  block:

    let json = """
      {
          "glossary": {
              "title": "example glossary",
              "GlossDiv": {
                  "title": "S",
                  "GlossList": {
                      "GlossEntry": {
                          "ID": "SGML",
                              "SortAs": "SGML",
                              "GlossTerm": "Standard Generalized Markup Language",
                              "Acronym": "SGML",
                              "Abbrev": "ISO 8879:1986",
                              "GlossDef": {
                              "para": "A meta-markup language, used to create markup languages such as DocBook.",
                              "GlossSeeAlso": ["GML", "XML"]
                          },
                          "GlossSee": "markup"
                      }
                  }
              }
          }
      }
      """

    let s = peg "DOC":
      S              <- *{' ','\t','\r','\n'}
      String         <- ?S * '"' * *({'\x20'..'\xff'} - '"' - '\\' | Escape ) * '"' * ?S
      Escape         <- '\\' * ({ '[', '"', '|', '\\', 'b', 'f', 'n', 'r', 't' } | UnicodeEscape)
      UnicodeEscape  <- 'u' * {'0'..'9','A'..'F','a'..'f'}{4}
      True           <- "true"
      False          <- "false"
      Null           <- "null"
      Number         <- ?Minus * IntPart * ?FractPart * ?ExpPart
      Minus          <- '-'
      IntPart        <- '0' | {'1'..'9'} * *{'0'..'9'}
      FractPart      <- "." * +{'0'..'9'}
      ExpPart        <- ( 'e' | 'E' ) * ?( '+' | '-' ) * +{'0'..'9'}
      DOC            <- JSON * -{}
      JSON           <- ?S * ( Number | Object | Array | String | True | False | Null ) * ?S
      Object         <- '{' * ( String * ":" * JSON * *( "," * String * ":" * JSON ) | ?S ) * "}"
      Array          <- "[" * ( JSON * *( "," * JSON ) | ?S ) * "]"

    echo s(json)




