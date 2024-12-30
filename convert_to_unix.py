#%%
"""
Due to windows ending files with `^M` and unix with `\n` there are certain issues when 
reading windows files in linux, as a result this script converts these problematic files
File to walk nvim directory and convert files that written in windows to unix.
"""

import os
dir = "./nvim"
tmp = []
for root, _, files in os.walk(dir):
    for file in files:
        path = os.path.join(root, file)
        if path.endswith(".vim") or path.endswith(".lua"):
            os.system(f"dos2unix {path}")
            
