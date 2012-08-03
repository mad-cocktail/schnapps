Set charset name and preprocess strings
=======================================

It is a tiny parse transform.

__License__: MIT

__Author__: Uvarov Michael ([`freeakk@gmail.com`](mailto:freeakk@gmail.com))

[![Build Status](https://secure.travis-ci.org/freeakk/gin.png?branch=master)](http://travis-ci.org/freeakk/gin)


```erlang
-compile({parse_transform, gin}).
-encoding({SourceEncoding, StringsEncoding, StringsType}).
```

where:

* `SourceEncoding` is a term of the `unicode:encoding()` type.
  Valid values:

    - `latin1`;
    - `utf8`;
    - `{utf16, big}`;
    - `{utf16, little}`;
    - `{utf32, big}`;
    - `{utf32, little}`.

* `StringsEncoding` is a term of the `unicode:encoding()` type.
    Valid values:
    - `latin1`;
    - `unicode`;
    - `utf8`;
    - `utf16`;
    - `{utf16, big}`;
    - `{utf16, little}`;
    - `utf32`;
    - `{utf32, big}`;
    - `{utf32, little}`.

* `StringsType`. 
    Valid values:
    - `list`;
    - `binary`.

Common combinations:
* `{latin1, latin1, list}.`
    This encoding is used by Erlang by default.
* `{utf8, unicode, list}.`
    A string is a list of codepoints. 
* `{utf8, utf16, binary}.`
    The module uses probably ICU for string processing.
