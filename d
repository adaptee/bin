#!/usr/bin/env python
# vim: set fileencoding=utf-8 :

import re
import sys
import locale
import subprocess

_, default_encoding = locale.getdefaultlocale()

def normalize(word):

    # remove whitespace and tailing ', .'
    word = word.strip().rstrip('.').rstrip(',')

    pattern = ur'(\S+)'
    match = re.search(pattern, word)

    return match.group(0).lower()

if __name__ == '__main__':

    if len(sys.argv) > 1 :

        word = sys.argv[1]
        word = normalize( unicode(word, default_encoding) )

        subprocess.call( ['sdcv', '-n', word] )
    else:
        subprocess.call( ['sdcv', '-n'] )



