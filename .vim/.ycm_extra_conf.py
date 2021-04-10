import os

def FlagsForFile( filename, **kwargs ):
    ext = os.path.splitext(filename)[1]
    lang = ''
    # apparently 'file' cannot detect .cpp files as cpp
    if ext == '.cpp':
        lang = 'cpp'
    else:
        if filename.endswith('.c') or filename.endswith('.h'):
            lang = 'c'

    if lang == 'c':
        return {
            'flags': [ '-x', 'c', '-std=c11', '-pedantic', '-Wall', '-Wextra', '' ],
        }
    elif lang == 'cpp':
        return {
            'flags': [ '-x', 'c++', '-std=c++14', '-Wall', '-Wextra'],
        }
