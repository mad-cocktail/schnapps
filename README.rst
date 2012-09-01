Set charset name and preprocess strings
=======================================

It is a tiny parse transform, that converts literal strings into
something else.

**License**: MIT

**Author**: Uvarov Michael (freeakk@gmail.com)

**Status**: Experimental

.. image:: https://secure.travis-ci.org/mad-cocktail/schnapps.png?branch=master
    :alt: Build Status
    :target: http://travis-ci.org/mad-cocktail/schnapps


.. code-block:: erlang

    -compile({parse_transform, gin}).
    -encoding({SourceEncoding, StringsEncoding, StringsType}).

where:

-  ``SourceEncoding`` is a term of the ``unicode:encoding()`` type.
   Valid values:

   -  ``latin1``;
   -  ``utf8``;
   -  ``{utf16, big}``;
   -  ``{utf16, little}``;
   -  ``{utf32, big}``;
   -  ``{utf32, little}``.

-  ``StringsEncoding`` is a term of the ``unicode:encoding()`` type.
   Valid values:

   -  ``latin1``;
   -  ``unicode``;
   -  ``utf8``;
   -  ``utf16``;
   -  ``{utf16, big}``;
   -  ``{utf16, little}``;
   -  ``utf32``;
   -  ``{utf32, big}``;
   -  ``{utf32, little}``.

-  ``StringsType``. Valid values:

   -  ``list``;
   -  ``binary``.

Common combinations: 
 * ``{latin1, latin1, list}.``
   This encoding is used by Erlang by default. 
 * ``{utf8, unicode, list}.`` 
   A string is a list of codepoints.
 * ``{utf8, utf16, binary}.`` 
   The module uses probably ICU for string processing.

